From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH 1/3] regulator: tps65218.c: fix LS3 issues
Date: Wed, 20 Feb 2019 09:15:50 +0100
Message-ID: <1550650552-26013-2-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

- Fix list of valid LS3 currents from mA to µA
- Fix selection of min/max microAmps of LS3.
  Selecting one of the configured values as max value now really
  selects it instead of the next lower one

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 drivers/regulator/tps65218-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 6209bee..5dd559e 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -188,7 +188,8 @@ static struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.set_suspend_disable	= tps65218_pmic_set_suspend_disable,
 };
 
-static const int ls3_currents[] = { 100, 200, 500, 1000 };
+static const int ls3_currents[] = { 100000, 200000, 500000, 1000000 };
+
 
 static int tps65218_pmic_set_input_current_lim(struct regulator_dev *dev,
 					       int lim_uA)
@@ -214,7 +215,7 @@ static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
 	unsigned int num_currents = ARRAY_SIZE(ls3_currents);
 	struct tps65218 *tps = rdev_get_drvdata(dev);
 
-	while (index < num_currents && ls3_currents[index] < max_uA)
+	while (index < num_currents && ls3_currents[index] <= max_uA)
 		index++;
 
 	index--;
-- 
2.7.4
