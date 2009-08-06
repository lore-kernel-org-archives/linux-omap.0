From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH v2] OMAP3: RX51: Updated rx51_defconfig
Date: Thu,  6 Aug 2009 11:01:45 +0300
Message-ID: <1249545705-9651-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37004 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbZHFICY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 04:02:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Added REGULATOR, MMC and updated default CMDLINE. Linux-omap
now boots on RX51.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/configs/rx51_defconfig |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index eb2cb31..f238df6 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -282,7 +282,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw console=ttyMTD,log console=tty0"
+CONFIG_CMDLINE="init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw console=ttyMTD,log console=tty0 console=ttyS2,115200n8"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
@@ -1354,7 +1354,7 @@ CONFIG_USB_OTG_UTILS=y
 # CONFIG_USB_GPIO_VBUS is not set
 # CONFIG_ISP1301_OMAP is not set
 CONFIG_TWL4030_USB=y
-CONFIG_MMC=m
+CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
 
@@ -1449,7 +1449,8 @@ CONFIG_RTC_DRV_TWL4030=m
 # on-CPU RTC drivers
 #
 # CONFIG_DMADEVICES is not set
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set
 
-- 
1.6.0.4

