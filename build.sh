./mvnw -V clean generate-sources -f cart-spec/pom.xml -P spec
sed 's|</project>||g' cart-spec/target/generated-sources/openapi/pom.xml > pom.txt
cat <<'EOF' > distributionManagement.txt
    <distributionManagement>
        <repository>
            <id>sonatype-snapshots</id>
            <name>sonatype-snapshots</name>
            <url>https://oss.sonatype.org/content/repositories/snapshots</url>
        </repository>
    </distributionManagement>
</project>
EOF
cat pom.txt distributionManagement.txt > cart-spec/target/generated-sources/openapi/pom.xml

./mvnw -V clean generate-sources -f catalog-spec/pom.xml -P spec
sed 's|</project>||g' catalog-spec/target/generated-sources/openapi/pom.xml > pom.txt
cat pom.txt distributionManagement.txt > catalog-spec/target/generated-sources/openapi/pom.xml

./mvnw -V clean generate-sources -f order-spec/pom.xml -P spec
sed 's|</project>||g' order-spec/target/generated-sources/openapi/pom.xml > pom.txt
cat pom.txt distributionManagement.txt > order-spec/target/generated-sources/openapi/pom.xml

./mvnw -V clean generate-sources -f payment-spec/pom.xml -P spec
sed 's|</project>||g' payment-spec/target/generated-sources/openapi/pom.xml > pom.txt
cat pom.txt distributionManagement.txt > payment-spec/target/generated-sources/openapi/pom.xml

./mvnw -V clean generate-sources -f shipping-spec/pom.xml -P spec
sed 's|</project>||g' shipping-spec/target/generated-sources/openapi/pom.xml > pom.txt
cat pom.txt distributionManagement.txt > shipping-spec/target/generated-sources/openapi/pom.xml

./mvnw -V clean generate-sources -f user-spec/pom.xml -P spec
sed 's|</project>||g' user-spec/target/generated-sources/openapi/pom.xml > pom.txt
cat pom.txt distributionManagement.txt > user-spec/target/generated-sources/openapi/pom.xml

./mvnw -V clean package -f socks-common/pom.xml -U
./mvnw -V clean package -f cart-api/pom.xml -U
./mvnw -V clean package -f catalog-api/pom.xml -Dmaven.test.skip=true -U
./mvnw -V clean package -f order-api/pom.xml -U
./mvnw -V clean package -f payment-api/pom.xml -U
./mvnw -V clean package -f shipping-api/pom.xml -U
./mvnw -V clean package -f shop-ui/pom.xml -U
./mvnw -V clean package -f user-api/pom.xml -U

./mvnw -V spring-boot:build-image -f cart-api/pom.xml -Dspring-boot.build-image.imageName=698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-cart -Dmaven.test.skip=true
./mvnw -V spring-boot:build-image -f catalog-api/pom.xml -Dspring-boot.build-image.imageName=698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-catalog -Dmaven.test.skip=true
./mvnw -V spring-boot:build-image -f order-api/pom.xml -Dspring-boot.build-image.imageName=698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-order -Dmaven.test.skip=true
./mvnw -V spring-boot:build-image -f payment-api/pom.xml -Dspring-boot.build-image.imageName=698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-payment -Dmaven.test.skip=true
./mvnw -V spring-boot:build-image -f shipping-api/pom.xml -Dspring-boot.build-image.imageName=698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-shipping -Dmaven.test.skip=true
./mvnw -V spring-boot:build-image -f shop-ui/pom.xml -Dspring-boot.build-image.imageName=698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-ui -Dmaven.test.skip=true
./mvnw -V spring-boot:build-image -f user-api/pom.xml -Dspring-boot.build-image.imageName=698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-user -Dmaven.test.skip=true

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 698489875176.dkr.ecr.ap-southeast-1.amazonaws.com

docker push 698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-cart:latest
docker push 698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-catalog:latest
docker push 698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-order:latest
docker push 698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-payment:latest
docker push 698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-shipping:latest
docker push 698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-ui:latest
docker push 698489875176.dkr.ecr.ap-southeast-1.amazonaws.com/spring-socks-user:latest

