From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Bug in linux omap clock framework?
Date: Mon, 8 Dec 2008 02:24:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>  <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com> <1228726770.8668.66.camel@tubuntu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37099 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbYLHJYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 04:24:48 -0500
In-Reply-To: <1228726770.8668.66.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi Tomi,

On Mon, 8 Dec 2008, Tomi Valkeinen wrote:

> On Sat, 2008-12-06 at 16:51 -0700, ext Paul Walmsley wrote:
> > Hi Tomi,
> > 
> > nice test case.
> > 
> > On Fri, 5 Dec 2008, Tomi.Valkeinen@nokia.com wrote:
> > 
> > > I have had strange clk_enable() crashes with DSS2, and now I managed to
> > > isolate it. With the included patch, on OMAP3 SDP board, with default
> > > kernel config, I always get the crash below. In this example case it
> > > happens at specific time on boot, but with DSS2 it happens randomly at
> > > runtime, when I enable the DSS clocks.
> > 
> > Looks like there's some problem with the DSS driver's usage of 
> > dss_tv_fclk.  Enabling dss_tv_fclk before entering your test code's 
> > while-loop makes the problem go away here.  Patch below.
> 
> Yes, enabling dss_tv_fclk "fixes" it. Also enabling dss1_alwon_fck fixes
> it. (Note that I had a bug in the test code: it's dss1_alwon_fck in
> omap3, not dss1_fck =). Funny that I didn't get any error.).

Hmmm, yeah, we should patch the clock code to warn when 
clk_enable()/clk_disable()/etc is passed a NULL pointer, that would help 
quite a bit.

> > As an aside, your test patch does not actually disable dss1_fclk, since it 
> > is already enabled by the time the while-loop starts.  So you might also 
> > want to add a clk_disable(c2) before your while-loop starts, when you 
> > test.
> 
> What makes you say that? Who would enable it? And clk_get_count returns
> 0 for dss_ick, dss1_alwon_fck and dss_tv_fclk.

This was my mistake, I was assuming that dss1_fclk was valid without 
checking it against the clock tree.

> > Based on the traceback that you sent, I'd conjecture that probably some 
> > part of the DSS subsystem is generating an interrupt via DSS_IRQ; but then 
> > dss_iclk ends up disabled, and the MPU INTC is not able to communicate 
> > with the DSS, and the INTC wedges.  (The aborting access is to 0xd8200098, 
> > the INTCPS_PENDING_IRQ0 register, rather than a DSS register.)  Probably 
> > some IRQs need to be masked before disabling the dss_iclk.
> 
> Okay. So, is this a DSS problem or clock framework problem? 

At this point my guess would be that it is a DSS driver problem, but I 
don't think it is clear yet.

> First I made the following test module to make testing easier, and to 
> turn off any interrupts. Crashes with DSS interrupts turned off also 
> (although they should be off by default).
> 
> Disable omapfb from kconfig if you try this.

OK, will try this later on today.


- Paul
