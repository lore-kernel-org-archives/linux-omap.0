From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 14/24] omap4: Enable WDT and McBSP support
Date: Tue, 16 Feb 2010 21:28:05 +0530
Message-ID: <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54284 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757055Ab0BPP6i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:58:38 -0500
In-Reply-To: <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>

This patch enables watchdog timer and McBSP support on omap4430
sdp platform.
Additinaly the uart3 made as default console in the omap_4430sdp_defconfig

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    7 ++++---
 drivers/watchdog/Kconfig                |    6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 3de640a..7ac3fbf 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -199,7 +199,7 @@ CONFIG_ARCH_OMAP4=y
 #
 # CONFIG_OMAP_RESET_CLOCKS is not set
 # CONFIG_OMAP_MUX is not set
-# CONFIG_OMAP_MCBSP is not set
+CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MBOX_FWK is not set
 # CONFIG_OMAP_MPU_TIMER is not set
 CONFIG_OMAP_32K_TIMER=y
@@ -304,7 +304,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/ram0 rw mem=128M console=ttyS0,115200n8 initrd=0x81600000,20M ramdisk_size=20480"
+CONFIG_CMDLINE="root=/dev/ram0 rw mem=128M console=ttyS2,115200n8 initrd=0x81600000,20M ramdisk_size=20480"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
@@ -488,7 +488,8 @@ CONFIG_GPIOLIB=y
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
-# CONFIG_WATCHDOG is not set
+CONFIG_WATCHDOG=y
+CONFIG_OMAP_WATCHDOG=y
 CONFIG_SSB_POSSIBLE=y
 
 #
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3da3f48..1185f05 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -194,10 +194,10 @@ config EP93XX_WATCHDOG
 
 config OMAP_WATCHDOG
 	tristate "OMAP Watchdog"
-	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP3
+	depends on ARCH_OMAP16XX || ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
 	help
-	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog.  Say 'Y'
-	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430 watchdog timer.
+	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430 watchdog.  Say 'Y'
+	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430 watchdog timer.
 
 config PNX4008_WATCHDOG
 	tristate "PNX4008 Watchdog"
-- 
1.6.0.4

