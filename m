From: kabbin <kabbin26@yahoo.com.tw>
Subject: Building kenel error
Date: Fri, 18 Aug 2006 17:18:40 +0800 (CST)
Message-ID: <20060818091840.41324.qmail@web17810.mail.tpe.yahoo.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Dear all:
  I use arm-linux-gcc-4.0.2-glibc-2.3.6 to build linux kernel from
http://linux.omap.com/pub/kernel/h4/source/linux-2.6.10-omap2420-omap2430=
.tgz

# make clean
# make omap_h4_2420_defconfig=20
# make uImage

and I got :
arch/arm/mach-omap2/clock24xx.c: In function =98c'clk_safe':
arch/arm/mach-omap2/clock24xx.c:1365: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1366: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1370: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1371: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1378: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1379: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1383: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1384: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1388: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1392: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1396: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1397: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1401: error: case label does not reduce t=
o an integer constant
arch/arm/mach-omap2/clock24xx.c:1402: error: case label does not reduce t=
o an integer constant
make[1]: *** [arch/arm/mach-omap2/clock24xx.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2


Is this a well-known bug? And do I need to find a patch for it?=20
Thanks for your help.=20
BEST REGARDS. =20


___________________________________________________=20
 =B3=CC=B7s=AA=A9 Yahoo!=A9_=BC=AF=A7Y=AE=C9=B3q=B0T 7.0=A1A=A7K=B6O=BA=F4=
=B8=F4=B9q=B8=DC=A5=F4=A7A=A5=B4=A1I=20
 http://messenger.yahoo.com.tw/
