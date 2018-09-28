From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
Date: Sat, 29 Sep 2018 02:51:11 +0300
Message-ID: <d14cc796-8644-41a3-5135-299bd8820204@gmail.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
 <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
 <20180928202251.GM5662@atomide.com>
 <2c0132ff-ea0f-f19e-ebfb-a0d077565d2c@gmail.com>
 <20180928224109.GS5662@atomide.com>
 <ea0a59ef-e201-986a-9499-a0638359b1b9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ea0a59ef-e201-986a-9499-a0638359b1b9@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Maciej Purski <m.purski@samsung.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On 9/29/18 2:17 AM, Dmitry Osipenko wrote:
> On 9/29/18 1:41 AM, Tony Lindgren wrote:
>> * Dmitry Osipenko <digetx@gmail.com> [180928 22:31]:
>>> On 9/28/18 11:22 PM, Tony Lindgren wrote:
>>>> * Dmitry Osipenko <digetx@gmail.com> [180928 20:13]:
>>>>> Tony, could you please give a try to the patch below?
>>>>>
>>>>> Do the following:
>>>>>
>>>>> 1) git cherry-pick 696861761a58d8c93605b5663824929fb6540f16
>>>>> 2) git cherry-pick 456e7cdf3b1a14e2606b8b687385ab2e3f23a49a
>>>>> 3) Apply this patch:
>>>>
>>>> Seems to be getting closer, system boots up and starts
>>>> init, but then I start getting tons of this on beagle-x15:
>>>
>>> Tony, could you please try this one? Fixed couple more bugs, should be good now.
>>
>> I'm still getting these errors after init:
> 
> Thank you very much again, seems I got what's wrong with your case. The ti-abb-regulator driver sets the "abb->current_info_idx = -EINVAL" on probe and that value is getting updated only after the first voltage change, hence _regulator_get_voltage() returns -22.
> 
> Please try this patch:

I've revised the patch and here is the current final version.


>From 0332e230568d5bba470f917f0b36dd9ef9e6e511 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 28 Sep 2018 21:49:20 +0300
Subject: [PATCH] Fixup regulator_balance_voltage() v4

---
 drivers/regulator/core.c | 58 +++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 282511508698..17dce370f236 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3099,10 +3099,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	voltage->min_uV = min_uV;
 	voltage->max_uV = max_uV;
 
-	ret = regulator_check_consumers(rdev, &min_uV, &max_uV, state);
-	if (ret < 0)
-		goto out2;
-
 	/* for not coupled regulators this will just set the voltage */
 	ret = regulator_balance_voltage(rdev, state);
 	if (ret < 0)
@@ -3187,7 +3183,9 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
-static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
+static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
+					 int *min_uV, int *max_uV,
+					 suspend_state_t state)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
@@ -3202,7 +3200,8 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 	desired_max_uV = rdev->constraints->max_uV;
 	ret = regulator_check_consumers(rdev,
 					&desired_min_uV,
-					&desired_max_uV, PM_SUSPEND_ON);
+					&desired_max_uV,
+					state);
 	if (ret < 0)
 		goto out;
 
@@ -3210,8 +3209,10 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 	 * If there are no coupled regulators, simply set the voltage demanded
 	 * by consumers.
 	 */
-	if (n_coupled == 1) {
-		ret = desired_min_uV;
+	if (n_coupled == 1 || state != PM_SUSPEND_ON) {
+		*min_uV = desired_min_uV;
+		*max_uV = desired_max_uV;
+		ret = 1;
 		goto out;
 	}
 
@@ -3285,8 +3286,10 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 		ret = -EINVAL;
 		goto out;
 	}
-	ret = possible_uV;
+	ret = (possible_uV == desired_min_uV);
 
+	*min_uV = possible_uV;
+	*max_uV = desired_max_uV;
 out:
 	return ret;
 }
@@ -3298,7 +3301,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 	struct regulator_dev *best_rdev;
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	int n_coupled;
-	int i, best_delta, best_uV, ret = 1;
+	int i, best_delta, best_min_uV, best_max_uV, ret = 1;
+	bool last = false;
 
 	c_rdevs = c_desc->coupled_rdevs;
 	n_coupled = c_desc->n_coupled;
@@ -3314,9 +3318,10 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 	 * Find the best possible voltage change on each loop. Leave the loop
 	 * if there isn't any possible change.
 	 */
-	while (1) {
+	while (!last) {
 		best_delta = 0;
-		best_uV = 0;
+		best_min_uV = 0;
+		best_max_uV = 0;
 		best_rdev = NULL;
 
 		/*
@@ -3330,24 +3335,29 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			 * max_spread constraint in order to balance
 			 * the coupled voltages.
 			 */
-			int optimal_uV, current_uV;
+			int optimal_uV, optimal_max_uV, current_uV = 0;
 
-			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
-			if (optimal_uV < 0) {
-				ret = optimal_uV;
+			ret = regulator_get_optimal_voltage(c_rdevs[i],
+							    &optimal_uV,
+							    &optimal_max_uV,
+							    state);
+			if (ret < 0)
 				goto out;
-			}
 
-			current_uV = _regulator_get_voltage(c_rdevs[i]);
-			if (current_uV < 0) {
-				ret = optimal_uV;
-				goto out;
+			if (n_coupled > 1) {
+				current_uV = _regulator_get_voltage(c_rdevs[i]);
+				if (current_uV < 0) {
+					ret = current_uV;
+					goto out;
+				}
 			}
 
 			if (abs(best_delta) < abs(optimal_uV - current_uV)) {
 				best_delta = optimal_uV - current_uV;
 				best_rdev = c_rdevs[i];
-				best_uV = optimal_uV;
+				best_min_uV = optimal_uV;
+				best_max_uV = optimal_max_uV;
+				last = (best_rdev == rdev && ret > 0);
 			}
 		}
 
@@ -3357,8 +3367,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			goto out;
 		}
 
-		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
-						 best_uV, state);
+		ret = regulator_set_voltage_rdev(best_rdev, best_min_uV,
+						 best_max_uV, state);
 
 		if (ret < 0)
 			goto out;
-- 
2.19.0
