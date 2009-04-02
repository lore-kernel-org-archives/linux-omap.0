From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v3] ARM: OMAP: board-ldp: add regulator info to get the microSD slot working again
Date: Thu, 2 Apr 2009 11:58:11 -0700
Message-ID: <200904021158.11612.david-b@pacbell.net>
References: <1238489589-12216-1-git-send-email-koen@beagleboard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n26.bullet.mail.mud.yahoo.com ([68.142.206.221]:24752 "HELO
	n26.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754784AbZDBS6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Apr 2009 14:58:15 -0400
In-Reply-To: <1238489589-12216-1-git-send-email-koen@beagleboard.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@beagleboard.org>
Cc: linux-omap@vger.kernel.org

Ack on that v3 patch, FWIW ... but also:

On Tuesday 31 March 2009, Koen Kooi wrote:
> +static const struct twl4030_resconfig ldp_resconfig[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0/* disable regulators that u-boot left enabled;=
 the
> +=A0=A0=A0=A0=A0=A0=A0 * devices' drivers should be managing these.
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0{ .resource =3D RES_VMMC1, },
> +=A0=A0=A0=A0=A0=A0=A0{ 0, },
> +};
> +

Purely for information -- as in, maybe *more* regulators should
be disabled -- here's a patch I tend to run with.  Obviously it's
better to set the resconfig stuff than to do what this originally
tried to do, but this predates resconfig.

All this does (now) is print some messages that highlight when
regulators end up in wierd states after initialization.

- Dave

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -39,6 +39,9 @@ struct twlreg_info {
 	/* FIXED_LDO voltage */
 	u8			deciV;
=20
+	/* true iff regulator is set up for Linux*/
+	bool			in_use;
+
 	/* voltage in mV =3D table[VSEL]; table_len must be a power-of-two */
 	u8			table_len;
 	const u16		*table;
@@ -419,6 +422,8 @@ static struct twlreg_info twl4030_regs[]
 	/* VUSBCP is managed *only* by the USB subchip */
 };
=20
+static bool is_4030;
+
 static int twl4030reg_probe(struct platform_device *pdev)
 {
 	int				i;
@@ -430,6 +435,8 @@ static int twl4030reg_probe(struct platf
 	for (i =3D 0, info =3D NULL; i < ARRAY_SIZE(twl4030_regs); i++) {
 		if (twl4030_regs[i].desc.id !=3D pdev->id)
 			continue;
+		if (pdev->id =3D=3D TWL4030_REG_VAUX2_4030)
+			is_4030 =3D true;
 		info =3D twl4030_regs + i;
 		break;
 	}
@@ -458,6 +465,8 @@ static int twl4030reg_probe(struct platf
 	}
 	platform_set_drvdata(pdev, rdev);
=20
+	info->in_use =3D true;
+
 	/* NOTE:  many regulators support short-circuit IRQs (presentable
 	 * as REGULATOR_OVER_CURRENT notifications?) configured via:
 	 *  - SC_CONFIG
@@ -469,6 +478,64 @@ static int twl4030reg_probe(struct platf
 	return 0;
 }
=20
+/*
+ * Make sure all LDOs are in the P1 (Linux) group or none; and that
+ * if Linux can't have enabled them, they're in no group (disabled).
+ * Unused-but-enabled LDOs are a constant power drain.
+ *
+ * NOTE:  something else must disable LDOs which Linux manages, but
+ * which may have been wrongly enabled during system startup.
+ */
+static __init int twl4030_ldo_tweak(void)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(twl4030_regs); i++) {
+		struct twlreg_info *info =3D &twl4030_regs[i];
+		int dev_grp, new_grp;
+		int status;
+
+		/* ignore the "other" VAUX2 descriptor */
+		if (info->base =3D=3D 0x1b) {
+			if (info->desc.id =3D=3D TWL4030_REG_VAUX2_4030) {
+				if (!is_4030)
+					continue;
+			} else {
+				if (is_4030)
+					continue;
+			}
+		}
+
+		dev_grp =3D twl4030reg_read(info, VREG_GRP);
+		if (dev_grp < 0)
+			continue;
+		dev_grp &=3D 0xf0;
+
+		if (info->in_use)
+			new_grp =3D dev_grp & (P1_GRP | WARM_CFG);
+		else
+			new_grp =3D 0;
+		if (dev_grp =3D=3D new_grp)
+			continue;
+
+		/* reset and report this; the bootloader might be fixable */
+#if 0
+		status =3D twl4030reg_write(info, VREG_GRP, new_grp);
+#else
+		status =3D 0;
+#endif
+		if (status < 0)
+			pr_err("TWL: can't update LDO %s, err %d\n",
+				info->desc.name, status);
+		else
+			pr_info("TWL: LDO %s, dev_grp %02x --> %02x\n",
+				info->desc.name, dev_grp, new_grp);
+
+	}
+	return 0;
+}
+late_initcall(twl4030_ldo_tweak);
+
 static int __devexit twl4030reg_remove(struct platform_device *pdev)
 {
 	regulator_unregister(platform_get_drvdata(pdev));



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
