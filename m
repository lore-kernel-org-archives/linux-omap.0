From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 3/5] clk: introduce the common clock framework
Date: Fri, 2 Dec 2011 21:32:03 +0100
Message-ID: <20111202203203.GB4585@pengutronix.de>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-4-git-send-email-mturquette@linaro.org>
 <alpine.DEB.2.00.1111291619110.6289@utopia.booyaka.com>
 <20111201084547.GD19739@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1112012352000.6289@utopia.booyaka.com>
 <20111202202306.GF19739@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41703 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab1LBUc1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 15:32:27 -0500
Content-Disposition: inline
In-Reply-To: <20111202202306.GF19739@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, linaro-dev@lists.linaro.org, linus.walleij@stericsson.com, patches@linaro.org, eric.miao@linaro.org, broonie@opensource.wolfsonmicro.com, magnus.damm@gmail.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, richard.zhao@linaro.org, grant.likely@secretlab.ca, dsaxena@linaro.org, arnd.bergmann@linaro.org, shawn.guo@freescale.com, skannan@quicinc.com, sboyd@quicinc.com, jeremy.kerr@canonical.com, linux-omap@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>

Hello,

On Fri, Dec 02, 2011 at 08:23:06PM +0000, Russell King - ARM Linux wrot=
e:
> On Fri, Dec 02, 2011 at 10:13:10AM -0700, Paul Walmsley wrote:
> > Hi Russell,
> >=20
> > On Thu, 1 Dec 2011, Russell King - ARM Linux wrote:
> >=20
> > > On Wed, Nov 30, 2011 at 06:20:50PM -0700, Paul Walmsley wrote:
> > > > 1. When a clock user calls clk_enable() on a clock, the clock f=
ramework=20
> > > > should prevent other users of the clock from changing the clock=
's rate. =20
> > > > This should persist until the clock user calls clk_disable() (b=
ut see also=20
> > > > #2 below).  This will ensure that clock users can rely on the r=
ate=20
> > > > returned by clk_get_rate(), as long as it's called between clk_=
enable()=20
> > > > and clk_disable().  And since the clock's rate is guaranteed to=
 remain the=20
> > > > same during this time, code that cannot tolerate clock rate cha=
nges=20
> > > > without special handling (such as driver code for external I/O =
devices)=20
> > > > will work safely without further modification.
> > >=20
> > > So, if you have a PLL whose parent clock is not used by anything =
else.
> > > You want to program it to a certain rate.
> > >=20
> > > You call clk_disable() on the PLL clock.
> >=20
> > The approach described wouldn't require the PLL to be disabled befo=
re=20
> > changing its rate.  If there are no other users of the PLL, or if t=
he=20
> > other users of the PLL have indicated that it's safe for others to =
change=20
> > the PLL's rate, the clock framework would allow the PLL rate change=
, even=20
> > if the PLL is enabled.  (modulo any notifier activity, and assuming=
 that=20
> > the underlying PLL hardware allows its frequency to be reprogrammed=
 while=20
> > the PLL is enabled)
> >=20
> > > This walks up the tree and disables the parent.  You then try to =
set the=20
> > > rate using clk_set_rate(). clk_set_rate() in this circumstance ca=
n't=20
> > > wait for the PLL to lock because it can't - there's no reference =
clock=20
> > > for it.
> >=20
> > As an aside, this seems like a good time to mention that the behavi=
or of=20
> > clk_set_rate() on a disabled clock needs to be clarified.
>=20
> It's more complicated than that.  Clocks have more states than just
> enabled and disabled.
>=20
> There is:
> - unprepared
> - prepared and disabled
> - prepared and enabled
>=20
> Implementations can chose at which point to enable their PLLs and wai=
t
> for them to lock - but if they want to sleep while waiting, they must
> do this in the prepare method, not the enable method (remember, enabl=
e
> is to be callable from atomic contexts.)
>=20
> So, it's entirely possible that a prepared clock will have the PLLs u=
p
> and running, which means that clk_set_rate() can also wait for the PL=
L
> to stablize (which would be a good idea.)
>=20
> Now... we can say that PLLs should be locked when the prepare method
> returns, or whenever clk_set_rate() returns.  The problem with that i=
s
> there's a race condition between clk_enable() and clk_set_rate() - if
> we allow clk_set_rate() to sleep waiting for the PLL to lock, a
> concurrent clk_enable() can't be prevented from returning because
> that would involve holding a spinlock...
But you can achieve that the concurrent clk_enable fails. Would that be
sane?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
