From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] OMAP: DSS2: Remove suspicous and unused TAAL regulator API usage
Date: Mon, 19 Mar 2012 14:50:46 +0000
Message-ID: <1332168646-4391-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48340 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752633Ab2CSOu4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 10:50:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

The TAAL driver contains some regulator support which is currently unused
(the code is there but the one panel supported by the driver doesn't have
any regulators provided). This code mostly looks like an open coded
version of the regulator core bulk API.

The only additional feature is that a voltage range can be set once when
the device is opened, though this is never varied at runtime. The general
expectation is that if the device is not actively managing the voltage of
the device (eg, doing DVFS) then any configuration will be done using the
constraints rather than by drivers, saving them code and ensuring that
they work well with systems where the voltage is not configurable.

If systems are added needing regulator support this can be added back in,
though it should be based on core features rather than open coding things.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/video/omap2/displays/panel-taal.c |   80 -----------------------------
 1 files changed, 0 insertions(+), 80 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 0f21fa5..72d6307 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -30,7 +30,6 @@
 #include <linux/gpio.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
-#include <linux/regulator/consumer.h>
 #include <linux/mutex.h>
 
 #include <video/omapdss.h>
@@ -55,73 +54,6 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable);
 
 static int taal_panel_reset(struct omap_dss_device *dssdev);
 
-struct panel_regulator {
-	struct regulator *regulator;
-	const char *name;
-	int min_uV;
-	int max_uV;
-};
-
-static void free_regulators(struct panel_regulator *regulators, int n)
-{
-	int i;
-
-	for (i = 0; i < n; i++) {
-		/* disable/put in reverse order */
-		regulator_disable(regulators[n - i - 1].regulator);
-		regulator_put(regulators[n - i - 1].regulator);
-	}
-}
-
-static int init_regulators(struct omap_dss_device *dssdev,
-			struct panel_regulator *regulators, int n)
-{
-	int r, i, v;
-
-	for (i = 0; i < n; i++) {
-		struct regulator *reg;
-
-		reg = regulator_get(&dssdev->dev, regulators[i].name);
-		if (IS_ERR(reg)) {
-			dev_err(&dssdev->dev, "failed to get regulator %s\n",
-				regulators[i].name);
-			r = PTR_ERR(reg);
-			goto err;
-		}
-
-		/* FIXME: better handling of fixed vs. variable regulators */
-		v = regulator_get_voltage(reg);
-		if (v < regulators[i].min_uV || v > regulators[i].max_uV) {
-			r = regulator_set_voltage(reg, regulators[i].min_uV,
-						regulators[i].max_uV);
-			if (r) {
-				dev_err(&dssdev->dev,
-					"failed to set regulator %s voltage\n",
-					regulators[i].name);
-				regulator_put(reg);
-				goto err;
-			}
-		}
-
-		r = regulator_enable(reg);
-		if (r) {
-			dev_err(&dssdev->dev, "failed to enable regulator %s\n",
-				regulators[i].name);
-			regulator_put(reg);
-			goto err;
-		}
-
-		regulators[i].regulator = reg;
-	}
-
-	return 0;
-
-err:
-	free_regulators(regulators, i);
-
-	return r;
-}
-
 /**
  * struct panel_config - panel configuration
  * @name: panel name
@@ -150,8 +82,6 @@ struct panel_config {
 		unsigned int low;
 	} reset_sequence;
 
-	struct panel_regulator *regulators;
-	int num_regulators;
 };
 
 enum {
@@ -977,11 +907,6 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	atomic_set(&td->do_update, 0);
 
-	r = init_regulators(dssdev, panel_config->regulators,
-			panel_config->num_regulators);
-	if (r)
-		goto err_reg;
-
 	td->workqueue = create_singlethread_workqueue("taal_esd");
 	if (td->workqueue == NULL) {
 		dev_err(&dssdev->dev, "can't create ESD workqueue\n");
@@ -1075,8 +1000,6 @@ err_gpio:
 err_bl:
 	destroy_workqueue(td->workqueue);
 err_wq:
-	free_regulators(panel_config->regulators, panel_config->num_regulators);
-err_reg:
 	kfree(td);
 err:
 	return r;
@@ -1113,9 +1036,6 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 	/* reset, to be sure that the panel is in a valid state */
 	taal_hw_reset(dssdev);
 
-	free_regulators(td->panel_config->regulators,
-			td->panel_config->num_regulators);
-
 	kfree(td);
 }
 
-- 
1.7.9.1

