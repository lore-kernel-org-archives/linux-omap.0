From: <Ling.Alex@iac.com.tw>
Subject: RE: query on u-boot support for Micron nand flash
Date: Wed, 7 Mar 2007 08:22:11 +0800
Message-ID: <922E8E753B0EE949B450E3AE20BE48439EFCA4@IACSMX8.isc.iac>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Large page NAND flash has some differences in command/address cycles. In =
fact, u-boot 1.1.4 supports 2K page size NAND Flash by its nand flash =
driver in drivers/nand/*. You can porting it to the legacy nand flash =
driver just with some small modifications :)



-----Original Message-----
From: linux-omap-open-source-bounces+s-kipisz2=3Dti.com at =
linux.omap.com
[mailto:linux-omap-open-source-bounces+s-kipisz2=3Dti.com at =
linux.omap.com]
On Behalf Of sandeep prabhu
Sent: Tuesday, March 06, 2007 3:11 AM
To: Linux-omap-open-source at linux.omap.com
Subject: query on u-boot support for Micron nand flash

Hi,

I am using Micron NAND flash (MT29F1GxxABB) on a custom omap2430 based
board, to which I am porting the u-boot (version 1.1.4).
I am downloading the u-boot ELF image using CCS and trying to access
NAND
Flash using the u-boot commands. I am using the nand legacy
driver(drivers/nand_legacy/nand_legacy.c).
I am able to detect the nand flash, and retrieve the vendor and device
ID
properly, but read/write operations fail on nand flash.

Nand Chip Details:
Chip       : MT29F1GxxABB
Total Size : 128MB
Page Size  : 2KB
OOB Size   : 64bytes per page.
Block Size : 128KB =3D 64Pages
# of Blocks: 1024
Bus Width  : 16 bit (16x)

I have following queries on this:

1. Does u-boot support large page NAND devices like this Micron chip ?
and
if it does, how to enable it ?
2. Does anyone has driver for Micron NAND Flash ? any patches that need
to
be applied ?


Please help,
Sandeep Prabhu


=20
Best regards,
Alex
Tel 021-64853668 ext 2434
Mail Ling.Alex@iac.com.tw
=20
