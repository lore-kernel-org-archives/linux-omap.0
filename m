From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 07/12] OMAPDSS: Kconfig: Select audio dependencies if OMAP5_DSS_HDMI_AUDIO=y
Date: Thu, 26 Jun 2014 22:20:58 +0300
Message-ID: <67ea660311de39b8a35e90a9a7d3b345fdaaf895.1403807781.git.jsarha@ti.com>
References: <cover.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48803 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaFZTVe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2014 15:21:34 -0400
In-Reply-To: <cover.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

Adds help section and SND_SOC dependency to OMAP4_DSS_HDMI_AUDIO.
Selects SND_OMAP_SOC, SND_SOC_HDMI_CODEC, and SND_SIMPLE_CARD if
OMAP4_DSS_HDMI_AUDIO is enabled.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 871f722..1cce26c 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -6,9 +6,9 @@ menuconfig OMAP2_DSS
 	select VIDEOMODE_HELPERS
 	select OMAP2_DSS_INIT
 	select HDMI
-	select SND_OMAP_SOC if OMAP4_DSS_HDMI_AUDIO
-	select SND_SOC_HDMI_CODEC if OMAP4_DSS_HDMI_AUDIO
-	select SND_SIMPLE_CARD if OMAP4_DSS_HDMI_AUDIO
+	select SND_OMAP_SOC if OMAP4_DSS_HDMI_AUDIO || OMAP5_DSS_HDMI_AUDIO
+	select SND_SOC_HDMI_CODEC if OMAP4_DSS_HDMI_AUDIO || OMAP5_DSS_HDMI_AUDIO
+	select SND_SIMPLE_CARD if OMAP4_DSS_HDMI_AUDIO || OMAP5_DSS_HDMI_AUDIO
         help
 	  OMAP2+ Display Subsystem support.
 
@@ -99,8 +99,16 @@ config OMAP5_DSS_HDMI
 	  specification.
 
 config OMAP5_DSS_HDMI_AUDIO
+	bool "HDMI audio support for OMAP5"
 	depends on OMAP5_DSS_HDMI
-	bool
+	depends on SND_SOC=y || OMAP2_DSS = SND_SOC
+	default y
+	help
+	  HDMI audio support for OMAP5 based SoCs. Adds integrated
+	  ASoC Digital Audio Interface component driver into OMAPDSS
+	  module. If enabled OMAP2_DSS selects SND_OMAP_SOC,
+	  SND_SOC_HDMI_CODEC, and SND_SIMPLE_CARD for full HDMI
+	  audio support.
 
 config OMAP2_DSS_SDI
 	bool "SDI support"
-- 
1.7.9.5

