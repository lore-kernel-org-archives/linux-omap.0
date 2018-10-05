From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 03/11] regulator: core: Mutually resolve regulators coupling
Date: Fri,  5 Oct 2018 18:36:30 +0300
Message-ID: <20181005153638.1886-4-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

If registered regulator found a couple, then the couple can find the
registered regulator too and hence coupling can be mutually resolved
at the registration time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 54 +++++++++++++---------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5105eaaf3cef..925df9e6f1e3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4439,7 +4439,7 @@ static int regulator_register_resolve_supply(struct device *dev, void *data)
 	return 0;
 }
 
-static int regulator_fill_coupling_array(struct regulator_dev *rdev)
+static void regulator_resolve_coupling(struct regulator_dev *rdev)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	int n_coupled = c_desc->n_coupled;
@@ -4453,33 +4453,21 @@ static int regulator_fill_coupling_array(struct regulator_dev *rdev)
 
 		c_rdev = of_parse_coupled_regulator(rdev, i - 1);
 
-		if (c_rdev) {
-			c_desc->coupled_rdevs[i] = c_rdev;
-			c_desc->n_resolved++;
-		}
-	}
-
-	if (rdev->coupling_desc.n_resolved < n_coupled)
-		return -1;
-	else
-		return 0;
-}
+		if (!c_rdev)
+			continue;
 
-static int regulator_register_fill_coupling_array(struct device *dev,
-						  void *data)
-{
-	struct regulator_dev *rdev = dev_to_rdev(dev);
+		regulator_lock(c_rdev);
 
-	if (!IS_ENABLED(CONFIG_OF))
-		return 0;
+		c_desc->coupled_rdevs[i] = c_rdev;
+		c_desc->n_resolved++;
 
-	if (regulator_fill_coupling_array(rdev))
-		rdev_dbg(rdev, "unable to resolve coupling\n");
+		regulator_unlock(c_rdev);
 
-	return 0;
+		regulator_resolve_coupling(c_rdev);
+	}
 }
 
-static int regulator_resolve_coupling(struct regulator_dev *rdev)
+static int regulator_init_coupling(struct regulator_dev *rdev)
 {
 	int n_phandles;
 
@@ -4519,13 +4507,6 @@ static int regulator_resolve_coupling(struct regulator_dev *rdev)
 	if (!of_check_coupling_data(rdev))
 		return -EPERM;
 
-	/*
-	 * After everything has been checked, try to fill rdevs array
-	 * with pointers to regulators parsed from device tree. If some
-	 * regulators are not registered yet, retry in late init call
-	 */
-	regulator_fill_coupling_array(rdev);
-
 	return 0;
 }
 
@@ -4662,11 +4643,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto wash;
 
-	mutex_lock(&regulator_list_mutex);
-	ret = regulator_resolve_coupling(rdev);
-	mutex_unlock(&regulator_list_mutex);
-
-	if (ret != 0)
+	ret = regulator_init_coupling(rdev);
+	if (ret < 0)
 		goto wash;
 
 	/* add consumers devices */
@@ -4700,6 +4678,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	rdev_init_debugfs(rdev);
 
+	/* try to resolve regulators coupling since a new one was registered */
+	mutex_lock(&regulator_list_mutex);
+	regulator_resolve_coupling(rdev);
+	mutex_unlock(&regulator_list_mutex);
+
 	/* try to resolve regulators supply since a new one was registered */
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_register_resolve_supply);
@@ -5155,9 +5138,6 @@ static int __init regulator_init_complete(void)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_late_cleanup);
 
-	class_for_each_device(&regulator_class, NULL, NULL,
-			      regulator_register_fill_coupling_array);
-
 	return 0;
 }
 late_initcall_sync(regulator_init_complete);
-- 
2.19.0
