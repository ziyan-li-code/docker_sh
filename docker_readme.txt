(1) Generate a dockerfile in local position "path_to_dockerfile".

(2) cd "path_to_dockerfile" in Docker Desktop's terminal

(3) docker build -t user_name/file_name:version_tag .

(4) docker images to obtain the Image_ID 

(5) docker tag Image_ID user_name/file_name:version_tag

(6) docker push user_name/file_name:version_tag