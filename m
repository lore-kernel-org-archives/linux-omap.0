From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 06/21] OMAP: DSS2: Taal: Fix request_irq() error handling
Date: Wed,  5 May 2010 17:27:26 +0300
Message-ID: <61a89461654fe44174902f6e29b8acded7529b67.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
 <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65022 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540Ab0EEO2I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:08 -0400
In-Reply-To: <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Separate gpio_request() and request_irq() error handling.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index b7d1275..788aa91 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -603,7 +603,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		if (r) {
 			dev_err(&dssdev->dev, "IRQ request failed\n");
 			gpio_free(gpio);
-			goto err3;
+			goto err4;
 		}
 
 		init_completion(&td->te_completion);
@@ -614,16 +614,16 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	r = sysfs_create_group(&dssdev->dev.kobj, &taal_attr_group);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to create sysfs files\n");
-		goto err4;
+		goto err5;
 	}
 
 	return 0;
+err5:
+	if (td->use_ext_te)
+		free_irq(gpio_to_irq(dssdev->phy.dsi.ext_te_gpio), dssdev);
 err4:
-	if (td->use_ext_te) {
-		int gpio = dssdev->phy.dsi.ext_te_gpio;
-		free_irq(gpio_to_irq(gpio), dssdev);
-		gpio_free(gpio);
-	}
+	if (td->use_ext_te)
+		gpio_free(dssdev->phy.dsi.ext_te_gpio);
 err3:
 	backlight_device_unregister(bldev);
 err2:
-- 
1.6.5.2

