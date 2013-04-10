From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: OMAP4+: omap2plus_defconfig: Enable audio via TWL6040 as module
Date: Wed, 10 Apr 2013 11:08:00 +0200
Message-ID: <1365584880-25810-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57328 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab3DJJIH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 05:08:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Jyri Sarha <jsarha@ti.com>

Boards supported upstream all use TWL6040 as audio codec, enable the common
ASoC machine driver by default for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index bd07864..eea501c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -152,6 +152,7 @@ CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
 CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65910=y
+CONFIG_TWL6040_CORE=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
@@ -194,6 +195,7 @@ CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_OMAP_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
+CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
 CONFIG_USB=y
 CONFIG_USB_DEBUG=y
-- 
1.8.1.5

