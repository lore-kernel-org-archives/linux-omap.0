From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH 0/2] omap_wdt: fix interface clock handling
Date: Wed, 9 Mar 2011 09:02:35 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B0652E1@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
 <87bp1lv8uc.fsf@ti.com>
 <alpine.DEB.2.00.1103081543430.10981@utopia.booyaka.com>
 <alpine.DEB.2.00.1103081605460.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:42575 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756811Ab1CIJCu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 04:02:50 -0500
In-Reply-To: <alpine.DEB.2.00.1103081605460.15132@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, ilkka.koskinen@nokia.com, charu@ti.com, wim@iguana.be



> -----Original Message-----
> From: ext Paul Walmsley [mailto:paul@pwsan.com]
> Sent: 9. maaliskuuta 2011 1:11
> To: Jokiniemi Kalle (Nokia-MS/Tampere)
> Cc: Kevin Hilman; linux-omap@vger.kernel.org; tony@atomide.com; b-
> cousson@ti.com; Koskinen Ilkka (Nokia-MS/Tampere); Charulatha
> Varadarajan; wim@iguana.be
> Subject: Re: [PATCH 0/2] omap_wdt: fix interface clock handling
> 
> Hi
> 
> On Tue, 8 Mar 2011, Paul Walmsley wrote:
> 
> > On Tue, 8 Mar 2011, Kevin Hilman wrote:
> >
> > > Kalle Jokiniemi <kalle.jokiniemi@nokia.com> writes:
> > >
> > > > The runtime PM does not offer enough granularity to control
> > > > individual clocks separately as needed. Current pm implementation
> > > > of omap_wdt blocks the CORE power domain from idling in OMAP SoC,
> > > > as it keeps the interface clock of the watchdog always on. This
> > > > causes severe power leakage in devices where the omap watchdog is
> > > > in active use.
> > >
> > > The iclk remains active because it's in hardware-controlled
> > > auto-idle mode.
> >
> > ... and we think that the interface clock never enters auto-idle
> > because the WDT doesn't SIdleAck to the PRCM until the special
> > sequence has been written to the WDT registers to disable it.  So even
> > if its *CLKEN bits are set to zero, the WDT prevents the system from going
> idle.
> 
> Actually, thinking about this further, I think this statement must be wrong.
> The WDT may actually SIdleAck even when it's enabled.  Otherwise, how
> could disabling the clocks save much power?  The WDT shouldn't need its
> interface clock to be enabled in order to keep its timer ticking or to reset the
> system.

Yes, the interface clock is not needed for the WDTIMER to work, and disabling the interface clock allows the sleeping to happen. This is what I observed. To my understanding, the pm_runtime calls automatically disable also the functional clock. I know the WDTIMER won't stop by just disabling the fclk bit, but it does not seem correct operation to assume this. This is why I reverted the runtime_pm patches. Can we somehow control only the iclk via runtime-pm?

> 
> So this first patch might not even be necessary.
> 
> Kalle, if both patches work, perhaps you might try dropping this one and see
> if the problem is still there?

Ok, I tried them both: first both individually, and then combined. No luck, CORE power domain still remains ON with all combinations.

Looking at the registers dump, the clock bits are disabled as one would expect, however this does not seem to help in getting CORE to sleep. Actually, with the working clk_enable/disable approach, both fclk and iclk clocks are shown as enabled, though I guess this is due to the clk_disable(iclk) only allowing HW power domain state transition to disable the interface clock (not to disable it immediately). Maybe the transition goes somehow sour with r-pm, as both clocks seem disabled, while the wdt is internally still ticking (due to the special disable sequence not done, and it should not be done, as we need the watchdog).

This gets us back to square one, how to use the runtime-pm to only disable the iclk (or more precisely allow the device to sleep, when wdt is used)? Is it out of the question to use direct clock control via clock framework? It "just works" :)

- Kalle

> 
> 
> - Paul
