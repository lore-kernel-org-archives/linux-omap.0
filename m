From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 6/7] ARM: OMAP2+: omap2plus_defconfig: Enable leds-gpio driver
Date: Wed, 21 Nov 2012 12:29:22 +0530
Message-ID: <1353481163-29462-7-git-send-email-anilkumar@ti.com>
References: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55344 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640Ab2KUG7i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 01:59:38 -0500
In-Reply-To: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

AM335X-EVMSK and AM335X-BONE devices have gpio controlled user leds,
one has to manually enable this support to use user leds. So this
patch enables gpio-leds driver in omap2plus_defconfig. Also enables
TRIGGER_TIMER and TRIGGER_HEARTBEAT.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 133f04a..5e1a763 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -202,6 +202,11 @@ CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_SDIO_UART=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_OMAP=y
 CONFIG_RTC_DRV_TWL92330=y
-- 
1.7.9.5

