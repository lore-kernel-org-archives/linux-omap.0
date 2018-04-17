From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] regulator: lp87565: Enable LP87565_BUCK_CTRL_1_FPWM_MP_0_2
Date: Tue, 17 Apr 2018 14:21:55 +0530
Message-ID: <1523955115-30164-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Buck10 is a multi(dual) phase regulator. So as part of enabling it
turn on the LP87565_BUCK_CTRL_1_FPWM_MP_0_2 bit which forces it to
operate always in multiphase and forced-PWM operation mode.
This helps improve the transient voltage response while switching OPP.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Boot tested on dra76-evm and read the ctrl register after probe.

Applies on top of linux-next branch with
https://patchwork.kernel.org/patch/10344529/
on top.

 drivers/regulator/lp87565-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 9ee08d6..3af588e 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -178,7 +178,8 @@ static const struct lp87565_regulator regulators[] = {
 	LP87565_REGULATOR("BUCK10", LP87565_BUCK_10, "buck10", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK0_CTRL_1,
-			  LP87565_BUCK_CTRL_1_EN, 3230,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 	LP87565_REGULATOR("BUCK23", LP87565_BUCK_23, "buck23", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
-- 
1.9.1
