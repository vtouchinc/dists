DIST_NAME=("focal" "bionic")
OS=("Ubuntu")
CONTAINER=("main" "test")
KEYNAME="dev@vtouch.io"
for os in "${OS[@]}"; do
    cd $os
    for dist in "${DIST_NAME[@]}"; do
        cd $dist
        apt-ftparchive packages . > Packages
        gzip -k -f Packages
        apt-ftparchive release . > Release
        gpg --default-key ${KEYNAME} -abs -o Release.gpg Release
        gpg --default-key ${KEYNAME} --clearsign -o InRelease Release
        cd ..
    done
    apt-ftparchive packages . > Packages
    gzip -k -f Packages
    apt-ftparchive release . > Release
    gpg --default-key ${KEYNAME} -abs -o Release.gpg Release
    gpg --default-key ${KEYNAME} --clearsign -o InRelease Release
    cd ..
done