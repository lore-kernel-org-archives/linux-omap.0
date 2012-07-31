From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] OMAPDSS: HDMI: Disable PLL properly in case of error at power_on
Date: Mon, 30 Jul 2012 19:12:02 -0500
Message-ID: <1343693522-26170-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53639 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308Ab2GaANX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 20:13:23 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6V0DMt7015226
	for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 19:13:22 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6V0DMGQ020766
	for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 19:13:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Small patch to disable the PLL appropriately before runtime_put in case
an error occurs while enabling the PHY.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 060216f..a65dafa 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -501,7 +501,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	r = hdmi.ip_data.ops->phy_enable(&hdmi.ip_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
-		goto err;
+		goto err_phy_enable;
 	}
 
 	hdmi.ip_data.ops->video_configure(&hdmi.ip_data);
@@ -537,6 +537,7 @@ err_mgr_enable:
 	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 err_vid_enable:
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
+err_phy_enable:
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 err:
 	hdmi_runtime_put();
-- 
1.7.5.4

