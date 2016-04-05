From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v1] regulator: twl: Provide of_map_mode for twl4030
Date: Tue,  5 Apr 2016 08:59:34 +0300
Message-ID: <1459835974-31664-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20160404222638.GM2350@sirena.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160404222638.GM2350@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, tony@atomide.com, lgirdwood@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

of_map_mode is needed so to be possible to set initial regulators mode from
the board DTS. Otherwise, for DT boot, regulators are left in their default
state after reset/reboot. Document device specific modes as well.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 .../bindings/regulator/twl-regulator.txt           |  6 ++++++
 drivers/regulator/twl-regulator.c                  | 22 +++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
index 75b0c16..74a91c4 100644
--- a/Documentation/devicetree/bindings/regulator/twl-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -57,6 +57,12 @@ For twl4030 regulators/LDOs
 
 Optional properties:
 - Any optional property defined in bindings/regulator/regulator.txt
+For twl4030 regulators/LDOs:
+ - regulator-initial-mode:
+  - 0x08 - Sleep mode, the nominal output voltage is maintained with low power
+           consumption with low load current capability.
+  - 0x0e - Active mode, the regulator can deliver its nominal output voltage
+           with full-load current capability.
 
 Example:
 
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index aad748b0..53fcbb0 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -395,6 +395,18 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 	return twl4030_send_pb_msg(message);
 }
 
+static inline unsigned int twl4030reg_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case RES_STATE_ACTIVE:
+		return REGULATOR_MODE_NORMAL;
+	case RES_STATE_SLEEP:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int twl6030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -897,10 +909,11 @@ static struct regulator_ops twlsmps_ops = {
 #define TWL4030_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
 			remap_conf) \
 		TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, \
-			remap_conf, TWL4030, twl4030fixed_ops)
+			remap_conf, TWL4030, twl4030fixed_ops, \
+			twl4030reg_map_mode)
 #define TWL6030_FIXED_LDO(label, offset, mVolts, turnon_delay) \
 		TWL_FIXED_LDO(label, offset, mVolts, 0x0, turnon_delay, \
-			0x0, TWL6030, twl6030fixed_ops)
+			0x0, TWL6030, twl6030fixed_ops, 0x0)
 
 #define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) \
 static const struct twlreg_info TWL4030_INFO_##label = { \
@@ -917,6 +930,7 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		.enable_time = turnon_delay, \
+		.of_map_mode = twl4030reg_map_mode, \
 		}, \
 	}
 
@@ -932,6 +946,7 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		.enable_time = turnon_delay, \
+		.of_map_mode = twl4030reg_map_mode, \
 		}, \
 	}
 
@@ -977,7 +992,7 @@ static const struct twlreg_info TWL6032_INFO_##label = { \
 	}
 
 #define TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, remap_conf, \
-		family, operations) \
+		family, operations, map_mode) \
 static const struct twlreg_info TWLFIXED_INFO_##label = { \
 	.base = offset, \
 	.id = num, \
@@ -992,6 +1007,7 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 		.owner = THIS_MODULE, \
 		.min_uV = mVolts * 1000, \
 		.enable_time = turnon_delay, \
+		.of_map_mode = map_mode, \
 		}, \
 	}
 
-- 
1.9.1
