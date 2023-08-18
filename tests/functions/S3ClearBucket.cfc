component extends="org.lucee.cfml.test.LuceeTestCase" labels="s3" {
	function run( testResults , testBox ) {
		describe( title="Test suite for S3ClearBucket()", body=function() {
			it(title="check region with blackbaze",skip=Util::isBackBlazeNotSupported(), body = function( currentSpec ) {
				testit(Util::getBackBlazeCredentials());
			});	

			it(title="check region with amazon",skip=Util::isAWSNotSupported(), body = function( currentSpec ) {
				testit(Util::getAWSCredentials());
			});	

			it(title="check region with wasabi",skip=Util::isWasabiNotSupported(), body = function( currentSpec ) {
				testit(Util::getWasabiCredentials());
			});		

			it(title="check region with google",skip=Util::isGoogleNotSupported(), body = function( currentSpec ) {
				testit(Util::getGoogleCredentials());
			});			
	
		});
	}


	private function testit(cred) {
		// create variables
		var bucketName=cred.PREFIX&"S3ClearBucket";
		var objectName="sub/test.txt";
		

		// create source bucket
		if(!S3Exists( 
			bucketName:bucketName,  objectName:objectName, 
			accessKeyId:cred.ACCESS_KEY_ID, secretAccessKey:cred.SECRET_KEY, host:(isNull(cred.HOST)?nullvalue():cred.HOST))) {
			S3Write( 
				value:"Susi Sorglos",
				bucketName:bucketName,  objectName:objectName, 
				accessKeyId:cred.ACCESS_KEY_ID, secretAccessKey:cred.SECRET_KEY, host:(isNull(cred.HOST)?nullvalue():cred.HOST));
		}

		var kids=S3ListBucket(bucketName:bucketName, accessKeyId:cred.ACCESS_KEY_ID, secretAccessKey:cred.SECRET_KEY,host:(isNull(cred.HOST)?nullvalue():cred.HOST));
		assertTrue(kids.recordcount>0);

		S3ClearBucket(bucketName:bucketName, accessKeyId:cred.ACCESS_KEY_ID, secretAccessKey:cred.SECRET_KEY,host:(isNull(cred.HOST)?nullvalue():cred.HOST));
		
		var kids=S3ListBucket(bucketName:bucketName, accessKeyId:cred.ACCESS_KEY_ID, secretAccessKey:cred.SECRET_KEY,host:(isNull(cred.HOST)?nullvalue():cred.HOST));
		assertTrue(kids.recordcount==0);
		
	}


	private function doFind(value){
		return value EQ "world";
	}
	
}