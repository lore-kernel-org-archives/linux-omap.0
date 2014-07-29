From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 29/35] arm: omap: intc: switch over to linear irq domain
Date: Tue, 29 Jul 2014 09:15:22 -0500
Message-ID: <20140729141522.GB17808@saruman.home>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-30-git-send-email-balbi@ti.com>
 <20140729121425.GR29045@atomide.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140729121425.GR29045-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 29, 2014 at 05:14:25AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140728 14:19]:
> > now that we don't need to support legacy board-files,
> > we can completely switch over to a linear irq domain
> > and make use of irq_alloc_domain_generic_chips() to
> > allocate all generic irq chips for us.
>=20
> This patch seems to somehow break off-idle for omap3=20
> where it no longer wakes up.

Sure your bisection is correct ? This patch just switches from legacy
irq domain to linear irq domain.

> Other than that, this whole series boots fine for me.

good

--=20
balbi

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT16x6AAoJEIaOsuA1yqRE3B0P/jxVV9udi5sGpFs3nrqKzwGO
SlfI6OO+xFzerEXXlf0NmPNIVpdtw5TfjYcx12cBMAGG9w8OZovJ0QOo0AT+LNwU
8dzI2PErV3XVfmOOaz/51peLQ3bYN3n9n9215eBp0ABHtHVUd7/R6yG2KtRFqTWR
PYoSebRnJflkwHDn5Fay3X8/rW8ZUF4LupLnjygPuQTIO3xT70a2rBBYABTG+DUy
0xzk+IJ8HT6qLdezHJjkiXikbFkJoO/mpVg+YhXvW5vHy7pJGASkPmhUyY2LPEva
UJniXfp3f4E6jRfizz2g7Lws8Xu2xMvqix4+uVeGFZQ7o7ZbUBEgBWcdxtJ9TK6O
CVQPmYEiywlCCq/Wo1kTxt7JgyuZj2vWL9wggZ62Zn6wnhIfFss2iJlmOVOhlP7m
WHQl+90oibOXee9r7eWxynz08Gd5gScH2YvJvMQmc7TobUZutXcOQZQwNnEsSdvs
CoKODxB8gjtOpc8+uF3EV921+EVeCwyuwjvZ/PHzAGGvY0i+bsdRx23Xki7GdPAA
VW0yVztHbeuDDcs7ca8aZorcazooknLf2SfIUNe2u/dJjhWIT+cGD0rK5kkWDxSr
ieqofqYRF6Kb9ah0z3xCNKTqqXqjyk0vIrIB8O+gRECTowYtYnWJPuG2Q3vBZOOT
G/1qSy9SPH0k5TD6vjJU
=sLSv
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
