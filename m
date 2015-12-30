From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Routable IRQs
Date: Wed, 30 Dec 2015 20:49:01 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512302037340.28591@nanos>
References: <878u4dj9r7.fsf@ti.com> <alpine.DEB.2.11.1512301903450.28591@nanos> <87ziwrixsu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ziwrixsu.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Felipe,

On Wed, 30 Dec 2015, Felipe Balbi wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> >  - Is there a "mapping" block between PRUSS and the host interrupt controller
> >    or is this "mapping" block part of PRUSS?
> 
> The description in TRM is a bit "poor", but from what I can gather, the
> mapping is done on an interrupt controller inside the PRUSS. However,
> Linux is the one who's got the driver for that INTC (well, Linux will be
> the one with the soft ethernet/uart/whatever IP to talk to). All of its
> (INTC's) registers are memory mapped to the ARM side.

Ok. And the INTC registers include the "mapping" configuration, right?
 
> >  - We all know how well shared interrupts work. Is there a point of supporting
> >    64 interrupts when you only have 10 irq lines available?
> 
> I'm looking at these 64 events more like MSI kind of events. It's just

Well, that's fine to look at them this way, but they will end up shared no
matter what.

> that the events themselves can be routed to any of the 10 available HW
> IRQ lines.
> 
> >  - I assume that the PRUSS interrupt mapping is more or less a question of the
> >    firmware implementation. So you either have a fixed association in the
> >    firmware which is reflected in the DT description of the IP block or you
> >    need an interface to tell the PRUSS firmware which event it should map to
> >    which irq line. Is there actually a value in doing the latter?
> 
> right, I'd say the mapping is pretty static. Unless Suman has some extra
> information which I don't. I guess the question was really to see if
> there was an easy way for doing this so we don't have to mess with DTS
> for every other FW and their neighbor.

Well, you will need information about every other firmware simply because you
need to know which events the firmware is actually using and what the purpose
of the particular event is.

Assume you have a simple uart with 3 events (RX, TX, status). So how will the
firmware tell you which event is which? You have a few options:

 1) DT + fixed mapping scheme: 

    Describe the PRUSS event number in DT and have a fixed mapping scheme like
    the one you mentioned evt0 -> irq0 .....

 2) DT + DT mapping scheme

    Describe the PRUSS event number in DT and describe the mapping scheme in
    DT as well

 3) DT + dynamic mapping scheme

    Describe the PRUSS event number in DT and let your interrupt controller
    associate the irq number dynamically. That's kind of similar to MSI with
    the exception that it needs to support shared interrupts.

 4) Fully dynamic association

    Have a query interface to the firmware which tells you which event it uses
    for which particular purpose (RX, TX ...) and then establish a dynamic
    mapping to one of the interrupts.

Not sure which level of complexity you want :)

Thanks,

	tglx



 
