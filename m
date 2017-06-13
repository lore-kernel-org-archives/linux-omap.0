From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] regulator: tps65910: check TPS65910_NUM_REGS at build
 time
Date: Tue, 13 Jun 2017 15:58:53 +0200
Message-ID: <0c5e903eed2005e39bdf7abdd1061dffc078109a.1497361550.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/tps65910-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 696116ebdf50a..81672a58fcc23 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1107,6 +1107,7 @@ static int tps65910_probe(struct platform_device *pdev)
 
 	switch (tps65910_chip_id(tps65910)) {
 	case TPS65910:
+		BUILD_BUG_ON(TPS65910_NUM_REGS < ARRAY_SIZE(tps65910_regs));
 		pmic->get_ctrl_reg = &tps65910_get_ctrl_register;
 		pmic->num_regulators = ARRAY_SIZE(tps65910_regs);
 		pmic->ext_sleep_control = tps65910_ext_sleep_control;
@@ -1119,6 +1120,7 @@ static int tps65910_probe(struct platform_device *pdev)
 					DCDCCTRL_DCDCCKSYNC_MASK);
 		break;
 	case TPS65911:
+		BUILD_BUG_ON(TPS65910_NUM_REGS < ARRAY_SIZE(tps65911_regs));
 		pmic->get_ctrl_reg = &tps65911_get_ctrl_register;
 		pmic->num_regulators = ARRAY_SIZE(tps65911_regs);
 		pmic->ext_sleep_control = tps65911_ext_sleep_control;
@@ -1144,8 +1146,7 @@ static int tps65910_probe(struct platform_device *pdev)
 	if (!pmic->rdev)
 		return -ENOMEM;
 
-	for (i = 0; i < pmic->num_regulators && i < TPS65910_NUM_REGS;
-			i++, info++) {
+	for (i = 0; i < pmic->num_regulators; i++, info++) {
 		/* Register the regulators */
 		pmic->info[i] = info;
 
-- 
2.11.0
