From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Tue, 13 Dec 2011 10:48:01 +0200
Message-ID: <1323766081.1877.21.camel@deskari>
References: <1323755818-17901-1-git-send-email-mythripk@ti.com>
	 <1323755818-17901-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-KIOAnZTUlSnu/mvVJHb8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59001 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751660Ab1LMIsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 03:48:08 -0500
Received: by mail-lpp01m010-f42.google.com with SMTP id j5so2324529lag.29
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 00:48:05 -0800 (PST)
In-Reply-To: <1323755818-17901-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>


--=-KIOAnZTUlSnu/mvVJHb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-12-13 at 11:26 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Disables the internal pull resistor for SDA and SCL which are enabled by
> default, as there are expernal pull up's in 4460 and 4430 ES2.3

Typo above with external.

> SDP, Blaze and Panda Boards, It is done to avoid the EDID read failure.
>=20
> Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c    |   13 ++++++++++++-
>  arch/arm/mach-omap2/board-omap4panda.c |   14 +++++++++++++-
>  arch/arm/mach-omap2/display.c          |   17 ++++++++++++++---
>  include/video/omapdss.h                |    4 +++-
>  4 files changed, 42 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/bo=
ard-4430sdp.c
> index c3bd640..1b7c5e5 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -826,7 +826,18 @@ static void omap_4430sdp_display_init(void)
>  	sdp4430_lcd_init();
>  	sdp4430_picodlp_init();
>  	omap_display_init(&sdp4430_dss_data);
> -	omap_hdmi_init();
> +	/*
> +	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
> +	 * HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
> +	 * internal pull up resistor - This is a change needed in
> +	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze Boards as the
> +	 * external pull up are present. This is needed to avoid
> +	 * EDID read failure.
> +	 */

The comment above about the control bits is not needed here. Those are
internal details. And the "EDID read failure" is only needed in the
commit message. What you should have here in the comment is something
like:

"OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and later have
external pull up on the HDMI I2C lines."

> +	if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2))

Parenthesis around omap_rev are extra.

> +		omap_hdmi_init(OMAP_HDMI_EXTERNAL_PULLUP);

Should the define name be a bit more specific? The pull-up is about the
I2C SDA and SCL lines, right?

And while I would presume that normally the SDA and SCL both either have
external or internal pull-up, I don't see it as impossible that somebody
would need different configuration for the lines. So optimally we'd have
separate bits for those two. However, to keep the API simpler I think
it's fine to have only one bit for now.

> +	else
> +		omap_hdmi_init(0);
>  }
> =20
>  #ifdef CONFIG_OMAP_MUX
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2=
/board-omap4panda.c
> index d95df2e..212e06c 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -541,7 +541,19 @@ void omap4_panda_display_init(void)
>  		pr_err("error initializing panda DVI\n");
> =20
>  	omap_display_init(&omap4_panda_dss_data);
> -	omap_hdmi_init();
> +
> +	/*
> +	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
> +	 * HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
> +	 * internal pull up resistor - This is a change needed in
> +	 * OMAP4460 Panda and OMAP4430 ES2.3 Panda Boards as the
> +	 * external pull up are present. This is needed to avoid
> +	 * EDID read failure.
> +	 */
> +	if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2))
> +		omap_hdmi_init(OMAP_HDMI_EXTERNAL_PULLUP);
> +	else
> +		omap_hdmi_init(0);
>  }
> =20
>  static void __init omap4_panda_init(void)
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.=
c
> index 8436088..a75e179 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -97,8 +97,11 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmo=
d_data[] __initdata =3D {
>  	{ "dss_hdmi", "omapdss_hdmi", -1 },
>  };
> =20
> -static void omap4_hdmi_mux_pads()
> +static void omap4_hdmi_mux_pads(int flags)
>  {
> +	u32 reg;
> +	u16 control_i2c_1;
> +
>  	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
>  	omap_mux_init_signal("hdmi_hpd",
>  			OMAP_PIN_INPUT_PULLUP);
> @@ -109,6 +112,14 @@ static void omap4_hdmi_mux_pads()
>  			OMAP_PIN_INPUT_PULLUP);
>  	omap_mux_init_signal("hdmi_ddc_sda",
>  			OMAP_PIN_INPUT_PULLUP);
> +
> +	if (flags & OMAP_HDMI_EXTERNAL_PULLUP) {
> +		control_i2c_1 =3D OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_1;
> +		reg =3D omap4_ctrl_pad_readl(control_i2c_1);
> +		reg |=3D (OMAP4_HDMI_DDC_SDA_PULLUPRESX_MASK |
> +		OMAP4_HDMI_DDC_SCL_PULLUPRESX_MASK);

Indentation missing.

> +		omap4_ctrl_pad_writel(reg, control_i2c_1);
> +	}
>  }
> =20
>  static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
> @@ -144,10 +155,10 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned =
lanes)
>  	return 0;
>  }
> =20
> -int omap_hdmi_init(void)
> +int omap_hdmi_init(int flags)
>  {
>  	if (cpu_is_omap44xx())
> -		omap4_hdmi_mux_pads();
> +		omap4_hdmi_mux_pads(flags);
> =20
>  	return 0;
>  }
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index 0cb0469..df585b5 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -49,6 +49,8 @@
>  #define DISPC_IRQ_FRAMEDONETV		(1 << 24)
>  #define DISPC_IRQ_WBBUFFEROVERFLOW	(1 << 25)
> =20
> +#define OMAP_HDMI_EXTERNAL_PULLUP	0x1

