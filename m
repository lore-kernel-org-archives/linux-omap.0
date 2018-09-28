From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
Date: Fri, 28 Sep 2018 23:09:17 +0300
Message-ID: <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702080505.GN112168@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 7/2/18 11:05 AM, Tony Lindgren wrote:
> * Maciej Purski <m.purski@samsung.com> [180618 14:11]:
>> If the regulator is not coupled, balance_voltage() should preserve
>> its desired max uV, instead of setting the exact value like in
>> coupled regulators case.
>>
>> Remove debugs, which are not necessary for now.
> 
> Sorry for the delay in testing. I gave your series with this one
> a quick boot test on beagleboard-x15 and now the output is
> different. So instead of just hanging it seems to be stuck in
> some eternal loop see below.

Hello guys,

I'm working on the CPUFreq driver for NVIDIA Tegra and it requires the coupled-regulators functionality, hence I'm interested in getting the coupled regulators series finalized ASAP and want to help with it.

It looks to me that the infinite-loop problem is caused by the voltage value that is getting rounded-up by the driver because it isn't aligned to the uV_step. IIUC, uV_step is relevant only for the "linear" regulators and hence we can't simply set the best_delta to uV_step to solve the problem. Other solution could be to bail out of the loop once regulator sets value equal to the "desired".

Tony, could you please give a try to the patch below?

Do the following:

1) git cherry-pick 696861761a58d8c93605b5663824929fb6540f16
2) git cherry-pick 456e7cdf3b1a14e2606b8b687385ab2e3f23a49a
3) Apply this patch:

>From 7928aecb3af9d367dd3c085972349aaa16318c1b Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 28 Sep 2018 21:49:20 +0300
Subject: [PATCH] Fixup regulator_balance_voltage()

---
 drivers/regulator/core.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 282511508698..4a386fe9f26a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3187,7 +3187,8 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
-static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
+static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
+					 int *min_uV, int *max_uV)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
@@ -3211,7 +3212,9 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 	 * by consumers.
 	 */
 	if (n_coupled == 1) {
-		ret = desired_min_uV;
+		*min_uV = desired_min_uV;
+		*max_uV = desired_max_uV;
+		ret = 1;
 		goto out;
 	}
 
@@ -3285,8 +3288,10 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
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
@@ -3298,7 +3303,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 	struct regulator_dev *best_rdev;
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	int n_coupled;
-	int i, best_delta, best_uV, ret = 1;
+	int i, best_delta, best_min_uV, best_max_uV, ret = 1;
+	bool last = false;
 
 	c_rdevs = c_desc->coupled_rdevs;
 	n_coupled = c_desc->n_coupled;
@@ -3314,9 +3320,10 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
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
@@ -3330,24 +3337,26 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			 * max_spread constraint in order to balance
 			 * the coupled voltages.
 			 */
-			int optimal_uV, current_uV;
+			int optimal_uV, optimal_max_uV, current_uV;
 
-			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
-			if (optimal_uV < 0) {
-				ret = optimal_uV;
+			ret = regulator_get_optimal_voltage(c_rdevs[i],
+							    &optimal_uV,
+							    &optimal_max_uV);
+			if (ret < 0)
 				goto out;
-			}
 
 			current_uV = _regulator_get_voltage(c_rdevs[i]);
 			if (current_uV < 0) {
-				ret = optimal_uV;
+				ret = current_uV;
 				goto out;
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
 
@@ -3357,8 +3366,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
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
