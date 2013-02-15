From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP EHCI having clock problems?
Date: Fri, 15 Feb 2013 18:04:10 +0200
Message-ID: <20130215160410.GB20334@arwen.pp.htv.fi>
References: <87halea4s3.fsf@linaro.org>
 <511DE9AB.5080403@ti.com>
 <87fw0x608o.fsf@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44577 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593Ab3BOQEU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 11:04:20 -0500
Content-Disposition: inline
In-Reply-To: <87fw0x608o.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2013 at 07:54:47AM -0800, Kevin Hilman wrote:
> Roger Quadros <rogerq@ti.com> writes:
>=20
> > Hi Kevin,
> >
> > On 02/15/2013 12:50 AM, Kevin Hilman wrote:
> >> Felipe, Roger,
> >>=20
> >> Using Tony's current master branch, and enabling EHCI support, I see=
=20
> >> the clock framework spitting loudly about the EHCI driver (full boot l=
og
> >> below.)   The same thing happens on v3.8-rc7.
> >>=20
> >> Any idea what's going on?  Am I missing a set of fixes that's already
> >> been posted?
> >
> > Thanks for pointing out. This series should fix the issues
> > https://lkml.org/lkml/2013/1/23/155
> >
> > They should be on their way to linux-next.
>=20
> Great.  But what about v3.8?  I see the same problems in v3.8-rc7.

isn't it too late for v3.8 ? I guess the only way out would be to send
the patch for stable.

--=20
balbi

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHlx6AAoJEIaOsuA1yqREH3kQAJ7b4Tj7QyXPnJwTLB9OfKLi
fGWWcjYDPlaqaiyTI48/CyrFZ3WNBEaB69a7Nfkieq4AegriE9NHiepS36KNQAFj
E0OPZlSPsK5p/uF2lOPNpUuWhyXMRQgFqzTmLJQTBJXd/cPWxgPDn640ffr6MXZ5
smP6djPbIGZFAUP9zvXgzoe2NloUWyvLLP9bQATmLWi+iIUWVuaaJbQBWhlIa96E
u2uqthfCKeq8aEnPTAfJWMiamCdOrd+HHOpbE+HqlbNaCGOGRSB84JmHuUb7rHn6
uY0nNVhRT//k1mLaiwzz58p3VLvmz3OKXYNO5+vwLMybQQrF4yISgy+W4BbvlYAy
MgKPpT6TdYsGWZlIXwGKbsas2LtSjqoAfzwxRJZ4N5e0wxhkMihM6VB1RU8Q7j7q
GJmU7c4lSWmEu0Vay8nTE5BER4bIX1CAWDtzQRWsCcIrvbBCMNvcAlBG+/9K4N8w
tQmD4GbsQWR5bP8FGgXWtvmcR9v2gN9OIN/O0U2CH5Ad31DaXkciBa0HkXwlg+ub
0ISYt3PZky50doTUhjtiMx5ggB3VZVULgbcQTm+spHkmHB0hMkrsZD8CAVdt0BZ4
HMonuTN7E+MjgY63RL3ccZdrJEROzVr2Gf7NnNcWQsYbbinjzFwKwwtw7zxA2zy3
7/arUsZHTsi/PS9IJL5n
=79+6
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
