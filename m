From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/4] omap_dss: add FocalTech ETM070003DH6 display
 support
Date: Thu, 17 Nov 2011 12:26:15 +0200
Message-ID: <1321525575.1919.78.camel@deskari>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com>
	 <1320797568-11169-3-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QToDuH2tR7LrnVpW/j2J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59674 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756394Ab1KQK0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 05:26:21 -0500
Received: by faar15 with SMTP id r15so3538696faa.23
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 02:26:18 -0800 (PST)
In-Reply-To: <1320797568-11169-3-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com


--=-QToDuH2tR7LrnVpW/j2J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-11-09 at 01:12 +0100, Ilya Yanok wrote:
> Add data for the FocalTech ETM070003DH6 display to the generic_dpi_panel
> display driver.
>=20
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |   24 ++++++++++++++++=
++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/v=
ideo/omap2/displays/panel-generic-dpi.c
> index 519c47d..42bfe47 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -297,6 +297,30 @@ static struct panel_config generic_dpi_panels[] =3D =
{
> =20
>  		.name			=3D "apollon",
>  	},
> +	/* FocalTech ETM070003DH6 */
> +	{
> +		{
> +			.x_res		=3D 800,
> +			.y_res		=3D 480,
> +
> +			.pixel_clock	=3D 28000,
> +
> +			.hsw		=3D 48,
> +			.hfp		=3D 40,
> +			.hbp		=3D 40,
> +
> +			.vsw		=3D 3,
> +			.vfp		=3D 13,
> +			.vbp		=3D 29,
> +		},
> +		.acbi			=3D 0x0,
> +		.acb			=3D 0x28,

You could just remove .acbi and .acb, I don't think they are needed.

> +		.config			=3D OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					  OMAP_DSS_LCD_IHS,
> +		.power_on_delay		=3D 50,
> +		.power_off_delay	=3D 100,

Did you check from the panel spec if any delays are needed? These look
like just copied from the Sharp panel data.

 Tomi


--=-QToDuH2tR7LrnVpW/j2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOxOFHAAoJEPo9qoy8lh71/QsP/j1Px1Z8DnuMeJPQJKrM+qnZ
IJUdRrrzWmAy4jSY/DuDdbL2ZIEoRXu1yDeEnrArzg7M4//wFlemviRHyoJJg8An
MKgDlA+m8B1MV1DQ9KSi5IvT/9Ie4PYLi88pM+zxTAFbDRi83312NuVc5bSGZXQV
DdRFRwbOhv6TutCCdzhjs1ksaQp6kgjcBPGHJsZQDhgqUC/p9uy0UngXFrEthvt1
rIQ71w29V7GfT9pjNvnMHWUjJVyOK0j2TP+gAxDccXfgDSjn1Z/VxCiCZI/8olGJ
pU1EJNlQ84Lw1mizvOyZNSWqM4GFyqIxbryw1fGgRy/0PFpVmwAm3Rk11wYbTsuy
W82jqZpxOMwm1EkqbIGpoGpSw6iTnNO6hjBSwUW8TgXpbUBVP0hhoVFd2SREZE/A
egw97enBJAxOLuZyRe6HEIO0tJLOMTYJYtVAQDyVd9mB0ave3cBMH47oV+fQy08c
f2ZiOTQRgPm6hK9aPn1XqOTO/yxEbTNuoqZb6dqVz9YzUzsgqLtEMwqYzF1iZDRo
hejw0bjMCj87/8hz2ZQSpHBXD/Kpj6rUYsyE1QaPy5DNYA14dxYwr8b27wtox9WL
4HPi81Leg8w6/3MwYSr97e9YmGfw5iznoTQ97vHFfqQStbpfIHU+zaBXdtZE62by
056QNWBou42iFH6EFKnU
=dz99
-----END PGP SIGNATURE-----

--=-QToDuH2tR7LrnVpW/j2J--

