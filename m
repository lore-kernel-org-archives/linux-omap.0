From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Routable IRQs
Date: Wed, 30 Dec 2015 19:17:05 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512301903450.28591@nanos>
References: <878u4dj9r7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878u4dj9r7.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Felipe,

On Tue, 29 Dec 2015, Felipe Balbi wrote:
> Anyway, the interesting part is that PRUSS has 64 events (on current
> incarnations at least) and PRUSS has 10 physical IRQ lines to the ARM
> land. Each of these 64 events can be routed to any of these 10 IRQ
> lines. This might not be very useful on UP (AM335x & AM437x) other than
> the fact that soft-IP drivers running on Linux would need to guarantee
> they are the ones who should handle the IRQ. However, on SMP (AM57xx) we
> could have real tangible benefits by means of IRQ affinity, etc.
> 
> So, the question is, what is there in IRQ subsystem today for routable
> IRQ support ?
> 
> If a Diagram helps here's a simple one. Note that I'm not showing
> details on the PRUSS side, but that side can also map events pretty much
> any way it wants.
> 
>  .--------------------.             .--------------------.
>  |      HOST CPU      |             |       PRUSS        |
>  |--------------------|             |--------------------|
>  |                    |             |                    |
>  |               irq0 |<-.----------|evt0                |
>  |                    |  |          |                    |
>  |               irq1 |  |  .-------|evt1                |
>  |                    |  |  |       |                    |
>  |               irq2 |  '----------|evt2                |
>  |                    |     |       |                    |
>  |               irq3 |     |       |                    |
>  |                    |     |       |                    |
>  |               irq4 |     |       | .                  |
>  |                    |     |       |                    |
>  |               irq5 |     |       | .                  |
>  |                    |     |       |                    |
>  |               irq6 |     |       | .                  |
>  |                    |     |       |                    |
>  |               irq7 |<----'       |                    |
>  |                    |             |                    |
>  |               irq8 |             |                    |
>  |                    |             |                    |
>  |               irq9 |<------------|evtN                |
>  '--------------------'             '--------------------'
> 
> Given this setup, what I want to do, is let soft-IP drivers running on
> linux rely on standard *request_*irq() calls and DTS descrition. But I'm
> still considering how/if we should describe the routing itself or just
> go round-robin (i.o.w. irq0 -> evt0, irq1 -> evt1, ..., irq9 -> evt9,
> irq0 -> evt10, ...).
> 
> Thoughts ?

I have a few questions:

 - Is there a "mapping" block between PRUSS and the host interrupt controller
   or is this "mapping" block part of PRUSS?

 - We all know how well shared interrupts work. Is there a point of supporting
   64 interrupts when you only have 10 irq lines available?

 - I assume that the PRUSS interrupt mapping is more or less a question of the
   firmware implementation. So you either have a fixed association in the
   firmware which is reflected in the DT description of the IP block or you
   need an interface to tell the PRUSS firmware which event it should map to
   which irq line. Is there actually a value in doing the latter?

Thanks,

	tglx
