From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 12/18] OMAPDSS: hdmi.h: Add members to hdmi drvdata for audio implementation
Date: Tue, 14 Oct 2014 20:29:31 +0300
Message-ID: <3811cd4b435ab6bff3697a690af0af9070378c9c.1413306131.git.jsarha@ti.com>
References: <cover.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35598 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755422AbaJNRaD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2014 13:30:03 -0400
In-Reply-To: <cover.1413306131.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds display_enabled flag and audio_abort_cb callback to struct hdmi.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 6d129f2..bfaaf2f 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -366,10 +366,12 @@ struct omap_hdmi {
 	struct regulator *vdda_reg;
 
 	bool core_enabled;
+	bool display_enabled;
 
 	struct omap_dss_device output;
 
 	struct platform_device *audio_pdev;
+	void (*audio_abort_cb)(struct device *dev);
 };
 
 #endif
-- 
1.7.9.5

