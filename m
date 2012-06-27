From: Paul Walmsley <paul@pwsan.com>
Subject: RE: Current state of AM33xx patches
Date: Wed, 27 Jun 2012 12:31:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271218540.27496@utopia.booyaka.com>
References: <4FD5BA4C.9070706@gmail.com> <4FD5FD9E.5040203@ti.com> <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com> <79CD15C6BA57404B839C016229A409A83EA5B7DE@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52885 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab2F0SbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 14:31:08 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5B7DE@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Domenico Andreoli <cavokz@gmail.com>, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav

On Wed, 27 Jun 2012, Hiremath, Vaibhav wrote:

> Build Steps:
> ============
>  - make ARCH=arm CROSS_COMPILE=<toolchain> distclean
>  - make ARCH=arm CROSS_COMPILE=<toolchain> omap2plus_defconfig
>  - Enable option CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
>  - make ARCH=arm CROSS_COMPILE=<toolchain> uImage-dtb.am335x-evm
>    (Since I am not using DT aware u-boot)
> 
> Use the ramdisk image to boot kernel, since we do not have support for any 
> storage devices in the mainline.
> 
> U-Boot commands to boot:
> ========================
> setenv bootcmd 'mmc rescan 0; fatload mmc 0 81000000 uImage; fatload mmc 0 82000000 ramdisk-pm.gz; bootm 81000000'
> setenv bootargs 'console=ttyO0,115200n8 mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial'
> boot
> 
> 
> Hope this will help you to boot the kernel on BeagleBone.

Was anyone else able to get this to work?

I tried these steps here but with one difference: I put the U-boot 
commands into the uEnv.txt file:

optargs=mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial ignore_loglevel debug
uenvcmd=mmc rescan 0; fatload mmc 0 81000000 uImage; fatload mmc 0 82000000 ramdisk-pm.gz; bootm 81000000

Unfortunately the kernel did not boot.  The log is at the bottom of this 
file.  I did verify in U-boot that the commands were being executed 
correctly by walking through them by hand.

The branch used was your am335x-upstream-staging branch, plus a minor 
patch to allow the kernel to build on an am335x-only config (although for 
the purposes of this test, omap2plus_defconfig was used).

This is on a BeagleBone A3, using gcc version 4.5.1 (Sourcery G++ Lite 
2010.09-50).

Enabling CONFIG_EARLY_PRINTK doesn't make any difference, which isn't too 
surprising since there's no output from the kernel at all.  
Unfortunately, I don't have the time to do in-depth troubleshooting here 
with JTAG.

Any thoughts? 


- Paul


No daughter card present
NAND:  HW ECC Hamming Code selected
nand_get_flash_type: second ID read did not match 10,10 against 00,00
No NAND device found!!!
0 MiB
MMC:   OMAP SD/MMC: 0
*** Warning - readenv() failed, using default environment

Net:   cpsw
Hit any key to stop autoboot:  0 
SD/MMC found on device 0
reading uEnv.txt

224 bytes read
Loaded environment from uEnv.txt
Importing environment from mmc ...
Running uenvcmd ...
reading uImage

3819902 bytes read
reading ramdisk-pm.gz

2013059 bytes read
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.5.0-rc1-11828-ge2b3dd1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3819838 Bytes = 3.6 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...



