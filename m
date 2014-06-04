From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Wed, 4 Jun 2014 09:25:53 +0300
Message-ID: <538EBBF1.7040804@ti.com>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com> <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com> <20140515060834.3084.5199@quantum> <5374B241.9010201@ti.com> <20140531000207.10062.55946@quantum> <alpine.DEB.2.02.1406031907210.14238@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="M4D5pellEqf6BBqVjNEmkMD6UGqFQAbkX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55915 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbaFDG0Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 02:26:25 -0400
In-Reply-To: <alpine.DEB.2.02.1406031907210.14238@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org

--M4D5pellEqf6BBqVjNEmkMD6UGqFQAbkX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/06/14 22:35, Paul Walmsley wrote:

> What's really needed is better control over rounding in the clock code.=
 =20

Well, if you ask me, what's really needed _now_ is to fix the bug that
makes am3xxx (and am4xxx when it's merged) display not to work. I don't
need a fix that solves all the clock set_rate/round issues once and for
all, I just want to get the display working.

> Both the driver API should be improved; and, to the extent that clock=20
> sources share the same underlying code implementation, probably some cl=
ock=20
> source configuration data enhancement is needed (DT or whatever).
>=20
> Furthermore, clk_set_rate() should never silently round a requested rat=
e -=20
> it should just return an error if it can't satisfy the requested rate=20
> precisely.  Silently rounding a rate is racy, and, if we care about=20
> drivers behaving consistently across different integration environments=
,=20
> prone to behavior that the driver may not expect.
>=20
> Frankly, a DT "ti,round-rate" property is risible.  I certainly underst=
and=20
> why you don't like it and I don't know why that specific property was=20
> proposed.  The issue has never been whether clk_round_rate() should rou=
nd=20

I created the property for the v2 because (if I recall right) you were
worried that fixing the rounding bug unconditionally could break some
drivers, and suggested that it should be used only for DSS.

> rates.  Of course it should.  The more pertinent question is, *how* sho=
uld=20
> it round the rate?  A more reasonable DT property approach would be to =

> specify how the clock's rate should be rounded: to the closest rate, to=
=20
> the closest rate equal to or less than the desired rate, to the closest=
=20
> rate greater than or equal to the desired rate; what the tolerance of t=
he=20
> "closest rate" should be, etc.  But drivers, e.g. many drivers that=20
> control external I/O, should always be able to state that they want an =

> exact rate.
>=20
> ...
>=20
> In terms of the short-term thing to do, I'm currently thinking that the=
=20
> thing to do is to modify the PLL set_rate() code in mach-omap2/ to not =

> round the rate at all, and then switch the PLL rate rounding code to=20
> equal-or-closest-lesser-rate, with something like the oldhardcoded rate=
=20
> tolerances.  That should push the responsibility out to the drivers to =

> control how they want the rounding to happen.  Then the drivers should =
be=20
> able to probe available rates with repeated calls to clk_round_rate() i=
f=20
> they want, and if people get unhappy with that, then it might drive=20
> rounding improvements in the clock API.

I agree, the current clock rounding is rather undefined, and I need to
do my own calculations in omapdss to "probe" the clock rates.

> But all this won't happen in -rc8; this is 3.16 material..
>=20
>=20
>> We can always see how it goes and fix it up afterwards when everything=
=20
>> explodes.
>=20
> No thanks... that's what leads to these kinds of messes :-(=20

I don't understand how this fix would lead to a mess.

1. AM3xxx/AM4xxx display is broken
2. The PLL round function is broken, it doesn't round
3. The fix to omap2_dpll_round_rate has been in TI's kernel for a long
time, no problems observed
4. We've ran test runs with linux-next + the fix, no problems observed

I agree that there's a possibility that some driver could break with the
fix. I think it's a theoretical possibility, because clk-divider.c (I
think there's always a divider after the pll in omaps) doesn't handle
the error from the dpll code, so I don't really see how a driver could
manage to handle the error as the error is not conveyed to the driver.

In any case, if a driver breaks because of the fix, the driver's clock
handling is totally broken in any case, and it should be fixed.

Do we want to keep an important subsystem totally broken because there's
a theoretical possibility that the fix could break something else?

The fix was first posted in January. And we're still discussing about
it. And I still don't understand why the fix could cause problems. So
if the patch (v1 preferably) cannot be applied to 3.15, I'd very much
like to hear how it makes the situation worse, either for the current
kernel or for any future changes to the drivers/clock code.

 Tomi



--M4D5pellEqf6BBqVjNEmkMD6UGqFQAbkX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjrv0AAoJEPo9qoy8lh71RpsP/3pWpS1ZTtj1HmHkV4TUfElW
E8nuOU3rPS2qjpKoVvJxlz2I7A94LCd7JyvMpSZs01JPY8EfyISJTNJabKnLReQs
KOfPf6tA2z9khw0MqW1+4UHxx/klEDnf16s9Sc9PqaCHJe7G97Owlohe+UVspE+w
ADkZ12iZtFfBk++eGzDwxxfe4sZqW1XxgQr4/ST/9A6AL9rJwQtuMc6b4EhiCshy
iDn0+mN21kdsQI1oVSMJOd7s3MShC3/+wPE9yxclR+8D0ja76CgPut24DzmC2X5o
lcJQTRh3oTnzlYfbsHi0BIpZNU6IrMDUt2hBfkFviRR/GCWROG9b8evRMbizHC7w
n7HI44oOfiJuK7Lj7PHUqYiI8G0EhUTBDvA8wrKe6/YfYwqhIZEf9d0xYwbqaM9b
a5yiFt5W+bbqk85YE3CE52APsp0mQdAEt1T7x4sQxADGU+sc+Y8JZIlaCHfdc3bl
ApyXK8crgttkc3I1XccE/Wr7K16Z/Hwgdrl+q5SGS/maCUeszwC/JYzZAbD5Be5f
ttiTSJzm598NUcVtPX5TNquSSvN8tXjQvU/I7JjE/27jTNra8mslu+CwqQj24U+R
1lH8d3zyQMeYkGz1xZa4/GsNGgH6elZt2s341xbiitkr3Chfk9qUD80FW3orcoIf
Fbv+0fqptEKRARV95sY+
=GBkl
-----END PGP SIGNATURE-----

--M4D5pellEqf6BBqVjNEmkMD6UGqFQAbkX--
