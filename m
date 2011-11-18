From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Fri, 18 Nov 2011 09:30:45 +0200
Message-ID: <1321601445.1814.24.camel@deskari>
References: <1321365035-9224-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-p+WM0MsP08B4RJiaum5X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34391 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756326Ab1KRHax (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 02:30:53 -0500
Received: by bkbzs8 with SMTP id zs8so4178562bkb.13
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 23:30:50 -0800 (PST)
In-Reply-To: <1321365035-9224-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>


--=-p+WM0MsP08B4RJiaum5X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-11-15 at 19:20 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Disables the internal pull resistor for SDA and SCL which are enabled by
> default, as there are expernal pull up's in 4460 and 4430 ES2.3
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
> index c3bd640..d0a82f9 100644
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
> +	 * OMAP4460 and OMAP4430 ES2.3 SDP, Blaze and Panda as the
> +	 * external pull up are present. This is needed to avoid
> +	 * EDID read failure.
> +	 */

I don't think this comment makes sense here. The register and bit
details are not seen here, they are handled in the display.c.

Also, the comment is still speaking of OMAP versions. This is about
board revisions. And this is SDP board file, no need to talk about
Panda.

So the text should be something like "44xxSDP rev XYZ and later have
external HDMI I2C line pull up. We detect the board revision with the
OMAP revision."

> +	if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2))

If you compare omap_rev() you should also use cpu_is_omap at the same
time. In this case (cpu_is_omap443x() && omap_rev() >
OMAP4430_REV_ES2_2). Otherwise the omap_rev check could match, say,
omap3 or omap5 boards.

> +		omap_hdmi_init(OMAP_HDMI_EXTERNAL_PULLUP);
> +	else
> +		omap_hdmi_init(0);
>  }
> =20
>  #ifdef CONFIG_OMAP_MUX
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2=
/board-omap4panda.c
> index d95df2e..44ff8e0 100644
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
> +	 * OMAP4460 and OMAP4430 ES2.3 SDP, Blaze and Panda as the
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

Indent is wrong here, and the parenthesis are extra.

 Tomi


--=-p+WM0MsP08B4RJiaum5X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOxgmlAAoJEPo9qoy8lh71G8oP/3vcvc/fbOh4EIFT4xSdOza0
FCkiXMNb5WkNM+FsysTnJX1PCPuSJHziU9gKKgMh20bYq+wxraEcquqoa42ulSj2
x5tSWXdduIkVfpD+PyMtmv46oiaNQBoM+fOpGFxzCCzndVq1jX9PcefKeJ+iTSBn
EokNUmOm0sfDck9heH9+QPq252kmPmUBb0/lGexa51kMfi02Xy+EJ5YzAnu5My/q
1H/oS3eyn5NhzGppgLUwxdjjDccJVW45oR2KcSU+8EisYpz3P9j63JVoxN0QF/Hy
DysUpH8Jtjyv5aqzKFot8d3ZnzTAI9zRzz4QeegaDvsfOw4DeV46aWYPubOkGdEm
DehhfHDCsgDnvPPjHLQ14JGdGA+ZoEg6s8xawGraaY8iYO5icnH/gJNUwZCt7W3V
f136/11pEPwYTegLUZEug9a7CLMzUp4A8vn88f4+8fdqJCkSwm6+dVuhG91fmz8F
abOojaQaXwm8XYXyBfqrrIq5KlTCbpuM8uCjdxkgiz97gLUMdr8PkvYWsaDO5JcK
MKxLyEUnFJkwnexPNjiS/Z0hfukayyE/6ZypR2Bu5gtAqsJLRx1US52oY3VuS8yI
puJPivK4BAkXS7hi0kQ+QFbQchJUCcIIrHn+JHiMCUGnt44fYyP8AU6k8ScCZazt
B42yqdb7uHNSAx6ns3tA
=OlBI
-----END PGP SIGNATURE-----

--=-p+WM0MsP08B4RJiaum5X--