An enum would be nicer, so that it's clearer where this can be used. And
as the flags is a bit field, you could define the value as (1 << 0) as
the custom is elsewhere in the file.

>  struct omap_dss_device;
>  struct omap_overlay_manager;
> =20
> @@ -310,7 +312,7 @@ struct omap_dss_board_info {
>  /* Init with the board info */
>  extern int omap_display_init(struct omap_dss_board_info *board_data);
>  /* HDMI mux init*/
> -extern int  omap_hdmi_init(void);
> +extern int  omap_hdmi_init(int flags);

Extra space between int and the function name. (in the previous patch
also).

 Tomi


--=-KIOAnZTUlSnu/mvVJHb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO5xE9AAoJEPo9qoy8lh71lkQP/2k7vnf+PPEdX7PBNYJC1mhZ
mDspRF7LyPHQdCavtNQz/eqFAB8DlyJSdvfrAoQjbfEq2W9ryziSbyyrPt1oSREx
dhHWiAsxiDvM4nWipufdmf86AiX6wPNvqoCxxJq4kJKEkbFMvo2nOAWyJwY+m87M
VbhR0B9JErvFaAevlssCTrj9r11C7UpBhjW2BrI1UEZV2dC1SdrYCWcm7drrX7Dj
9L2LEG+zJ/Bj84nt0WpxA/JOj6WRuBqJrrGgLsBn7iAFYYaAtokQ5nezcCJn6XP8
+x/1zjTZi8a9eyC9L45za1SNGfp8Q1+0itBZLk1c07gECTZyIDc8T8PIwOnIfnmZ
3u4nbLSF8LESYJxCQjzW5zZjMv8XpxjdXSyDWv1IWEqKNYc7EkyQnAfCMwC+fV9o
Yx6dD7IUc5pz6OyV55fOjQ3FnISJBWq0pq2eOOxI0ebotOQPnDCrAu7pEn1D+yB2
/CE8Jg5tFb0SKt56MfMmk/gJ31dYJlh8n7zd/tlZSgFAPLYyb4fSWb92wyNffVWI
YVJGRYIegpJrMJTDqDKx0yqrrTZi+AQqPWSNMOEkRtSlW+gICkkcztbG8kVudXZ1
kL8/UsNnyIBQCjy8it72APbzF1KRU8eFINsjr6VB8lXeUSOmbEUY0VwPIxnJ501q
Izj2cBVgSMe5J+D0tw+1
=HNEA
-----END PGP SIGNATURE-----

--=-KIOAnZTUlSnu/mvVJHb8--

