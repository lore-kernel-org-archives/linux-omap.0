From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 8/8] OMAP: DSS2: HDMI: improve hdmi output enable
Date: Mon, 12 Sep 2011 12:12:53 +0300
Message-ID: <1315818773-18660-9-git-send-email-tomi.valkeinen@ti.com>
References: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:36793 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204Ab1ILJN1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:13:27 -0400
In-Reply-To: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

Enabling HDMI output often causes sync lost errors, and almost always
causes timeout errors being printed from dispc_mgr_enable_digit_out().

The sync lost problem seems to go lessen greatly if we first enable the
HDMI output, and only then enable the DISPC output. However, as this is
only based on observations, the fix may not be perfect as the problem
may lie somewhere else. Nevertheless, HDMI works better with this patch.

This will also fix the dispc's dispc_mgr_enable_digit_out(), as the code
waits for two VSYNCs after enabling the output. If the HDMI output is
disabled (as it was previously), there are no VSYNCs and
dispc_mgr_enable_digit_out() will print timeout errors.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 4752137..06a78b2 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -529,10 +529,10 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dispc_set_digit_size(dssdev->panel.timings.x_res,
 			dssdev->panel.timings.y_res);
 
-	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
-
 	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
 
+	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
+
 	return 0;
 err:
 	hdmi_runtime_put();
-- 
1.7.4.1

