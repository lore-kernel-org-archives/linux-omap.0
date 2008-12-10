From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Bug in linux omap clock framework?
Date: Wed, 10 Dec 2008 00:02:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812092345490.5902@utopia.booyaka.com>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>  <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>  <1228726770.8668.66.camel@tubuntu>  <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>  <1228831086.31061.9.camel@tubuntu>
  <alpine.DEB.2.00.0812091612240.5902@utopia.booyaka.com> <1228878281.3405.7.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53032 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbYLJHCh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2008 02:02:37 -0500
In-Reply-To: <1228878281.3405.7.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Igor,

On Wed, 10 Dec 2008, Igor Stoppa wrote:

> On Tue, 2008-12-09 at 16:14 -0700, ext Paul Walmsley wrote:
> > 
> > On Tue, 9 Dec 2008, Tomi Valkeinen wrote:
> > 
> > > It looks to me that when I do clk_enable() to a clock which is inside a
> > > turned off powerdomain, clk_enable() function will return before the
> > > powerdomain is fully turned on. Reading PM_PWSTST_DSS shows that the
> > > powerdomain is still in transition state.
> > > 
> > > The following change waits until the powerdomain has finished the
> > > transition. At least it fixed the problem for me, and other things seem
> > > to be still working =).
> > 
> > Nice work - this makes sense.  Tested your patch here also. 
> 
> Just a thought:
> wouldn't this feature be required in basically every similar case?
> 
> And if yes, wouldn't it be better to embed it into clk_enable() so that
> the driver code doesn't have to address it explicitly and can be more
> easily shared across different OMAP architectures?

I think Tomi's patch covers all of the similar cases, even though it isn't 
in clock..d directly.  clock.c:omap2_clk_enable() calls 
clockdomain.c:omap2_clkdm_clk_enable() whenever a clock is enabled.  This 
is the function that Tomi's patch changes.  When the number of active 
clocks in a clockdomain goes from 0 to 1, omap2_clkdm_clk_enable() will 
wait until the powerdomain indicates that it has finished its transition 
before continuing.  (The powerdomain may not actually change state at this 
point, but pwrdm_wait_transition() just waits for the "INTRANSITION" bit 
to equal zero, so it should be safe to test even if the powerdomain state 
does not change.)


- Paul
