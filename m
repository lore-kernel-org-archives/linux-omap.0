From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 13/13] ASoC: omap: Add Kconfig option for OMAP5 HDMI audio
Date: Fri, 23 May 2014 22:08:02 +0300
Message-ID: <cabfe3a2a2b3475bbd0ee8d121fb10c42c66b6fe.1400871999.git.jsarha@ti.com>
References: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46945 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaEWTIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 15:08:42 -0400
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds SND_OMAP_SOC_OMAP5_HDMI config option for OMAP5 HDMI audio support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/omap/Kconfig |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index d44463a..697e1b8 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -101,7 +101,7 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	  - PandaBoardES (4460)
 
 config SND_OMAP_SOC_OMAP_HDMI
-	tristate "SoC Audio support for Texas Instruments OMAP HDMI"
+	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
 	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && OMAP2_DSS
 	select SND_OMAP_SOC_HDMI
 	select SND_SOC_HDMI_CODEC
@@ -110,6 +110,17 @@ config SND_OMAP_SOC_OMAP_HDMI
 	  Say Y if you want to add support for SoC HDMI audio on Texas Instruments
 	  OMAP4 chips
 
+
+config SND_OMAP_SOC_OMAP5_HDMI
+	tristate "SoC Audio support for Texas Instruments OMAP5 HDMI"
+	depends on SND_OMAP_SOC && OMAP5_DSS_HDMI && OMAP2_DSS
+	select SND_OMAP_SOC_HDMI
+	select SND_SOC_HDMI_CODEC
+	select OMAP5_DSS_HDMI_AUDIO
+	help
+	  Say Y if you want to add support for SoC HDMI audio on Texas Instruments
+	  OMAP5 chips
+
 config SND_OMAP_SOC_OMAP3_PANDORA
 	tristate "SoC Audio support for OMAP3 Pandora"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
-- 
1.7.9.5

