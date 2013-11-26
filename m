From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12 diet] ARM: OMAP2+: Remove legacy omap3 board-*.c
 files and make mach-omap2 DT only for booting
Date: Mon, 25 Nov 2013 17:17:45 -0800
Message-ID: <20131126011744.GA26766@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50372 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752115Ab3KZBRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 20:17:47 -0500
Content-Disposition: inline
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

We can now boot all mach-omap2 related boards using appended device
tree by creating a related .dts file with pretty much the same
functionality as booted in the legacy platform data mode.

So let's remove the legacy board files so we can finally make mach-omap2
boot using device tree only. The main reason for doing this is to leave
out massive amounts of legacy platform data that is no longer needed
when booted with device tree.

There are some devices that still need platform data, but that we
can deal with using the auxdata support in mach-omap2/pdata-quirks.c
based on the board specific device tree compatible flag.

The only board-*.c files remaining will be board-generic.c that's used
for device tree based booting, and board-n8x0.c that's needed temporarily
until basic omap2 legacy devices work with device tree. Note that we're
also removing board-ti8168evm.c that's not omap3, but that seems broken
anyways as it's missing handle_irq. And there's really nothing stopping
us from booting ti81xx with device tree either except adding support to
board-generic.c like other omaps have.

If you're new to booting things with device tree, here are some quick
instructions for bringing up new boards with device tree:

1. Look at the existing files in arch/arm/boot/dts

There's a fair chance somebody has already created a suitable
file for your board.

2. Create omap3-yourboard.dts file in arch/arm/boot/dts

If you don't see a suitable omap3-*.dts file, chances are your
board is very similar to one of them. For older 34xx/35xx based
boards take a look at the omap3-beagle.dts and omap3-ldp.dts, and
for newer 36xx/37xx based boards take a look at omap3-beagle-xm.dts
and omap3-evm-37xx.dts.

3. Add omap3-yourboard.dtb to the arch/arm/boot/dts/Makefile

4. Check that you have the necessary .config options enabled

CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y

These are enabled in omap2plus_defconfig by default.

5. Build the kernel

$ ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- make omap3-myboard.dtb
$ ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- make zImage

6. Append the .dtb file to zImage

$ cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-evm-37xx.dtb > /tmp/zImage

7. Optionally run mkimage to create uImage file

$ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
  -n Linux -d /tmp/zImage-omap2plus /tmp/uImage-omap2plus

8. Add support for further devices to the .dts files

Please try to add support for further devices as device tree drivers.
If you need some legacy devices to keep things working, you can also
use the pdata-quirk.c to initialize those.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Here's the diet version of this patch as the full patch was too big
for the lists it seems.

This diet version of the patch just removes the legacy board-*.c file
entries from Kconfig and Makefile, which should be enough for most
people for testing.

If the full patch does not make it to the lists, it's also available
here:

http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/commit/?id=1f7260bc2ba270ef04b8eaa2a7824fb32aa516aa

The full patch also removes the following board-*.c files:

 arch/arm/mach-omap2/board-3430sdp.c          |  633 ------------
 arch/arm/mach-omap2/board-am3517crane.c      |  150 ---
 arch/arm/mach-omap2/board-am3517evm.c        |  379 -------
 arch/arm/mach-omap2/board-cm-t35.c           |  771 ---------------
 arch/arm/mach-omap2/board-cm-t3517.c         |  337 ------
 arch/arm/mach-omap2/board-devkit8000.c       |  655 -------------
 arch/arm/mach-omap2/board-ldp.c              |  425 --------
 arch/arm/mach-omap2/board-omap3beagle.c      |  596 ------------
 arch/arm/mach-omap2/board-omap3logic.c       |  251 -----
 arch/arm/mach-omap2/board-omap3pandora.c     |  630 ------------
 arch/arm/mach-omap2/board-omap3stalker.c     |  438 --------
 arch/arm/mach-omap2/board-omap3touchbook.c   |  396 --------
 arch/arm/mach-omap2/board-overo.c            |  572 -----------
 arch/arm/mach-omap2/board-rx51-peripherals.c | 1323 ---------------------------
 arch/arm/mach-omap2/board-rx51-video.c       |   67 -
 arch/arm/mach-omap2/board-rx51.c             |  142 --
 arch/arm/mach-omap2/board-ti8168evm.c        |   62 -


