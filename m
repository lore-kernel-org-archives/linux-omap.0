From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 5/5] regulator: tps65218: do not disable DCDC3 during poweroff on broken PMICs
Date: Fri, 24 Jun 2016 13:58:11 +0530
Message-ID: <1466756892-17015-5-git-send-email-j-keerthy@ti.com>
References: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, tony@atomide.com, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, j-keerthy@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Some versions of tps65218 do not seem to support poweroff modes properly
if DCDC3 regulator is shut-down. Thus, keep it enabled even during
poweroff if the version info matches the broken silicon revision.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/tps65218-regulator.c | 8 ++++++++
 include/linux/mfd/tps65218.h           | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index d1e631d..eb0f5b1 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -180,6 +180,14 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
 	if (rid < TPS65218_DCDC_1 || rid > TPS65218_LDO_1)
 		return -EINVAL;
 
+	/*
+	 * Certain revisions of TPS65218 will need to have DCDC3 regulator
+	 * enabled always, otherwise an immediate system reboot will occur
+	 * during poweroff.
+	 */
+	if (rid == TPS65218_DCDC_3 && tps->rev == TPS65218_REV_2_1)
+		return 0;
+
 	if (!tps->info[rid]->strobe) {
 		if (rid == TPS65218_DCDC_3)
 			tps->info[rid]->strobe = 3;
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index 85e464e..d1db952 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -63,6 +63,11 @@
 #define TPS65218_CHIPID_CHIP_MASK	0xF8
 #define TPS65218_CHIPID_REV_MASK	0x07
 
+#define TPS65218_REV_1_0		0x0
+#define TPS65218_REV_1_1		0x1
+#define TPS65218_REV_2_0		0x2
+#define TPS65218_REV_2_1		0x3
+
 #define TPS65218_INT1_VPRG		BIT(5)
 #define TPS65218_INT1_AC		BIT(4)
 #define TPS65218_INT1_PB		BIT(3)
-- 
1.9.1
