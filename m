From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 06/13] OMAPDSS: Kconfig: Update OMAP4_DSS_HDMI_AUDIO option
Date: Fri, 27 Jun 2014 21:38:48 +0300
Message-ID: <60203a25c536855bfcbda46afcc7c3db67bc03ca.1403894190.git.jsarha@ti.com>
References: <cover.1403894190.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42177 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbaF0SjU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 14:39:20 -0400
In-Reply-To: <cover.1403894190.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

Add help section to OMAP4_DSS_HDMI_AUDIO with dependency to
OMAP4_DSS_HDMI and select for newly created OMAP_DSS_HDMI_AUDIO. The
OMAP_DSS_HDMI_AUDIO option is for common HDMI audio support and it is
is dependent on SND_SOC.

Also selects SND_OMAP_SOC, SND_SOC_HDMI_CODEC, and SND_SIMPLE_CARD for
OMAP2_DSS if OMAP_DSS_HDMI_AUDIO is enabled.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 41fb8ac..701164a 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -6,6 +6,9 @@ menuconfig OMAP2_DSS
 	select VIDEOMODE_HELPERS
 	select OMAP2_DSS_INIT
 	select HDMI
+	select SND_OMAP_SOC if OMAP_DSS_HDMI_AUDIO
+	select SND_SOC_HDMI_CODEC if OMAP_DSS_HDMI_AUDIO
+	select SND_SIMPLE_CARD if OMAP_DSS_HDMI_AUDIO
         help
 	  OMAP2+ Display Subsystem support.
 
@@ -78,7 +81,17 @@ config OMAP4_DSS_HDMI
 	  HDMI support for OMAP4 based SoCs.
 
 config OMAP4_DSS_HDMI_AUDIO
-	bool
+	bool "HDMI audio support for OMAP4"
+	depends on OMAP4_DSS_HDMI
+	depends on SND_SOC=y || OMAP2_DSS = SND_SOC
+	select OMAP_DSS_HDMI_AUDIO
+	default y
+	help
+	  HDMI audio support for OMAP4 based SoCs. Adds integrated
+	  ASoC Digital Audio Interface component driver into OMAPDSS
+	  module. If enabled OMAP2_DSS selects SND_OMAP_SOC,
+	  SND_SOC_HDMI_CODEC, and SND_SIMPLE_CARD for full HDMI
+	  audio support.
 
 config OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
-- 
1.7.9.5

