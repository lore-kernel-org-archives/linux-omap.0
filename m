From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] musb: musb: dsps: support multiple instances
Date: Tue, 18 Jun 2013 11:38:04 +0300
Message-ID: <20130618083804.GK5461@arwen.pp.htv.fi>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de>
 <1371482014-5244-2-git-send-email-bigeasy@linutronix.de>
 <20130618082725.GG5461@arwen.pp.htv.fi>
 <51C01BA1.6040009@linutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51C01BA1.6040009-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--2feizKym29CxAecD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2013 at 10:34:41AM +0200, Sebastian Andrzej Siewior wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> On 06/18/2013 10:27 AM, Felipe Balbi wrote:
> >> diff --git a/drivers/usb/musb/musb_dsps.c
> >> b/drivers/usb/musb/musb_dsps.c index e1b661d..d9ff390 100644 ---
> >> a/drivers/usb/musb/musb_dsps.c +++
> >> b/drivers/usb/musb/musb_dsps.c @@ -415,9 +415,14 @@ static int
> >> dsps_musb_init(struct musb *musb) /* mentor core register starts
> >> at offset of 0x400 from musb base */ musb->mregs +=3D
> >> wrp->musb_core_offset;
> >>=20
> >> -	/* NOP driver needs change if supporting dual instance */ -
> >> usb_nop_xceiv_register(); -	musb->xceiv =3D
> >> usb_get_phy(USB_PHY_TYPE_USB2); +	if (!glue->dev->of_node) { +
> >> /* This hack works only for a single instance. */ +
> >> usb_nop_xceiv_register(); +		musb->xceiv =3D
> >> usb_get_phy(USB_PHY_TYPE_USB2);
> >=20
> > I think you can drop this altogether, am335x is DT-only anyway :-)
>=20
> Yes, but this is also used by:
>=20
> $ git grep "musb-ti81xx"
> arch/arm/mach-omap2/usb-musb.c:         name =3D "musb-ti81xx";
> drivers/usb/musb/musb_dsps.c:           .name   =3D "musb-ti81xx",
>=20
> Is that one also am33xx?

my bad, it's not :-)

> >> +	} else { +		musb->xceiv =3D
> >> devm_usb_get_phy_by_phandle(glue->dev, "phys", +
> >> musb->config->instance); +	}
> >=20
> > after doing all this, perhaps we should re-factor phy_get into=20
> > musb_core.c, so that we can remove this sort of support from all
> > glue layers.
>=20
> So keep this is as is and add later a phy_get into musb? I would have
> check if everyone has a phy instance but I guess so.

sure, let's keep it as is :-)

--=20
balbi

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwBxsAAoJEIaOsuA1yqREbQAP/RcbBbotuY8gyo3ApKYlerha
IiQnTajCPud2WTCeP3Erg8RwempDBmxDxU/0Gr2yXKMfzenWN5pEnEdyP385dBx3
fRb+mk0I70Xqt8+e3iPpuuYhoNuedqjQc0oTJiOm2GUe2/dO3t8zg3BoOVEPXI54
XcBmwtU6sAqyVlFgeiyy3aQjLPJcOgNQ4mkyn5zsrLlKH2rG9G+MwsboApQB9WZS
Zx6TWHWW+TQAK2O5oSVvSgqFm1kenk9UHYvxohEPm1zb4DSB/GnzAoUup3xtaynd
z5UbG0BTV3l+8yUX70kyRKssVAyMh4VOEGO5c2L6XAbG6peB9Noakke3Qgm9L5fm
TqBVV93imQ4FgwsfzwOrvpFo6gtIvH7oVv/G/tWW9U+jnYRObbY9Lh52Dk6F37X8
ICjyp897NS6XHgJ9HOPa9dx28+lJQ2rczzB6GhgaE31ZZbqogBgxPz9FDEx7lBF1
KjolXjc0aGSgKDV2hkalSKgMyfHeimU0lNvy0enCay0gTdmaP8qNJvWpGNx178JJ
lki1Ks31LGtGmthHNTjnw4yIb2gsjT1CpCCo7I93dN20PKzfTV3q3X6Z5fojEReG
pz6QRT0OxxdMDpi3G3FbWapG2HNQV4T3XUSLFIk489h3UCYJ9SyiorXDDGqlW7cO
bzqPiIGpBxXg+Y4zBqJ+
=CKna
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
