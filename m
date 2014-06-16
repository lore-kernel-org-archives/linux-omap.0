From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Mon, 16 Jun 2014 15:28:52 +0300
Message-ID: <539EE304.3070900@ti.com>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com> <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com> <20140515060834.3084.5199@quantum> <5374B241.9010201@ti.com> <20140531000207.10062.55946@quantum> <alpine.DEB.2.02.1406031907210.14238@utopia.booyaka.com> <538EBBF1.7040804@ti.com> <alpine.DEB.2.02.1406131924571.340@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="cJUenLrRiQ6Lx3ETsK9iH1wGHEfNp8odL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40134 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679AbaFPM3b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jun 2014 08:29:31 -0400
In-Reply-To: <alpine.DEB.2.02.1406131924571.340@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org

--cJUenLrRiQ6Lx3ETsK9iH1wGHEfNp8odL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/06/14 22:53, Paul Walmsley wrote:

> Whatever we do to the (common, not DSS-specific) clock code to fix this=
=20
> issue, it has to make sense independently of your specific DSS needs.=20

I agree. I think the fix (v1) makes sense for all users of the pll.
Correct me if I'm wrong, but the current state is:

- The pll's round_rate does not round, but instead returns an error if
it cannot produce the exact rate that was requested.

- All OMAP PLL's have dividers after them, handled with clk-divider drive=
r.

- clk-divider driver does not handle errors from round_rate, but instead
goes on and the resulting clock rate is more or less garbage.

- If a driver requests a clock rate that cannot be produced exactly,
it'll instead get a garbage clock rate, leading to undefined behavior.

So surely fixing the round_rate so that the clock code behaves sanely,
if not optimally, is much better than the current undefined behavior?

And again, currently a driver needs to request an exact clock rate, as
otherwise it'll get a garbage clock rate, and I'm quite sure it won't
work correctly. So all the current drivers request an exact clock rate,
and they are not affected by the fix, or the drivers are totally broken
already.

> This is why I asked you for a DSS-specific change, since it would=20
> effectively avoid this basic principle.

Yes, a DSS specific change would be marginally safer, but I think the
DSS specific options get rather hacky or complex. One option was the DT
flag, which was not accepted. Another would be adding a list of accepted
clock rates to DSS driver, and the DSS driver would "round" internally.
Quite hacky, I wouldn't like to go there.

And as I don't see the generic fix causing any problems, I don't see why
we would want to make big hacks somewhere else, just to avoid the
generic fix.

I'm open to ideas how to make a relatively clean DSS specific fix for
this, which can be merged for the next -rc.

> Right now, in my view, it does not make sense to have a PLL clk_set_rat=
e()=20
> function that unconditionally rounds to the "closest" rate for all user=
s. =20
> As I've written before, callers could end up with a clock rate that is =

> different than what's needed for a synchronous I/O user that expects an=
=20
> exact rate.  I am concerned about both rounding to a lower rate and=20
> rounding to a higher rate in this case, although the higher rate is=20
> marginally more of a concern to me since the resulting rate may be high=
er=20
> than the device is characterized for at a given voltage.
>=20
> Furthermore, as a general interface principle, allowing clk_set_rate() =
to=20
> silently round rates could lead to unexpected behavior, since the set o=
f=20
> rates that clk_set_rate() can round to may change between the call to=20
> clk_round_rate() and the call to clk_set_rate().

Maybe, but, correct me if I'm wrong, that's how the clock set_rate has
worked (always?). The exact behavior for set_rate and round_rate isn't
defined anywhere I've seen, which to me means the behavior is
implementation specific.

However, I think it's clear that round_rate _should_ round, which it
currently does not. With this fix, both set_rate and round_rate work
inside the "spec".

> So again I think that the right way to deal with this is to:
>=20
> 1. avoid silently rounding rates in clk_set_rate() and to return an err=
or=20
> if calling clk_set_rate() would result in a rate other than the one=20
> desired; and to
>=20
> 2. modify clk_round_rate() such that it returns the closest=20
> lowest-or-equal rate match to the target rate requested.

I see that as a separate thing. What you're talking about is improving
the clock API. What I'm talking about is fixing a major (at least to the
owners of AM3xxx boards) bug in the mainline kernel, with as minimal
changes as possible.

The fix doesn't need to solve all the possible issues around clock rate.
It just needs to fix the bug we have, without causing any new bugs.
Afaik, the fix does not introduce any new problems. The behavior of
set_rate and round_rate can be improved later.

If the fix would be merged asap, we would get as long testing time as
possible before the 3.16 is released. If we find any drivers broken by
this fix, we can fix the drivers or in the worst case revert the fix.

 Tomi



--cJUenLrRiQ6Lx3ETsK9iH1wGHEfNp8odL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTnuMHAAoJEPo9qoy8lh71w20P/jASlJm6zO46CMEelYwBmbEe
5cc90HSBHJNVa8fa9zAIyQdT2x81kkeJdZkufdu5f95Jj/D9acWN0DMJrkPdUmiq
LUH7TAgJGFcWI6S3slRq9OKeCmwjJBe1gNoz8ugvyg+tdwY2PFNu/MPGvsBQve3g
OSXA+Pe/exvaRIU4GaTlMc69VITBdqX55m/OK9FvLs62RKBRMnQrWKVZMzGBQvS5
ILm6b/W/BeGI6yQkKZ75vHKCmuh0Z9VqKF3bM2Ve4aSbfen5kg1TEhyFYl0KJoyw
DhIXjYMdbpHzWll8h5txjffyuJ0YE8r1XX2WjNnwMdANugTCxnZX3NrXhBtfwwyo
u0aOL7gm83KVRNT7eZKJqNF3JYlRPNKqKQwKS5FQPfdpICtJLT0++1t+2N/uBVxj
k7TM1y3ZkRVIyIsV0IbS6sCyyYcmqMOufddg6rgOLxCzU0KjmkNRxxHjkUpDZ+Lr
CQl2KeGPOrzjagny3lbcyFmvAAowgV3xXSXSa85Imh5CBt6yCiyiCyGOYO1CjlwG
NzE6WnDJpgUQ42csW8MVaTdFLCZIqR8pA0w6sqof3RbZFZd0jAuE5Ggq+gSHBRo7
k6RwjzLJGFiw9VV/jx2Bc2ahdLHrRmi3SuQn6M2J2XJZnV2h/KMDEN8bLSRTW17f
nkRWE6dsKr6E3v5mkTHz
=jxIP
-----END PGP SIGNATURE-----

--cJUenLrRiQ6Lx3ETsK9iH1wGHEfNp8odL--
