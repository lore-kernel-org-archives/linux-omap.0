From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Initialising omapfb on AM3517 issues
Date: Wed, 19 Sep 2012 10:23:41 +0300
Message-ID: <1348039421.2565.6.camel@deskari>
References: <F690310232FDDF4AB457E8B3EF90DDE05D7B4BDE@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-XGQioWi2g3Q8ZKfveYQt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:35614 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754624Ab2ISHXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 03:23:51 -0400
Received: by lbbgj3 with SMTP id gj3so587021lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 00:23:48 -0700 (PDT)
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE05D7B4BDE@MARCM-SBS2011.marcmltd.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Murphy <marcmltd@marcm.co.uk>
Cc: "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>


--=-XGQioWi2g3Q8ZKfveYQt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2012-09-18 at 16:41 +0000, Marc Murphy wrote:
> Hello all,
> I have been moving from the ti 2.6.37 BSP to the 3.x kernel with quite a =
bit of success, the main issue I have at the moment is trying to get the fr=
ame buffer and any displays I have initialised.
>=20
> [    2.805358] omapfb omapfb: no driver for display: lcd
> [    2.810729] omapfb omapfb: no displays
> [    2.814666] omapfb omapfb: failed to setup omapfb
>=20
> I have tried a few versions of release and none of them will initialise;
>=20
> Currently on
> [    0.000000] Linux version 3.6.0-rc3
>=20
> I have started with board-am3517evm display config and even that doesn't =
initialise.  Is there something I am missing with the configs or is there a=
 patch required to get the feature to work.
>=20
> My current config options use;
> #
> # Graphics support
> #
> CONFIG_DRM=3Dy

omapdrm and omapfb cannot be used at the same time. That said, you don't
seem to enable omapdrm, only the core drm support, so it shouldn't
matter. But you don't need CONFIG_DRM if you use omapfb.

> CONFIG_FB=3Dy
> CONFIG_FB_CFB_FILLRECT=3Dy
> CONFIG_FB_CFB_COPYAREA=3Dy
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
>=20
> #
> # Frame buffer hardware drivers
> #
> CONFIG_OMAP2_VRAM=3Dy
> CONFIG_OMAP2_VRFB=3Dy
> CONFIG_OMAP2_DSS=3Dy
> CONFIG_OMAP2_VRAM_SIZE=3D12
> CONFIG_OMAP2_DSS_DPI=3Dy
> CONFIG_OMAP2_DSS_VENC=3Dy
> CONFIG_OMAP2_DSS_DSI=3Dy
> CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=3D1
> CONFIG_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=3Dy
> CONFIG_FB_OMAP2=3Dy
> CONFIG_FB_OMAP2_NUM_FBS=3D3
>=20
> #
> # OMAP2/3 Display Device Drivers
> #
> CONFIG_PANEL_GENERIC_DPI=3Dy
> CONFIG_PANEL_SHARP_LS037V7DW01=3Dy
> CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> CONFIG_LCD_CLASS_DEVICE=3Dy
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> CONFIG_BACKLIGHT_GENERIC=3Dy
>=20
> And the init structs are
> static int am3517_evm_panel_enable_lcd(struct omap_dss_device *dssdev)
> {
>     gpio_set_value(TAM3517_DVI_PON_GPIO, 0);
>     gpio_set_value(TAM3517_LCD_ENVDD_GPIO, 0);
>     gpio_set_value(TAM3517_LCD_PON_GPIO, 1);
>         printk("LCD voltage on\n");
> 	return 0;
> }
>=20
> static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
> {
>     gpio_set_value(TAM3517_LCD_ENVDD_GPIO, 1);
>     gpio_set_value(TAM3517_LCD_PON_GPIO, 0);
> }
>=20
> static struct panel_generic_dpi_data lcd_panel =3D {
> //    .name			=3D "generic_dpi_panel",

You need to define name for the panel you have. You can see the list of
supported panels in drivers/video/omap2/displays/panel-generic-dpi.c. If
you don't give a name, the panel driver doesn't start.

There's also a problem with the vdds_dsi regulator. Search the list for
"[PATCH] OMAPDSS: Do not require a VDDS_DSI regulator on am35xx". The
patch to fix it hasn't been merged yet.

 Tomi


--=-XGQioWi2g3Q8ZKfveYQt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQWXL9AAoJEPo9qoy8lh71tbMP/3HOwbpQ4Rrhu+Fa07l2MVv3
T8tTvoB4e79i/ooM77f1+7VjlZAKISZJ64Xdxy1NhMNXtCsQ+65cyHCAoWScx4Tu
65OlwihGAMI1Ea8TJybzXGVOjbYCwm5XYYq2hOFBZgioywbtGyN5TpsKJfpLzvGk
vfMDm3mVhyp0F5NvQcygqTRCEB97DkJWpu366in12LtHc7lqNi90bDp/jtv4AByP
Yq20/jXL89UnmZaV2BGoKUSPMRHMZDXVKDChSnwIbx5K48XzseGkhX4LIWctWBtN
xBkqaWwynAZDe/19mv+rq6k4baBUtHVAukjXgFwihT7hkNBHjnGqrwy9pHv3tDRv
Dfxjy5qinzUm8npddErxwf+wehsvQAZQotgYzA7xQQEgkKkrSFmXpmuQSx43u/Nk
n+8DJsh9RAUFf6cU9pmoBxIe/aufdTnRR3dYRfFBmWCAljt8mnqL4M1gjC8FPX+3
Td/7x12GUhnZwVafqEPsbRmGaH2V1EMP8PZxuD95PIkmnlKnjtzwYLP4nknnF8qd
d7OsvKumbbrOe/qA+G52IvfyjYsnR9H2fEIEmWP6m9/JCANMtePuJQ9SJ7nD/umK
AylBxxnZcdUgy+ZzXXxiqXCauTtroWtbyYm1VdW/BWlGfST3zhCZse9TTfgQvwlX
AAzxk1r4ndr9/uEh+WD9
=nWuL
-----END PGP SIGNATURE-----

--=-XGQioWi2g3Q8ZKfveYQt--

