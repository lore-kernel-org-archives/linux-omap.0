From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 06/21] OMAP: DSS2: Taal: Fix request_irq() error handling
Date: Mon,  3 May 2010 09:18:26 +0300
Message-ID: <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34458 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab0ECGSy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:54 -0400
In-Reply-To: <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
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
index 3729ec2..98f882a 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -601,7 +601,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 		if (r) {
 			dev_err(&dssdev->dev, "IRQ request failed\n");
 			gpio_free(gpio);
-			goto err3;
+			goto err4;
 		}
 
 		init_completion(&td->te_completion);
@@ -612,18 +612,18 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	r = sysfs_create_group(&dssdev->dev.kobj, &taal_attr_group);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to create sysfs files\n");
-		goto err4;
+		goto err5;
 	}
 
 	taal_hw_reset(dssdev);
 
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

