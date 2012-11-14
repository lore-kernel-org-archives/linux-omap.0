From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: don't save a value only needed for
 read-clearing
Date: Wed, 14 Nov 2012 19:50:33 +0100
Message-ID: <20121114185033.GB26955@pengutronix.de>
References: <1352913666-11022-1-git-send-email-wolfram@the-dreams.de>
 <20121114183739.GA30212@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121114183739.GA30212-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > This makes one of my code analyzers happy and makes me a part of the
>=20
> anything open source which we could all be using ? :-)

'my' as in 'one of those I am using'. It was cppcheck which found that
flaw. Its use for kernel code is limited, but it does find one or the
other thing.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCj5/kACgkQD27XaX1/VRvc5QCcDluOrhhW+Jf6CiDgldHv0PWz
JW0An2AF5Iu00ZBR+9xG//ys+u+ZekQy
=vsOP
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
