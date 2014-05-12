From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 18/19] ARM: omap2plus_defconfig: Enable OMAP5 HDMI support
Date: Mon, 12 May 2014 12:12:29 +0300
Message-ID: <0bfc3fad1abdf93cfd2b063554564dc540838646.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37975 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443AbaELJNG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 05:13:06 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

This patch is here only as an example on how to enable HDMI video for
OMAP5 uEVM. Adds CONFIG_GPIO_PCA953X=y and CONFIG_OMAP5_DSS_HDMI=y.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 35c42aa..363733e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -157,6 +157,7 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_TWL4030=y
+CONFIG_GPIO_PCA953X=y
 CONFIG_W1=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_SENSORS_LM75=m
@@ -190,6 +191,7 @@ CONFIG_FB_TILEBLITTING=y
 CONFIG_OMAP2_DSS=y
 CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
+CONFIG_OMAP5_DSS_HDMI=y
 CONFIG_FB_OMAP2=y
 CONFIG_DISPLAY_ENCODER_TFP410=m
 CONFIG_DISPLAY_ENCODER_TPD12S015=m
-- 
1.7.9.5

