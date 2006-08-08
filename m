From: Yan-Ming <kabbin26@yahoo.com.tw>
Subject: Building Uboot 1.1.4 problems
Date: Tue, 8 Aug 2006 18:41:03 +0800 (CST)
Message-ID: <20060808104103.44810.qmail@web17801.mail.tpe.yahoo.com>
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

HI
   I am a newbie for boot loader, and I have some problems when update
u-boot 1.1.3 to u-boot 1.1.4 for OMAP2420 H4 ES 2.X Menelaus COMBO.

 First, I got u-boot.bin.gz from
http://linux.omap.com/pub/bootloader/h4/u-boot.bin.gz
 gunzip it and renamed to u-boot.bin.raw.

After that, I used TI OST_Host to burn it to flash. It really work!
and I got the following messages:
*****************************************
U-Boot 1.1.3 (Feb 27 2006 - 12:26:39)
U-Boot code: 80E80000 -> 80E9C658  BSS: -> 80EA1424
OMAP2420-GP revision 3, PRCM III
TI H4 SDP Base Board + Menelaus Daughter Board + mDDR
RAM Configuration:
Bank #0: 80000000 32 MB
Bank #1: 82000000 32 MB
Flash: 64 MB
In:    serial
Out:   serial
Err:   serial
*****************************************

But when I build u-boot-1.1.4
from ftp://ftp.denx.de/pub/u-boot/u-boot-1.1.4.tar.bz2
using arm-linux-gcc-4.0.2-glibc-2.3.6

#make distclean
#make omap2420h4_config
#make all

I got error message:
common/env_flash.c  row: 267 undefined reference to 'flash_probe'

I comment the line 267 and then build with no error message.
Also, I got u-boot.bin and rename it to u-boout.bin.raw.
But after buring to Flash by OST, it shows nothing at all on the terminal.

Could anyone help me,please ?
Any advise would be very helpful.Thanks.
Best regards.

 ___________________________________________________=20
 =B3=CC=B7s=AA=A9 Yahoo!=A9_=BC=AF=A7Y=AE=C9=B3q=B0T 7.0=A1A=A7K=B6O=BA=F4=
=B8=F4=B9q=B8=DC=A5=F4=A7A=A5=B4=A1I=20
 http://messenger.yahoo.com.tw/
