From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/6] Drop legacy booting for omap4 for v3.11, boot with
 device tree only
Date: Fri, 7 Jun 2013 13:05:44 +0300
Message-ID: <51B1B078.9000401@ti.com>
References: <20130517191304.468.73487.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2OJPVKTFALOJXUUPNQPLD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52703 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab3FGKGO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 06:06:14 -0400
In-Reply-To: <20130517191304.468.73487.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

------enig2OJPVKTFALOJXUUPNQPLD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 17/05/13 22:17, Tony Lindgren wrote:
> Hi all,
>=20
> Here are patches against v3.10-rc1 to drop omap4 legacy booting as
> things are now working well enough for booting omap4 with device
> tree.
>=20
> We already have am33xx and omap5 booting with device tree only,
> and converting omap4 is relatively easy with just two board-*.c
> files merged as we have not accepted any new board-*.c files for
> quite some time now.
>=20
> By working "well enough" I mean that I can use my omap4 panda-es
> with device tree with a Motorola LapDock with HDMI, DVI, HID, USB
> and WLAN using v3.10-rc1 and the patches in this series plus some
> extra patches that are driver related.
>=20
> Of course some things will need more work, like PM. But that
> has not yet been fully working for omap4 anyways, and that
> work can now be combined with omap5 PM work to some extent.

You can also add the one below to this series.

 Tomi


=46rom d22837262b59ad381feb215496fafe3fe399972f Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 7 Jun 2013 13:01:05 +0300
Subject: [PATCH] ARM: OMAP2+: Remove legacy DSS initialization for omap4

This is no longer needed as omap4 is now booted using device tree.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c | 47 ----------------------------------=
------
 arch/arm/mach-omap2/dss-common.h |  2 --
 2 files changed, 49 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-c=
ommon.c
index 393aeef..43ec787 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -80,24 +80,6 @@ static struct omap_dss_board_info omap4_panda_dss_data=
 =3D {
 	.default_device	=3D &omap4_panda_dvi_device,
 };
=20
-void __init omap4_panda_display_init(void)
-{
-	omap_display_init(&omap4_panda_dss_data);
-
-	/*
-	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
-	 * later have external pull up on the HDMI I2C lines
-	 */
-	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
-		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
-	else
-		omap_hdmi_init(0);
-
-	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
-}
-
 void __init omap4_panda_display_init_of(void)
 {
 	omap_display_init(&omap4_panda_dss_data);
@@ -204,35 +186,6 @@ static struct omap_dss_board_info sdp4430_dss_data =3D=
 {
  * used by picodlp on the 4430sdp platform. Keep this gpio disabled as L=
CD2 is
  * selected by default
  */
-void __init omap_4430sdp_display_init(void)
-{
-	int r;
-
-	r =3D gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
-			"display_sel");
-	if (r)
-		pr_err("%s: Could not get display_sel GPIO\n", __func__);
-
-	r =3D gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
-		"DLP POWER ON");
-	if (r)
-		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
-
-	omap_display_init(&sdp4430_dss_data);
-	/*
-	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
-	 * later have external pull up on the HDMI I2C lines
-	 */
-	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
-		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
-	else
-		omap_hdmi_init(0);
-
-	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
-}
-
 void __init omap_4430sdp_display_init_of(void)
 {
 	int r;
diff --git a/arch/arm/mach-omap2/dss-common.h b/arch/arm/mach-omap2/dss-c=
ommon.h
index 915f6ff..c28fe3c 100644
--- a/arch/arm/mach-omap2/dss-common.h
+++ b/arch/arm/mach-omap2/dss-common.h
@@ -6,9 +6,7 @@
  * This file will be removed when DSS supports DT.
  */
=20
-void __init omap4_panda_display_init(void);
 void __init omap4_panda_display_init_of(void);
-void __init omap_4430sdp_display_init(void);
 void __init omap_4430sdp_display_init_of(void);
=20
 #endif
--=20
1.8.1.2




------enig2OJPVKTFALOJXUUPNQPLD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRsbB4AAoJEPo9qoy8lh7138IP+wWt3GEwUWWGoSJunmgQW6en
M2nmgNuXw3wk+x67vadd6t6j6QKNL0f5GWShQAQQTKDeWJEJTvhFBNlTmXdvVosB
Qz7EBM5eE7ORBac+9rJoMRYmMnvgck4xXFMLyGKn6/WusRGuBz091wB5awh4EkGy
47cI84O2P2n+3QI95LbmGfilFklB9FgdynxLcQxmPUIxm3LjJIItv3mte58iCiEW
+gWrkT+3c3fhFoxTDwZpSgrUVexIVGWjQJal/CyHeaqfRNMdT2RSDAciHO0bQkhh
mw2QuKUUPyV8lSB7C7vpwGWSYI1ReZf5Xcq9YLk+z0oY2r1+XjhtUJwUKks5Zeza
bHjdy2qaGRuwWK7xcZ15VZE1kM9ekdTiqVhzF7CuT6JNC6ghxnN+mwRrQNFDbmQ9
w3dYL2tkH4ObGynBf+IfO63lkdc/SXZa4g+rsIYPGqVJvd1nWeqWWZaIioAxRP54
3Frh97dTVUZ/r1HbK9UC6JkejCSfUe5kcErbuvjIjojADryCJpNjskERSzv/d65w
zF6kK3C6U9X4dplO25Yt32/8Ii11jve6UezzgABItVK6QbPtKIMbi82ivhmO3DYu
6CwQqYTUk/v9o1gBMdWMP/NLtD8IfF4cYlFbY6YHwJ3fVILOzqO3emmEGSJnUj+6
gEPmqggbn6y5ds3PctqU
=AKzC
-----END PGP SIGNATURE-----

------enig2OJPVKTFALOJXUUPNQPLD--
