From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3 cpuidle interrupt latency
Date: Tue, 3 Mar 2009 15:53:40 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC052561@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com>
 <873advaet2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43635 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbZCCKXs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 05:23:48 -0500
In-Reply-To: <873advaet2.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Tuesday, March 03, 2009 1:16 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: omap3 cpuidle interrupt latency
> 
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> > I have noticed large interrupt latency when the cpuidle is enabled.
> > e.g. response time for ping goes from avg 10-20ms to 800-1000ms.
> > (I am at HEAD of the 'pm' branch)
> 
> Is it interrupt latency in general you are measuring?  or 
> just the interrupt latency for the smc network driver.  I 
> think what you are seeing is the result of the SMC IRQ not 
> being configured as a wakeup source, thus a network interrupt 
> will not wake the system, but you end up waiting for the next 
> idle timer until the system wakes and handles the network interrupt.

I used SMC as an example. The read over USB is also slow...

I feel there is generic latency. Initially, I was suspecting
the hrtimer functions taking long time. But that may not be
the case.

> 
> By default, I don't believe the GPIO interrupt used by the 
> smc is configured as a wakeup source.  Have you configured 
> that GPIO as a wakeup source?

My current measurements are based with all idle related flags
'sleep_while_idle', 'clocks_off_while_idle' and 'enable_off_mode'
set at 0.

Does WFI require a wakeup event? Even when system is not in 'off' stare?

~sanjeev

> 
> Kevin
> 
> 
> > The IRQs and FIQs are disabled at the beginning of the function
> > omap3_enter_idle() but WFI is executed much later in 
> _omap_sram_idle().
> > In between, there is only one check for pending IRQs - 
> > omap_irq_pending()
> >  
> > If any interrupt occurs beyond this point is it considered 
> by the WFI?
> >  
> > To reduce this latency, I am planning to do either/both of thse:
> > - Add more checks for pending IRQs
> > - Reduce the time for which the IRQs and FIQs are disabled
> >  
> > Benefits will depend upon the behavior of WFI.
> >  
> > Best regards,
> > Sanjeev
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" 
> > in the body of a message to majordomo@vger.kernel.org More 
> majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> 