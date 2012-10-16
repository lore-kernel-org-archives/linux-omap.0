From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/6] OMAPDSS: Convert to devm_ioremap
Date: Mon, 15 Oct 2012 20:27:15 -0500
Message-ID: <1350350839-30408-3-git-send-email-ricardo.neri@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44015 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500Ab2JPB3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 21:29:43 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9G1Th2w007237
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:43 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9G1ThKl015136
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:43 -0500
In-Reply-To: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Using devm_ioremap provides better memory handling and improves
readability.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 2cba177..6773e2c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1010,8 +1010,13 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), "HDMI"))
+		return -EBUSY;
+
 	/* Base address taken from platform */
-	hdmi.ip_data.base_wp = ioremap(res->start, resource_size(res));
+	hdmi.ip_data.base_wp = devm_ioremap(&pdev->dev, res->start,
+					     resource_size(res));
 	if (!hdmi.ip_data.base_wp) {
 		DSSERR("can't ioremap WP\n");
 		return -ENOMEM;
@@ -1019,7 +1024,7 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	r = hdmi_get_clocks(pdev);
 	if (r) {
-		iounmap(hdmi.ip_data.base_wp);
+		DSSERR("can't get clocks\n");
 		return r;
 	}
 
@@ -1064,8 +1069,6 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 
 	hdmi_put_clocks();
 
-	iounmap(hdmi.ip_data.base_wp);
-
 	return 0;
 }
 
-- 
1.7.5.4

