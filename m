From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v7.1 12/19] OMAPDSS: hdmi.h: Add members to hdmi drvdata for audio implementation
Date: Wed, 12 Nov 2014 16:41:03 +0200
Message-ID: <34f0cd3f1e273a702eb5e962d2eca93d8f34ff86.1415803065.git.jsarha@ti.com>
References: <cover.1415803064.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48815 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbaKLOlh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 09:41:37 -0500
In-Reply-To: <cover.1415803064.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

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

