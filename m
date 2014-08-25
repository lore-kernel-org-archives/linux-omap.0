From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4 09/15] OMAPDSS: Kconfig: Implement options for OMAP4 and OMAP5 HDMI audio support
Date: Mon, 25 Aug 2014 22:04:17 +0300
Message-ID: <dbbb97319a3bf0d8a1a532788fb120f8e5979690.1408993242.git.jsarha@ti.com>
References: <cover.1408993242.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42392 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933373AbaHYTEt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Aug 2014 15:04:49 -0400
In-Reply-To: <cover.1408993242.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Selecting OMAP4_DSS_HDMI_AUDIO or OMAP5_DSS_HDMI_AUDIO option causes
OMAP2_DSS to select SND_OMAP_SOC_HDMI_AUDIO and SND_OMAP_SOC.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 3d5eb6c..14aa218 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -6,6 +6,8 @@ menuconfig OMAP2_DSS
 	select VIDEOMODE_HELPERS
 	select OMAP2_DSS_INIT
 	select HDMI
+	select SND_OMAP_SOC_HDMI_AUDIO if OMAP_DSS_HDMI_AUDIO
+	select SND_OMAP_SOC if OMAP_DSS_HDMI_AUDIO
         help
 	  OMAP2+ Display Subsystem support.
 
@@ -67,6 +69,9 @@ config OMAP2_DSS_VENC
 config OMAP2_DSS_HDMI_COMMON
 	bool
 
+config OMAP_DSS_HDMI_AUDIO
+	bool
+
 config OMAP4_DSS_HDMI
 	bool "HDMI support for OMAP4"
         default y
@@ -75,7 +80,17 @@ config OMAP4_DSS_HDMI
 	  HDMI support for OMAP4 based SoCs.
 
 config OMAP4_DSS_HDMI_AUDIO
-	bool
+	bool "OMAP5 HDMI audio support"
+	depends on OMAP4_DSS_HDMI
+	depends on SND_SOC=y || OMAP2_DSS = SND_SOC
+	select OMAP_DSS_HDMI_AUDIO
+	default y
+	help
+	  HDMI audio support for OMAP4 based SoCs. Selects audio
+	  support libarary for OMAPDSS HDMI driver. The librarry
+	  implements an integrated ASoC Digital Audio Interface
+	  component driver into OMAPDSS module and registers a dummy
+	  HDMI codec and SND_SIMPLE_CARD for full HDMI audio support.
 
 config OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
@@ -87,8 +102,17 @@ config OMAP5_DSS_HDMI
 	  specification.
 
 config OMAP5_DSS_HDMI_AUDIO
+	bool "OMAP5 HDMI audio support"
 	depends on OMAP5_DSS_HDMI
-	bool
+	depends on SND_SOC=y || OMAP2_DSS = SND_SOC
+	select OMAP_DSS_HDMI_AUDIO
+	default y
+	help
+	  HDMI audio support for OMAP5 based SoCs. Selects audio
+	  support libarary for OMAPDSS HDMI driver. The librarry
+	  implements an integrated ASoC Digital Audio Interface
+	  component driver into OMAPDSS module and registers a dummy
+	  HDMI codec and SND_SIMPLE_CARD for full HDMI audio support.
 
 config OMAP2_DSS_SDI
 	bool "SDI support"
-- 
1.7.9.5

