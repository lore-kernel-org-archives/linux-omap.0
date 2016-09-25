From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65910: Work around silicon erratum SWCZ010" to the regulator tree
Date: Sat, 24 Sep 2016 22:59:07 -0700
Message-ID: <E1bo2Sx-00039x-UQ@finisterre>
References: <1474620720-1157-2-git-send-email-j.remmet@phytec.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1474620720-1157-2-git-send-email-j.remmet@phytec.de>
Sender: stable-owner@vger.kernel.org
To: Jan Remmet <j.remmet@phytec.de>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, tony@atomide.com, lgirdwood@gmail.combroonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: tps65910: Work around silicon erratum SWCZ010

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8f9165c981fed187bb483de84caf9adf835aefda Mon Sep 17 00:00:00 2001
From: Jan Remmet <j.remmet@phytec.de>
Date: Fri, 23 Sep 2016 10:52:00 +0200
Subject: [PATCH] regulator: tps65910: Work around silicon erratum SWCZ010

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
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/regulator/tps65910-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index fb991ec76423..696116ebdf50 100644
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
2.9.3
