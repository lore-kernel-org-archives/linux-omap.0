From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] regulator: twl: fix use of integer as pointer
Date: Tue,  7 Jun 2016 18:40:01 +0100
Message-ID: <1465321201-15314-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The TWL6030_FIXED_LDO() macro passes the TWL_FIXED_LDO()
macro an 0x0 instead of a NULL. Changing this to a NULL
fixes the following warnings:

drivers/regulator/twl-regulator.c:1068:1: warning: Using plain integer as NULL pointer
drivers/regulator/twl-regulator.c:1069:1: warning: Using plain integer as NULL pointer
drivers/regulator/twl-regulator.c:1070:1: warning: Using plain integer as NULL pointer
drivers/regulator/twl-regulator.c:1071:1: warning: Using plain integer as NULL pointer
drivers/regulator/twl-regulator.c:1072:1: warning: Using plain integer as NULL pointer
drivers/regulator/twl-regulator.c:1073:1: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/regulator/twl-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index faeb5ee..210681d 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -905,7 +905,7 @@ static struct regulator_ops twlsmps_ops = {
 			twl4030reg_map_mode)
 #define TWL6030_FIXED_LDO(label, offset, mVolts, turnon_delay) \
 		TWL_FIXED_LDO(label, offset, mVolts, 0x0, turnon_delay, \
-			0x0, TWL6030, twl6030fixed_ops, 0x0)
+			0x0, TWL6030, twl6030fixed_ops, NULL)
 
 #define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf) \
 static const struct twlreg_info TWL4030_INFO_##label = { \
-- 
2.8.1
