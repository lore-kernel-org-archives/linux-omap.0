From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 2/7] OMAPDSS: HDMI: Convert to devm_request_and_ioremap
Date: Fri, 2 Nov 2012 18:31:43 -0600
Message-ID: <1351902708-866-3-git-send-email-ricardo.neri@ti.com>
References: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44981 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab2KBXeN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 19:34:13 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA2NYCBo022251
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:12 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA2NYC04013377
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:12 -0500
In-Reply-To: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Using devm_request_and_ioremap provides better memory handling and
improves readability.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index cdb043d..51ee0a6 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1012,7 +1012,7 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	}
 
 	/* Base address taken from platform */
-	hdmi.ip_data.base_wp = ioremap(res->start, resource_size(res));
+	hdmi.ip_data.base_wp = devm_request_and_ioremap(&pdev->dev, res);
 	if (!hdmi.ip_data.base_wp) {
 		DSSERR("can't ioremap WP\n");
 		return -ENOMEM;
@@ -1020,7 +1020,7 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	r = hdmi_get_clocks(pdev);
 	if (r) {
-		iounmap(hdmi.ip_data.base_wp);
+		DSSERR("can't get clocks\n");
 		return r;
 	}
 
@@ -1065,8 +1065,6 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 
 	hdmi_put_clocks();
 
-	iounmap(hdmi.ip_data.base_wp);
-
 	return 0;
 }
 
-- 
1.7.5.4

