From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] omap2+: Use Kconfig symbol in Makefile instead of obj-y
Date: Wed, 24 Aug 2011 04:54:31 -0700
Message-ID: <20110824115431.2985.64232.stgit@kaulin>
References: <20110824115048.2985.24230.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45911 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754124Ab1HXLyc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 07:54:32 -0400
In-Reply-To: <20110824115048.2985.24230.stgit@kaulin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

As noted by Grant Likely <grant.likely@secretlab.ca>, omap2+ Makefile unnecessarily
repeats entries for common device init code instead of using Kconfig symbol.

Remove references to hsmmc.o and board-flash.o. Also omap_phy_internal.o
references can be removed once it has some Kconfig symbol to use.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile |   76 ++++++++++++++++++------------------------
 1 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f343365..b1501bd 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -185,78 +185,66 @@ endif
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
-obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
-					   hsmmc.o
+obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
-obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
-					   hsmmc.o
-obj-$(CONFIG_MACH_DEVKIT8000)     	+= board-devkit8000.o \
-                                           hsmmc.o
-obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
-					   board-flash.o \
-					   hsmmc.o
-obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o \
-					   hsmmc.o
-obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o \
-					   hsmmc.o
-obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
-					   hsmmc.o
-obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
-					   hsmmc.o
-obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
-					   hsmmc.o
-obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
-					   hsmmc.o \
-					   board-flash.o
+obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
+obj-$(CONFIG_MACH_DEVKIT8000)     	+= board-devkit8000.o
+obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o
+obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o
+obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o
+obj-$(CONFIG_MACH_ENCORE)		+= board-omap3encore.o
+obj-$(CONFIG_MACH_OVERO)		+= board-overo.o
+obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
+obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
+obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
-					   sdram-nokia.o \
-					   hsmmc.o
+					   sdram-nokia.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   sdram-nokia.o \
 					   board-rx51-peripherals.o \
-					   board-rx51-video.o \
-					   hsmmc.o
+					   board-rx51-video.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom.o \
 					   board-zoom-peripherals.o \
 					   board-zoom-display.o \
-					   board-flash.o \
-					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom.o \
 					   board-zoom-peripherals.o \
 					   board-zoom-display.o \
-					   board-flash.o \
-					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
 					   board-zoom-peripherals.o \
-					   board-zoom-display.o \
-					   board-flash.o \
-					   hsmmc.o
-obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
-					   hsmmc.o
+					   board-zoom-display.o
+obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o
 obj-$(CONFIG_MACH_CM_T3517)		+= board-cm-t3517.o
-obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
-					   hsmmc.o
-obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
-					   hsmmc.o
+obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o
+obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o \
-					   hsmmc.o \
 					   omap_phy_internal.o
 obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
-					   hsmmc.o \
+					   omap_phy_internal.o
+
+obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o \
 					   omap_phy_internal.o
 
 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
-					   omap_phy_internal.o \
+					   omap_phy_internal.o
 
 obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 
-obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o \
-					   hsmmc.o
+obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
+
 # Platform specific device init code
+
+omap-flash-$(CONFIG_MTD_NAND_OMAP2)	:= board-flash.o
+omap-flash-$(CONFIG_MTD_ONENAND_OMAP2)	:= board-flash.o
+obj-y					+= $(omap-flash-y) $(omap-flash-m)
+
+omap-hsmmc-$(CONFIG_MMC_OMAP_HS)	:= hsmmc.o
+obj-y					+= $(omap-hsmmc-m) $(omap-hsmmc-y)
+
+
 usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
 obj-y					+= $(usbfs-m) $(usbfs-y)
 obj-y					+= usb-musb.o

