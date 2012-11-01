From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix spurious IRQs: disable/enable IRQ at INTC
 when idle
Date: Thu, 1 Nov 2012 23:49:21 +0100
Message-ID: <20121101224921.GE22956@pengutronix.de>
References: <1350067225-24589-1-git-send-email-khilman@deeprootsystems.com>
 <CAM=Q2csm0Eh9F6d1wKhEfOOtG+aY+Fh8D-dKPC0RMbKupVQHYQ@mail.gmail.com>
 <1350282337.17145.45.camel@kj-X230>
 <87zk3ntzfe.fsf@deeprootsystems.com>
 <20121016010223.GL15569@atomide.com>
 <1350377235.2014.26.camel@kj-X230>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1350377235.2014.26.camel@kj-X230>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Huzefa Kankroliwala <huzefank-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

>  Anyway new patch coming soon :)

Was there one? I have skimmed a number of threads discussing spurious
interrupts or interrupt floods but AFAICS all discussions ended up in
trying another approach later or fixing the issue somewhere else than
I2C. Is this correct? Or is there a bugfix patch left for 3.7 that I
missed?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCS/HEACgkQD27XaX1/VRunPACdEOuQinGV7sysWLwRcYTOv9Jo
D7MAoKTqtAkyZJax2ZxYRoqFoWHWa9zY
=QAFo
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
