From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH 1/1] OMAPDSS: Return right error during connector probe
Date: Thu, 12 Sep 2013 14:12:55 +0530
Message-ID: <1378975375-14747-1-git-send-email-sathyap@ti.com>
References: <yes>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44677 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939Ab3ILInB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Sep 2013 04:43:01 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id r8C8h17T023473
	for <linux-omap@vger.kernel.org>; Thu, 12 Sep 2013 03:43:01 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id r8C8h1KR008402
	for <linux-omap@vger.kernel.org>; Thu, 12 Sep 2013 03:43:01 -0500
In-Reply-To: <yes>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Sathya Prakash M R <sathyap@ti.com>

While using HDMI connector driver with sil9022 encoder
came across issue where connector driver is probed first.
This resulted in error. A deffered probe solved this.
Most connector drivers need a encoder driver as their
video source. This patch ensures we do a probe defferal
if video source is not present for connector drivers.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
 .../video/omap2/displays-new/connector-analog-tv.c |    2 +-
 drivers/video/omap2/displays-new/connector-dvi.c   |    2 +-
 drivers/video/omap2/displays-new/connector-hdmi.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/displays-new/connector-analog-tv.c b/drivers/video/omap2/displays-new/connector-analog-tv.c
index 5338f36..547a604 100644
--- a/drivers/video/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/omap2/displays-new/connector-analog-tv.c
@@ -177,7 +177,7 @@ static int tvc_probe_pdata(struct platform_device *pdev)
 	in = omap_dss_find_output(pdata->source);
 	if (in == NULL) {
 		dev_err(&pdev->dev, "Failed to find video source\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 
 	ddata->in = in;
diff --git a/drivers/video/omap2/displays-new/connector-dvi.c b/drivers/video/omap2/displays-new/connector-dvi.c
index bc5f8ce..63d88ee 100644
--- a/drivers/video/omap2/displays-new/connector-dvi.c
+++ b/drivers/video/omap2/displays-new/connector-dvi.c
@@ -263,7 +263,7 @@ static int dvic_probe_pdata(struct platform_device *pdev)
 	in = omap_dss_find_output(pdata->source);
 	if (in == NULL) {
 		dev_err(&pdev->dev, "Failed to find video source\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 
 	ddata->in = in;
diff --git a/drivers/video/omap2/displays-new/connector-hdmi.c b/drivers/video/omap2/displays-new/connector-hdmi.c
index c582671..9abe2c0 100644
--- a/drivers/video/omap2/displays-new/connector-hdmi.c
+++ b/drivers/video/omap2/displays-new/connector-hdmi.c
@@ -290,7 +290,7 @@ static int hdmic_probe_pdata(struct platform_device *pdev)
 	in = omap_dss_find_output(pdata->source);
 	if (in == NULL) {
 		dev_err(&pdev->dev, "Failed to find video source\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 
 	ddata->in = in;
-- 
1.7.9.5

