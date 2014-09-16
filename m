From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 08/15] OMAPDSS: Kconfig: Remove HDMI audio booleans from Kconfig
Date: Tue, 16 Sep 2014 13:04:22 +0300
Message-ID: <368338029236c13764737a77f0a125ad2f77e17b.1410860765.git.jsarha@ti.com>
References: <cover.1410860765.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54414 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721AbaIPKEw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 06:04:52 -0400
In-Reply-To: <cover.1410860765.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The booleans are not used anymore. Just select SND_OMAP_SOC_HDMI_AUDIO
to enable OMAP HDMI audio support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 3d5eb6c..d1fa730 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -74,9 +74,6 @@ config OMAP4_DSS_HDMI
 	help
 	  HDMI support for OMAP4 based SoCs.
 
-config OMAP4_DSS_HDMI_AUDIO
-	bool
-
 config OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
 	default n
@@ -86,10 +83,6 @@ config OMAP5_DSS_HDMI
 	  Definition Multimedia Interface. See http://www.hdmi.org/ for HDMI
 	  specification.
 
-config OMAP5_DSS_HDMI_AUDIO
-	depends on OMAP5_DSS_HDMI
-	bool
-
 config OMAP2_DSS_SDI
 	bool "SDI support"
         default n
-- 
1.7.9.5

