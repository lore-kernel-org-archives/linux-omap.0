From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Fri, 3 Oct 2008 00:33:32 +0300
Message-ID: <20081002213327.GC10743@frodo>
References: <200810010851.47774.david-b@pacbell.net> <200810010915.46032.david-b@pacbell.net> <20081001.213437.22091635.Hiroshi.DOYU@nokia.com> <200810021350.03739.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45891 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbYJBVds (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 17:33:48 -0400
Content-Disposition: inline
In-Reply-To: <200810021350.03739.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com

On Thu, Oct 02, 2008 at 01:50:02PM -0700, David Brownell wrote:
> On Wednesday 01 October 2008, Hiroshi DOYU wrote:
> > Or, this feature itself can be covered by 'virtual clock(vclk)'?
> >=20
> > =A0 =A0 http://marc.info/?l=3Dlinux-omap&m=3D122066992729949&w=3D2
> >=20
> > which means that,
> > in this case, if 'vclk' just has a single child, not multiple, it c=
an
> > be used just as 'aliasing' of clock names, without touching the
> > contents of 'struct clk', since 'vclk' is a inhritance of 'struct c=
lk'.
>=20
> If clk_get(dev, alias) keys on "dev", then that could seem to
> be an alternate implementation strategy.  Does it?

in that case, clk_associate (or clk_add_alias like in pxa) would be
needed to associate the device with the struct clk, right ?

> I've not been tracking the evolution of the OMAP clock tree
> code, but the treatment of "dev" seems quite indirect.  It
> doesn't seem possible, for example, to stick a programmable
> clock onto a non-platform device ... even when that's the
> relevant input to, for example, some external CODEC.

in this case I think clk_associate would fail. Same for anything
else that "hides" the device pointer from board-files.

> That's one way to look at it.  Hiding is not the requirement
> though; I have no problem if they can see that information.
> (Not that the clock interfaces support querying by any scheme
> more intelligent than looking up all possible names!)

the problem with names for omap is that it's useful to name the clock
with the same name we see in TRM to ease the search (it's +3k pages
manual, anything to make searching easier is valid :-) but then again,
clk names changes among omap versions. So an alias (or function) name
would help us keeping the correct clk name in the header files and yet
have a standard/simpler name for drivers to use, like "mmc interface
clock" (mmc_ick) and "mmc functional clock" (mmc_fck). No matter if it'=
s
omap1/2/3/... we could keep the function name the same while clk name
refers to TRM.

> The requirement is instead to provide a portable "logical" view
> of the clock tree ... it doesn't matter if a "physical" view is
> available too, or even that both models exist.

that's true. We need a logical and rather stable (I'm referring to clk
names here) view of the clk tree so drivers don't have to care anymore
about different clk names. Having to add cpu conditional code in the
driver just because of a different clk name doesn't sound doable anymor=
e
neither passing an extra char * to the driver via pdata.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
