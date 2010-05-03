From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 20/21] OMAP: DSS2: Taal: Add regulator configuration support
Date: Mon,  3 May 2010 09:18:40 +0300
Message-ID: <ca115745068df8138dcc09052fb0e6868986fabe.1272621452.git.ext-jani.1.nikula@nokia.com>
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
 <b88e1b382ddf14870c7a44e7ca620ad84d883b50.1272621452.git.ext-jani.1.nikula@nokia.com>
 <5a5dc1e253df571477551b8f63560ad9d1a3ab2b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <df2ca92a00d718b95aa6a7875a4199882c86f513.1272621452.git.ext-jani.1.nikula@nokia.com>
 <d76f00a4c763b84d7511a9f0c98eb7117e9e6a3e.1272621452.git.ext-jani.1.nikula@nokia.com>
 <261f7b2c8cf1120e05d9664137e22ed237657c60.1272621452.git.ext-jani.1.nikula@nokia.com>
 <453fa1efec72cc2a4c029b6791c373a4a2e7ad7d.1272621452.git.ext-jani.1.nikula@nokia.com>
 <f2fff5b0fb2c3d2d0968a0c6c73ec2836c4ef0eb.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30963 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab0ECGS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:57 -0400
In-Reply-To: <f2fff5b0fb2c3d2d0968a0c6c73ec2836c4ef0eb.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Add support for configuring regulators in the panel specific
configuration data.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   83 +++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index e209713..07832c4 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -30,6 +30,7 @@
 #include <linux/gpio.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include <linux/regulator/consumer.h>
 #include <linux/mutex.h>
 
 #include <plat/display.h>
@@ -68,6 +69,73 @@ static irqreturn_t taal_te_isr(int irq, void *data);
 static void taal_te_timeout_work_callback(struct work_struct *work);
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable);
 
+struct panel_regulator {
+	struct regulator *regulator;
+	const char *name;
+	int min_uV;
+	int max_uV;
+};
+
+static void free_regulators(struct panel_regulator *regulators, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		/* disable/put in reverse order */
+		regulator_disable(regulators[n - i - 1].regulator);
+		regulator_put(regulators[n - i - 1].regulator);
+	}
+}
+
+static int init_regulators(struct omap_dss_device *dssdev,
+			struct panel_regulator *regulators, int n)
+{
+	int r, i, v;
+
+	for (i = 0; i < n; i++) {
+		struct regulator *reg;
+
+		reg = regulator_get(&dssdev->dev, regulators[i].name);
+		if (IS_ERR(reg)) {
+			dev_err(&dssdev->dev, "failed to get regulator %s\n",
+				regulators[i].name);
+			r = PTR_ERR(reg);
+			goto err;
+		}
+
+		/* FIXME: better handling of fixed vs. variable regulators */
+		v = regulator_get_voltage(reg);
+		if (v < regulators[i].min_uV || v > regulators[i].max_uV) {
+			r = regulator_set_voltage(reg, regulators[i].min_uV,
+						regulators[i].max_uV);
+			if (r) {
+				dev_err(&dssdev->dev,
+					"failed to set regulator %s voltage\n",
+					regulators[i].name);
+				regulator_put(reg);
+				goto err;
+			}
+		}
+
+		r = regulator_enable(reg);
+		if (r) {
+			dev_err(&dssdev->dev, "failed to enable regulator %s\n",
+				regulators[i].name);
+			regulator_put(reg);
+			goto err;
+		}
+
+		regulators[i].regulator = reg;
+	}
+
+	return 0;
+
+err:
+	free_regulators(regulators, i);
+
+	return r;
+}
+
 /**
  * struct panel_config - panel configuration
  * @name: panel name
@@ -75,6 +143,8 @@ static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable);
  * @timings: panel resolution
  * @sleep: various panel specific delays, passed to msleep() if non-zero
  * @reset_sequence: reset sequence timings, passed to udelay() if non-zero
+ * @regulators: array of panel regulators
+ * @num_regulators: number of regulators in the array
  */
 struct panel_config {
 	const char *name;
@@ -93,6 +163,9 @@ struct panel_config {
 		unsigned int high;
 		unsigned int low;
 	} reset_sequence;
+
+	struct panel_regulator *regulators;
+	int num_regulators;
 };
 
 enum {
@@ -629,6 +702,11 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	atomic_set(&td->do_update, 0);
 
+	r = init_regulators(dssdev, panel_config->regulators,
+			panel_config->num_regulators);
+	if (r)
+		goto err_reg;
+
 	td->esd_wq = create_singlethread_workqueue("taal_esd");
 	if (td->esd_wq == NULL) {
 		dev_err(&dssdev->dev, "can't create ESD workqueue\n");
@@ -715,6 +793,8 @@ err_gpio:
 err_bl:
 	destroy_workqueue(td->esd_wq);
 err_wq:
+	free_regulators(panel_config->regulators, panel_config->num_regulators);
+err_reg:
 	kfree(td);
 err:
 	return r;
@@ -747,6 +827,9 @@ static void taal_remove(struct omap_dss_device *dssdev)
 	/* reset, to be sure that the panel is in a valid state */
 	taal_hw_reset(dssdev);
 
+	free_regulators(td->panel_config->regulators,
+			td->panel_config->num_regulators);
+
 	kfree(td);
 }
 
-- 
1.6.5.2

