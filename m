From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 08/11] regulator: core: Add new max_uV_step constraint
Date: Fri,  5 Oct 2018 18:36:35 +0300
Message-ID: <20181005153638.1886-9-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On NVIDIA Tegra30 there is a requirement for regulator "A" to have voltage
higher than voltage of regulator "B" by N microvolts, the N value changes
depending on the voltage of regulator "B". This is similar to min-spread
between voltages of regulators, the difference is that the spread value
isn't fixed. This means that extra carefulness is required for regulator
"A" to drop its voltage without violating the requirement, hence its
voltage should be changed in steps so that its couple "B" could follow
(there is also max-spread requirement).

Add new "max_uV_step" constraint that breaks voltage change into several
steps, each step is limited by the max_uV_step value.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c          | 41 +++++++++++++++++++++++++++++++
 drivers/regulator/of_regulator.c  |  4 +++
 include/linux/regulator/machine.h |  3 +++
 3 files changed, 48 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 089e8ad8ef57..ba03bdf3716f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3191,6 +3191,36 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
+static int regulator_limit_voltage_step(struct regulator_dev *rdev,
+					int *current_uV, int *min_uV)
+{
+	struct regulation_constraints *constraints = rdev->constraints;
+
+	/* Limit voltage change only if necessary */
+	if (!constraints->max_uV_step || !_regulator_is_enabled(rdev))
+		return 1;
+
+	if (*current_uV < 0) {
+		*current_uV = _regulator_get_voltage(rdev);
+
+		if (*current_uV < 0)
+			return *current_uV;
+	}
+
+	if (abs(*current_uV - *min_uV) <= constraints->max_uV_step)
+		return 1;
+
+	/* Clamp target voltage within the given step */
+	if (*current_uV < *min_uV)
+		*min_uV = min(*current_uV + constraints->max_uV_step,
+			      *min_uV);
+	else
+		*min_uV = max(*current_uV - constraints->max_uV_step,
+			      *min_uV);
+
+	return 0;
+}
+
 static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 					 int *current_uV,
 					 int *min_uV, int *max_uV,
@@ -3302,6 +3332,17 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	desired_min_uV = possible_uV;
 
 finish:
+	/* Apply max_uV_step constraint if necessary */
+	if (state == PM_SUSPEND_ON) {
+		ret = regulator_limit_voltage_step(rdev, current_uV,
+						   &desired_min_uV);
+		if (ret < 0)
+			return ret;
+
+		if (ret == 0)
+			done = false;
+	}
+
 	/* Set current_uV if wasn't done earlier in the code and if necessary */
 	if (n_coupled > 1 && *current_uV == -1) {
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c4223b3e0dff..a732f09d207b 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -170,6 +170,10 @@ static void of_get_regulation_constraints(struct device_node *np,
 				  &pval))
 		constraints->max_spread = pval;
 
+	if (!of_property_read_u32(np, "regulator-max-step-microvolt",
+				  &pval))
+		constraints->max_uV_step = pval;
+
 	constraints->over_current_protection = of_property_read_bool(np,
 					"regulator-over-current-protection");
 
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index a459a5e973a7..1d34a70ffda2 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -158,6 +158,9 @@ struct regulation_constraints {
 	/* used for coupled regulators */
 	int max_spread;
 
+	/* used for changing voltage in steps */
+	int max_uV_step;
+
 	/* valid regulator operating modes for this machine */
 	unsigned int valid_modes_mask;
 
-- 
2.19.0
