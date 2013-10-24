From: NeilBrown <neilb@suse.de>
Subject: [PATCH] twl4030_charger: add devicetree support.
Date: Thu, 24 Oct 2013 16:50:05 +1100
Message-ID: <20131024165005.78bc8740@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/4Qz24Bg_Jg9//8YCHXbsI_A"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41792 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab3JXFuZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Oct 2013 01:50:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Belisko Marek <marek.belisko@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

--Sig_/4Qz24Bg_Jg9//8YCHXbsI_A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


[my first device-tree related patch.  Please let me know what I got wrong so
I wont repeat the mistake in all the others I have queued]

This allows the charger to be enabled with devicetree, and
allows the parameters for charging the backup battery to be set.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/Documentation/devicetree/bindings/power/twl-charger.txt b/Docu=
mentation/devicetree/bindings/power/twl-charger.txt
new file mode 100644
index 0000000..8afaa9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/twl-charger.txt
@@ -0,0 +1,20 @@
+TWL BCI (Battery Charger Interface)
+
+Required properties:
+- compatible:
+  - "ti,twl4030-bci"
+- interrupts: two interrupt lines from the TWL SIH (secondary
+  interrupt handler) - interrupts 9 and 2.
+
+Optional properties:
+- bb-uvolt: microvolts for charging the backup battery.
+- bb-uamp: microamps for charging the backup battery.
+
+Examples:
+
+bci {
+   compatible =3D "ti,twl4030-bci";
+   interrupts =3D <9>, <2>;
+   bb-uvolt =3D <3200000>;
+   bb-uamp =3D <150>;
+};
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index ae6a17a..5a12540 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -19,6 +19,12 @@
 		interrupts =3D <11>;
 	};
=20
+	charger: bci {
+		compatible =3D "ti,twl4030-bci";
+		interrupts =3D <9>, <2>;
+		bci3v1-supply =3D <&vusb3v1>;
+	};
+
 	watchdog {
 		compatible =3D "ti,twl4030-wdt";
 	};
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charge=
r.c
index d98abe9..a06b973 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -495,10 +495,38 @@ static enum power_supply_property twl4030_charger_pro=
ps[] =3D {
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
=20
+#ifdef CONFIG_OF
+static const struct twl4030_bci_platform_data *
+twl4030_bci_parse_dt(struct device *dev)
+{
+	struct device_node *np =3D dev->of_node;
+	struct twl4030_bci_platform_data *pdata;
+	u32 num;
+
+	if (!np)
+		return NULL;
+	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return pdata;
+
+	if (of_property_read_u32(np, "bb-uvolt", &num) =3D=3D 0)
+		pdata->bb_uvolt =3D num;
+	if (of_property_read_u32(np, "bb-uamp", &num) =3D=3D 0)
+		pdata->bb_uamp =3D num;
+	return pdata;
+}
+#else
+static inline const struct twl4030_bci_platform_data *
+twl4030_bci_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int __init twl4030_bci_probe(struct platform_device *pdev)
 {
 	struct twl4030_bci *bci;
-	struct twl4030_bci_platform_data *pdata =3D pdev->dev.platform_data;
+	const struct twl4030_bci_platform_data *pdata =3D pdev->dev.platform_data;
 	int ret;
 	u32 reg;
=20
@@ -506,6 +534,9 @@ static int __init twl4030_bci_probe(struct platform_dev=
ice *pdev)
 	if (bci =3D=3D NULL)
 		return -ENOMEM;
=20
+	if (!pdata)
+		pdata =3D twl4030_bci_parse_dt(&pdev->dev);
+
 	bci->dev =3D &pdev->dev;
 	bci->irq_chg =3D platform_get_irq(pdev, 0);
 	bci->irq_bci =3D platform_get_irq(pdev, 1);
@@ -581,8 +612,11 @@ static int __init twl4030_bci_probe(struct platform_de=
vice *pdev)
=20
 	twl4030_charger_enable_ac(true);
 	twl4030_charger_enable_usb(bci, true);
-	twl4030_charger_enable_backup(pdata->bb_uvolt,
-				      pdata->bb_uamp);
+	if (pdata)
+		twl4030_charger_enable_backup(pdata->bb_uvolt,
+					      pdata->bb_uamp);
+	else
+		twl4030_charger_enable_backup(0, 0);
=20
 	return 0;
=20
@@ -631,10 +665,17 @@ static int __exit twl4030_bci_remove(struct platform_=
device *pdev)
 	return 0;
 }
=20
+static const struct of_device_id twl_bci_of_match[] =3D {
+	{.compatible =3D "ti,twl4030-bci", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, twl_bci_of_match);
+
 static struct platform_driver twl4030_bci_driver =3D {
 	.driver	=3D {
 		.name	=3D "twl4030_bci",
 		.owner	=3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(twl_bci_of_match),
 	},
 	.remove	=3D __exit_p(twl4030_bci_remove),
 };

--Sig_/4Qz24Bg_Jg9//8YCHXbsI_A
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUmi1DTnsnt1WYoG5AQIJ/g//fC6TTgweCqCIKNmLp7C1tvLdsu9ztog7
BwjYIB+XuUZXJzETJYcwbi+MWX1B3FZvdruSZBuZcK5Hn0G+RH3OaUqJ9oRb+1fv
ODX+eMYMpOOX/5qB4vq5bAF7QkUddOLCZYEV7ZebQW/fQLkWZl3/D8HvpH6KVab7
BzZ9sL3NjFWeAZN5uQXxR+pDWpyzIphFjE7SoLBVdrkbtWZoKQ/7WGmAXRYBs1tj
+LS/vPsIoxpCFFnlj1uGQaaflbD9RXJKugPHg5/GgbYe/I7JLtwOr/+CNwYahnWW
eI+sWv0Oc8Vyj+GY8HgjVZP2pwmG2MdrK+LDBSkJXB/4LfBJLDsO8fiT0ItOGj75
71Ar/LPlNRVypICb+IvILOKYDtdryH/+UdAoQpcFhxTZEjnY6m/5GcjkrjUFx5u6
M+iMbjMVVGHIiIRXK1UazWtTfupTFloxlfNFsCaEUIp0l7ROrPVizmi7342aV4jz
bR+EUzSwycRgkUtwOUK+9T1Yj3xnKqLjTQEd317CqDRJiisz+rErDareICTbeYLl
uTzhTicDy9GjC4EqoWy7SpprK3uvcMkJ818/t49drO614Icx20mIsEOW3hzSxn2q
Djtn3eOwjRex48oUrYhWg/YCQCz//iGGZNXKPM74on05zUrIKIhavuhpHMsiFaPJ
izTz86rmv5k=
=7PFI
-----END PGP SIGNATURE-----

--Sig_/4Qz24Bg_Jg9//8YCHXbsI_A--
