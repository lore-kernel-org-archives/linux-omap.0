From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Tue, 14 Jan 2014 14:36:13 -0600
Message-ID: <20140114203613.GA604@saruman.home>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <52CF12FB.6000602@ti.com>
 <20140109231513.GA11648@saruman.home>
 <52CFC2F1.706@ti.com>
 <20140110161352.GG6665@saruman.home>
 <52D02037.3090705@ti.com>
 <20140110185110.GM31323@atomide.com>
 <52D53084.1070105@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56022 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbaANUhl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jan 2014 15:37:41 -0500
Content-Disposition: inline
In-Reply-To: <52D53084.1070105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, balbi@ti.com, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 02:41:40PM +0200, Tero Kristo wrote:
> On 01/10/2014 08:51 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [140110 08:32]:
> >>On 01/10/2014 06:13 PM, Felipe Balbi wrote:
> >>>On Fri, Jan 10, 2014 at 11:52:49AM +0200, Tero Kristo wrote:
> >>>>On 01/10/2014 01:15 AM, Felipe Balbi wrote:
> >>>>>On Thu, Jan 09, 2014 at 03:22:03PM -0600, Nishanth Menon wrote:
> >>>>>>
> >>>>>>conflicts with be changes on Tony's be branch.
> >>>>>>commit 80f304dd2360cf5d50953c4eb4e902536f6a1263
> >>>>>>     ARM: OMAP2+: raw read and write endian fix
> >>>>>>
> >>>>>>Conflict:
> >>>>>>arch/arm/mach-omap2/clkt_clksel.c
> >>>>>>arch/arm/mach-omap2/clkt_dpll.c
> >>>>>>arch/arm/mach-omap2/clkt_iclk.c
> >>>>>>arch/arm/mach-omap2/clock.c
> >>>>>>arch/arm/mach-omap2/clock36xx.c
> >>>>>>arch/arm/mach-omap2/dpll3xxx.c
> >>>>>>arch/arm/mach-omap2/dpll44xx.c
> >>>>>>
> >>>>>>Both change raw_readls -> should now be just clk api instead which
> >>>>>>already does readl_relaxed etc.. If Tony feels like, then we should
> >>>>>>probably post a branch based on 'be' branch for easy merge.
> >
> >This should be a trivial merge conflict to handle, so let's not base
> >things on the BE changes.
> >
> >>>>I think all of these fails are caused by the initially bugged
> >>>>Makefile + Kconfig under mach-omap2. Seems like they can be fixed by
> >>>>the patches I inlined at the end (will also post them as proper
> >>>>patches to l-o list after this.) The question is, should Mike go
> >>>>ahead and merge these along with the base clk patches or how should
> >>>>we handle them? Patch 1 must be merged, patch 2 is a nice to have one
> >>>>which allows DRA7 only builds (doing DRA7 only build currently seems
> >>>>not possible.)
> >>>
> >>>If it's OK with Tony, I would suggest having a branch with both patches
> >>>below which both Tony and Mike merge before merging CCF series. That w=
ay
> >>>we avoid bisection problems.
> >
> >I can queue those two separately as fixes.
> >
> >>That reminds me, I think the baseline branch for the mach-omap2
> >>patches is still somewhat unclear to me, what should be used for
> >>this? And which patches should be put there (the mach-omap2 patches
> >>depend on the drivers/clk/ti part basically, so I need to put at
> >>least those there also.)
> >
> >I would keep the clock patches against some mainline -rc commit if
> >possible, and if there are non trivial merge conflicts, the omap
> >to use as the base is commit adfe9361b236154215d4b0fc8b6d79995394b15c.
> >
> >In any case, it's probably best that Mike merges this all via his
> >clock tree unless there non-trivial merge conflicts.
> >
>=20
> I just pushed a branch against rc7 with makefile fixes in place to
> fix omap1 and omap2 only builds for this stuff. Inlined the delta
> here at the end. Do you want me to repost the series as v14 for this
> or is the attached delta ok for review purposes? All the changes have
> been squashed to existing patches (except the 2 patches I posted
> separately for DRA7xx / AM43xx only builds.)
>=20
> The test branch itself can be found here:
>=20
> tree: https://github.com/t-kristo/linux-pm.git
> branch: 3.13-rc7-dt-clks-v13-build-fixes
>=20
> Felipe, care to run your randconfig magic for this?

This branch builds just fine so far, I still have omap5 multiplaform and
uniplatform builds, but since that was working before i'm assuming it
won't break.

cheers

--=20
balbi

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS1Z+9AAoJEIaOsuA1yqREGewP/3p9TxF6Bl8m+whQ+Dc9PpNP
JO+ZJUZiTsRZNualVMRzxP5GnbeN4nd6wWT1ZQX/QBqZZgKErhJoxCvhbwzKxaFD
uRbN185yczzNx0dwbe2fdeN08R44tsJvYOr2cGjIRud6uXWpQfidoXGBWAIAyGNA
2Mr1F9WDOnY3vm7RcvkWMNAMJ9y6nY2FBkcGTsV80+y3BqbmwQ5QjE2dyX46fIor
2HLFJo6yyM0buJWaI69jjFbzpxpcx1K5irqJAI14ZAe4tvDOPR1MLD505EV+ZjGw
ix3LylXV7AnayTsuAo0KR1pfU7USLvokS9EQ1HWwVJw1jBrd6XhH/fxm8M7VRBP3
SulMDm/loLI+0R6t6DHb1XWt3ffO7NAVHPzLY8MgmISCz1PiqnDaKTTSqZxpvJU6
4IuflVqF5953dD/xoKdKiPQ2tzSEXW7+sSjP0Q+JjXyy0wDolkJAP0DFgb3jhsEw
b5i4GCFymwGWFXoemz8OzqUu9PP+7h1cMenxDGWpauLcuU2QN0nIVyZIh+0b9IF9
It2HyQqmrGSwcEBW3236+S4A1RbP+knDe+15R/M8ett/dL7PaEt28nFFcdmZClFW
HzrkLwHY0dsOA0cAPERCbmMTgbXVaGOHUSuzKcvWIbrSyX5x55oJzm13IZ5kxZ1t
SJbLYy0kEQOCb6FnQk7x
=fWyv
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
