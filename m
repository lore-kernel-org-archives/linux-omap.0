From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.29-rc6 2/2] regulator: twl4030 voltage enumeration (v2)
Date: Tue, 3 Mar 2009 14:59:59 -0800
Message-ID: <200903031500.00166.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902261602.58832.david-b@pacbell.net> <1235737930.31223.117.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n23.bullet.mail.mud.yahoo.com ([68.142.206.162]:28191 "HELO
	n23.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754794AbZCCXAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 18:00:05 -0500
In-Reply-To: <1235737930.31223.117.camel@vega.slimlogic.co.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Friday 27 February 2009, Liam Girdwood wrote:
> Sorry, this didn't apply. It looks like I'm missing an earlier patch(s)
> here. Could you regenerate this and your core patch against latest
> for-next.

Here you go.

- Dave


========== CUT HERE
From: David Brownell <dbrownell@users.sourceforge.net>

Minor cleanups to the twl403 regulator driver, mostly enabled
by other recent changes:  comments, shrink memory usage, add
definition for one bit.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/regulator/twl4030-regulator.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -36,13 +36,13 @@ struct twlreg_info {
 	/* twl4030 resource ID, for resource control state machine */
 	u8			id;
 
+	/* FIXED_LDO voltage */
+	u8			deciV;
+
 	/* voltage in mV = table[VSEL]; table_len must be a power-of-two */
 	u8			table_len;
 	const u16		*table;
 
-	/* chip constraints on regulator behavior */
-	u16			min_mV;
-
 	/* used by regulator core */
 	struct regulator_desc	desc;
 };
@@ -93,6 +93,7 @@ static int twl4030reg_grp(struct regulat
 #define P3_GRP		BIT(7)		/* "peripherals" */
 #define P2_GRP		BIT(6)		/* secondary processor, modem, etc */
 #define P1_GRP		BIT(5)		/* CPU/Linux */
+#define WARM_CFG	BIT(4)
 
 static int twl4030reg_is_enabled(struct regulator_dev *rdev)
 {
@@ -325,14 +326,14 @@ static int twl4030fixed_list_voltage(str
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 
-	return info->min_mV * 1000;
+	return info->deciV * 100 * 1000;
 }
 
 static int twl4030fixed_get_voltage(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 
-	return info->min_mV * 1000;
+	return info->deciV * 100 * 1000;
 }
 
 static struct regulator_ops twl4030fixed_ops = {
@@ -369,7 +370,7 @@ static struct regulator_ops twl4030fixed
 #define TWL_FIXED_LDO(label, offset, mVolts, num) { \
 	.base = offset, \
 	.id = num, \
-	.min_mV = mVolts, \
+	.deciV = mVolts / 100 , \
 	.desc = { \
 		.name = #label, \
 		.id = TWL4030_REG_##label, \
@@ -381,7 +382,7 @@ static struct regulator_ops twl4030fixed
 	}
 
 /*
- * We list regulators here if systems need some level of
+ * We expose regulators here if systems need some level of
  * software control over them after boot.
  */
 static struct twlreg_info twl4030_regs[] = {
@@ -435,6 +436,7 @@ static int twl4030reg_probe(struct platf
 
 	/* Constrain board-specific capabilities according to what
 	 * this driver and the chip itself can actually do.
+	 * (Regulator core now does this for voltage constraints.)
 	 */
 	c = &initdata->constraints;
 	c->valid_modes_mask &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;



