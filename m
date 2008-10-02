From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Thu, 2 Oct 2008 13:50:02 -0700
Message-ID: <200810021350.03739.david-b@pacbell.net>
References: <200810010851.47774.david-b@pacbell.net> <200810010915.46032.david-b@pacbell.net> <20081001.213437.22091635.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:43618 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754481AbYJBUuG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 16:50:06 -0400
In-Reply-To: <20081001.213437.22091635.Hiroshi.DOYU@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com

On Wednesday 01 October 2008, Hiroshi DOYU wrote:
> Or, this feature itself can be covered by 'virtual clock(vclk)'?
>=20
> =A0 =A0 http://marc.info/?l=3Dlinux-omap&m=3D122066992729949&w=3D2
>=20
> which means that,
> in this case, if 'vclk' just has a single child, not multiple, it can
> be used just as 'aliasing' of clock names, without touching the
> contents of 'struct clk', since 'vclk' is a inhritance of 'struct clk=
'.

If clk_get(dev, alias) keys on "dev", then that could seem to
be an alternate implementation strategy.  Does it?

I've not been tracking the evolution of the OMAP clock tree
code, but the treatment of "dev" seems quite indirect.  It
doesn't seem possible, for example, to stick a programmable
clock onto a non-platform device ... even when that's the
relevant input to, for example, some external CODEC.


> I think that the point here is how to __hide__ the real detail clock
> information(names, numbers, functionalites and so on) from client
> device drivers.

That's one way to look at it.  Hiding is not the requirement
though; I have no problem if they can see that information.
(Not that the clock interfaces support querying by any scheme
more intelligent than looking up all possible names!)

The requirement is instead to provide a portable "logical" view
of the clock tree ... it doesn't matter if a "physical" view is
available too, or even that both models exist.


> Some driver may need to control multiple clocks at=20
> once. Some may need a clock which has different names between omap1,
> omap2/3 or target boards. Or some may need to control multiple clock
> groups from the functional perspective. So I think that a *flexible*
> infrastructure would be better to afford such requiments, keeping
> 'struct clk' as simple as possible.

That vclk stuff looked a bit less obvious than I like.
Maybe I just haven't seen the need for those particular
flavors of flexibility.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
