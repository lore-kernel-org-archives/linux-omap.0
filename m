From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] regulator: twl: Enable regulators over the powerbus as well
Date: Wed, 23 Mar 2016 21:22:36 +0200
Message-ID: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Assigning a device group to a regulator does not change its state. To
change the state of a regulator a message over the powerbus is required.
Also, the check for the current state of a regulator should not count on
a device group being assigned, but on the current resource state.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/regulator/twl-regulator.c | 85 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 955a6fb..125d5b1 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -21,7 +21,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/i2c/twl.h>
-
+#include <linux/delay.h>
 
 /*
  * The TWL4030/TW5030/TPS659x0/TWL6030 family chips include power management, a
@@ -165,7 +165,7 @@ static int twl4030reg_is_enabled(struct regulator_dev *rdev)
 	if (state < 0)
 		return state;
 
-	return state & P1_GRP_4030;
+	return (state & 0x0f) != 0;
 }
 
 static int twl6030reg_is_enabled(struct regulator_dev *rdev)
@@ -188,11 +188,78 @@ static int twl6030reg_is_enabled(struct regulator_dev *rdev)
 	return grp && (val == TWL6030_CFG_STATE_ON);
 }
 
+#define PB_I2C_BUSY	BIT(0)
+#define PB_I2C_BWEN	BIT(1)
+
+static int twl4030_wait_pb_ready(void)
+{
+
+	int	ret;
+	int	timeout = 10;
+	u8	val;
+
+	do {
+		ret = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
+				      TWL4030_PM_MASTER_PB_CFG);
+		if (ret < 0)
+			return ret;
+
+		if (!(val & PB_I2C_BUSY))
+			return 0;
+
+		mdelay(1);
+		timeout--;
+	} while (timeout);
+
+	return -ETIMEDOUT;
+}
+
+static int twl4030_send_pb_msg(unsigned msg)
+{
+	u8	val;
+	int	ret;
+
+	/* save powerbus configuration */
+	ret = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
+			      TWL4030_PM_MASTER_PB_CFG);
+	if (ret < 0)
+		return ret;
+
+	/* Enable I2C access to powerbus */
+	ret = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val | PB_I2C_BWEN,
+			       TWL4030_PM_MASTER_PB_CFG);
+	if (ret < 0)
+		return ret;
+
+	ret = twl4030_wait_pb_ready();
+	if (ret < 0)
+		return ret;
+
+	ret = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, msg >> 8,
+			       TWL4030_PM_MASTER_PB_WORD_MSB);
+	if (ret < 0)
+		return ret;
+
+	ret = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, msg & 0xff,
+			       TWL4030_PM_MASTER_PB_WORD_LSB);
+	if (ret < 0)
+		return ret;
+
+	ret = twl4030_wait_pb_ready();
+	if (ret < 0)
+		return ret;
+
+	/* Restore powerbus configuration */
+	return twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val,
+				TWL_MODULE_PM_MASTER);
+}
+
 static int twl4030reg_enable(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			grp;
 	int			ret;
+	unsigned		message;
 
 	grp = twlreg_grp(rdev);
 	if (grp < 0)
@@ -201,8 +268,12 @@ static int twl4030reg_enable(struct regulator_dev *rdev)
 	grp |= P1_GRP_4030;
 
 	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	message = MSG_SINGULAR(DEV_GRP_P1, info->id, RES_STATE_ACTIVE);
+
+	return twl4030_send_pb_msg(message);
 }
 
 static int twl6030reg_enable(struct regulator_dev *rdev)
@@ -324,13 +395,7 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 	if (!(status & (P3_GRP_4030 | P2_GRP_4030 | P1_GRP_4030)))
 		return -EACCES;
 
-	status = twl_i2c_write_u8(TWL_MODULE_PM_MASTER,
-			message >> 8, TWL4030_PM_MASTER_PB_WORD_MSB);
-	if (status < 0)
-		return status;
-
-	return twl_i2c_write_u8(TWL_MODULE_PM_MASTER,
-			message & 0xff, TWL4030_PM_MASTER_PB_WORD_LSB);
+	return twl4030_send_pb_msg(message);
 }
 
 static int twl6030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
-- 
1.9.1
