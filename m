From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Thu, 24 Apr 2014 13:34:21 -0500
Message-ID: <20140424183420.GE4659@saruman.home>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
 <530DD33A.20005@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57391 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758672AbaDXSiG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 14:38:06 -0400
Content-Disposition: inline
In-Reply-To: <530DD33A.20005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>

--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2014 at 01:42:50PM +0200, Tomi Valkeinen wrote:
> On 19/02/14 21:49, Paul Walmsley wrote:
> > On Fri, 17 Jan 2014, Tomi Valkeinen wrote:
> >=20
> >> omap2_dpll_round_rate() doesn't actually round the given rate, even if
> >> the name and the description so hints. Instead it only tries to find an
> >> exact rate match, or if that fails, return ~0 as an error.
> >=20
> > In the past, we had "rate tolerance" code, which allowed the clock code=
 to=20
> > return an approximate rate within some margin.  See for example commit=
=20
> > 241d3a8dca239610d3d991bf58d4fe38c2d86fd5 ("OMAP2+: clock: remove the DP=
LL=20
> > rate tolerance code").  The rate tolerance was set at compile-time, but=
 it=20
> > was set on a per-PLL basis, which in theory allowed PLLs responsible fo=
r=20
> > audio, etc. to have a very low rate tolerance, but PLLs that only drove=
=20
> > internal functional blocks to have a high rate tolerance. =20
> >=20
> > Part of the reason why this was removed is because some of the TI hardw=
are=20
> > guys didn't want any PLL rates used that were not explicitly=20
> > characterized.
>=20
> Ok.
>=20
> >> What this basically means is that the user of the clock needs to know
> >> what rates the dpll can support, which obviously isn't right.
> >=20
> > In principle I agree with you, but I'm not sure that this rate rounding=
=20
> > function is the solution.
> >=20
> >> This patch adds a simple method of rounding: during the iteration, the=
=20
> >> code keeps track of the closest rate match. If no exact match is found=
,=20
> >> the closest is returned.
> >=20
> > So that's one possible rounding policy; maybe it works fine for a displ=
ay=20
> > interface PLL, at least for some values of "closest rate".  But another=
=20
> > might be "only allow a selection from a set of pre-determined rates=20
> > characterized by the silicon validation team".  Or another rounding=20
> > function might need to select a more distant rate that minimizes jitter=
,=20
> > EMI, or power consumption. =20
> >=20
> > Seems to me that there needs to be some way for a clock user to=20
> > communicate its requirements along these lines to the clock framework f=
or=20
> > use by the rate rounding code.  At the very least, some kind of [min, m=
ax]=20
> > interval seems appropriate.
> >=20
> > Also I've often thought that it would be useful for your purposes to be=
=20
> > able to query a clock to return a list or some other parametric=20
> > description of the rates that it can provide.
>=20
> I fully agree with all you said above.
>=20
> However, I'm not trying to fix the omap clock framework here =3D). I just
> want the displays to work properly in mainline kernel.
>=20
> So, presuming this was merged, and gets display working, how would it
> affect other users compared to the current state? The patched version
> returns the same rate than before, if an exact match is found. Rounded
> rate is only returned as a last option, instead of an error.
>=20
> Do we have drivers that handle that error somehow, and then do something
> (what?) to get some other rate?
>=20
> If the clock path in question also has a divider component after the
> pll, using clk-divider.c (which I guess is used in all/most of the
> DPLLs?), things would go badly wrong if there's an error, as
> clk-divider.c doesn't handle it.
>=20
> So I can make no guarantees, but I have a hunch that all current users
> ask for an exact clock, in which case this patch doesn't change their
> behavior, except for display which it fixes.

no further updates here ? Display is still broken on BBB :-(

--=20
balbi

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWVksAAoJEIaOsuA1yqREiG0P/iAWmibVgyXdwukP59uAveFs
4SVyFIZ94JfIzWM/vxOXV40l/jbPcLPIpBUUi7mxuYik0tgyr8krGJVTvZHI7T/v
WZsOP0fRlo8TSb7JG7QP9fJZENRVomiaqYgJf/P5Q2WmimpOgmwA0gQlm9XjGUdY
rSeVbhi5CmQ9siACHAHJ1utn+UVEVEdkWomTRVUZoSNuniWQ/rtTC4Thh+XJNsvB
gONc/PdW7jJ7Qi4XJT4DXhnr4GKNPFn0NMiqDnbdT1uHM/mtEsjLgkSmAZtCF7eo
UibR6f6a/VzinvBLVTlom2mjLXZMmt+igWiJYQixAyuFZfbaDUSEAWdPS9sC66+W
r0V92SqZl85OALicZ1+EQV5sNsiCiABVaXcHi8yBrDUuuycN274azH5fkwx0WL76
N/Cebwhu3zvKLyKM9DdP3v8gnnfyKUfGsJmFeLRtCCtTsxx701J6ICWeM7l1T62j
t5SMmoYZH543X02eCZqX9zRPphJk5FYf01PZPNemxTCjpDaw56abHYPlghO2qI13
lBc2NZU1twz6e29+/xfBn1gGH9eWnOfKU49yD7Zgvq9CxMb6SBmFKekhzCh4hQAs
YarYUMsnnMZ50rvsAGEDpwPrq98x/egkD+JCiRfCt+9hjtCYlzcigV8Jzuwo8ikj
g+4mGoxtRyCCqAwPJxJ/
=NDqa
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
