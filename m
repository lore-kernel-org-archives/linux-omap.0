From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 15:12:24 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1101251506360.31804@localhost6.localdomain6>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com> <20110124110609.GJ16202@n2100.arm.linux.org.uk> <20110124111114.GA19409@n2100.arm.linux.org.uk>
 <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com> <20110125103231.GD11507@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251418260.31804@localhost6.localdomain6> <20110125133752.GI13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:45129 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753659Ab1AYOM4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 09:12:56 -0500
In-Reply-To: <20110125133752.GI13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: catalin.marinas@arm.com, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 25 Jan 2011, Russell King - ARM Linux wrote:
> On Tue, Jan 25, 2011 at 02:23:10PM +0100, Thomas Gleixner wrote:
> > In which way? I mean the generic code issues a call to the set_mode
> > function when we leave the broadcast mode. So what should the generic
> > code do more ?
> 
> I can't say because these patches only add the hooks, there's no
> implementation yet which uses the hooks.
> 
> Given the description about _why_ those hooks are necessary, it seems
> that something is required.  Either we start adding custom hacks to
> each clockevent driver as is done with this patch, or we get some
> generic help in place.
> 
> I'm not thrilled by the custom hack approach - and I thought the
> clockevent stuff was created to stop this kind of thing happening.

Yes, and it does the right thing:

     idle enter (where the cpu local tick device stops)

     	  tick_broadcast_oneshot_control(CLOCK_EVT_NOTIFY_BROADCAST_ENTER)

		clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN)
		tick_broadcast_set_event(dev->next_event, 1)

    idle exit

     	  tick_broadcast_oneshot_control(CLOCK_EVT_NOTIFY_BROADCAST_EXIT)

		clockevents_set_mode(dev, CLOCK_EVT_MODE_ONESHOT)
		tick_program_event(dev->next_event, 1)

So the generic code has all the calls in place. If a clock chip
implementation misses to set control registers in the
CLOCK_EVT_MODE_ONESHOT case, then it's not a short coming of the
generic code which needs magic hooks in the arch code.

The same applies for the periodic mode switch, which is handled via
tick_broadcast_on_off().

Am I missing something ?

Thanks,

	tglx
