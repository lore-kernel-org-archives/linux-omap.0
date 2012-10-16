From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 5/6] OMAPDSS: HDMI: Handle error when initing the display at probe
Date: Mon, 15 Oct 2012 20:27:18 -0500
Message-ID: <1350350839-30408-6-git-send-email-ricardo.neri@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52191 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab2JPB3o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:29:44 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9G1ThS2009341
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:43 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9G1Thwo015148
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:43 -0500
In-Reply-To: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Do not blindly assume that the panel could be init'ed.

While there, put mutex initialization in the same place.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index bea42f4..e5be0a5 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -60,6 +60,7 @@
 static struct {
 	struct mutex lock;
 	struct platform_device *pdev;
+
 	struct hdmi_ip_data ip_data;
 
 	struct clk *sys_clk;
@@ -1004,6 +1005,7 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi.pdev = pdev;
 
 	mutex_init(&hdmi.lock);
+	mutex_init(&hdmi.ip_data.lock);
 
 	res = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1036,9 +1038,11 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi.ip_data.pll_offset = HDMI_PLLCTRL;
 	hdmi.ip_data.phy_offset = HDMI_PHY;
 
-	mutex_init(&hdmi.ip_data.lock);
-
-	hdmi_panel_init();
+	r = hdmi_panel_init();
+	if (r) {
+		DSSERR("can't init panel\n");
+		goto err_panel_init;
+	}
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
@@ -1047,6 +1051,10 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi_probe_pdata(pdev);
 
 	return 0;
+
+err_panel_init:
+	hdmi_put_clocks();
+	return r;
 }
 
 static int __exit hdmi_remove_child(struct device *dev, void *data)
-- 
1.7.5.4

