From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 13/21] OMAP: DSS2: Taal: Change probe error handling labels
Date: Wed,  5 May 2010 17:27:33 +0300
Message-ID: <a4e7d90e0f036e227a29d94e28b7036c2f9d419b.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
 <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
 <61a89461654fe44174902f6e29b8acded7529b67.1273067195.git.ext-jani.1.nikula@nokia.com>
 <16a98ca1b45ba9b9bb30f23d242449c1d440df07.1273067195.git.ext-jani.1.nikula@nokia.com>
 <aa1e310d0d385db39b5d53ba4d3dcf02b7e2f47f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <0cfff2a3cbb4231b41b382caf8aab7c52f47b0d5.1273067195.git.ext-jani.1.nikula@nokia.com>
 <adb61d94ee2a25284f6bd3f55ec4213501cbe8e3.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4cb510ffbc3216e2a7dac16edaff5fb1980b3315.1273067195.git.ext-jani.1.nikula@nokia.com>
 <8665676eca5bbd3be35b63f7110f629e94a6babe.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34121 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934770Ab0EEO2G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:06 -0400
In-Reply-To: <8665676eca5bbd3be35b63f7110f629e94a6babe.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Switch from numbered to named labels to make it easier to add new
labels for error handling.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index fa4c67b..e32424c 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -539,7 +539,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	td = kzalloc(sizeof(*td), GFP_KERNEL);
 	if (!td) {
 		r = -ENOMEM;
-		goto err0;
+		goto err;
 	}
 	td->dssdev = dssdev;
 
@@ -549,7 +549,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	if (td->esd_wq == NULL) {
 		dev_err(&dssdev->dev, "can't create ESD workqueue\n");
 		r = -ENOMEM;
-		goto err1;
+		goto err_wq;
 	}
 	INIT_DELAYED_WORK_DEFERRABLE(&td->esd_work, taal_esd_work);
 
@@ -571,7 +571,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 					  &taal_bl_ops, &props);
 	if (IS_ERR(bldev)) {
 		r = PTR_ERR(bldev);
-		goto err2;
+		goto err_bl;
 	}
 
 	td->bldev = bldev;
@@ -591,7 +591,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		r = gpio_request(gpio, "taal irq");
 		if (r) {
 			dev_err(&dssdev->dev, "GPIO request failed\n");
-			goto err3;
+			goto err_gpio;
 		}
 
 		gpio_direction_input(gpio);
@@ -603,7 +603,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		if (r) {
 			dev_err(&dssdev->dev, "IRQ request failed\n");
 			gpio_free(gpio);
-			goto err4;
+			goto err_irq;
 		}
 
 		init_completion(&td->te_completion);
@@ -614,23 +614,23 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	r = sysfs_create_group(&dssdev->dev.kobj, &taal_attr_group);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to create sysfs files\n");
-		goto err5;
+		goto err_sysfs;
 	}
 
 	return 0;
-err5:
+err_sysfs:
 	if (td->use_ext_te)
 		free_irq(gpio_to_irq(dssdev->phy.dsi.ext_te_gpio), dssdev);
-err4:
+err_irq:
 	if (td->use_ext_te)
 		gpio_free(dssdev->phy.dsi.ext_te_gpio);
-err3:
+err_gpio:
 	backlight_device_unregister(bldev);
-err2:
+err_bl:
 	destroy_workqueue(td->esd_wq);
-err1:
+err_wq:
 	kfree(td);
-err0:
+err:
 	return r;
 }
 
-- 
1.6.5.2

