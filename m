From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/11] OMAPDSS: HDMI4: fix error handling
Date: Wed, 17 Jun 2015 15:54:34 +0300
Message-ID: <1434545675-477-11-git-send-email-tomi.valkeinen@ti.com>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43912 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755464AbbFQMzE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 08:55:04 -0400
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Error handling in hdmi_power_on_full() is not correct, and could leave
resources unfreed.

Fix this by arranging the error labels correctly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 916d47978f41..e1345abd41bb 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -229,9 +229,9 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 err_mgr_enable:
 	hdmi_wp_video_stop(&hdmi.wp);
 err_vid_enable:
-err_phy_cfg:
 	hdmi_wp_set_phy_pwr(&hdmi.wp, HDMI_PHYPWRCMD_OFF);
 err_phy_pwr:
+err_phy_cfg:
 err_pll_cfg:
 	dss_pll_disable(&hdmi.pll.pll);
 err_pll_enable:
-- 
2.1.4

