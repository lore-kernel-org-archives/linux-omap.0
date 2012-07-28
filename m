From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/2] OMAPDSS:HDMI: Improve error handling at power on
Date: Fri, 27 Jul 2012 19:21:37 -0500
Message-ID: <1343434897-8444-3-git-send-email-ricardo.neri@ti.com>
References: <1343434897-8444-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47355 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab2G1AYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jul 2012 20:24:04 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6S0O4El014513
	for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 19:24:04 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6S0O4xC020954
	for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 19:24:04 -0500
In-Reply-To: <1343434897-8444-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Handle the errors that may occur when selecting the source of the
sync signal for the DIGIT channel of the display controller and
when enabling the PHY.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 060216f..3caac2a 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -501,13 +501,17 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	r = hdmi.ip_data.ops->phy_enable(&hdmi.ip_data);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
-		goto err;
+		goto err_phy_enable;
 	}
 
 	hdmi.ip_data.ops->video_configure(&hdmi.ip_data);
 
 	/* Make selection of HDMI in DSS */
-	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
+	r = dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
+	if (r) {
+		DSSDBG("Failed to start PHY\n");
+		goto err_src_hdmi_venc;
+	}
 
 	/* Select the dispc clock source as PRCM clock, to ensure that it is not
 	 * DSI PLL source as the clock selected by DSI PLL might not be
@@ -536,7 +540,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 err_mgr_enable:
 	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 err_vid_enable:
+err_src_hdmi_venc:
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
+err_phy_enable:
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 err:
 	hdmi_runtime_put();
-- 
1.7.5.4

