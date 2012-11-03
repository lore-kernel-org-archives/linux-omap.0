From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 4/7] OMAPDSS: HDMI: Handle panel init error at probe
Date: Fri, 2 Nov 2012 18:31:45 -0600
Message-ID: <1351902708-866-5-git-send-email-ricardo.neri@ti.com>
References: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48286 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141Ab2KBXeN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 19:34:13 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA2NYDWI029592
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:13 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA2NYDBb013386
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:13 -0500
In-Reply-To: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Do not blindly assume that the panel could be initialized.

While there, group mutex initialization at a single place.
Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 51ee0a6..696386c 100644
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
@@ -1031,9 +1033,11 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
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
 
@@ -1042,6 +1046,10 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
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

