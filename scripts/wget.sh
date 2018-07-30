BIN_PATH=../packages
wget -O $BIN_PATH/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
wget -O $BIN_PATH/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
wget -O $BIN_PATH/cfssl-certinfo https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
chmod +x $BIN_PATH/*
