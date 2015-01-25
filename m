From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Sun, 25 Jan 2015 16:18:49 +0100
Message-ID: <20150125151848.GF2719@earth.universe>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <20150113204219.GJ2419@atomide.com>
 <20150115142536.GC512@earth.universe>
 <201501241300.00723@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44995 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbbAYPSz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 25 Jan 2015 10:18:55 -0500
Content-Disposition: inline
In-Reply-To: <201501241300.00723@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2015 at 01:00:00PM +0100, Pali Roh=E1r wrote:
> Another regression for DT setup (which does not occur for board code):
>=20
> omap_hsmmc driver does not export slot_name sysfs entry because
> it not supported by DT yet. Entry slot_name is used by userspace
> application to determinate if mmc block device is internal eMMC
> memory or external uSD card. So support for this property also in
> DT is needed.
>=20
> Here is simple patch which fix this problem:
>=20
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n=
900.dts
> index 8571027..31ca609 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -665,6 +665,7 @@
>  };
> =20
>  &mmc1 {
> +	slot-name =3D "external";
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&mmc1_pins>;
>  	vmmc-supply =3D <&vmmc1>;
> @@ -674,6 +675,7 @@
> =20
>  /* most boards use vaux3, only some old versions use vmmc2 instead */
>  &mmc2 {
> +	slot-name =3D "internal";
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&mmc2_pins>;
>  	vmmc-supply =3D <&vaux3>;
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 7c71dcd..cd189eb 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2021,6 +2021,8 @@ static struct omap_hsmmc_platform_data *of_get_hsmm=
c_pdata(struct device *dev)
>  	if (of_find_property(np, "enable-sdio-wakeup", NULL))
>  		pdata->pm_caps |=3D MMC_PM_WAKE_SDIO_IRQ;
> =20
> +	of_property_read_string(np, "slot-name", &pdata->name);
> +
>  	return pdata;
>  }
>  #else

I suggest to use "label" as DT property name, which is also used for
labeling GPIOs, LEDs, partitions, ... in DT.

-- Sebastian

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUxQlWAAoJENju1/PIO/qa7JEP/AonzeaZUF04FS6O7iNzFN4S
KsrpW/9O5B8+q2LqZKxM8PcAzrSqHtijWG4UsFW1vDG7NqJK+MPVwwviHJTaL8el
z3oId4An3C5Wmj4O3ib6r8F8qShnMqX/1fh+EzziakO0GNhGepLpAUHUbFywvL4J
+6GaDSHN77WVb9jceFfB3yL4oV4tD7zXKwLzLKmc8VkxPp+idR6ClEUpaNsd+0VH
i+Svnjz3VdWwsNPqEz1B9BAZgEEyTXRlJnqvK/7P8t9v2KrufIpiWjz0BYMyYF8U
RHii0iry0HUaNJfs0F4NiZ+aTSQuBCXU1xOdVFMZZEVa3QhMSYz46rMhHnf8XJhn
0/9tFfW2ha86zzaP/SP2CHawKBH19nkD9xnmgNNiDIan7yu6Mdcxe3MDx36snIxz
uwAl3f6eJhoTSCqtJZAP99SvJFk0O7btIR9GQV4+6Pcpd2WupNR2Qatg60TWmoPx
NwpyWua9OSh9/pMV/eMssz12a28dK0M5WubTcX/sabmL0OtTCzuaHWYm8g1em47B
Ym0T9QjMuHJ4VO9QyJsBHKbU51cPCa27OLX9nhikJd7/K7Jw9sA6j0p9dMAYtoC7
3xkWGcRLOEf9i6UblPJVyJgp4pDsEIWONA3qXnm7Xat6+48CdP0L+8yB60bpQLCp
M6XBS/qXpeEIC9z/oPhI
=h0TJ
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
