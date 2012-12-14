From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 7/8] ARM: OMAP2+: omap2plus_defconfig: Enable leds-gpio driver
Date: Fri, 14 Dec 2012 11:03:03 +0530
Message-ID: <1355463184-16283-8-git-send-email-anilkumar@ti.com>
References: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49432 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab2LNFdh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 00:33:37 -0500
In-Reply-To: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

AM335X-EVMSK and AM335X-BONE devices have gpio controlled user leds,
one has to manually enable this support to use user leds. So this
patch enables gpio-leds driver in omap2plus_defconfig. Also enables
different TRIGGERS like TRIGGER_TIMER, TRIGGER_HEARTBEAT and etc.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index e1d2385..b0ad0b0 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -200,6 +200,16 @@ CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_SDIO_UART=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
-- 
1.7.9.5

