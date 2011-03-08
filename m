From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] omap_wdt: fix interface clock handling
Date: Tue, 8 Mar 2011 16:10:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081605460.15132@utopia.booyaka.com>
References: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com> <87bp1lv8uc.fsf@ti.com> <alpine.DEB.2.00.1103081543430.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38444 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311Ab1CHXKs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:10:48 -0500
In-Reply-To: <alpine.DEB.2.00.1103081543430.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, ilkka.koskinen@nokia.com, Charulatha Varadarajan <charu@ti.com>, wim@iguana.be

Hi

On Tue, 8 Mar 2011, Paul Walmsley wrote:

> On Tue, 8 Mar 2011, Kevin Hilman wrote:
> 
> > Kalle Jokiniemi <kalle.jokiniemi@nokia.com> writes:
> > 
> > > The runtime PM does not offer enough granularity to control
> > > individual clocks separately as needed. Current pm implementation
> > > of omap_wdt blocks the CORE power domain from idling in
> > > OMAP SoC, as it keeps the interface clock of the watchdog always
> > > on. This causes severe power leakage in devices where 
> > > the omap watchdog is in active use.
> > 
> > The iclk remains active because it's in hardware-controlled
> > auto-idle mode.  
> 
> ... and we think that the interface clock never enters auto-idle because 
> the WDT doesn't SIdleAck to the PRCM until the special sequence has been 
> written to the WDT registers to disable it.  So even if its *CLKEN bits 
> are set to zero, the WDT prevents the system from going idle.

Actually, thinking about this further, I think this statement must be 
wrong.  The WDT may actually SIdleAck even when it's enabled.  Otherwise, 
how could disabling the clocks save much power?  The WDT shouldn't need 
its interface clock to be enabled in order to keep its timer ticking or to 
reset the system.  

So this first patch might not even be necessary.

Kalle, if both patches work, perhaps you might try dropping this one and 
see if the problem is still there?


- Paul
