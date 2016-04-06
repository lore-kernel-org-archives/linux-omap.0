From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] regulator: twl: Fix a typo in twl4030_send_pb_msg
Date: Wed,  6 Apr 2016 09:06:03 +0300
Message-ID: <1459922763-14775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <57043B87.20304@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57043B87.20304@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Commit <2330b05c095bdeaaf1261c54cd2d4b9127496996> ("regulator: twl: Make
sure we have access to powerbus before trying to write to it")
has implemented the needed logic to correctly access powerbus through i2c,
however it brought a typo when powerbus configuration is restored, which
results in writing to a wrong register. Fix that by providing the correct
register value.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/regulator/twl-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 11c6a5c..faeb5ee 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -253,7 +253,7 @@ static int twl4030_send_pb_msg(unsigned msg)
 
 	/* Restore powerbus configuration */
 	return twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val,
-				TWL_MODULE_PM_MASTER);
+				TWL4030_PM_MASTER_PB_CFG);
 }
 
 static int twl4030reg_enable(struct regulator_dev *rdev)
-- 
1.9.1
