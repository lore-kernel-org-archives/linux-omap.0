From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/22] OMAPDSS: HDMI5: disable interlace modes
Date: Wed, 12 Nov 2014 13:52:17 +0200
Message-ID: <1415793144-11723-16-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53624 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbaKLLxH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:53:07 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We don't support interlace modes properly on OMAP5+ HDMI, so we need to
reject interlace timings.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 169b764bb9d4..c053d692ec16 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -290,6 +290,10 @@ static int hdmi_display_check_timing(struct omap_dss_device *dssdev,
 {
 	struct omap_dss_device *out = &hdmi.output;
 
+	/* TODO: proper interlace support */
+	if (timings->interlace)
+		return -EINVAL;
+
 	if (!dispc_mgr_timings_ok(out->dispc_channel, timings))
 		return -EINVAL;
 
-- 
2.1.3

