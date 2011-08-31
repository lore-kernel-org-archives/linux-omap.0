From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 8/8] OMAP: DSS2: HDMI: fix hdmi output enable
Date: Wed, 31 Aug 2011 16:21:48 +0300
Message-ID: <1314796908-17354-9-git-send-email-tomi.valkeinen@ti.com>
References: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37074 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755693Ab1HaNWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:22:18 -0400
In-Reply-To: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Enabling HDMI output often causes sync lost errors. The problem seems to
go away if we first enable the HDMI output, and only then enable the
DISPC output.

This will also fix the dispc's dispc_mgr_enable_digit_out(), as the code
waits for two VSYNCs after enabling the output. If the HDMI output is
disabled (as it was previously), there are no VSYNCs and
dispc_mgr_enable_digit_out() will print timeout errors.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 504c507..d08096b 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1184,10 +1184,10 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dispc_set_digit_size(dssdev->panel.timings.x_res,
 			dssdev->panel.timings.y_res);
 
-	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
-
 	hdmi_wp_video_start(1);
 
+	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
+
 	return 0;
 err:
 	hdmi_runtime_put();
-- 
1.7.4.1

