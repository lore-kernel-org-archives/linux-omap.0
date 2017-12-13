From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v5 1/8] clocksource: dmtimer: Remove all the exports
Date: Wed, 13 Dec 2017 10:15:27 +0100
Message-ID: <20171213091527.GA18859@lenoch>
References: <1513059137-21593-2-git-send-email-j-keerthy@ti.com>
 <20171212071624.GA3453@lenoch>
 <c6a407a8-41c5-f0fd-931c-a58e7e627c82@ti.com>
 <20171212080134.GA9589@lenoch>
 <9de9b3dc-09f4-d58b-ba5a-60fcb563c665@ti.com>
 <20171212081923.GA10084@lenoch>
 <7c92b0c2-8784-9c14-66b0-a19fe68f08ad@ti.com>
 <20171212170054.GD14441@atomide.com>
 <20171212180317.GB10337@lenoch>
 <20171212182150.GF14441@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212182150.GF14441@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, aaro.koskinen@iki.fi, thierry.reding@gmail.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 12, 2017 at 10:21:50AM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [171212 18:06]:
> > I do not follow. Each general-purpose timer module has its own interrupt line,
> > so claiming that irq directly using request_irq seems enough. Could you
> > explain interrupt controller idea a bit more?
> 
> Well let's assume we have drivers/clocksource/timer-dm.c implement
> an irq controller. Then the pwm driver would just do:
> 
> pwm9: dmtimer-pwm {
> 	compatible = "ti,omap-dmtimer-pwm";
> 	#pwm-cells = <3>;
> 	ti,timers = <&timer9>;
> 	ti,clock-source = <0x00>; /* timer_sys_ck */
> 	interrupts-extended = <&timer9 IRQ_TYPE_SOMETHING>;
> };
> 
> Then you can do whatever you need to in the pwm driver with
> enable_irq/disable_irq + a handler?

That seems to work. Now should we map 1:1 to timer interrupt or
have separate interrupt for match, overflow and capture?
Former would need some more dm_timer_ops to determine interrupt
source, while later would work "automagically" - but I haven't
tested it yet.

> If reading the line status is needed.. Then maybe the GPIO framework
> needs to have hardware timer support instead?

It does not seem OMAP can read event pin value in event capture mode.

> Anyways, just thinking out loud how we could have a Linux generic
> hardware timer framework that drivers like pwm could then use.

I need a bit longer chain:
dmtimer -> pwm -> rc (which calls ir_raw_event_store from interrupt)
Is extending pwm core with interrpt callback the right thing there?
Something like:
(*pulse_captured)(ktime_t width, ktime_t last_edge);

Thank you,
	ladis
