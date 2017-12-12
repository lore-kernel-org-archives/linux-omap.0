From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/8] clocksource: dmtimer: Remove all the exports
Date: Tue, 12 Dec 2017 10:21:50 -0800
Message-ID: <20171212182150.GF14441@atomide.com>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <1513059137-21593-2-git-send-email-j-keerthy@ti.com>
 <20171212071624.GA3453@lenoch>
 <c6a407a8-41c5-f0fd-931c-a58e7e627c82@ti.com>
 <20171212080134.GA9589@lenoch>
 <9de9b3dc-09f4-d58b-ba5a-60fcb563c665@ti.com>
 <20171212081923.GA10084@lenoch>
 <7c92b0c2-8784-9c14-66b0-a19fe68f08ad@ti.com>
 <20171212170054.GD14441@atomide.com>
 <20171212180317.GB10337@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212180317.GB10337@lenoch>
Sender: linux-pwm-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, aaro.koskinen@iki.fi, thierry.reding@gmail.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [171212 18:06]:
> On Tue, Dec 12, 2017 at 09:00:54AM -0800, Tony Lindgren wrote:
> > Hmm what do you mean? We don't want to export tons of custom functions from
> > the timers in and then be in trouble when at some point we have a Linux
> > generic hw timer framework. We already had to deal with these custom
> > exports earlier with conversion to multiarch and then again with
> > device tree.
> >
> > For now, it's best to pass the timer information to the pwm driver in
> > platform data. In the long run that will be much easier to deal with than
> > fixing random drivers tinkering with the timer registers directly.
> 
> All that register access would happen only in drivers/clocksource/timer-dm.c?
> So platform data will hold all function pointers needed for event capture
> and the pwm driver will do only interface to pwm framework.

Yes please.

> > Ideally the pwm driver would just do a request_irq from the dmtimer code
> > where dmtimer code would implement an interrupt controller. That would
> > be already most fo the Linux generic hardware timer framework right there :)
> 
> I do not follow. Each general-purpose timer module has its own interrupt line,
> so claiming that irq directly using request_irq seems enough. Could you
> explain interrupt controller idea a bit more?

Well let's assume we have drivers/clocksource/timer-dm.c implement
an irq controller. Then the pwm driver would just do:

pwm9: dmtimer-pwm {
	compatible = "ti,omap-dmtimer-pwm";
	#pwm-cells = <3>;
	ti,timers = <&timer9>;
	ti,clock-source = <0x00>; /* timer_sys_ck */
	interrupts-extended = <&timer9 IRQ_TYPE_SOMETHING>;
};

Then you can do whatever you need to in the pwm driver with
enable_irq/disable_irq + a handler?

If reading the line status is needed.. Then maybe the GPIO framework
needs to have hardware timer support instead?

Anyways, just thinking out loud how we could have a Linux generic
hardware timer framework that drivers like pwm could then use.

Regards,

Tony
