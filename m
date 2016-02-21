From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 1/6] power_supply: isp1704_charger: Error messages when probe fail
Date: Sun, 21 Feb 2016 12:28:18 +0100
Message-ID: <1456054103-19551-2-git-send-email-pali.rohar@gmail.com>
References: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch adds more detailed error messages when probe function fail.
It is useful for debbuging why driver refuse to register charger device=
=2E

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/power/isp1704_charger.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_ch=
arger.c
index 46a292a..acaf7cf 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -411,8 +411,10 @@ static int isp1704_charger_probe(struct platform_d=
evice *pdev)
 	if (np) {
 		int gpio =3D of_get_named_gpio(np, "nxp,enable-gpio", 0);
=20
-		if (gpio < 0)
+		if (gpio < 0) {
+			dev_err(&pdev->dev, "missing DT GPIO nxp,enable-gpio\n");
 			return gpio;
+		}
=20
 		pdata =3D devm_kzalloc(&pdev->dev,
 			sizeof(struct isp1704_charger_data), GFP_KERNEL);
@@ -422,8 +424,10 @@ static int isp1704_charger_probe(struct platform_d=
evice *pdev)
=20
 		ret =3D devm_gpio_request_one(&pdev->dev, pdata->enable_gpio,
 					GPIOF_OUT_INIT_HIGH, "isp1704_reset");
-		if (ret)
+		if (ret) {
+			dev_err(&pdev->dev, "gpio request failed\n");
 			goto fail0;
+		}
 	}
=20
 	if (!pdata) {
@@ -443,6 +447,7 @@ static int isp1704_charger_probe(struct platform_de=
vice *pdev)
=20
 	if (IS_ERR(isp->phy)) {
 		ret =3D PTR_ERR(isp->phy);
+		dev_err(&pdev->dev, "usb_get_phy failed\n");
 		goto fail0;
 	}
=20
@@ -452,8 +457,10 @@ static int isp1704_charger_probe(struct platform_d=
evice *pdev)
 	isp1704_charger_set_power(isp, 1);
=20
 	ret =3D isp1704_test_ulpi(isp);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(&pdev->dev, "isp1704_test_ulpi failed\n");
 		goto fail1;
+	}
=20
 	isp->psy_desc.name		=3D "isp1704";
 	isp->psy_desc.type		=3D POWER_SUPPLY_TYPE_USB;
@@ -466,6 +473,7 @@ static int isp1704_charger_probe(struct platform_de=
vice *pdev)
 	isp->psy =3D power_supply_register(isp->dev, &isp->psy_desc, &psy_cfg=
);
 	if (IS_ERR(isp->psy)) {
 		ret =3D PTR_ERR(isp->psy);
+		dev_err(&pdev->dev, "power_supply_register failed\n");
 		goto fail1;
 	}
=20
@@ -478,8 +486,10 @@ static int isp1704_charger_probe(struct platform_d=
evice *pdev)
 	isp->nb.notifier_call =3D isp1704_notifier_call;
=20
 	ret =3D usb_register_notifier(isp->phy, &isp->nb);
-	if (ret)
+	if (ret) {
+		dev_err(&pdev->dev, "usb_register_notifier failed\n");
 		goto fail2;
+	}
=20
 	dev_info(isp->dev, "registered with product id %s\n", isp->model);
=20
--=20
1.7.9.5

