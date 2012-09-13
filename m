From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Thu, 13 Sep 2012 21:37:07 +0300
Message-ID: <20120913183705.GA17430@arwen.pp.htv.fi>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <20120912131615.GB16547@pengutronix.de>
 <87pq5quaqr.fsf@deeprootsystems.com>
 <87wqzysuu3.fsf@deeprootsystems.com>
 <87sjaldcjp.fsf@deeprootsystems.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87sjaldcjp.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 13, 2012 at 11:04:42AM -0700, Kevin Hilman wrote:
> Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> writes:
>=20
> > Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> writes:
> >
> [...]
>=20
> >> Sorry to be late to the party (again), but still catching up after some
> >> time off.
> >>
> >> Unfortunately, this series causes PM regressions on several OMAP
> >> platforms.  I hope we can hold off on this until those issues are
> >> addressed.
> >
> > I tracked the regression down to [PATCHv8 21/22] (see reply there.)
> >
> > Since this series is already merged, I suggest that the problem patch be
> > reverted, at least for v3.7 and until the problem is better understood
> > and tested.
> >
> > With that patch reverted, all my PM tests are passing.  Feel free to
> > add:
>=20
> OK, the i2c series is off the hook.
>=20
> Felipe and I spent a little time tracking this down.  Felipe suggested
> that there might be a driver with periodic i2c activity keeping I2C
> awake, and thus preventing CORE retention.  He was right.

FYI, the original idea came from Shubhro. We agreed that would be the
only way i2c would be prevented from idling.

--=20
balbi

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUifRAAoJEIaOsuA1yqREe9MQAITjfmsOfW/L/hKi/6NCLu+G
9pGVG8d8wDe7A+jQzCOuNyhXcetDhfbPxpksRdIGcTiBOCQ5iBTLuUKKTFM9Mhkr
xAtSIfmGt9G1uNKlK78Ak/C92sCZEfbn0eTVBj/NLlXTDUbz1PKuJA17hpLvkM1S
6qmNERXcMuAK6pia+Ti7GcbE7bMi0+H2M391NcwaVbfVXARkedMYiwm5yH7g0Xz6
SEp7sss7g9Hd7mMDtQte47a0OIaP5Atg0Y1mNgirHRZYQi6V5rCCRNuBR26j04yO
YmHauSpVU1LuVicQBfH29bjLkETidycAD+ETdKlnXUS4opGJk9WGGVeuJFp08p6C
pQFR1UJRb7BuWfd0rsgHSAzkh/CPKFTlhUm8wmC6FWk8gLnKx0WfCk6/briJvLb4
Zv/UkBOfMJXdsm+e8bWRUmoh1//80eP4PTYulnAfHVZ66bASSl/hqBiaf/mxzXT2
wNIJRAX6YyTuPolrQA+Kk4v/RPem0EU96c7OJgbNfqdYAXYFG9XX4UN68oTJ98sL
hhdIEig5l9Q5NZ6rTryvH9lFrmvjqLyA8+roDEjZYgOiVHSafu+4wvKsueDYg9S8
N3HVLDMf0K9GTWlwgLmREOfOaJwsF6dsdx5ATE5D85S63TH20zSSzSZdUqFhLyf8
HvniNlNxt3ctbzAkyx5Z
=oXwI
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
