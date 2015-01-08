From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Enable misc options for BeagleBoard-X15 platform
Date: Thu, 8 Jan 2015 15:14:40 -0600
Message-ID: <1420751680-21230-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46939 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637AbbAHVPG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2015 16:15:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

BeagleBoard-X15 has options such as rtc, fan that need to be functional

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Applies on
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
branch:
omap-for-v3.20/defconfig  4af41284e83c ARM: omap2plus_defconfig: enable TPS65218 power button

 erch/arm/configs/omap2plus_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b5ccb36c599b..3435e6043710 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -184,6 +184,7 @@ CONFIG_TOUCHSCREEN_TSC2007=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_TPS65218_PWRBUTTON=m
 CONFIG_INPUT_TWL4030_PWRBUTTON=m
+CONFIG_INPUT_PALMAS_PWRBUTTON=m
 CONFIG_SERIO=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
@@ -205,6 +206,7 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_TWL4030=y
+CONFIG_GPIO_PALMAS=y
 CONFIG_W1=m
 CONFIG_HDQ_MASTER_OMAP=m
 CONFIG_BATTERY_BQ27x00=m
@@ -216,6 +218,7 @@ CONFIG_CHARGER_BQ24735=m
 CONFIG_POWER_RESET=y
 CONFIG_POWER_AVS=y
 CONFIG_HWMON=m
+CONFIG_SENSORS_GPIO_FAN=m
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_TMP102=m
 CONFIG_THERMAL=m
@@ -346,6 +349,8 @@ CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_GPIO=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=m
+CONFIG_RTC_DRV_PALMAS=m
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=m
 CONFIG_RTC_DRV_OMAP=m
-- 
1.7.9.5

