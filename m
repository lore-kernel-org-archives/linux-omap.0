From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] bluetooth: Add hci_h4p driver
Date: Wed, 21 Jan 2015 12:46:27 +0100
Message-ID: <201501211246.27449@pali>
References: <20141223130219.GA5731@amd> <7522CAC7-AFD9-470F-B4F8-3C39942DBC04@holtmann.org> <20150121110131.GA19792@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2668218.qebEoV65DQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150121110131.GA19792@amd>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart2668218.qebEoV65DQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 21 January 2015 12:01:31 Pavel Machek wrote:
> > > Strange, where do you see DOS style line breaks?
> > > Checkpatch here does not warn about that, and they really
> > > should not be there.
> >=20
> > If that would be the only pieces, then I would have fixed it
> > already. That is not the big deal. The rest of checkpatch
> > is what I am not going to fix for you.
>=20
> I can fix the checkpatch, but I'd like to understand how ^Ms
> got there, because otherwise it will happen again.
>=20

IIRC lines in email according to RFC2822 specification must be=20
delimited by CRLF. Maybe this is reason?

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart2668218.qebEoV65DQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS/kZMACgkQi/DJPQPkQ1KHNwCgirb0YAu/ipLdvsiz3UwuHR+y
PYIAmweevr4kH+u6tyK2tvaHab42Ewdw
=/x02
-----END PGP SIGNATURE-----

--nextPart2668218.qebEoV65DQ--
