From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/5] OMAP3: RX51: Updated rx51_defconfig
Date: Thu, 6 Aug 2009 11:12:19 +0300
Message-ID: <20090806081218.GG7374@atomide.com>
References: <20090805141051.1964.74687.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hYooF8G/hrfVAmum"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49537 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZHFIM1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 04:12:27 -0400
Content-Disposition: inline
In-Reply-To: <20090805141051.1964.74687.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just one more..

Tony

--hYooF8G/hrfVAmum
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="rx51-boots.patch"

>From a46c20070f08759cfbd42c05fe7debb178d896cb Mon Sep 17 00:00:00 2001
From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Thu, 6 Aug 2009 11:07:46 +0300
Subject: [PATCH] OMAP3: RX51: Updated rx51_defconfig

Added REGULATOR, MMC and updated default CMDLINE so RX51 now boots.

Note that the regulator code should be moved from mmc-twl4030.c
to omap_hsmmc.c so it can be a module.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

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
 

--hYooF8G/hrfVAmum--
