From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 1/3] OMAPDSS: HDMI: HPD support in boardfile
Date: Tue, 10 Jan 2012 09:37:25 +0200
Message-ID: <1326181045.1939.38.camel@deskari>
References: <1325853877-6712-1-git-send-email-mythripk@ti.com>
	 <1325853877-6712-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-z5V21Vhv0PgeEPmG3a5S"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59002 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751198Ab2AJHhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 02:37:31 -0500
Received: by lagw12 with SMTP id w12so2182188lag.2
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 23:37:29 -0800 (PST)
In-Reply-To: <1325853877-6712-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-z5V21Vhv0PgeEPmG3a5S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-06 at 18:14 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Add support for HPD GPIO configuration in board file.
> Also remove the enabling  of GPIO's required for HDMI from
> hdmi driver file to display.c based on the GPIO #'s sent from
> board file.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---

You are doing too much in this patch. This changes the HPD gpio to
CT_CP_HPD, changes how gpios are allocated, moves gpio allocation into
another file, changes the pulls of the gpios, introduces a new field
into dss device...

You should do just one logical thing in a patch.

> -static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
> +static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags, int hpd_gpio=
)
>  {
>  	u32 reg;
>  	u16 control_i2c_1;
> =20
>  	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
>  	omap_mux_init_signal("hdmi_hpd",
> -			OMAP_PIN_INPUT_PULLUP);
> +			OMAP_PIN_INPUT_PULLDOWN);

Is the "hdmi_hpd" always the same pin? If so, it can be handled in
display.c, no need to handle it in the board files.

>  	omap_mux_init_signal("hdmi_cec",
>  			OMAP_PIN_INPUT_PULLUP);
>  	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
> @@ -112,6 +113,10 @@ static void omap4_hdmi_mux_pads(enum omap_hdmi_flags=
 flags)
>  			OMAP_PIN_INPUT_PULLUP);
>  	omap_mux_init_signal("hdmi_ddc_sda",
>  			OMAP_PIN_INPUT_PULLUP);
> +	omap_mux_init_signal("gpmc_wait2.gpio_100",
> +			OMAP_PIN_INPUT_PULLDOWN);

Hmm, what is "gpmc_wait2.gpio_100"?

> +	/* HPD GPIO needs to be muxed*/
> +	omap_mux_init_gpio(hpd_gpio, OMAP_PIN_INPUT | OMAP_PULL_ENA);

Isn't this the same as the "hdmi_hpd" case above? Why are both needed?

>  	/*
>  	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
> @@ -160,10 +165,18 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned =
lanes)
>  	return 0;
>  }
> =20
> -int omap_hdmi_init(enum omap_hdmi_flags flags)
> +int omap_hdmi_init(enum omap_hdmi_flags flags, int hpd_gpio,
> +		struct gpio hdmi_gpios[], int size)
>  {
> +	int status;
> +
> +	status =3D gpio_request_array(hdmi_gpios, size);
> +	if (status) {
> +		pr_err("%s: Cannot request HDMI GPIOs\n", __func__);
> +		return status;
> +	}

I don't see much point in this. The GPIOs are still declared in the
board files, and this function doesn't use the GPIOs for anything. It's
better to request them in the board file.

> @@ -319,7 +320,8 @@ struct omap_dss_board_info {
>  /* Init with the board info */
>  extern int omap_display_init(struct omap_dss_board_info *board_data);
>  /* HDMI mux init*/
> -extern int omap_hdmi_init(enum omap_hdmi_flags flags);
> +extern int omap_hdmi_init(enum omap_hdmi_flags flags, int hpd_gpio,
> +			struct gpio hdmi_gpios[], int size);
> =20
>  struct omap_display_platform_data {
>  	struct omap_dss_board_info *board_data;
> @@ -568,6 +570,8 @@ struct omap_dss_device {
> =20
>  	int reset_gpio;
> =20
> +	int hpd_gpio;

The hpd_gpio is for the hdmi device, not for all dss devices. So it
shouldn't be in the omap_dss_device. Did you check the example patch I
made to fix the phy issue?

I still think we should try to fix the bug at hand, not try to implement
proper HPD support. Was there something wrong with the example patch I
gave? (other than it needs some splitting up).

 Tomi


--=-z5V21Vhv0PgeEPmG3a5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPC+q1AAoJEPo9qoy8lh71UMEP/0r26mh6vxcj2QMLATj/d8MB
0FpDxjcnqy4pN/vxB/iHSya0YWsBQd/RZCbRIVOxl5l4SmqRX5apV+ggQ0k1wQj5
r0/pf7aZoYck3D+mg9hm+omkXPWDGHObVYyonuveQk2SoVhyaHStfSCER9ZtA5hI
wZSQlNKjkIsDN6YInBRLjzYFf5N4SS31xFopXSawXjTVUCJz7XbfDuL72+1aiOxW
dTR8B45x1aw2+YGG0H65dCmMrYBZ+dIztQyHGOXdpEWTB7wFQv17K0551NaRqD3j
iP9UM3c0/F6UlE/BAF0XSlH2ln5HZvf+ATtVuukNk+e2GKziU/DwHCdk9+O+Rap4
TQCAzjhvBTXihErpRAVRmbJEnLXSxuiUY1IXfR9rdVhorDFMeu6nMKRWoYpk33/i
N47gB6v6s5rM80aL9G0TbN/2Qw1Sj2P4h5B8lHYBTFy1nI89D3GO4GORcNNxhOgR
6HkF7wMLeW1EhCvU4pVFnyMPsc0c1WblD3VUCUtRsFLFBbYixZV1EH0WsqaIOjbL
bYZ4sZng2s7mKCO43mZxS/SpNa01Q9Y+UqGv3DUWyBE73aAljO9PD4+6f4SWg6gK
Mn8vsu8tdf2TU+dVqCdnrqYQbxc09Olt8be37GsSZDZQCeTkaPrf1kaH4bJX//OQ
9QLiUkoz9IJofJ8krpug
=R2TX
-----END PGP SIGNATURE-----

--=-z5V21Vhv0PgeEPmG3a5S--

