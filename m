From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 06/15] OMAPDSS: hdmi: Add pdev pointer for audio_pdev in HDMI DRV data
Date: Tue, 16 Sep 2014 13:04:20 +0300
Message-ID: <6ce17ea991fe8efa49127ed43c5f41978b2210a0.1410860765.git.jsarha@ti.com>
References: <cover.1410860765.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54410 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbaIPKEt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 06:04:49 -0400
In-Reply-To: <cover.1410860765.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

This is used to store omap-hdmi-audio pdev for unregistering it.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 6bf077b..a6e08ff 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -368,6 +368,8 @@ struct omap_hdmi {
 	bool core_enabled;
 
 	struct omap_dss_device output;
+
+	struct platform_device *audio_pdev;
 };
 
 #endif
-- 
1.7.9.5

