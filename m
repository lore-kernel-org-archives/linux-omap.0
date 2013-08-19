From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: always send stop after nack
Date: Mon, 19 Aug 2013 08:57:02 -0500
Message-ID: <20130819135702.GC26587@radagast>
References: <51E50217.1000507@yahoo.es>
 <20130716090300.GG8880@arwen.pp.htv.fi>
 <51E5137B.7000302@yahoo.es>
 <20130716094212.GL8880@arwen.pp.htv.fi>
 <51E527F7.4080007@ti.com>
 <20130716112746.GN8880@arwen.pp.htv.fi>
 <51E537A4.40300@ti.com>
 <20130716130058.GD15036@arwen.pp.htv.fi>
 <51E57211.2040001@yahoo.es>
 <20130819121123.GA4540@katana>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130819121123.GA4540@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Hein Tibosch <hein_tibosch-mRCrAkd8dF0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 02:11:23PM +0200, Wolfram Sang wrote:
> Hi,
>=20
> > > Which means your original patch starts to make a lot more sense. I
> > > wonder is this is really what we should be doing though - breaking out
> > > of the loop, I mean.
>=20
> Yup, that is fine. I applied the old patch with Acks from Hein and
> Felipe to -next. Thanks!
>=20
> > It looks like TI's i2c-davinci will have the same problem as i2c-omap,
> > and will need the same change.
>=20
> Somebody up for this?

I would suggest deleting i2c-davinci and making sure it can use
i2c-omap. It's the same IP anyway. Just an older version which was used
back in OMAP1 times.

--=20
balbi

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSEiQuAAoJEIaOsuA1yqREM4wQAIUuk/k+6QpJVhcEMMBlgeNl
dKSyNUXSuqIxp+/jmTYGnoxYA1OQ0cyZjJTl8PltLzG4wszIlkaCJsN5h+zXQBwT
x0k2vCWJL28fL81H0HGnU7gOoXeCjpQa+Ixkh/nFMVN9ieflXLa3OZyuSJAjiIfB
boeRPmfJpzQywFsi4r5r8ZF0WeesQEHHSE9978NxiI/fY9Ly1Q8QbbhAPDMkBolB
xb4pX4vxPkuhmqRpwsB8eVqVblZw+udMZUcz5miSKXYO982pVhutPlqBBz+LxIHd
amp3T0fDDb3Cqu6vKzd+7kPF+RJQAvJyDmiuHIoo7W+zzEDpD7LBHf681CAvQnfB
+YwWTa6oOmlfK74+90mFDnJHnn6Sw6ThumUmNiZn5Xdy4IM4OKDxOjifhaaetAU7
uZFMA5Gv4LBJlyX/x4SC2KqLCeXXMXUrvPBEdP5XPhz5W8v3jDXDJq6EcQ3WgDhH
yyFxTgAFbkPx2g65yLPhNgHoFTksRxWKUvkBmmaA6sYBfmQK28NZrIS5/UKNGLpr
eVUnhiVZiAl8if12zgkXOvsa7CnaPCkRq3LZsNNbOC+qXBkq5JgzMck8r5KJEr71
Z7cOxGoTGbjLYtQZcYoo621R3F3481fkSNntJfr7ktv5X2gm2ZKbqpmpuW3UlD9l
bwVQ3OA7aqMpn7tWRBEb
=eJUg
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
