From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/11] omap2/3/4: Update PMIC options for TWL and Menelaus
	chips
Date: Fri, 30 Apr 2010 13:34:07 -0700
Message-ID: <20100430203407.25812.60023.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65394 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933287Ab0D3UeL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:34:11 -0400
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

These are needed for mounting root on MMC on many boards.
Also disable CONFIG_WATCHDOG_NOWAYOUT, that can keep the
system from running with external watchdogs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_defconfig |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index d2ab492..a846836 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -1263,7 +1263,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_LIS3_I2C is not set
 # CONFIG_THERMAL is not set
 CONFIG_WATCHDOG=y
-CONFIG_WATCHDOG_NOWAYOUT=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
 
 #
 # Watchdog Device Drivers
@@ -1292,9 +1292,9 @@ CONFIG_MFD_CORE=y
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_MENELAUS is not set
+CONFIG_MENELAUS=y
 CONFIG_TWL4030_CORE=y
-# CONFIG_TWL4030_POWER is not set
+CONFIG_TWL4030_POWER=y
 CONFIG_TWL4030_CODEC=y
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
@@ -1313,7 +1313,7 @@ CONFIG_TWL4030_CODEC=y
 # CONFIG_AB4500_CORE is not set
 CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_DEBUG is not set
-CONFIG_REGULATOR_FIXED_VOLTAGE=y
+# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
 # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
@@ -1321,8 +1321,8 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_REGULATOR_MAX8660 is not set
 CONFIG_REGULATOR_TWL4030=y
 # CONFIG_REGULATOR_LP3971 is not set
-# CONFIG_REGULATOR_TPS65023 is not set
-# CONFIG_REGULATOR_TPS6507X is not set
+CONFIG_REGULATOR_TPS65023=y
+CONFIG_REGULATOR_TPS6507X=y
 # CONFIG_MEDIA_SUPPORT is not set
 
 #
@@ -1752,6 +1752,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_PCF8583 is not set
 # CONFIG_RTC_DRV_M41T80 is not set
 # CONFIG_RTC_DRV_BQ32K is not set
+CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set

