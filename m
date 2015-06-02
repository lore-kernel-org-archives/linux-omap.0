From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Enable TOUCHSCREEN_PIXCIR
Date: Tue, 2 Jun 2015 12:45:11 +0300
Message-ID: <1433238311-12990-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55171 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756117AbbFBJpS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 05:45:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Some of the OMAP based boards e.g. am437x-gp-evm have
the Pixcir touch controller. Enable the related device
driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3743ca2..45cdeb8 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -204,6 +204,7 @@ CONFIG_KEYBOARD_TWL4030=m
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
+CONFIG_TOUCHSCREEN_PIXCIR=m
 CONFIG_TOUCHSCREEN_TSC2005=m
 CONFIG_TOUCHSCREEN_TSC2007=m
 CONFIG_INPUT_MISC=y
-- 
2.1.4

