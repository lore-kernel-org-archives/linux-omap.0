From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc2-omap1-git 2/7] twl4030 regulator uses new get_status() op
Date: Tue, 20 Jan 2009 02:48:26 -0800
Message-ID: <200901200248.26729.david-b@pacbell.net>
References: <200901200244.36238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:44264 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756730AbZATLBT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2009 06:01:19 -0500
In-Reply-To: <200901200244.36238.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Update twl4030 regulator driver to support the new get_status()
method and otherwise implement the newly "clarified" semantics.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Given this, I think this driver is ready to merge to mainline.

 drivers/regulator/twl4030-regulator.c |   39 +++++++++++++++-----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -90,17 +90,6 @@ static int twl4030reg_grp(struct regulat
 	return twl4030reg_read(rdev_get_drvdata(rdev), VREG_GRP);
 }
 
-static int twl4030reg_is_enabled(struct regulator_dev *rdev)
-{
-	int	state = twl4030reg_grp(rdev);
-
-	if (state < 0)
-		return state;
-
-	/* resource state == OFF (vs SLEEP or ACTIVE) */
-	return (state & 0x0f) != 0;
-}
-
 /*
  * Enable/disable regulators by joining/leaving the P1 (processor) group.
  * We assume nobody else is updating the DEV_GRP registers.
@@ -110,6 +99,16 @@ static int twl4030reg_is_enabled(struct 
 #define P2_GRP		BIT(6)		/* secondary processor, modem, etc */
 #define P1_GRP		BIT(5)		/* CPU/Linux */
 
+static int twl4030reg_is_enabled(struct regulator_dev *rdev)
+{
+	int	state = twl4030reg_grp(rdev);
+
+	if (state < 0)
+		return state;
+
+	return (state & P1_GRP) != 0;
+}
+
 static int twl4030reg_enable(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -136,7 +135,7 @@ static int twl4030reg_disable(struct reg
 	return twl4030reg_write(info, VREG_GRP, grp);
 }
 
-static unsigned twl4030reg_get_mode(struct regulator_dev *rdev)
+static int twl4030reg_get_status(struct regulator_dev *rdev)
 {
 	int	state = twl4030reg_grp(rdev);
 
@@ -146,10 +145,10 @@ static unsigned twl4030reg_get_mode(stru
 
 	/* assume state != WARM_RESET; we'd not be running...  */
 	if (!state)
-		return REGULATOR_MODE_OFF;
+		return REGULATOR_STATUS_OFF;
 	return (state & BIT(3))
-		? REGULATOR_MODE_NORMAL
-		: REGULATOR_MODE_STANDBY;
+		? REGULATOR_STATUS_NORMAL
+		: REGULATOR_STATUS_STANDBY;
 }
 
 static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
@@ -306,7 +305,8 @@ static struct regulator_ops twl4030ldo_o
 	.is_enabled	= twl4030reg_is_enabled,
 
 	.set_mode	= twl4030reg_set_mode,
-	.get_mode	= twl4030reg_get_mode,
+
+	.get_status	= twl4030reg_get_status,
 };
 
 /*----------------------------------------------------------------------*/
@@ -329,7 +329,8 @@ static struct regulator_ops twl4030fixed
 	.is_enabled	= twl4030reg_is_enabled,
 
 	.set_mode	= twl4030reg_set_mode,
-	.get_mode	= twl4030reg_get_mode,
+
+	.get_status	= twl4030reg_get_status,
 };
 
 /*----------------------------------------------------------------------*/
@@ -426,9 +427,7 @@ static int twl4030reg_probe(struct platf
 		c->min_uV = min_uV;
 	if (!c->max_uV || c->max_uV > max_uV)
 		c->max_uV = max_uV;
-	c->valid_modes_mask &= REGULATOR_MODE_NORMAL
-				| REGULATOR_MODE_STANDBY
-				| REGULATOR_MODE_OFF;
+	c->valid_modes_mask &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
 	c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE
 				| REGULATOR_CHANGE_MODE
 				| REGULATOR_CHANGE_STATUS;
