From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 8/8] usb: phy: generic: allow multiples calls to
 usb_phy_generic_register()
Date: Fri, 18 Apr 2014 09:45:39 -0500
Message-ID: <20140418144539.GA25098@saruman.home>
References: <1397683595-3606-1-git-send-email-balbi@ti.com>
 <1397683595-3606-9-git-send-email-balbi@ti.com>
 <fd3b2ebd2ebc9ba0f1930b068d9016d8@doppler.thel33t.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35319 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbaDROsV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Apr 2014 10:48:21 -0400
Content-Disposition: inline
In-Reply-To: <fd3b2ebd2ebc9ba0f1930b068d9016d8@doppler.thel33t.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Felipe Balbi <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, kgene.kim@samsung.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Roger Quadros <rogerq@ti.com>, George Cherian <george.cherian@ti.com>, bigeasy@linutronix.de, aaro.koskinen@iki.fi, heikki.krogerus@linux.intel.com, zhangwm@marvell.com, David Cohen <david.a.cohen@linux.intel.com>, linux-omap-owner@vger.kernel.org

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2014 at 11:38:07AM +0100, Leigh Brown wrote:
> On 2014-04-16 22:26, Felipe Balbi wrote:
> >it's now very easy to return a platform_device pointer
> >and have the caller pass it as argument when calling
> >usb_phy_generic_unregister().
> >
> >Signed-off-by: Felipe Balbi <balbi@ti.com>
> >---
> > drivers/usb/musb/am35x.c            | 12 +++++++++---
> > drivers/usb/musb/blackfin.c         | 10 ++++++++--
> > drivers/usb/musb/da8xx.c            | 14 +++++++++++---
> > drivers/usb/musb/tusb6010.c         |  3 ++-
> > drivers/usb/phy/phy-generic.c       | 19 +++++--------------
> > include/linux/usb/usb_phy_generic.h |  8 ++++----
> > 6 files changed, 39 insertions(+), 27 deletions(-)
> >
> >diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> >index 05459b5..0a34dd8 100644
> >--- a/drivers/usb/musb/am35x.c
> >+++ b/drivers/usb/musb/am35x.c
> >@@ -85,6 +85,7 @@
> > struct am35x_glue {
> > 	struct device		*dev;
> > 	struct platform_device	*musb;
> >+	struct platform_device	*phy;
> > 	struct clk		*phy_clk;
> > 	struct clk		*clk;
> > };
> >@@ -503,7 +504,9 @@ static int am35x_probe(struct platform_device *pdev)
> >
> > 	pdata->platform_ops		=3D &am35x_ops;
> >
> >-	usb_phy_generic_register();
> >+	glue->phy =3D usb_phy_generic_register();
> >+	if (IS_ERR(glue->phy))
> >+		goto err7;
> > 	platform_set_drvdata(pdev, glue);
> >
> > 	pinfo =3D am35x_dev_info;
> >@@ -517,11 +520,14 @@ static int am35x_probe(struct platform_device *pde=
v)
> > 	if (IS_ERR(musb)) {
> > 		ret =3D PTR_ERR(musb);
> > 		dev_err(&pdev->dev, "failed to register musb device: %d\n", ret);
> >-		goto err7;
> >+		goto err8;
> > 	}
> >
> > 	return 0;
> >
> >+err8:
> >+	usb_phy_generic_unregister(glue->phy);
> >+
> > err7:
> > 	clk_disable(clk);
> >
> >@@ -546,7 +552,7 @@ static int am35x_remove(struct platform_device *pdev)
> > 	struct am35x_glue	*glue =3D platform_get_drvdata(pdev);
> >
> > 	platform_device_unregister(glue->musb);
> >-	usb_phy_generic_unregister();
> >+	usb_phy_generic_unregister(glue->phy);
> > 	clk_disable(glue->clk);
> > 	clk_disable(glue->phy_clk);
> > 	clk_put(glue->clk);
> >diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
> >index 53acffe..d40d5f0 100644
> >--- a/drivers/usb/musb/blackfin.c
> >+++ b/drivers/usb/musb/blackfin.c
> >@@ -29,6 +29,7 @@
> > struct bfin_glue {
> > 	struct device		*dev;
> > 	struct platform_device	*musb;
> >+	struct platform_device	*phy;
> > };
> > #define glue_to_musb(g)		platform_get_drvdata(g->musb)
> >
> >@@ -475,7 +476,9 @@ static int bfin_probe(struct platform_device *pdev)
> >
> > 	pdata->platform_ops		=3D &bfin_ops;
> >
> >-	usb_phy_generic_register();
> >+	glue->phy =3D usb_phy_generic_register();
> >+	if (IS_ERR(glue->phy))
> >+		goto err2;
> > 	platform_set_drvdata(pdev, glue);
> >
> > 	memset(musb_resources, 0x00, sizeof(*musb_resources) *
> >@@ -513,6 +516,9 @@ static int bfin_probe(struct platform_device *pdev)
> > 	return 0;
> >
> > err3:
> >+	usb_phy_generic_unregister(glue->phy);
> >+
> >+err2:
> > 	platform_device_put(musb);
> >
> > err1:
> >@@ -527,7 +533,7 @@ static int bfin_remove(struct platform_device *pdev)
> > 	struct bfin_glue		*glue =3D platform_get_drvdata(pdev);
> >
> > 	platform_device_unregister(glue->musb);
> >-	usb_phy_generic_unregister();
> >+	usb_phy_generic_unregister(glue->phy);
> > 	kfree(glue);
> >
> > 	return 0;
> >diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> >index 024751f..058775e 100644
> >--- a/drivers/usb/musb/da8xx.c
> >+++ b/drivers/usb/musb/da8xx.c
> >@@ -85,6 +85,7 @@
> > struct da8xx_glue {
> > 	struct device		*dev;
> > 	struct platform_device	*musb;
> >+	struct platform_device	*phy;
> > 	struct clk		*clk;
> > };
> >
> >@@ -510,7 +511,11 @@ static int da8xx_probe(struct platform_device *pdev)
> >
> > 	pdata->platform_ops		=3D &da8xx_ops;
> >
> >-	usb_phy_generic_register();
> >+	glue->phy =3D usb_phy_generic_register();
> >+	if (IS_ERR(glue->phy)) {
> >+		ret =3D PTR_ERR(glue->phy);
> >+		goto err5;
> >+	}
> > 	platform_set_drvdata(pdev, glue);
> >
> > 	memset(musb_resources, 0x00, sizeof(*musb_resources) *
> >@@ -537,11 +542,14 @@ static int da8xx_probe(struct platform_device *pde=
v)
> > 	if (IS_ERR(musb)) {
> > 		ret =3D PTR_ERR(musb);
> > 		dev_err(&pdev->dev, "failed to register musb device: %d\n", ret);
> >-		goto err5;
> >+		goto err6;
> > 	}
> >
> > 	return 0;
> >
> >+err6:
> >+	usb_phy_generic_unregister(glue->phy);
> >+
> > err5:
> > 	clk_disable(clk);
> >
> >@@ -560,7 +568,7 @@ static int da8xx_remove(struct platform_device *pdev)
> > 	struct da8xx_glue		*glue =3D platform_get_drvdata(pdev);
> >
> > 	platform_device_unregister(glue->musb);
> >-	usb_phy_generic_unregister();
> >+	usb_phy_generic_unregister(glue->phy);
> > 	clk_disable(glue->clk);
> > 	clk_put(glue->clk);
> > 	kfree(glue);
> >diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
> >index e1da199..f38a8db 100644
> >--- a/drivers/usb/musb/tusb6010.c
> >+++ b/drivers/usb/musb/tusb6010.c
> >@@ -31,6 +31,7 @@
> > struct tusb6010_glue {
> > 	struct device		*dev;
> > 	struct platform_device	*musb;
> >+	struct platform_device	*phy;
> > };
> >
> > static void tusb_musb_set_vbus(struct musb *musb, int is_on);
> >@@ -1222,7 +1223,7 @@ static int tusb_remove(struct platform_device *pde=
v)
> > 	struct tusb6010_glue		*glue =3D platform_get_drvdata(pdev);
> >
> > 	platform_device_unregister(glue->musb);
> >-	usb_phy_generic_unregister();
> >+	usb_phy_generic_unregister(glue->phy);
> > 	kfree(glue);
> >
> > 	return 0;
> >diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic=
=2Ec
> >index 2c49cd8..7594e50 100644
> >--- a/drivers/usb/phy/phy-generic.c
> >+++ b/drivers/usb/phy/phy-generic.c
> >@@ -41,25 +41,16 @@
> >
> > #include "phy-generic.h"
> >
> >-static struct platform_device *pd;
> >-
> >-void usb_phy_generic_register(void)
> >+struct platform_device *usb_phy_generic_register(void)
> > {
> >-	if (pd)
> >-		return;
> >-	pd =3D platform_device_register_simple("usb_phy_generic", -1, NULL, 0);
> >-	if (IS_ERR(pd)) {
> >-		pr_err("Unable to register generic usb transceiver\n");
> >-		pd =3D NULL;
> >-		return;
> >-	}
> >+	return platform_device_register_simple("usb_phy_generic",
> >+			PLATFORM_DEVID_AUTO, NULL, 0);
> > }
> > EXPORT_SYMBOL_GPL(usb_phy_generic_register);
> >
> >-void usb_phy_generic_unregister(void)
> >+void usb_phy_generic_unregister(struct platform_device *pdev)
> > {
> >-	platform_device_unregister(pd);
> >-	pd =3D NULL;
> >+	platform_device_unregister(pdev);
> > }
> > EXPORT_SYMBOL_GPL(usb_phy_generic_unregister);
> >
> >diff --git a/include/linux/usb/usb_phy_generic.h
> >b/include/linux/usb/usb_phy_generic.h
> >index c00176d..622e7226 100644
> >--- a/include/linux/usb/usb_phy_generic.h
> >+++ b/include/linux/usb/usb_phy_generic.h
> >@@ -15,14 +15,14 @@ struct usb_phy_generic_platform_data {
> >
> > #if defined(CONFIG_NOP_USB_XCEIV) ||
> >(defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
>=20
> Not related to your patch but `&& defined(MODULE)' appears to be incorrec=
t -
> that's how
> I found out about the next comment...
>=20
> > /* sometimes transceivers are accessed only through e.g. ULPI */
> >-extern void usb_phy_generic_register(void);
> >-extern void usb_phy_generic_unregister(void);
> >+extern struct platform_device *usb_phy_generic_register(void);
> >+extern void usb_phy_generic_unregister(struct platform_device *);
> > #else
> >-static inline void usb_phy_generic_register(void)
> >+static inline struct platform_device *usb_phy_generic_register(void)
> > {
> > }
>=20
> Should this return NULL now?

will fix, it's always good to have another set of eyes ;-)

thanks

--=20
balbi

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTUTqTAAoJEIaOsuA1yqRE9R0P/RDRNmSHrTDy3P62jIbW4XQo
ghvpkDtAgwuJHB6NBXrzyzW+8JsDsscHGcRE0dfNreVxHm4fBG9TSVz0wGu8X1zg
xeTo0lPyjrGH6+h0u7WwZ7E2RON67HzuTS2zdccMSdAE0AU04UxaMXdoGJ0xQsku
Qtac2MFKOneBQP07z1IhFZESWcRzz2+1qiwDfpcjO2eG3+bdmCq7AdZ+gj+6ctyR
slxHjyntsgFcc1qd+xPft50RqWVc7SLKms1CP3BZxa6MuSsptPzmOxG4WF+YGE3a
f+z7dlPXqyBUnMqdUAHf2T/Er3s5jIZs86re0C6gxlp2/p32zgRRf23nD/HT4I4U
u/+G09RolWPzZ5EuoGZ8B5kSFCEAgNxIJmsZl1Wah7R0whHDVUT5Pf7fPGFJaAQQ
UtgRCabaP9lgSUv6SetBl8YStga8RoZji8evJQx+ctd+wbl7zgXWImmQEEjr13kt
dXpDVrFJc1Ynwzc/96JYxSWZ939OvBnEtg6V1WXpQnxqj839WugYGEu2dRY8M3uw
LNm7eL2M6gbzXlU/HDXRYDX5zC9VbfxkLhHfqMKonM50SMsUMlJKILernCGhhN/6
qHXho30yKZHreHhEhkTmFQiTMzdPYvRL5NWVOQwbbAER3zgBVEVWTKF3xyCeijep
otzZqgTHXsjE+3S19HHQ
=qhk8
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
