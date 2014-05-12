From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 10/19] OMAPDSS: Kconfig: Add depencies and help section to OMAP5_DSS_HDMI_AUDIO
Date: Mon, 12 May 2014 12:12:21 +0300
Message-ID: <4a37cf19921622f81e20abcaecb98d6542567b3e.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44744 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbaELJMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 05:12:55 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index ecc2f50..b28e175 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -90,8 +90,15 @@ config OMAP5_DSS_HDMI
 	  specification.
 
 config OMAP5_DSS_HDMI_AUDIO
+	bool "HDMI audio support for OMAP5"
 	depends on OMAP5_DSS_HDMI
-	bool
+	depends on SND_OMAP_SOC=y || OMAP2_DSS = SND_OMAP_SOC
+	default y
+	help
+	  HDMI audio support for OMAP5 based SoCs. Adds integrated
+	  ASoC Digital Audio Interface component driver into OMAPDSS
+	  module. Select SND_SOC_HDMI_CODEC and SND_SIMPLE_CARD with
+	  devicetree description for full HDMI audio support.
 
 config OMAP2_DSS_SDI
 	bool "SDI support"
-- 
1.7.9.5

