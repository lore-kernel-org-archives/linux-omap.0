From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v4 4/4] ARM: OMAP2+: omap2plus_defconfig: Enable RTC support
Date: Fri, 14 Dec 2012 11:33:17 +0530
Message-ID: <1355464997-19367-5-git-send-email-anilkumar@ti.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60758 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab2LNGEG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 01:04:06 -0500
In-Reply-To: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com
Cc: grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com, rob.herring@calxeda.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

AM33XX family of devices use RTC module, one has to manually enable
this support to use RTC features. So this patch enable RTC driver in
omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 0ce6771..e58afc5 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -216,6 +216,7 @@ CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_OMAP=y
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_DMADEVICES=y
-- 
1.7.9.5

