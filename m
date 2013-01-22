From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Tue, 22 Jan 2013 10:15:08 +0000
Message-ID: <50FE66AC.2090306@mimc.co.uk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com> <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna> <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com> <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk> <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:42791 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752279Ab3AVKPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 05:15:09 -0500
In-Reply-To: <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Matt Porter <mporter@ti.com>, Richard Cochran <richardcochran@gmail.com>, "Menon\\, Nishanth" <nm@ti.com>, "Hiremath\\, Vaibhav" <hvaibhav@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel\\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 22/01/13 02:24, Paul Walmsley wrote:
>=20
> Hi guys,
>=20
> Regarding the AM33xx test failures with appended DTBs, it would be ve=
ry=20
> helpful if especially the TI people could try reproducing the problem=
=2E

My non-working setup (I'm using a recent U-Boot) is as follows ...

[Note that the DTB patch mentioned elsewhere in this thread seems to be=
 *already* applied to -next]

$ git describe
next-20130121
$ make -j 8 ARCH=3Darm CROSS_COMPILE=3Darm-linux- omap2plus_defconfig
$ make -j 8 ARCH=3Darm CROSS_COMPILE=3Darm-linux- menuconfig
CONFIG_ARM_APPENDED_DTB=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
CONFIG_EARLY_PRINTK=3Dy
$ make -j 8 ARCH=3Darm CROSS_COMPILE=3Darm-linux-
$ cat arch/arm/boot/zImage arch/arm/boot/dtb/am335x-bone.dtb > arch/arm=
/boot/zImage-dtb.am335x-bone
$ scripts/mkuboot.sh -A arm -O linux -C none -T kernel -a 0=D780008000 =
-e 0=D780008000 -n =91Linux=92 -d
arch/arm/boot/zImage-dtb.am335x-bone arch/arm/boot/uImage-dtb.am335x-bo=
ne
$ cp arch/arm/boot/uImage-dtb.am335x-bone /tftpboot/nanobone/uImage-dtb

And when I boot:-

U-Boot SPL 2013.01 (Jan 16 2013 - 15:20:58)
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2013.01 (Jan 16 2013 - 15:20:58)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
NAND:  No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
*** Warning - readenv() failed, using default environment

musb-hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk combine, bulk spl=
it, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Peripheral mode controller at 47401000 using PIO, IRQ 0
musb-hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk combine, bulk spl=
it, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
USB Host mode controller at 47401800 using PIO, IRQ 0
Net:   cpsw, usb_ether
Hit any key to stop autoboot:  0
mmc0 is current device
SD/MMC found on device 0
reading uEnv.txt
167 bytes read in 3 ms (53.7 KiB/s)
Loaded environment from uEnv.txt
Importing environment from mmc ...
Running uenvcmd ...
cpsw Waiting for PHY auto negotiation to complete. done
link up on port 0, speed 100, full duplex
BOOTP broadcast 1
BOOTP broadcast 2
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
DHCP client bound to address 10.0.0.112
Using cpsw device
TFTP from server 10.0.0.100; our IP address is 10.0.0.112
=46ilename '/nanobone/uImage-dtb'.
Load address: 0x80000000
Loading: ##############################################################=
###
         ##############################################################=
###
         ##############################################################=
###
         ##############################################################=
###
         ###########
         627.9 KiB/s
done
Bytes transferred =3D 3963919 (3c7c0f hex)
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3963855 Bytes =3D 3.8 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
