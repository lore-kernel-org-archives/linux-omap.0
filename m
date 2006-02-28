From: =?big5?q?=AAL=A4p=AA=B4?= <foxfromworld@yahoo.com.tw>
Subject: I can't make ssh for osk5912
Date: Tue, 28 Feb 2006 18:59:01 +0800 (CST)
Message-ID: <20060228105902.53508.qmail@web17505.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

When I make the ssh for osk. I found a problem about
-lz
Can you tell me how to solve it?
Many thanks.

make[1]: Entering directory
`/home/may/openssh-3.5p1/openbsd-compat'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/may/openssh-3.5p1/openbsd-compat'
arm-linux-gcc -o ssh ssh.o sshconnect.o sshconnect1.o
sshconnect2.o sshtty.o readconf.o clientloop.o -L.
-Lopenbsd-compat/ -L./fake-lib -lssh -lopenbsd-compat
-lutil -lz -lnsl  -lcrypto -lcrypt
/usr/local/arm/3.3.2/lib/gcc-lib/arm-linux/3.3.2/../../../../arm-linux/bi=
n/ld:
skipping incompatible ./fake-lib/libz.a when searching
for -lz
/usr/local/arm/3.3.2/lib/gcc-lib/arm-linux/3.3.2/../../../../arm-linux/bi=
n/ld:
cannot find -lz
collect2: ld returned 1 exit status
make: *** [ssh] Error 1


___________________________________________________  =B3=CC=B7s=AA=A9 Yah=
oo!=A9_=BC=AF=A7Y=AE=C9=B3q=B0T 7.0=A1A=A7K=B6O=BA=F4=B8=F4=B9q=B8=DC=A5=F4=
=A7A=A5=B4=A1I  http://messenger.yahoo.com.tw/
