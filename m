From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] regulator: tps65917/palmas: Add bypass "On" value
Date: Tue, 26 Apr 2016 11:36:42 -0500
Message-ID: <1461688602-19996-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When commit b554e1450658 ("regulator: tps65917/palmas: Add bypass
ops for LDOs with bypass capability") introduced bypass capability
to palmas regulator, it went with the assumption that regulator
regmap helpers just check val against the bypass_mask.

Unfortunately, this ignored the explicit "on" and "off" values when
the register value is masked with bypass_mask in commit ca5d1b3524b4
("regulator: helpers: Modify helpers enabling multi-bit control").

With the recent commit dd1a571daee7 ("regulator: helpers: Ensure
bypass register field matches ON value"), this issue gets highlighted
and fails tps65917/palmas based platforms which need regulators/ldos
that have bypass capability.

Introduce the bypass_on value appropriately for tps65917/palmas
regulator.

Fixes: b554e1450658 ("regulator: tps65917/palmas: Add bypass ops for LDOs with bypass capability")
Cc: Keerthy <j-keerthy@ti.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Fixes regression in next-20160426 for DRA7 platforms and BeagleBoard-X15

Fail in boot: http://pastebin.ubuntu.com/16065715/

 drivers/regulator/palmas-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 6efc7ee8aea3..c83e06b2cedb 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -944,6 +944,8 @@ static int palmas_ldo_registration(struct palmas_pmic *pmic,
 			if (id == PALMAS_REG_LDO9) {
 				desc->ops = &palmas_ops_ldo9;
 				desc->bypass_reg = desc->enable_reg;
+				desc->bypass_val_on =
+						PALMAS_LDO9_CTRL_LDO_BYPASS_EN;
 				desc->bypass_mask =
 						PALMAS_LDO9_CTRL_LDO_BYPASS_EN;
 			}
@@ -1055,6 +1057,8 @@ static int tps65917_ldo_registration(struct palmas_pmic *pmic,
 			    id == TPS65917_REG_LDO2) {
 				desc->ops = &tps65917_ops_ldo_1_2;
 				desc->bypass_reg = desc->enable_reg;
+				desc->bypass_val_on =
+						TPS65917_LDO1_CTRL_BYPASS_EN;
 				desc->bypass_mask =
 						TPS65917_LDO1_CTRL_BYPASS_EN;
 			}
@@ -1206,6 +1210,7 @@ static int palmas_smps_registration(struct palmas_pmic *pmic,
 				desc->enable_mask = SMPS10_BOOST_EN;
 			desc->bypass_reg = PALMAS_BASE_TO_REG(PALMAS_SMPS_BASE,
 							    PALMAS_SMPS10_CTRL);
+			desc->bypass_val_on = SMPS10_BYPASS_EN;
 			desc->bypass_mask = SMPS10_BYPASS_EN;
 			desc->min_uV = 3750000;
 			desc->uV_step = 1250000;
-- 
2.8.0
