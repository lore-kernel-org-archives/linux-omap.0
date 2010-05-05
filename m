From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 20/21] OMAP: DSS2: Taal: Add regulator configuration support
Date: Wed,  5 May 2010 17:27:40 +0300
Message-ID: <1b93af2daf403f2fe822469b71c12ea7eb1cc68a.1273067195.git.ext-jani.1.nikula@nokia.com>
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
 <a4e7d90e0f036e227a29d94e28b7036c2f9d419b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <ca7ff2e5a165ca8488190520f1f75e6e37642d3b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4f2a95d67d2b8004f4a2055681690920ebeb8e8f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <690ef5c45aee3fb87a40fa03039356f8238925dc.1273067195.git.ext-jani.1.nikula@nokia.com>
 <025c12267d4bd88e1f59d9e13aafec247fe3c730.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e149b5cf7d3dbed1961e06dc82291412e3223101.1273067195.git.ext-jani.1.nikula@nokia.com>
 <5e7384699d72bad3865dc9604b18ad05775bfb27.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34140 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934836Ab0EEO2P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:15 -0400
In-Reply-To: <5e7384699d72bad3865dc9604b18ad05775bfb27.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
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
index b73cd12..617723b 100644
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
@@ -714,6 +792,8 @@ err_gpio:
 err_bl:
 	destroy_workqueue(td->esd_wq);
 err_wq:
+	free_regulators(panel_config->regulators, panel_config->num_regulators);
+err_reg:
 	kfree(td);
 err:
 	return r;
@@ -746,6 +826,9 @@ static void taal_remove(struct omap_dss_device *dssdev)
 	/* reset, to be sure that the panel is in a valid state */
 	taal_hw_reset(dssdev);
 
+	free_regulators(td->panel_config->regulators,
+			td->panel_config->num_regulators);
+
 	kfree(td);
 }
 
-- 
1.6.5.2

