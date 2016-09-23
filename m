From: Jan Remmet <j.remmet@phytec.de>
Subject: [PATCH] regulator: tps65910: Work around silicon erratum SWCZ010
Date: Fri, 23 Sep 2016 10:52:00 +0200
Message-ID: <1474620720-1157-2-git-send-email-j.remmet@phytec.de>
References: <1474620720-1157-1-git-send-email-j.remmet@phytec.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474620720-1157-1-git-send-email-j.remmet@phytec.de>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

http://www.ti.com/lit/pdf/SWCZ010:
  DCDC o/p voltage can go higher than programmed value

Impact:
VDDI, VDD2, and VIO output programmed voltage level can go higher than
expected or crash, when coming out of PFM to PWM mode or using DVFS.

Description:
When DCDC CLK SYNC bits are 11/01:
* VIO 3-MHz oscillator is the source clock of the digital core and input
  clock of VDD1 and VDD2
* Turn-on of VDD1 and VDD2 HSD PFETis synchronized or at a constant
  phase shift
* Current pulled though VCC1+VCC2 is Iload(VDD1) + Iload(VDD2)
* The 3 HSD PFET will be turned-on at the same time, causing the highest
  possible switching noise on the application. This noise level depends
  on the layout, the VBAT level, and the load current. The noise level
  increases with improper layout.

When DCDC CLK SYNC bits are 00:
* VIO 3-MHz oscillator is the source clock of digital core
* VDD1 and VDD2 are running on their own 3-MHz oscillator
* Current pulled though VCC1+VCC2 average of Iload(VDD1) + Iload(VDD2)
* The switching noise of the 3 SMPS will be randomly spread over time,
  causing lower overall switching noise.

Workaround:
Set DCDCCTRL_REG[1:0]= 00.

Signed-off-by: Jan Remmet <j.remmet@phytec.de>
---
 drivers/regulator/tps65910-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index fb991ec..696116e 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1111,6 +1111,12 @@ static int tps65910_probe(struct platform_device *pdev)
 		pmic->num_regulators = ARRAY_SIZE(tps65910_regs);
 		pmic->ext_sleep_control = tps65910_ext_sleep_control;
 		info = tps65910_regs;
+		/* Work around silicon erratum SWCZ010: output programmed
+		 * voltage level can go higher than expected or crash
+		 * Workaround: use no synchronization of DCDC clocks
+		 */
+		tps65910_reg_clear_bits(pmic->mfd, TPS65910_DCDCCTRL,
+					DCDCCTRL_DCDCCKSYNC_MASK);
 		break;
 	case TPS65911:
 		pmic->get_ctrl_reg = &tps65911_get_ctrl_register;
-- 
1.9.1
