From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 14:15:30 +0000
Message-ID: <20110125141530.GB17286@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com> <20110124110609.GJ16202@n2100.arm.linux.org.uk> <20110124111114.GA19409@n2100.arm.linux.org.uk> <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com> <20110125103231.GD11507@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251418260.31804@localhost6.localdomain6> <20110125133752.GI13300@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251506360.31804@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42544 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab1AYOQG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 09:16:06 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101251506360.31804@localhost6.localdomain6>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: catalin.marinas@arm.com, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 25, 2011 at 03:12:24PM +0100, Thomas Gleixner wrote:
> On Tue, 25 Jan 2011, Russell King - ARM Linux wrote:
> > On Tue, Jan 25, 2011 at 02:23:10PM +0100, Thomas Gleixner wrote:
> > > In which way? I mean the generic code issues a call to the set_mode
> > > function when we leave the broadcast mode. So what should the generic
> > > code do more ?
> > 
> > I can't say because these patches only add the hooks, there's no
> > implementation yet which uses the hooks.
> > 
> > Given the description about _why_ those hooks are necessary, it seems
> > that something is required.  Either we start adding custom hacks to
> > each clockevent driver as is done with this patch, or we get some
> > generic help in place.
> > 
> > I'm not thrilled by the custom hack approach - and I thought the
> > clockevent stuff was created to stop this kind of thing happening.
> 
> Yes, and it does the right thing:
> 
>      idle enter (where the cpu local tick device stops)
> 
>      	  tick_broadcast_oneshot_control(CLOCK_EVT_NOTIFY_BROADCAST_ENTER)
> 
> 		clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN)
> 		tick_broadcast_set_event(dev->next_event, 1)
> 
>     idle exit
> 
>      	  tick_broadcast_oneshot_control(CLOCK_EVT_NOTIFY_BROADCAST_EXIT)
> 
> 		clockevents_set_mode(dev, CLOCK_EVT_MODE_ONESHOT)
> 		tick_program_event(dev->next_event, 1)
> 
> So the generic code has all the calls in place. If a clock chip
> implementation misses to set control registers in the
> CLOCK_EVT_MODE_ONESHOT case, then it's not a short coming of the
> generic code which needs magic hooks in the arch code.
> 
> The same applies for the periodic mode switch, which is handled via
> tick_broadcast_on_off().
> 
> Am I missing something ?

I quote Colin:

| This doesn't work for oneshot timers if the TWD_TIMER_CONTROL register
| gets reset by cpu idle between twd_set_mode and twd_set_next_event.

I quote the code:

static void twd_set_mode(enum clock_event_mode mode,
                        struct clock_event_device *clk)
{
        unsigned long ctrl;
        switch (mode) {
        case CLOCK_EVT_MODE_PERIODIC:
                /* timer load already set up */
                ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
                        | TWD_TIMER_CONTROL_PERIODIC;
                break;
        case CLOCK_EVT_MODE_ONESHOT:
                /* period set, and timer enabled in 'next_event' hook */
                ctrl = TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT;
                break;
        case CLOCK_EVT_MODE_UNUSED:
        case CLOCK_EVT_MODE_SHUTDOWN:
        default:
                ctrl = 0;
        }

        __raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
}

