From: Tony Lindgren <tony@atomide.com>
Subject: Re: dtb for pandaboard
Date: Wed, 11 Jul 2012 00:42:33 -0700
Message-ID: <20120711074232.GE1122@atomide.com>
References: <20120708173259.592552c1@pegasus.ausil.us>
 <20120709090848.GD1122@atomide.com>
 <20120710181119.27faf235@pegasus.ausil.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27392 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741Ab2GKHmf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 03:42:35 -0400
Content-Disposition: inline
In-Reply-To: <20120710181119.27faf235@pegasus.ausil.us>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dennis Gilmore <dennis@ausil.us>
Cc: linux-omap@vger.kernel.org

* Dennis Gilmore <dennis@ausil.us> [120710 16:16]:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Mon, 9 Jul 2012 02:08:49 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Dennis Gilmore <dennis@ausil.us> [120708 16:11]:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > Hi does anyone happen to have a working dtb file for the pandaboard?
> > > trying to test booting the fedora rawhide kernel which is
> > > 3.5.0-rc5 with a dtb file I made from the matching sources I dont
> > > get past decompressing the kernel. if i dont use a dtb file the
> > > system boots further but it i'm unable to find the root filesystem
> > > since it seems that the platform data has been messed up.
> > > modprobing omap results in no registration of the mmc block
> > > devices. 
> > > 
> > > i've not tested on a pandaboard ES or beagleboard yet  or any other
> > > type of omap system. 
> > 
> > FYI, I booted my panda es recently just fine with dtb append support
> > and the following .config addition using the plain
> > arch/arm/boot/dts/omap4-panda.dts file:
> > 
> > CONFIG_ARM_APPENDED_DTB=y
> > CONFIG_ARM_ATAG_DTB_COMPAT=y
> > CONFIG_EXT4_FS=y
> > 
> > Can you please enable DEBUG_LL, EARLY_PRINTK and add earlyprintk to
> > your cmdline and post what you get?
> > 
> > Regards,
> > 
> > Tony
> 
> Loaded environment from uEnv.txt
> Importing environment from mmc ...
> reading uImage-omap
> 
> 3988040 bytes read
> reading uInitrd-omap
> 
> 1190 bytes read
> reading omap4-panda.dtb
> 
> 5483 bytes read
> Booting from mmc ...
> ## Booting kernel from Legacy Image at 80300000 ...
>    Image Name:   3.5.0-0.rc6.git0.3.fc18.armv7hl.
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3987976 Bytes = 3.8 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at 81600000 ...
>    Image Name:   initramfs
>    Image Type:   ARM Linux RAMDisk Image (uncompressed)
>    Data Size:    1126 Bytes = 1.1 KiB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 82600000
>    Booting using the fdt blob at 0x82600000
>    Loading Kernel Image ... OK
> OK
>    reserving fdt memory region: addr=9d000000 size=3000000
>    Loading Ramdisk to bfefa000, end bfefa466 ... OK
>    Loading Device Tree to bfef5000, end bfef956a ... OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> Warning: Neither atags nor dtb found
> 
> is as far as i am getting.

Sounds like it's some kind of issue with dtb getting overwritten
by something. We had an issue where kernel BSS was overlapping dtb
in some cases, but those should be fixed.

Maybe try to leave out ARCH_OMAP2 and ARCH_OMAP3 and maybe CONFIG_NET
from your .config to make the kernel smaller and see if that makes
a difference?

If that works, then moving the dtb address in uEnv.txt should help.

Also, please check if the same issue happens with appended dtb:

Add the following to your .config:

CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y

Build the kernel, then create the uImage:

$ cat arch/arm/boot/zImage arch/arm/boot/$MACHINE.dtb > /srv/tftp/zImage-omap2plus && \
mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
-n "Linux" -d /srv/tftp/zImage-omap2plus /srv/tftp/uImage-omap2plus

You may need to leave out the dtb from your uEnv.txt, I forgot which dtb
is the primary one..

Regards,

Tony
