From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.29-rc6 2/2] regulator: twl4030 voltage enumeration (v2)
Date: Thu, 26 Feb 2009 16:02:58 -0800
Message-ID: <200902261602.58832.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902261150.15125.david-b@pacbell.net> <1235686618.31223.107.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n30.bullet.mail.mud.yahoo.com ([68.142.207.49]:41319 "HELO
	n30.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754935AbZB0ADK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 19:03:10 -0500
In-Reply-To: <1235686618.31223.107.camel@vega.slimlogic.co.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thursday 26 February 2009, Liam Girdwood wrote:
> >=20
> > Note that the twl4030 regulator patch referred to will need a
> > minor patch to work with the -next tree, because of interface
> > change in the regulator framework.
> >=20
> > =A0drivers/regulator/twl4030-regulator.c | =A0 62 +++++++++++------=
---------------
> > =A01 file changed, 23 insertions(+), 39 deletions(-)
>=20
> Applied.

=2E... and here's that "minor patch".

=3D=3D=3D=3D=3D=3D CUT HERE
=46rom: David Brownell <dbrownell@users.sourceforge.net>

Catch up the twl4030 regulator driver to the regulator
interface change adding another parameter.  Also, fix
some comments, and take this opportunity to shrink the
associated per-regulator memory usage by a word.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/regulator/twl4030-regulator.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -36,13 +36,13 @@ struct twlreg_info {
 	/* twl4030 resource ID, for resource control state machine */
 	u8			id;
=20
+	/* FIXED_LDO voltage */
+	u8			deciV;
+
 	/* voltage in mV =3D table[VSEL]; table_len must be a power-of-two */
 	u8			table_len;
 	const u16		*table;
=20
-	/* chip constraints on regulator behavior */
-	u16			min_mV;
-
 	/* used by regulator core */
 	struct regulator_desc	desc;
 };
@@ -329,14 +329,14 @@ static int twl4030fixed_list_voltage(str
 {
 	struct twlreg_info	*info =3D rdev_get_drvdata(rdev);
=20
-	return info->min_mV * 1000;
+	return info->deciV * 100 * 1000;
 }
=20
 static int twl4030fixed_get_voltage(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info =3D rdev_get_drvdata(rdev);
=20
-	return info->min_mV * 1000;
+	return info->deciV * 100 * 1000;
 }
=20
 static struct regulator_ops twl4030fixed_ops =3D {
@@ -373,7 +373,7 @@ static struct regulator_ops twl4030fixed
 #define TWL_FIXED_LDO(label, offset, mVolts, num) { \
 	.base =3D offset, \
 	.id =3D num, \
-	.min_mV =3D mVolts, \
+	.deciV =3D mVolts / 100 , \
 	.desc =3D { \
 		.name =3D #label, \
 		.id =3D TWL4030_REG_##label, \
@@ -385,7 +385,7 @@ static struct regulator_ops twl4030fixed
 	}
=20
 /*
- * We list regulators here if systems need some level of
+ * We expose regulators here if systems need some level of
  * software control over them after boot.
  */
 static struct twlreg_info twl4030_regs[] =3D {
@@ -439,6 +439,7 @@ static int twl4030reg_probe(struct platf
=20
 	/* Constrain board-specific capabilities according to what
 	 * this driver and the chip itself can actually do.
+	 * (Regulator core now does this for voltage constraints.)
 	 */
 	c =3D &initdata->constraints;
 	c->valid_modes_mask &=3D REGULATOR_MODE_NORMAL | REGULATOR_MODE_STAND=
BY;
@@ -446,7 +447,7 @@ static int twl4030reg_probe(struct platf
 				| REGULATOR_CHANGE_MODE
 				| REGULATOR_CHANGE_STATUS;
=20
-	rdev =3D regulator_register(&info->desc, &pdev->dev, info);
+	rdev =3D regulator_register(&info->desc, &pdev->dev, initdata, info);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "can't register %s, %ld\n",
 				info->desc.name, PTR_ERR(rdev));



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
