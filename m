From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3] OMAP: DSS2: Support for UMSH-8173MD TFT panel
Date: Tue, 03 Jan 2012 11:21:55 +0200
Message-ID: <1325582515.1973.8.camel@deskari>
References: <1324370436.2042.4.camel@deskari>
	 <1324374872-5132-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-99B+Trxf2HvzDPiiYXHb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:53266 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751185Ab2ACJWC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 04:22:02 -0500
Received: by lahd3 with SMTP id d3so3636562lah.19
        for <linux-omap@vger.kernel.org>; Tue, 03 Jan 2012 01:21:59 -0800 (PST)
In-Reply-To: <1324374872-5132-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-omap@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>


--=-99B+Trxf2HvzDPiiYXHb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-12-20 at 10:54 +0100, Daniel Mack wrote:
> This patch adds support for Microtip Technologies' UMSH-8173MD 800x480
> RGB TFT panel. Tested with an OMAP3 board.
>=20
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++=
++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/v=
ideo/omap2/displays/panel-generic-dpi.c
> index 519c47d..cbcf164 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -297,6 +297,31 @@ static struct panel_config generic_dpi_panels[] =3D =
{
> =20
>  		.name			=3D "apollon",
>  	},
> +
> +	/* Microtips Technologies - UMSH-8173MD */
> +	{
> +		{
> +			.x_res		=3D 800,
> +			.y_res		=3D 480,
> +
> +			.pixel_clock	=3D 34560,
> +
> +			.hsw		=3D 13,
> +			.hfp		=3D 101,
> +			.hbp		=3D 101,
> +
> +			.vsw		=3D 23,
> +			.vfp		=3D 1,
> +			.vbp		=3D 1,
> +		},
> +		.acbi			=3D 0x0,
> +		.acb			=3D 0x0,
> +		.config			=3D OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
> +		.power_on_delay		=3D 0,
> +		.power_off_delay	=3D 0,
> +		.name			=3D "UMSH-8173MD",

Looks fine, except the panel name is not in line with the other panel
names. I suggest "microtips_umsh_8173md". I can apply the patch and
make the change if you are ok with the name.

 Tomi


--=-99B+Trxf2HvzDPiiYXHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPAsizAAoJEPo9qoy8lh71AhYQAK8ShujQ0Pg562JdvmHe1ChD
UVfUhP0hjhhkSwXcR7k1CdXqIme+rp2yoDGrw0k98WVVxhln2bY77Gwu31tvzQ6r
kOpybU0opo291f89Py2HL2l9njUdz/RvIAucL2tZMIsKFjaz7wWAvT0Wy+1RiNWB
qmutQzKtbNR5QLC23UnOEK0TGZZaOu3G652LnY1m0mNI13HxLWmB1P9CapUGjs6j
tYjLZ2M46UjJQEqfLpXtEJXlZ4TW9wB/vgpRXMAzX11TxSZN75/wMelr2qftRItV
upzQZzozU524HH2RZKzz4yjTwGIwjagSHUeOfCHoK18GAZLPDKxZYPLVxnAwEhZB
Ep+pH9wqPJ2yLp+RPHD5blSsPEHPM4SA7zAQ12HGWLxmMYBE/IGwmQS008sjoAwz
m5d9W7OdFGas1eBjJXrfHOWdpR6/n/JKBn1FW2TM5lBtpMn94/JyH3tFNWSSP2TJ
69xKX8LeDtUY8XS0l8IymRv7dTjneGYzgZ52kB4SaiN5jviO6cVlRPruQLScXWLz
uS/qi0jjZoyT7K9djTFroEL/Izl7uej4GkL1HWoaiYn1LTm0Y6TCvOFvwcmISvhb
rmlfvnREHWGhtMmNar7oon+BmtKMjiIWt3mTnYeH2cSsiThDH6ad0+sjgEsD9yUr
XBKzLUFuiSaCRzVP46oZ
=aiWZ
-----END PGP SIGNATURE-----

--=-99B+Trxf2HvzDPiiYXHb--

