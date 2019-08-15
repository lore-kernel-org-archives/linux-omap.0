From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl: voltage lists for vdd1/2 on twl4030" to the regulator tree
Date: Thu, 15 Aug 2019 18:14:35 +0100 (BST)
Message-ID: <20190815171435.3A8AC2742BC7@ypsilon.sirena.org.uk>
References: <20190814214319.24087-1-andreas@kemnade.info>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190814214319.24087-1-andreas@kemnade.info>
Sender: stable-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Adam Ford <aford173@gmail.com>, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.orgMark Brown <broonie@kernel.org>, nm@ti.com, sboyd@kernel.org, stable@vger.kernel.org, tony@atomide.com, vireshk@kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl: voltage lists for vdd1/2 on twl4030

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

>From 3829100a63724f6dbf264b2a7f06e7f638ed952d Mon Sep 17 00:00:00 2001
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 14 Aug 2019 23:43:19 +0200
Subject: [PATCH] regulator: twl: voltage lists for vdd1/2 on twl4030

_opp_supported_by_regulators() wrongly ignored errors from
regulator_is_supported_voltage(), so it considered errors as
success. Since
commit 498209445124 ("regulator: core: simplify return value on suported_voltage")
regulator_is_supported_voltage() returns a real boolean, so
errors make _opp_supported_by_regulators() return false.

That reveals a problem with the declaration of the VDD1/2
regulators on twl4030.
The VDD1/VDD2 regulators on twl4030 are neither defined with
voltage lists nor with the continuous flag set, so
regulator_is_supported_voltage() returns false and an error
before above mentioned commit (which was considered success)
The result is that after the above mentioned commit cpufreq
does not work properly e.g. dm3730.

[    2.490997] core: _opp_supported_by_regulators: OPP minuV: 1012500 maxuV: 1012500, not supported by regulator
[    2.501617] cpu cpu0: _opp_add: OPP not supported by regulators (300000000)
[    2.509246] core: _opp_supported_by_regulators: OPP minuV: 1200000 maxuV: 1200000, not supported by regulator
[    2.519775] cpu cpu0: _opp_add: OPP not supported by regulators (600000000)
[    2.527313] core: _opp_supported_by_regulators: OPP minuV: 1325000 maxuV: 1325000, not supported by regulator
[    2.537750] cpu cpu0: _opp_add: OPP not supported by regulators (800000000)

The patch fixes declaration of VDD1/2 regulators by
adding proper voltage lists.

Fixes: 498209445124 ("regulator: core: simplify return value on suported_voltage")
Cc: stable@vger.kernel.org
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Tested-by: Adam Ford <aford173@gmail.com> #logicpd-torpedo-37xx-devkit
Link: https://lore.kernel.org/r/20190814214319.24087-1-andreas@kemnade.info
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl-regulator.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 6fa15b2d6fb3..866b4dd01da9 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -359,6 +359,17 @@ static const u16 VINTANA2_VSEL_table[] = {
 	2500, 2750,
 };
 
+/* 600mV to 1450mV in 12.5 mV steps */
+static const struct regulator_linear_range VDD1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 68, 12500)
+};
+
+/* 600mV to 1450mV in 12.5 mV steps, everything above = 1500mV */
+static const struct regulator_linear_range VDD2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 68, 12500),
+	REGULATOR_LINEAR_RANGE(1500000, 69, 69, 12500)
+};
+
 static int twl4030ldo_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -427,6 +438,8 @@ static int twl4030smps_get_voltage(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops twl4030smps_ops = {
+	.list_voltage   = regulator_list_voltage_linear_range,
+
 	.set_voltage	= twl4030smps_set_voltage,
 	.get_voltage	= twl4030smps_get_voltage,
 };
@@ -466,7 +479,8 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		}, \
 	}
 
-#define TWL4030_ADJUSTABLE_SMPS(label, offset, num, turnon_delay, remap_conf) \
+#define TWL4030_ADJUSTABLE_SMPS(label, offset, num, turnon_delay, remap_conf, \
+		n_volt) \
 static const struct twlreg_info TWL4030_INFO_##label = { \
 	.base = offset, \
 	.id = num, \
@@ -479,6 +493,9 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		.owner = THIS_MODULE, \
 		.enable_time = turnon_delay, \
 		.of_map_mode = twl4030reg_map_mode, \
+		.n_voltages = n_volt, \
+		.n_linear_ranges = ARRAY_SIZE(label ## _ranges), \
+		.linear_ranges = label ## _ranges, \
 		}, \
 	}
 
@@ -518,8 +535,8 @@ TWL4030_ADJUSTABLE_LDO(VSIM, 0x37, 9, 100, 0x00);
 TWL4030_ADJUSTABLE_LDO(VDAC, 0x3b, 10, 100, 0x08);
 TWL4030_ADJUSTABLE_LDO(VINTANA2, 0x43, 12, 100, 0x08);
 TWL4030_ADJUSTABLE_LDO(VIO, 0x4b, 14, 1000, 0x08);
-TWL4030_ADJUSTABLE_SMPS(VDD1, 0x55, 15, 1000, 0x08);
-TWL4030_ADJUSTABLE_SMPS(VDD2, 0x63, 16, 1000, 0x08);
+TWL4030_ADJUSTABLE_SMPS(VDD1, 0x55, 15, 1000, 0x08, 68);
+TWL4030_ADJUSTABLE_SMPS(VDD2, 0x63, 16, 1000, 0x08, 69);
 /* VUSBCP is managed *only* by the USB subchip */
 TWL4030_FIXED_LDO(VINTANA1, 0x3f, 1500, 11, 100, 0x08);
 TWL4030_FIXED_LDO(VINTDIG, 0x47, 1500, 13, 100, 0x08);
-- 
2.20.1
