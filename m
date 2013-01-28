From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 1/4] ARM: OMAP2+: dpll: round rate to closest value
Date: Mon, 28 Jan 2013 07:24:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301280721390.23108@utopia.booyaka.com>
References: <cover.1358937533.git.afzal@ti.com> <871e6890897534b6c3669e252f23bef5ff1247b6.1358937533.git.afzal@ti.com> <alpine.DEB.2.00.1301250816010.471@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A93EA9388C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56725 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab3A1HYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 02:24:31 -0500
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA9388C@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@linaro.org>, Russell King <linux@arm.linux.org.uk>

Hi

On Fri, 25 Jan 2013, Mohammed, Afzal wrote:

> On Fri, Jan 25, 2013 at 13:48:11, Paul Walmsley wrote:
> > On Wed, 23 Jan 2013, Afzal Mohammed wrote:
> 
> > > Currently round rate function would return proper rate iff requested
> > > rate exactly matches the PLL lockable rate. This causes set_rate to
> > > fail if exact rate could not be set. Instead round rate may return
> > > closest rate possible (less than the requested). And if any user is
> > > badly in need of exact rate, then return value of round rate could
> > > be used to decide whether to invoke set rate or not.
> > > 
> > > Modify round rate so that it return closest possible rate.
> > 
> > This doesn't look like the right approach to me.  For some PLLs, an exact 
> > rate is desired.
> 
> If exact rate is required, there is a way to achieve it as mentioned
> in the commit message, i.e. by first invoking round rate over reqd. rate
> and if it doesn't match, bail out w/o invoking set_rate.
> 
> And it seems requirement of CCF w.r.t to round rate is to return closest
> possible rate.

Hmm.  Maybe I need to take a closer look.  I'm a little worried that, 
since __clk_round_rate() can be called from omap3_noncore_dpll_set_rate(), 
we might wind up with inconsistent behavior.  Effectively we'd need to 
mandate that clk_round_rate() would have to be called first for any DPLL 
where we'd expect to set an exact rate.


- Paul
