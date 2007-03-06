From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: query on u-boot support for Micron nand flash
Date: Tue, 6 Mar 2007 07:16:25 -0600
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C6CBA8BA@dlee12.ent.ti.com>
References: <c04186510703060111l6928d500ocaea71d55cf77af8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c04186510703060111l6928d500ocaea71d55cf77af8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sandeep prabhu <sandeep.mitian@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I am aware of one of our customers using Micron large page NAND and
booting Linux.  They received u-boot code support from Micron.  You
might want to contact Micron for their support.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces+s-kipisz2=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+s-kipisz2=3Dti.com@linux.omap.com]=

On Behalf Of sandeep prabhu
Sent: Tuesday, March 06, 2007 3:11 AM
To: Linux-omap-open-source@linux.omap.com
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
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
