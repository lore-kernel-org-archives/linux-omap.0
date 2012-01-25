From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 25 Jan 2012 11:32:08 +1100
Message-ID: <20120125113208.40cdb62f@notabene.brown>
References: <20120113222045.37f9b4ec@notabene.brown>
	<1326870839.1954.23.camel@deskari>
	<20120118221538.342b4782@notabene.brown>
	<1326886940.1999.5.camel@lappy>
	<20120119073032.74cc0992@notabene.brown>
	<WC20120119101721.07072A@terrafix.co.uk>
	<1326969658.1935.24.camel@deskari>
	<WC20120119112911.670749@terrafix.co.uk>
	<1326973019.7926.7.camel@lappy>
	<WC20120119122128.020787@terrafix.co.uk>
	<87y5t3trek.fsf@ti.com>
	<20120120080508.0dc0c758@notabene.brown>
	<87ty3rql2q.fsf@ti.com>
	<20120121231216.16c7e318@notabene.brown>
	<87k44ikr23.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/i5n64=/LU/6zhQqdBH6W7/L"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58814 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754777Ab2AYAcU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 19:32:20 -0500
In-Reply-To: <87k44ikr23.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

--Sig_/i5n64=/LU/6zhQqdBH6W7/L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Jan 2012 14:11:16 -0800 Kevin Hilman <khilman@ti.com> wrote:

> NeilBrown <neilb@suse.de> writes:
>=20
> > On Thu, 19 Jan 2012 16:22:37 -0800 Kevin Hilman <khilman@ti.com> wrote:
> >
> >> NeilBrown <neilb@suse.de> writes:
> >>=20
> >> > On Thu, 19 Jan 2012 11:37:39 -0800 Kevin Hilman <khilman@ti.com> wro=
te:
> >> >
> >> >> "Joe Woodward" <jw@terrafix.co.uk> writes:
>=20
> >> >>=20
>=20
> [...]
>=20
> >> At least this part is expected. =20
> >>=20
> >> In the kernel you're using the UART clocks are enabled/disabled during
> >> the idle path depending on the low-power state being targetted, so wou=
ld
> >> expect to see lots of UART clock gating going on.
> >
> > Even though uarts 1,2,4 aren't even in use?
>=20
> Yes.  Our UART idle management before v3.3 was, um... a disaster.
>=20
> > Maybe this is fixed in 3.3?
>=20
> As of v3.3, the UARTs are managed independently using runtime PM
> autosupend, so only UART that are in use should be coming on and back
> off again.
>=20
> However, as Paul has recently posted some UART fixes, you'll see that we
> have a few kinks to work out in the UART driver as well.

Good news ... I'll probably hold out until -rc2 before I start experimenting
with 3.3 much.

I think I understand why I was getting single-character corruption when
waking the UART while you just lost the character - I suspect you had
off_mode enabled.  That makes the difference for me.
Hopefully we can get rid of both the corruption and the character loss, but
I'll wait until I've tried 3.3 before I pursue that much more.

Thanks,
NeilBrown

--Sig_/i5n64=/LU/6zhQqdBH6W7/L
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTx9NiDnsnt1WYoG5AQKgHxAAuM34rPfzm7woSBso9mDHi24eWREkIbQ5
F7n1xKNPYCf8+Spi0uubmJ9UWWAYasbJg/dHcq8Hf4wai2KCuGOVqWxoeslSY6hY
tu8VnZ8/lEiElnob+oXSvb9bOZd0f35uvBXBmiFH0Jwv95D1v7lWlL/t0xdjKQ0L
WYQN12VKJUfZC1yfr6YTYl3jqP07GxTXc3NUvsdzdriD+V3Q14af8X5QwMutAlTd
E4wGZ1vFzSht/4HHeAm3hKafef17IIdZFExA9W9l3mQerfaynUVPqO6gcLrX3Jwd
rgcORptqlbmYeTw2VL8PZul6zQ7+P3Ikz+WIc7TBUZCBVmSplMJwnulXbkf7MXma
juCgUJwJpym95apPH4BKlA4NFImKscdVLugK/bv9P9QCS5MnqPMOW/kdrhoN1Sv6
Bef3Tp59JgEiW109fyj+1q146yU+VDmGm9pMxFs/T8fj7/D9gMRKbRY97jTj8K6j
Iy7eIqTg12hgOg90rSQUIiOfPGAwOibgr8BDzGIDz1gx5z4p5QWNDO7c/ydCH3l8
WvvPgpOB+kZ9kjSVBwirU56n2IPaOtRLgF5bWCdT1ISpRUyR+pfxsS/4KAfzE1Tr
NRd9nEr7DB22IQYwQuwti3uo8sJKBzXm/9K3Um09Tv6ebxFJedS9uj/Fype1tmLI
Cqwsetwav4Y=
=/Zv6
-----END PGP SIGNATURE-----

--Sig_/i5n64=/LU/6zhQqdBH6W7/L--
