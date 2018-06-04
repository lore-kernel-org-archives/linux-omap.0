From: Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 4/7] regulator: core: Implement voltage balancing algorithm
Date: Mon, 04 Jun 2018 15:59:21 +0200
Message-ID: <1528120764-14316-5-git-send-email-m.purski@samsung.com>
References: <20180530144505.GB5705@atomide.com>
 <1528120764-14316-1-git-send-email-m.purski@samsung.com>
 <CGME20180604135953eucas1p2ec281df0793bc73e79f3000837abcb04@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Maciej Purski <m.purski@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires
higher voltage, there might occur a situation that the spread between
two devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators.

Introduce new function regulator_balance_voltage(), which
keeps max_spread constraint fulfilled between a group of coupled
regulators. It should be called if a regulator changes its
voltage or after disabling or enabling. Disabled regulators should
follow changes of the enabled ones, but their consumers' demands
shouldn't be taken into account while calculating voltage of other
coupled regulators.

Find voltages, which are closest to suiting all the consumers' demands,
while fulfilling max_spread constraint, keeping the following rules:
- if one regulator is about to rise its voltage, rise others
  voltages in order to keep the max_spread
- if a regulator, which has caused rising other regulators, is
  lowered, lower other regulators if possible
- if one regulator is about to lower its voltage, but it hasn't caused
  rising other regulators, don't change its voltage if it breaks the
  max_spread

Change regulators' voltages step by step, keeping max_spread constraint
fulfilled all the time. Function regulator_get_optimal_voltage()
should find the best possible change for the regulator, which doesn't
break max_spread constraint. In function regulator_balance_voltage()
optimize number of steps by finding highest voltage difference on
each iteration.

If a regulator, which is about to change its voltage, is not coupled,
method regulator_get_optimal_voltage() should simply return the lowest
voltage fulfilling consumers' demands.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c5478d2..0b366c5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,6 +105,8 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state);
 static int regulator_set_voltage_rdev(struct regulator_dev *rdev,
 				      int min_uV, int max_uV,
 				      suspend_state_t state);
@@ -3126,6 +3128,187 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
+static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
+	int max_spread = rdev->constraints->max_spread;
+	int n_coupled = c_desc->n_coupled;
+	int desired_min_uV, desired_max_uV, min_current_uV = INT_MAX;
+	int max_current_uV = 0, highest_min_uV = 0, target_uV, possible_uV;
+	int i, ret;
+
+	/* If consumers don't provide any demands, set voltage to min_uV */
+	desired_min_uV = rdev->constraints->min_uV;
+	desired_max_uV = rdev->constraints->max_uV;
+	ret = regulator_check_consumers(rdev,
+					&desired_min_uV,
+					&desired_max_uV, PM_SUSPEND_ON);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If there are no coupled regulators, simply set the voltage demanded
+	 * by consumers.
+	 */
+	if (n_coupled == 1) {
+		ret = desired_min_uV;
+		goto out;
+	}
+
+	/* Find highest min desired voltage */
+	for (i = 0; i < n_coupled; i++) {
+		int tmp_min = 0;
+		int tmp_max = INT_MAX;
+
+		if (!_regulator_is_enabled(c_rdevs[i]))
+			continue;
+
+		ret = regulator_check_consumers(c_rdevs[i],
+						&tmp_min,
+						&tmp_max, PM_SUSPEND_ON);
+		if (ret < 0)
+			goto out;
+
+		if (tmp_min > highest_min_uV)
+			highest_min_uV = tmp_min;
+	}
+
+	/*
+	 * Let target_uV be equal to the desired one if possible.
+	 * If not, set it to minimum voltage, allowed by other coupled
+	 * regulators.
+	 */
+	target_uV = max(desired_min_uV,  highest_min_uV - max_spread);
+
+	/*
+	 * Find min and max voltages, which currently aren't
+	 * violating max_spread
+	 */
+	for (i = 0; i < n_coupled; i++) {
+		int tmp_act;
+
+		/*
+		 * Don't check the regulator, which is about
+		 * to change voltage
+		 */
+		if (c_rdevs[i] == rdev)
+			continue;
+		if (!_regulator_is_enabled(c_rdevs[i]))
+			continue;
+
+		tmp_act = _regulator_get_voltage(c_rdevs[i]);
+		if (tmp_act < 0) {
+			ret = tmp_act;
+			goto out;
+		}
+
+		if (tmp_act < min_current_uV)
+			min_current_uV = tmp_act;
+
+		if (tmp_act > max_current_uV)
+			max_current_uV = tmp_act;
+	}
+
+	/* There aren't any other regulators enabled */
+	if (max_current_uV == 0) {
+		possible_uV = target_uV;
+	} else {
+		/*
+		 * Correct target voltage, so as it currently isn't
+		 * violating max_spread
+		 */
+		possible_uV = max(target_uV, max_current_uV - max_spread);
+		possible_uV = min(possible_uV, min_current_uV + max_spread);
+	}
+
+	if (possible_uV > desired_max_uV) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = possible_uV;
+
+out:
+	return ret;
+}
+
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state)
+{
+	struct regulator_dev **c_rdevs;
+	struct regulator_dev *best_rdev;
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int n_coupled;
+	int i, best_delta, best_uV, ret = 1;
+
+	c_rdevs = c_desc->coupled_rdevs;
+	n_coupled = c_desc->n_coupled;
+
+	/*
+	 * if system is in a state other than PM_SUSPEND_ON, don't check
+	 * other coupled regulators
+	 */
+	if (state != PM_SUSPEND_ON)
+		n_coupled = 1;
+
+	/*
+	 * Find the best possible voltage change on each loop. Leave the loop
+	 * if there isn't any possible change.
+	 */
+	while (1) {
+		best_delta = 0;
+		best_uV = 0;
+		best_rdev = NULL;
+
+		/*
+		 * Find highest difference between optimal voltage
+		 * and current voltage.
+		 */
+		for (i = 0; i < n_coupled; i++) {
+			/*
+			 * optimal_uV is the best voltage that can be set for
+			 * i-th regulator at the moment without violating
+			 * max_spread constraint in order to balance
+			 * the coupled voltages.
+			 */
+			int optimal_uV, current_uV;
+
+			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
+			if (optimal_uV < 0) {
+				ret = optimal_uV;
+				goto out;
+			}
+
+			current_uV = _regulator_get_voltage(c_rdevs[i]);
+			if (current_uV < 0) {
+				ret = optimal_uV;
+				goto out;
+			}
+
+			if (abs(best_delta) < abs(optimal_uV - current_uV)) {
+				best_delta = optimal_uV - current_uV;
+				best_rdev = c_rdevs[i];
+				best_uV = optimal_uV;
+			}
+		}
+
+		/* Nothing to change, return successfully */
+		if (!best_rdev) {
+			ret = 0;
+			goto out;
+		}
+
+		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
+						 best_uV, state);
+
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
 /**
  * regulator_set_voltage - set regulator output voltage
  * @regulator: regulator source
-- 
2.7.4
