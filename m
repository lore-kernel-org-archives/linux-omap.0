From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix bus recovery setup
Date: Fri, 31 Jul 2015 12:49:13 +0200
Message-ID: <20150731104912.GF1522@katana>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
 <20150714111004.GB1517@katana>
 <55A4FC19.4040709@ti.com>
 <20150714121207.GI1517@katana>
 <1438165650.20986.2.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438165650.20986.2.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan =?utf-8?B?TMO8YmJl?= <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 12:27:30PM +0200, Jan L=C3=BCbbe wrote:
> On Di, 2015-07-14 at 14:12 +0200, Wolfram Sang wrote:
> > On Tue, Jul 14, 2015 at 03:10:01PM +0300, Grygorii Strashko wrote:
> > > Hi Wolfram,
> > >=20
> > > On 07/14/2015 02:10 PM, Wolfram Sang wrote:
> > > > On Wed, Jul 08, 2015 at 04:35:27PM +0200, Jan Luebbe wrote:
> > > >> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not eno=
ugh to
> > > >=20
> > > > Felipe: it seems you did not need this; is this AM335x specific?
> > >=20
> > > We need it (Felipe's reply can be delayed).
> >=20
> > So, how did it work for him?
> >=20
> > > It's not AM335x specific. TMODE has to be configured for all OMAP4+ S=
oCs too.
> >=20
> > Okay, thanks for the stepping in!
>=20
> Wolfram, will you pick this as-is?

Yes, I was hoping for an answer to my above question to get a better
understanding, but we can still apply the patches meanwhile.



--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu1KoAAoJEBQN5MwUoCm23A0QAKav8gFzVwVEcLJDBjMqubj2
Y1hrJxOv8CHQ6ZCdNIDUHTqL05Ea1vfdNg1zsuedGi2a1hB3PtfVp1YTIUtYqoSK
33fvJERhsFaXm0+rn4AzHJmY1FK2fkpng5mhikxQhRUadJe767tF9Qa/YFr1uGGi
0rkshlmMhASELaDV6WdZRuDRg/WZD0KgUeNt4khsIQ/tWtcvF4UjRRLCK28YEsNp
Ya6HoROOjL4mxW1u7wWJms9mgY9Qp+TkcwoI+uyQjAuDms2mxSMc8t1/IPmaizGg
7+bSmbpFBR4F9FyUX1QetP3eVB4SHNFnn7MyIJ3MRDGa/Aan24Y31ZhP2ztcApXj
CMJYb6y2MPHxBhdakJRhAMutKux7R7nr8vQyG/FB1JuzsX0UU9QLkx1V80eomnbc
LkpXNuEZqdCs5WDAQ88RroDs2nfmbkKQkOv2HqJJhP7+3LBwEI+iQxD9RPxBgsP2
71FZ0lslDNPsNcTkzts2qGgG56srAZgH90d1iY5HL+MScMfX7svCILLIqxNlzJD2
+IRiInlizt2NqfzCLQom3mEI5wfaH8egEEE+MCHKuEKY1mtO3P3u3vk6vlvgRm5o
EFMccYXbhXYa9Zlj6/U1UJCVgyVcfG5Uzt8p8toqVMEBReIuErNgg8jhEc6/KSc0
LrGFuf9OQOLs0g6WEm9U
=1fpR
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
