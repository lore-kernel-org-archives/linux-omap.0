From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Fri, 29 Jul 2011 17:05:16 +0300
Message-ID: <20110729140515.GV31013@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-4-git-send-email-khilman@ti.com>
 <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
 <20110728055346.GA11921@foobar>
 <4E315C9F.1030801@ti.com>
 <CAOMWX4fYGD4aRomoHZjvy_F9CRb_U9UV4OOa0BgrzZhx81iQtQ@mail.gmail.com>
 <20110729134932.GA2258@foobar>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6h64vBu9tReNbGLX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:34667 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940Ab1G2OFU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 10:05:20 -0400
Received: by mail-yx0-f172.google.com with SMTP id 4so2270025yxp.3
        for <linux-omap@vger.kernel.org>; Fri, 29 Jul 2011 07:05:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110729134932.GA2258@foobar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--6h64vBu9tReNbGLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Fri, Jul 29, 2011 at 08:49:34AM -0500, Nishanth Menon wrote:
> From f03490456e24f72ca5272303c95a6f0b212494d5 Mon Sep 17 00:00:00 2001
> From: Nishanth Menon <nm@ti.com>
> Date: Wed, 27 Jul 2011 15:02:32 -0500
> Subject: [PATCH 1/2] OMAP: PM: omap_device: add omap_hwmod_name_get_odev
>=20
> An API which translates a standard hwmod name to corresponding
> omap_device is useful for drivers when they need to look up the
> device associated with a hwmod name to map back into the device
> structure pointers. These ideally should be used by drivers in
> mach directory. Using a generic hwmod name like "gpu" instead of
> the actual device name which could change in the future, allows
> us to:
> a) Could in effect help replace apis such as omap2_get_mpuss_device,
> omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device,
> etc..
> b) Scale to more devices rather than be restricted to named functions
> c) Simplify driver's platform_data from passing additional fields
> all doing the same thing with different function pointer names
> just for accessing a different device name.
>=20
> Change-Id: Ib42d22b4a929982c87a79866e3d7dc6e41073a6c
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>  arch/arm/plat-omap/omap_device.c              |   32 +++++++++++++++++++=
++++++
>  2 files changed, 33 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/pla=
t-omap/include/plat/omap_device.h
> index 70d31d0..7a3c046 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -102,6 +102,7 @@ int omap_device_register(struct omap_device *od);
>  int omap_early_device_register(struct omap_device *od);
> =20
>  void __iomem *omap_device_get_rt_va(struct omap_device *od);
> +struct omap_device *omap_hwmod_name_get_odev(const char *oh_name);
> =20
>  /* OMAP PM interface */
>  int omap_device_align_pm_lat(struct platform_device *pdev,
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_d=
evice.c
> index 92b4496..21df532 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -780,6 +780,38 @@ void __iomem *omap_device_get_rt_va(struct omap_devi=
ce *od)
>  	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
>  }
> =20
> +/**
> + * omap_hwmod_name_get_odev() - convert a hwmod name to omap_device poin=
ter
> + * @oh_name: name of the hwmod device
> + *
> + * returns back a struct omap_device * pointer associated with a hwmod
> + * device represented by a hwmod_name
> + */
> +struct omap_device *omap_hwmod_name_get_odev(const char *oh_name)
> +{
> +	struct omap_hwmod *oh;
> +
> +	if (!oh_name) {
> +		WARN(1, "%s: no hwmod name!\n", __func__);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	oh =3D omap_hwmod_lookup(oh_name);
> +	if (IS_ERR_OR_NULL(oh)) {
> +		WARN(1, "%s: no hwmod for %s\n", __func__,
> +			oh_name);
> +		return ERR_PTR(oh ? PTR_ERR(oh) : -ENODEV);
> +	}
> +	if (IS_ERR_OR_NULL(oh->od)) {
> +		WARN(1, "%s: no omap_device for %s\n", __func__,
> +			oh_name);
> +		return ERR_PTR(oh->od ? PTR_ERR(oh->od) : -ENODEV);
> +	}
> +
> +	return oh->od;
> +}
> +EXPORT_SYMBOL(omap_hwmod_name_get_odev);

maybe EXPORT_SYMBOL_GPL() ?? Not sure we want non-GPL code to access
this ;-)

--=20
balbi

--6h64vBu9tReNbGLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMr4bAAoJEAv8Txj19kN1p8AH/jlcYcFqhvfPXmD58QEET2H0
/hSgCuWgy3u1TCmasq80nT41hL2+DP8hRiOXAaOzSjotiCoH1Q4WihKRtiVpm/L/
nzF4L6BE074xZpfU1+uo9K6ddAXjJTl2iu4kVehyrLTBQ5b+pSSWQf9G245PLi4H
7SuxpH7AwUVLYdzuXVq+5f5t7XjS1OZQysQEJSW2s7YIw6shwtOp8e6+MJq7GiT+
SJobt/OZbzjFsYVl5xd92NjWPijZ9CqVLbBLR0RQMY9rCHSpBjue7h8kGPl+CRFK
Ou8CXdB1RqVbBA6QeOL4V6TVALCk1nUjQphc1e3GUzY3w/HSKToFSqE60vXnOSQ=
=tDpZ
-----END PGP SIGNATURE-----

--6h64vBu9tReNbGLX--
