From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v7.1 10/19] OMAPDSS: Kconfig: Remove HDMI audio booleans from Kconfig
Date: Wed, 12 Nov 2014 16:41:01 +0200
Message-ID: <252f750efa0fadaa58508e9fc87d3a128b915dfc.1415803065.git.jsarha@ti.com>
References: <cover.1415803064.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45153 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099AbaKLOld (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 09:41:33 -0500
In-Reply-To: <cover.1415803064.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

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

