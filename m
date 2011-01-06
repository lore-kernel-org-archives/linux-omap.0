From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
 irq chip
Date: Thu, 6 Jan 2011 08:24:04 +0200
Message-ID: <20110106062404.GA14141@besouro.research.nokia.com>
References: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
 <20110105181918.GB8717@n2100.arm.linux.org.uk>
 <20110105192425.GA24729@besouro.research.nokia.com>
 <87aajfvstw.fsf@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:20533 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118Ab1AFG3j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jan 2011 01:29:39 -0500
Content-Disposition: inline
In-Reply-To: <87aajfvstw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@ti.com>
Cc: eduardo.valentin@nokia.com, ext Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 05, 2011 at 03:22:51PM -0800, ext Kevin Hilman wrote:
> Eduardo Valentin <eduardo.valentin@nokia.com> writes:
> 
> > Hello Russell,
> >
> > On Wed, Jan 05, 2011 at 06:19:18PM +0000, Russell King wrote:
> >> On Wed, Jan 05, 2011 at 07:58:03PM +0200, Eduardo Valentin wrote:
> >> > Currently, if one calls disable_irq(gpio_irq), the irq
> >> > won't get disabled.
> >> > 
> >> > This is happening because the omap gpio code defines only
> >> > a .mask callback. And the default_disable function is just
> >> > a stub. The result is that, when someone calls disable_irq
> >> > for an irq in a gpio line, it will be kept enabled.
> >> > 
> >> > This patch solves this issue by setting the .disable
> >> > callback to point to the same .mask callback.
> >> 
> >> Amd this is a problem because?
> >
> > errr.. because the interrupt is enabled when it was supposed to be disabled?
> >
> 
> As Russell pointed out, it's not actually "supposed" to be.
> 
> With lazy disable, what disable_irq() does is prevent the *handler* from
> ever being called.  If another interrupt arrives, it will be caught by
> the genirq core, marked as IRQ_PENDING and then masked.  This "don't
> disable unless we really have to" is the desired behavior of the lazy
> disable feature.

Right. I'm convinced that the handler won't be called because of the lazy
disable mechanism.

> 
> >> 
> >> The way this works is that although it isn't disabled at that point,
> >> if it never triggers, then everything remains happy.  However, if it
> >> does trigger, the genirq code will then mask the interrupt and won't
> >> call the handler.
> >
> > Right.. I didn't see from this point. I will check how that gets unmasked.
> > But even so, if I understood correctly what you described, it would still
> > open a time window which the system would see at least 1 interrupt during
> > the time it was not suppose to. And that can wakeup a system which  is in
> > deep sleep mode, either via dynamic idle or static suspend.
> >
> > It is unlikely, I know. But it can still happen. And can be avoided.
> 
> If the GPIO is configured as a wakeup source, then wouldn't you want
> activity on that GPIO to wake up the system?

Yes I would want it.. of course, if the interrupt is enabled though..

I'm still trying to find a valid situation where someone disables an irq
but still wants its activity to be a wakeup source. I couldn't find so far..


> 
> If you don't want wakeups on that GPIO, then the driver should probably
> be using disable_irq_wake().

Yes. Let's take this situation. Let's assume a driver, at its suspend callback,
explicitly reports to the system that its irq can be disabled and also should
not be seen as a wakeup source, by calling disable_irq(gpio_irq) and
disable_irq_wake(gpio_irq).

What should be the expected system behavior when the user says echo mem > /sys/power/state?

>From the point we are done with devices suspend, that gpio will still
be marked as an irq, at the bank level. But its corresponding pad will
have its wakeup bit disabled. Would that work? I think yes, in most cases.

Now let's take the WFI instruction as a divisor for 2 situations:

A - common / working case: an interrupt on that gpio still happens after the WFI instruction.
Since the system is in sleep mode and the pad for that gpio is not wakeup
capable, then nothing would happen and the system won't wakeup. Then, I think
everyone is happy here.

B - corner case: an interrupt on that gpio happens before the WFI instruction.
Since the system is active, the gpio bank can still report this interrupt
and will do it. The suspend won't happen due to a irq which has been
explicitly marked as disabled and wakeup incapable.

Then, would that be the expected behavior? Assuming that the driver
has explicitly said to the system, you should not bother about this at all.

> 
> Kevin
> 

-- 
Eduardo Valentin
