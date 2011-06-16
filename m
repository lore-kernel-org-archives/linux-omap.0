From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
Date: Thu, 16 Jun 2011 21:43:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D563E79@dbde02.ent.ti.com>
References: <1308229940-27025-1-git-send-email-premi@ti.com>
 <877h8lsswk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42125 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab1FPQNS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jun 2011 12:13:18 -0400
In-Reply-To: <877h8lsswk.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Hilman, Kevin 
> Sent: Thursday, June 16, 2011 8:52 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
> 
> Hi Sanjeev,
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > When multiple wakeup sources are defined in a system,
> > there is a small window, when more than one source
> > can trigger wakeup interrupt.
> >
> > In the current implementation, the do-while() loop
> > can handle all wakeup sources that are recorded when
> > probing the status register in prcm_interrupt_handler().
> >
> > When the ISR executes due to next queued wakeup, it
> > there is nothing to be handled and value of "c" is 0.
> 
> Thanks for tracking this one down.
> 
> However, It's still not clear to me what is happening here.
> 
> Why is the IRQ firing if there is nothing to be handled?  
> That suggests
> to me that the IRQ status is not properly being cleared.

[SP] On the contrary the IRQ status is actually getting cleared,
     but there are more than "1" PRCM interrupts queued.

     The do-while() clears all the interrupt sources that
     are flagged in the status register.

     When the next wakeup interrupt is getting processed, the
     status register doesn't contain any "source" to handle.
     and value of "c" is returned as 0.... leading to the
     warning.

~sanjeev

> 
> Kevin
> 