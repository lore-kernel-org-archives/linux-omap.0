From: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] regulator: twl: Provide of_map_mode for twl4030
Date: Mon,  4 Apr 2016 21:57:14 +0300
Message-ID: <1459796234-2430-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20160328093938.GA2350@sirena.org.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160328093938.GA2350-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

of_map_mode is needed so to be possible to set initial regulators mode from
the board DTS. Otherwise, for DT boot, regulators are left in their default
state after reset/reboot. Document device specific modes as well.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/regulator/twl-regulator.txt      |  8 ++++++++
 drivers/regulator/twl-regulator.c                        | 16 +++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
index 75b0c16..fe759903 100644
--- a/Documentation/devicetree/bindings/regulator/twl-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -57,6 +57,14 @@ For twl4030 regulators/LDOs
 
 Optional properties:
 - Any optional property defined in bindings/regulator/regulator.txt
+For twl4030 regulators/LDOs:
+ - regulator-initial-mode:
+  - 0x00 - Off mode, the output voltage is not maintained and voltage regulator
+           power consumption is 0.
+  - 0x08 - Sleep mode, the nominal output voltage is maintained with low power
+           consumption with low load current capability.
+  - 0x0e - Active mode, the regulator can deliver its nominal output voltage
+           with full-load current capability.
 
 Example:
 
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
