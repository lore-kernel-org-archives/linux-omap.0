From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v2 5/6] TI816X: Enable Build for TI816X EVM
Date: Wed, 11 Aug 2010 22:41:19 +0530
Message-ID: <1281546679-11554-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52919 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537Ab0HKRL2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Aug 2010 13:11:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch adds build support for TI816X. This enables building files in
mach-omap2 and plat-omap directories.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/Makefile            |    1 +
 arch/arm/mach-omap2/Makefile |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 63d998e..8a089a5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -179,6 +179,7 @@ machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
 machine-$(CONFIG_ARCH_STMP37XX)		:= stmp37xx
+machine-$(CONFIG_ARCH_TI816X)		:= omap2
 machine-$(CONFIG_ARCH_U300)		:= u300
 machine-$(CONFIG_ARCH_U8500)		:= ux500
 machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 63b2d88..380aa7c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -16,6 +16,7 @@ clock-common				= clock.o clock_common_data.o \
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP4) += $(prcm-common) $(hwmod-common)
+obj-$(CONFIG_ARCH_TI816X) += $(omap-2-3-common) $(prcm-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
@@ -158,6 +159,7 @@ obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
 
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o \
 					   hsmmc.o
+obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
 # Platform specific device init code
 usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
 obj-y					+= $(usbfs-m) $(usbfs-y)
-- 
1.6.2.4

