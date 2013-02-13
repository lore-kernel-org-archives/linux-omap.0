From: Archit Taneja <archit@ti.com>
Subject: [PATCH 24/33] OMAPDSS: picodlp panel: handle gpio data in panel driver
Date: Wed, 13 Feb 2013 19:52:16 +0530
Message-ID: <1360765345-19312-25-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39941 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934079Ab3BMOY1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:27 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The picodlp panel driver leaves gpio requests to the platform's board file.
These should happen in the panel driver itself.

A platform data struct called picodlp_panel_data already exists to hold gpio
numbers and other platform data. Request all the gpios in the panel driver so
that the board files which use the the panel don't need to do it.

This will help in removing the need for the panel drivers to have platform
related callbacks.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-picodlp.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 56d536c..bc8ac77 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -423,10 +423,13 @@ static int picodlp_panel_probe(struct omap_dss_device *dssdev)
 	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
 	struct i2c_adapter *adapter;
 	struct i2c_client *picodlp_i2c_client;
-	int picodlp_adapter_id;
+	int r, picodlp_adapter_id;
 
 	dssdev->panel.timings = pico_ls_timings;
 
+	if (!picodlp_pdata)
+		return -EINVAL;
+
 	picod = devm_kzalloc(&dssdev->dev, sizeof(*picod), GFP_KERNEL);
 	if (!picod)
 		return -ENOMEM;
@@ -452,6 +455,22 @@ static int picodlp_panel_probe(struct omap_dss_device *dssdev)
 
 	dev_set_drvdata(&dssdev->dev, picod);
 
+	if (gpio_is_valid(picodlp_pdata->emu_done_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev,
+				picodlp_pdata->emu_done_gpio,
+				GPIOF_IN, "DLP EMU DONE");
+		if (r)
+			return r;
+	}
+
+	if (gpio_is_valid(picodlp_pdata->pwrgood_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev,
+				picodlp_pdata->pwrgood_gpio,
+				GPIOF_OUT_INIT_LOW, "DLP PWRGOOD");
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5

