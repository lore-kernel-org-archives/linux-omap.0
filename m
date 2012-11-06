From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3 1/7] OMAPDSS: HDMI: Rename resource variable at probe.
Date: Tue, 6 Nov 2012 00:19:11 -0600
Message-ID: <1352182757-1216-2-git-send-email-ricardo.neri@ti.com>
References: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54617 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab2KFFVv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 00:21:51 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA65LoSB001772
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:50 -0600
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA65Lowl016095
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:50 -0600
In-Reply-To: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Minor cleanup to give to the resource variable a more proper name.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index adcc906..cdb043d 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -998,22 +998,21 @@ static void __exit hdmi_uninit_output(struct platform_device *pdev)
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

