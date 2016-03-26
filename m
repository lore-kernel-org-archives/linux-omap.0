From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/3] regulator: twl: Provide of_map_mode for twl4030
Date: Sat, 26 Mar 2016 10:28:14 +0200
Message-ID: <1458980895-10240-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1458980895-10240-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458980895-10240-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

of_map_mode is needed so to be possible to set initial regulators mode from
the board DTS. Otherwise, for DT boot, regulators are left in their default
state after reset/reboot.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/regulator/twl-regulator.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index aad748b0..be8d05e 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -395,6 +395,12 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 	return twl4030_send_pb_msg(message);
 }
 
+static inline unsigned int twl4030reg_map_mode(unsigned int mode)
+{
+	return mode == RES_STATE_ACTIVE ?
+				REGULATOR_MODE_NORMAL : REGULATOR_MODE_STANDBY;
+}
+
 static int twl6030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -897,10 +903,11 @@ static struct regulator_ops twlsmps_ops = {
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
@@ -917,6 +924,7 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		.enable_time = turnon_delay, \
+		.of_map_mode = twl4030reg_map_mode, \
 		}, \
 	}
 
@@ -932,6 +940,7 @@ static const struct twlreg_info TWL4030_INFO_##label = { \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		.enable_time = turnon_delay, \
+		.of_map_mode = twl4030reg_map_mode, \
 		}, \
 	}
 
@@ -977,7 +986,7 @@ static const struct twlreg_info TWL6032_INFO_##label = { \
 	}
 
 #define TWL_FIXED_LDO(label, offset, mVolts, num, turnon_delay, remap_conf, \
-		family, operations) \
+		family, operations, map_mode) \
 static const struct twlreg_info TWLFIXED_INFO_##label = { \
 	.base = offset, \
 	.id = num, \
@@ -992,6 +1001,7 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 		.owner = THIS_MODULE, \
 		.min_uV = mVolts * 1000, \
 		.enable_time = turnon_delay, \
+		.of_map_mode = map_mode, \
 		}, \
 	}
 
-- 
1.9.1
