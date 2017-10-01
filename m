From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
Date: Sun, 1 Oct 2017 22:48:34 +0200
Message-ID: <20171001204834.kqc6fgfo7dx6m7rn@earth>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-2-tony@atomide.com>
 <20171001131151.loanjnvarkihbhik@earth>
 <20171001171406.GL4394@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vbbfx5uicw3y5566"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171001171406.GL4394-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--vbbfx5uicw3y5566
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 01, 2017 at 10:14:07AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org> [171001 06:12]:
> > On Fri, Sep 29, 2017 at 03:34:05PM -0700, Tony Lindgren wrote:
> > > Note that additional properties for sysc capabilities will be added
> > > later on. For now, we can already use this binding for interconnect
> > > target modules that do not have any child device drivers available.
> > > This allows us to idle the unused interconnect target modules during
> > > init without the need for legacy hwmod platform data for doing it.
> >=20
> > DT backwards compatibility is about booting an old DT file with a
> > newer kernel. Since old DT file does not contain a "ti,sysc-omap*"
> > node you don't need to add "ti,hwmod =3D *" support to it. Instead a
> > DT file, that uses ti,hwmod in the device node and does not have a
> > "ti,sysc-omap*" at all should still work.
>=20
> Not sure if I parse that right, but I'm assuming you suggest leaving
> out ti,hwmod to start with. Well I considered that, but it causes
> the "waiting for a magical flip issue". So initially we need to use
> both ti,sysc and ti,hwmod until ti,sysc alone has the equal
> functionality. That's because then we can do the following steps:
>=20
> 1. We want to add compatible =3D ti,sysc so we can define the
>    nodes and get the parent-children hierarhcy right. We can
>    already use the parent-child features even with ti,hwmods
>    before we have complete dts based data. We are currently
>    missing that capability without doing device specific parent
>    drivers like we do with drivers/usb/musb/musb_am335x.c. Note
>    that in this step we are moving the ti,hwmod to the parent
>    node
>=20
> 2. When ti,sysc can configure things based on dts data alone the
>    same way as the legacy platform data, we can just drop the
>    ti,hwmod property. We also want to be able to test one driver
>    at a time between ti,sysc + ti,hwmod vs ti,sysc only
>=20
> 3. Once ti,hwmod properties have been removed from the mainline
>    kernel, we can add a warning about ti,hwmod properties being
>    deprecated
>=20
> 4. Then later on, we can also drop the hwmod platform data and
>    continue produce warnings if ti,hwmod is seen

Ok, I misunderstood the reason for keeping/adding "ti,hwmod".
I thought it was only about keeping backwards compatibility, but
it's still required since hwmod is only partially converted to DT
by this patchset.

That basically means, that this patchset breaks DT ABI *now*, since
old DT has no ti,sysc node?

-- Sebastian

--vbbfx5uicw3y5566
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnRVJ8ACgkQ2O7X88g7
+ppb3xAAlDsEIkgc+dEhoweeKY+rSnSUU6Y9hAr0riIytvyC77f60YSQJy83QJ4h
TVN+cHya/NpkWMwM4VwHciEr5pz4Kqmz/DiZL2KUJOOztsyGLof5lnE2+W0pSh0y
omjgBuCaRYJUe2xWVKvXO7G2ABHkEtZrGpnlhnFaxcJWnRAsYmLPHbjMkr7uvrXF
8POUAfc5MIbSBUVCd9/fthYh2/iAW8r2D/4iyXt2HvGiiHgSR2ZTZimazjI3RZo8
TN45r/GH4ZzIICplDiCzAjh3Kt/hu2njai1D22I5VWzV20ubI5SgAq6d5ELmyk3I
1xNbJMpEASGp9Ybbq1F7RSO12ZdROMZbfXy2VZvtTE10GG1Tx1KI0wXmxFZHZxdD
dcEHCez/GTedI7Y6eV5qYNyOKeht1kwIva8wb1vn4d9toAORHz0OmTrr9E4hr8/P
r3WQNnYRCvPFmLwHwuEuEGbApITjIxCMNyNamKZd5X5hIbSb+RM3hKNk+GFauqu/
IsJNsNDObmo7URIQu+BZD3DaZm7yai/BUMvXGtIIH5usHg4U0s0NPeV3NQtMB8Q+
OtoW2FPT8ixbV5fEciN//OmTyMGlqos8H7GqwFrpGG2h7qezlSdsP6vlz0ua97Yj
i4nJ4b580fg+UOav0mLsVpUVJIj2YQHPfhqEjh0V0eXhpLTJ0KA=
=vJP0
-----END PGP SIGNATURE-----

--vbbfx5uicw3y5566--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
