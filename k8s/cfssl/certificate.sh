CERT_DIR=ca
BIN_DIR=bin
cat > $CERT_DIR/ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
         "expiry": "87600h",
         "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ]
      }
    }
  }
}
EOF

cat > $CERT_DIR/ca-csr.json <<EOF
{
    "CN": "kubernetes",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "Beijing",
            "ST": "Beijing",
            "O": "k8s",
            "OU": "System"
        }
    ]
}
EOF

$BIN_DIR/cfssl gencert -initca $CERT_DIR/ca-csr.json | $BIN_DIR/cfssljson -bare $CERT_DIR/ca -


cat > $CERT_DIR/server-csr.json <<EOF
{
    "CN": "kubernetes",
    "hosts": [
      "127.0.0.1",
      "172.17.100.11",
      "172.17.100.12",
      "172.17.100.13",
      "10.10.10.1",
      "kubernetes",
      "kubernetes.default",
      "kubernetes.default.svc",
      "kubernetes.default.svc.cluster",
      "kubernetes.default.svc.cluster.local"
    ],
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "BeiJing",
            "ST": "BeiJing",
            "O": "k8s",
            "OU": "System"
        }
    ]
}
EOF

$BIN_DIR/cfssl gencert -ca=$CERT_DIR/ca.pem -ca-key=$CERT_DIR/ca-key.pem -config=$CERT_DIR/ca-config.json -profile=kubernetes $CERT_DIR/server-csr.json | $BIN_DIR/cfssljson -bare $CERT_DIR/server


cat > $CERT_DIR/admin-csr.json <<EOF
{
  "CN": "admin",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "L": "BeiJing",
      "ST": "BeiJing",
      "O": "system:masters",
      "OU": "System"
    }
  ]
}
EOF

$BIN_DIR/cfssl gencert -ca=$CERT_DIR/ca.pem -ca-key=$CERT_DIR/ca-key.pem -config=$CERT_DIR/ca-config.json -profile=kubernetes $CERT_DIR/admin-csr.json | $BIN_DIR/cfssljson -bare $CERT_DIR/admin


cat > $CERT_DIR/kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "L": "BeiJing",
      "ST": "BeiJing",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
EOF

$BIN_DIR/cfssl gencert -ca=$CERT_DIR/ca.pem -ca-key=$CERT_DIR/ca-key.pem -config=$CERT_DIR/ca-config.json -profile=kubernetes $CERT_DIR/kube-proxy-csr.json | $BIN_DIR/cfssljson -bare $CERT_DIR/kube-proxy
