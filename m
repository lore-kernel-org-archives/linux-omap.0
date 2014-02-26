From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Wed, 26 Feb 2014 13:42:50 +0200
Message-ID: <530DD33A.20005@ti.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com> <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3Dj5J7jfPMosks93qXEWvSuhIis2KH5lP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57503 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbaBZLnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Feb 2014 06:43:23 -0500
In-Reply-To: <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>

--3Dj5J7jfPMosks93qXEWvSuhIis2KH5lP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/02/14 21:49, Paul Walmsley wrote:
> On Fri, 17 Jan 2014, Tomi Valkeinen wrote:
>=20
>> omap2_dpll_round_rate() doesn't actually round the given rate, even if=

>> the name and the description so hints. Instead it only tries to find a=
n
>> exact rate match, or if that fails, return ~0 as an error.
>=20
> In the past, we had "rate tolerance" code, which allowed the clock code=
 to=20
> return an approximate rate within some margin.  See for example commit =

> 241d3a8dca239610d3d991bf58d4fe38c2d86fd5 ("OMAP2+: clock: remove the DP=
LL=20
> rate tolerance code").  The rate tolerance was set at compile-time, but=
 it=20
> was set on a per-PLL basis, which in theory allowed PLLs responsible fo=
r=20
> audio, etc. to have a very low rate tolerance, but PLLs that only drove=
=20
> internal functional blocks to have a high rate tolerance. =20
>=20
> Part of the reason why this was removed is because some of the TI hardw=
are=20
> guys didn't want any PLL rates used that were not explicitly=20
> characterized.

Ok.

>> What this basically means is that the user of the clock needs to know
>> what rates the dpll can support, which obviously isn't right.
>=20
> In principle I agree with you, but I'm not sure that this rate rounding=
=20
> function is the solution.
>=20
>> This patch adds a simple method of rounding: during the iteration, the=
=20
>> code keeps track of the closest rate match. If no exact match is found=
,=20
>> the closest is returned.
>=20
> So that's one possible rounding policy; maybe it works fine for a displ=
ay=20
> interface PLL, at least for some values of "closest rate".  But another=
=20
> might be "only allow a selection from a set of pre-determined rates=20
> characterized by the silicon validation team".  Or another rounding=20
> function might need to select a more distant rate that minimizes jitter=
,=20
> EMI, or power consumption. =20
>=20
> Seems to me that there needs to be some way for a clock user to=20
> communicate its requirements along these lines to the clock framework f=
or=20
> use by the rate rounding code.  At the very least, some kind of [min, m=
ax]=20
> interval seems appropriate.
>=20
> Also I've often thought that it would be useful for your purposes to be=
=20
> able to query a clock to return a list or some other parametric=20
> description of the rates that it can provide.

I fully agree with all you said above.

However, I'm not trying to fix the omap clock framework here =3D). I just=

want the displays to work properly in mainline kernel.

So, presuming this was merged, and gets display working, how would it
affect other users compared to the current state? The patched version
returns the same rate than before, if an exact match is found. Rounded
rate is only returned as a last option, instead of an error.

Do we have drivers that handle that error somehow, and then do something
(what?) to get some other rate?

If the clock path in question also has a divider component after the
pll, using clk-divider.c (which I guess is used in all/most of the
DPLLs?), things would go badly wrong if there's an error, as
clk-divider.c doesn't handle it.

So I can make no guarantees, but I have a hunch that all current users
ask for an exact clock, in which case this patch doesn't change their
behavior, except for display which it fixes.

 Tomi



--3Dj5J7jfPMosks93qXEWvSuhIis2KH5lP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTDdM6AAoJEPo9qoy8lh712hoP/jVocHnojwVr5K3hi6e5m+8b
G0MvLeQPARQ7rjRCJtKFt3YNH1GvGx3cRZMX9N5pLBxlN5jB1FfdZnrk0EuvaeP2
9SFandsKXdAJVMepZD/HKG8O9QgoOQyICuvzA7whgh7C3IJiNFIsEdQWOrCA9W0E
JZ8GuWtAr2E3XPzdj0jFO6h7TRrgKsGc0fQ2E1rclp3K1gbdeLXayfp1ue5dARuq
0hhvK6917y1LTFEiNtgbGrjseuMBKczkO3flpfZtmZhIvmcG+omE3iV39x5b7Wfd
gLJjcwB7BZoVmBxsdVqUEK+48m/t/ZjbU6ZMxiQn95WFCupRCQ7akaa7+1wepYrn
0e+lyG45HFVyHKyBtgBcId8g6lTgnFhoVC0nqhMGQ4yccbr5danWa0jS1ScvvHlO
CVLPcujXTi/lzCW5wi9YPcLZyp28I9OAWtAnPcHSEjjBkkOpOsK5Gv32KDupj/Fo
GETwVlmO2AEtkMTQCuTWMKM35Ot0PIkAvjLyIsMz8X1+aEodJWe8+JjmY5lFfHqI
U47ItLrkCwm1Jl86iYe08aYCV9oeUDOiUrYPW9T/PP0nyI5SI4OsE5mSsZcTSCG8
S4NqI49F2VEV1DoM2x21aUpAONczYV2dY3OyjeFiuQDGqAhRbSqZqRGAkPD6nNdZ
b7GV8pjo3crAfc25XfhU
=pe3B
-----END PGP SIGNATURE-----

--3Dj5J7jfPMosks93qXEWvSuhIis2KH5lP--
