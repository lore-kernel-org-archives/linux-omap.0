From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/6] OMAPDSS: HDMI: Rename resource variable at probe.
Date: Mon, 15 Oct 2012 20:27:14 -0500
Message-ID: <1350350839-30408-2-git-send-email-ricardo.neri@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755452Ab2JPB3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 21:29:43 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9G1Thwa030363
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:43 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9G1Tgfa015133
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:42 -0500
In-Reply-To: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Minor cleanup to give to the resource variable a more proper name.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index a48a7dd..2cba177 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -997,22 +997,21 @@ static void __exit hdmi_uninit_output(struct platform_device *pdev)
 /* HDMI HW IP initialisation */
 static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 {
-	struct resource *hdmi_mem;
+	struct resource *res;
 	int r;
 
 	hdmi.pdev = pdev;
 
 	mutex_init(&hdmi.lock);
 
-	hdmi_mem = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
-	if (!hdmi_mem) {
+	res = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
+	if (!res) {
 		DSSERR("can't get IORESOURCE_MEM HDMI\n");
 		return -EINVAL;
 	}
 
 	/* Base address taken from platform */
-	hdmi.ip_data.base_wp = ioremap(hdmi_mem->start,
-						resource_size(hdmi_mem));
+	hdmi.ip_data.base_wp = ioremap(res->start, resource_size(res));
 	if (!hdmi.ip_data.base_wp) {
 		DSSERR("can't ioremap WP\n");
 		return -ENOMEM;
-- 
1.7.5.4

