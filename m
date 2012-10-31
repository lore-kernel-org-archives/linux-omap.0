From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] i2c: omap: Fix the revision register read
Date: Wed, 31 Oct 2012 13:52:54 +0200
Message-ID: <20121031115254.GB10733@arwen.pp.htv.fi>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
 <20121031101201.GB10094@arwen.pp.htv.fi>
 <5091045E.8040407@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5091045E.8040407-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2012 at 04:28:38PM +0530, Shubhrajyoti wrote:
> On Wednesday 31 October 2012 03:42 PM, Felipe Balbi wrote:
> >> =20
> >> > +	if (!_dev->regs)
> >> > +		return 0;
> > this is wrong, you need to make sure dev->regs is set early enough.
>=20
>=20
> to set the dev->regs I use the value read from revision register.
>=20
> to read the revision register I do a get_sync first. This in turn leads
> to the call to resume handler.
> At this point the regs is NULL and so the check.
>=20
> After reading the register and checking the scheme bit.
> the reg map is populated.
>=20
> How can this issue be solved?

aaa good point, missed that. Nevermind that comment ;-)

cheers

--=20
balbi

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkREWAAoJEIaOsuA1yqREMGcP/2liYH8AtCx64lol3ZGowZpb
Uhhm994U98z9QDzqw2rMYHY1oJ0PDBWaypxnRyXZBpzqukKS19m038uAff7mBq8r
EJnrI9G7IK39nKSbxVxJs1cQ61oquRcs+UBwsDz2jUw+vS1OU1+zKmnc5tveTZQK
YTg3lEnTaHUvEzfR7BBPNtcGgvVXXUUwPrg/lRdxnTNPvF8qfVowbYxTAzf726I2
JRUZat0O5/o1NHogauG25Co7xiMzBfjuRTjEo6T2CwM+4MYj+6dQ/VvMkA/Qf0vz
dXJnAgHjehisXzcZXFKsNtqc+pPl3iqkOuI2steNLyHsjiicY54hzePtogKZJ/9K
BjjH6/S1QppS5LMb1sQAzt6KJl+6u0bh6Yt1ltmjRNN13DJUqTF2MUDnB8in5Knr
hyW3YYpv63P1057kCKSBCKRM6ciTqo4q67S2XPOUtRGRtzrG235/ngxHM+5wGmf7
9e/hB544mX6+77WbgZ0BnAs/s0KQgoXaK/L8EPSm/az8EIwBynmdhijFk+WVx4rE
ziW+gaVP/gkE8davRS6yWcePHmzkDNvKpxkmKw+PLKteX3qty/0SmX43e0mZWWO7
SuffaxrBWz0yznfH+YD+Wm3VSDw1hALsT/mdPYq5lHn1y2A8oHpuPzRzf6YHJVvR
b34W+599De0n56cfq2uZ
=Nh3R
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