--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -192,80 +192,6 @@ config MACH_OMAP2_TUSB6010
 	depends on ARCH_OMAP2 && SOC_OMAP2420
 	default y if MACH_NOKIA_N8X0
 
-config MACH_OMAP3_BEAGLE
-	bool "OMAP3 BEAGLE board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
-config MACH_DEVKIT8000
-	bool "DEVKIT8000 board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CUS
-
-config MACH_OMAP_LDP
-	bool "OMAP3 LDP board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
-config MACH_OMAP3530_LV_SOM
-	bool "OMAP3 Logic 3530 LV SOM board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-	help
-	 Support for the LogicPD OMAP3530 SOM Development kit
-	 for full description please see the products webpage at
-	 http://www.logicpd.com/products/development-kits/texas-instruments-zoom%E2%84%A2-omap35x-development-kit
-
-config MACH_OMAP3_TORPEDO
-	bool "OMAP3 Logic 35x Torpedo board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-	help
-	 Support for the LogicPD OMAP35x Torpedo Development kit
-	 for full description please see the products webpage at
-	 http://www.logicpd.com/products/development-kits/zoom-omap35x-torpedo-development-kit
-
-config MACH_OVERO
-	bool "Gumstix Overo board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
-config MACH_OMAP3517EVM
-	bool "OMAP3517/ AM3517 EVM board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
-config MACH_CRANEBOARD
-	bool "AM3517/05 CRANE board"
-	depends on ARCH_OMAP3
-	select OMAP_PACKAGE_CBB
-
-config MACH_OMAP3_PANDORA
-	bool "OMAP3 Pandora"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-
-config MACH_TOUCHBOOK
-	bool "OMAP3 Touch Book"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
-config MACH_OMAP_3430SDP
-	bool "OMAP 3430 SDP board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
 config MACH_NOKIA_N800
        bool
 
@@ -284,44 +210,6 @@ config MACH_NOKIA_N8X0
 	select MACH_NOKIA_N810_WIMAX
 	select OMAP_PACKAGE_ZAC
 
-config MACH_NOKIA_RX51
-	bool "Nokia N900 (RX-51) phone"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
-config MACH_CM_T35
-	bool "CompuLab CM-T35/CM-T3730 modules"
-	depends on ARCH_OMAP3
-	default y
-	select MACH_CM_T3730
-	select OMAP_PACKAGE_CUS
-
-config MACH_CM_T3517
-	bool "CompuLab CM-T3517 module"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
-config MACH_CM_T3730
-       bool
-
-config MACH_SBC3530
-	bool "OMAP3 SBC STALKER board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CUS
-
-config MACH_TI8168EVM
-	bool "TI8168 Evaluation Module"
-	depends on SOC_TI81XX
-	default y
-
-config MACH_TI8148EVM
-	bool "TI8148 Evaluation Module"
-	depends on SOC_TI81XX
-	default y
-
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f78b177..914256e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -235,29 +235,7 @@ obj-$(CONFIG_SOC_OMAP2420)		+= msdi.o
 
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o pdata-quirks.o
-obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
-obj-$(CONFIG_MACH_DEVKIT8000)     	+= board-devkit8000.o
-obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o
-obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o
-obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o
-obj-$(CONFIG_MACH_OVERO)		+= board-overo.o
-obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
-obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
-obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o sdram-nokia.o
-obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-peripherals.o
-obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-video.o
-obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o
-obj-$(CONFIG_MACH_CM_T3517)		+= board-cm-t3517.o
-obj-$(CONFIG_MACH_TOUCHBOOK)		+= board-omap3touchbook.o
-
-obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
-
-obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
-
-obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
-obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
-obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8168evm.o
 
 # Platform specific device init code
 
