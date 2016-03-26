From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 3/3] regulator: twl: Regulator mode should not depend on regulator enabled state
Date: Sat, 26 Mar 2016 10:28:15 +0200
Message-ID: <1458980895-10240-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1458980895-10240-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458980895-10240-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

When machine constraints are applied, regulator framework first sets
initial mode (if any) and then enables the regulator if needed. The current
code in twl4030reg_set_mode always checks if the regulator is enabled
before applying the mode. That results in -EACCES error returned for
"always-on" regulators which have "initial-mode" set in the board DTS. Fix
that by removing the unneeded check.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/regulator/twl-regulator.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index be8d05e..d8f6ad6 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -371,7 +371,6 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	unsigned		message;
-	int			status;
 
 	/* We can only set the mode through state machine commands... */
 	switch (mode) {
@@ -385,13 +384,6 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 		return -EINVAL;
 	}
 
-	/* Ensure the resource is associated with some group */
-	status = twlreg_grp(rdev);
-	if (status < 0)
-		return status;
-	if (!(status & (P3_GRP_4030 | P2_GRP_4030 | P1_GRP_4030)))
-		return -EACCES;
-
 	return twl4030_send_pb_msg(message);
 }
 
-- 
1.9.1
