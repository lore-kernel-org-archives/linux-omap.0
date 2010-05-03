From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 13/21] OMAP: DSS2: Taal: Change probe error handling labels
Date: Mon,  3 May 2010 09:18:33 +0300
Message-ID: <b88e1b382ddf14870c7a44e7ca620ad84d883b50.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1a68710812da041ef583944411a1b7027d216c96.1272621452.git.ext-jani.1.nikula@nokia.com>
 <85172e14c23339065e319230f9707353409a901e.1272621452.git.ext-jani.1.nikula@nokia.com>
 <6e9febe4d2179309dcf93b7a8e897890c871f086.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ad1917b1c316a85051c4a908705d403956ca1720.1272621452.git.ext-jani.1.nikula@nokia.com>
 <4004b06a47d3c1d20d6d8a30ddccdf536faeb5a0.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30955 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493Ab0ECGSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:55 -0400
In-Reply-To: <4004b06a47d3c1d20d6d8a30ddccdf536faeb5a0.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
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
index 5b6c945..0f62c96 100644
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
 
@@ -569,7 +569,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 					  &taal_bl_ops, &props);
 	if (IS_ERR(bldev)) {
 		r = PTR_ERR(bldev);
-		goto err2;
+		goto err_bl;
 	}
 
 	td->bldev = bldev;
@@ -589,7 +589,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		r = gpio_request(gpio, "taal irq");
 		if (r) {
 			dev_err(&dssdev->dev, "GPIO request failed\n");
-			goto err3;
+			goto err_gpio;
 		}
 
 		gpio_direction_input(gpio);
@@ -601,7 +601,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		if (r) {
 			dev_err(&dssdev->dev, "IRQ request failed\n");
 			gpio_free(gpio);
-			goto err4;
+			goto err_irq;
 		}
 
 		init_completion(&td->te_completion);
@@ -612,25 +612,25 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	r = sysfs_create_group(&dssdev->dev.kobj, &taal_attr_group);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to create sysfs files\n");
-		goto err5;
+		goto err_sysfs;
 	}
 
 	taal_hw_reset(dssdev);
 
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

