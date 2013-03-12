From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Booting 3.9.0-rc2 on Beaglebone ?
Date: Tue, 12 Mar 2013 20:44:04 +0000
Message-ID: <513F9394.6010306@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:41482 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932514Ab3CLUoI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 16:44:08 -0400
Received: from [10.1.0.107] (unknown [176.62.209.156])
	by centos1.newflow.co.uk (Postfix) with ESMTP id 734A226B8039
	for <linux-omap@vger.kernel.org>; Tue, 12 Mar 2013 20:44:05 +0000 (GMT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm struggling to get the latest kernel git to load on my beaglebone.

My build process is:-

$ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux- distclean
$ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux- omap2plus_defconfig
CONFIG_DEBUG_LL=y
CONFIG_DEBUG_OMAP2PLUS_UART=y
CONFIG_DEBUG_AM33XXUART1=y
CONFIG_EARLY_PRINTK=y
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
$ make -j 8 ARCH=arm CROSS_COMPILE=arm-linux-
$ cat arch/arm/boot/zImage arch/arm/boot/am335x-bone.dtb > 
arch/arm/boot/zImage-dtb.am335x-bone
$ scripts/mkuboot.sh -A arm -O linux -C none  -T kernel -a 0x80008000 -e 
0x80008000 -n 'Linux' -d arch/arm/boot/zImage-dtb.am335x-bone 
arch/arm/boot/uImage-dtb.am335x-bone

But this produces the following when booting:-

## Booting kernel from Legacy Image at 80000000 ...
    Image Name:   Linux
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    3995640 Bytes = 3.8 MiB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...


Error: unrecognized/unsupported machine ID (r1 = 0x00000e05).

Available machine support:

ID (hex)        NAME
ffffffff        Generic OMAP5 (Flattened Device Tree)
ffffffff        Generic OMAP4 (Flattened Device Tree)
ffffffff        Generic AM33XX (Flattened Device Tree)
ffffffff        Generic OMAP3-GP (Flattened Device Tree)
ffffffff        Generic OMAP3 (Flattened Device Tree)
ffffffff        Generic OMAP2430 (Flattened Device Tree)
ffffffff        Generic OMAP2420 (Flattened Device Tree)
000001fe        OMAP2420 H4 board
00000384        OMAP2430 sdp2430 board
0000060a        OMAP3 Beagle Board
0000091a        OMAP3 Devkit8000
00000667        OMAP LDP board
000006ed        OMAP Logic 3530 LV SOM board
00000882        Logic OMAP3 Torpedo board
00000706        Gumstix Overo
000005ff        OMAP3 EVM
000006e1        Pandora Handheld Console
00000472        OMAP3430 3430SDP board
000006bf        Nokia N810 WiMAX
0000060c        Nokia N810
000004f7        Nokia N800
00000dc2        Nokia RM-696 board
00000c94        Nokia RM-680 board
000007a3        Nokia RX-51 board
000009a0        OMAP Zoom3 board
000007af        OMAP Zoom2 board
000009a1        OMAP 3630SDP board
00000cda        Compulab CM-T3730
00000925        Compulab CM-T35
00000abe        Compulab CM-T3517
00000a9d        IGEP OMAP3 module
00000928        IGEP v2 board
00000959        OMAP3 touchbook Board
00000870        OMAP4430 4430SDP board
00000ae7        OMAP4 Panda board
00000898        OMAP3517/AM3517 EVM
00000aa2        OMAP3 STALKER
00000bbc        ti8148evm
00000af0        ti8168evm
ffffffff        ARM-Versatile Express
000008e0        ARM-Versatile Express

Please check your kernel config and/or bootloader.

I guess I'm missing some vital step ?

Thanks for any help
Mark J.
