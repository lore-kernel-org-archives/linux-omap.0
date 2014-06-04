From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] regulator: core: print error value when constraints are not applied
Date: Wed, 4 Jun 2014 14:53:25 -0500
Message-ID: <1401911605-5157-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Alban Bedel <alban.bedel@avionic-design.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

With commit 064d5cd110f94ce41ca5681dcda8b77fa63d5b95
(regulator: core: Fix the init of DT defined fixed regulators)
We ensure that regulator must be capable of providing it's current
voltage when constraints are used, however adding the return value in
the print is a little more informative to explain the nature of the
failure involved.

So, instead of providing message such as:
smps9: failed to get the current voltage

having error value added to the message such as:
smps9: failed to get the current voltage(-22)

is a little more informative for debugging the error.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/regulator/core.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4c1f999..b4902ab 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -846,7 +846,9 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 	    rdev->constraints->min_uV == rdev->constraints->max_uV) {
 		int current_uV = _regulator_get_voltage(rdev);
 		if (current_uV < 0) {
-			rdev_err(rdev, "failed to get the current voltage\n");
+			rdev_err(rdev,
+				 "failed to get the current voltage(%d)\n",
+				 current_uV);
 			return current_uV;
 		}
 		if (current_uV < rdev->constraints->min_uV ||
@@ -856,8 +858,8 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 				rdev->constraints->max_uV);
 			if (ret < 0) {
 				rdev_err(rdev,
-					"failed to apply %duV constraint\n",
-					rdev->constraints->min_uV);
+					"failed to apply %duV constraint(%d)\n",
+					rdev->constraints->min_uV, ret);
 				return ret;
 			}
 		}
-- 
1.7.9.5
