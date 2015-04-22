From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the mcp794xx alarm
 after programming time
Date: Wed, 22 Apr 2015 03:09:25 +0200
Message-ID: <20150422010925.GH8539@piout.net>
References: <1429577494-15087-1-git-send-email-nm@ti.com>
 <20150421234139.GF8539@piout.net>
 <5536E433.90103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5536E433.90103@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-omap@vger.kernel.org

On 21/04/2015 at 18:58:43 -0500, Nishanth Menon wrote :
> > 
> > Consider the following use case: a platform is setting the RTC alarm
> > before going to suspend to ram. Before your patch, it may be woken up
> ^^ precisely what I am trying to solve.
> 
> > quite quickly, before expected. After your patch, it may never wake at
> > all.
> 
> Why is that so? when set alarm is requested for time X, you want
> interrupt at time X, not an interrupt for previous configured RTC
> alarm time!
> 

You expect at least an interrupt.

> If the time X is > the point when ALM0 is programmed, then you will
> get an interrupt.
> 

You are eluding my point. What happens if the alarm expires before ALM0
is programmed? Your system is probably dead because it will never wake
up.

> If you get an interrupt (like my screenshot shows) because the new
> value has not yet been programmed (just because we enabled interrupt
> before programming time), it is unexpected event and wrong!
> 
> Another scenario: Take the following time points A < B < C < D
> we program at time (A), an interrupt for time (C).
> but at time B, we intiate a new time request for time (D).
> if we happen to send the first ALM0EN at time C (before programming
> D), you will generate an interrupt, but before the irq handler can
> handle (since we are doing burst i2c), we program D which clears the
> irq status (as can be seen in waveform).
> 
> This does not make sense for a predictable behavior! Yeah, it will
> wakeup quickly, but when we go and read irqstatus (ALM0IF), it will be
> 0 and nothing will get reported to rtc subsystem. So:
> a) we woke up at a time not requested - this is wrong
> b) our irq handler has nothing to handle! - this is wrong as well.
> 
> in short, the behavior you are asking for is quiet the wrong behavior!
> 

I agree that an unexpected event is wrong but it is still better than a
dead system. I'm not asking to keep the current behaviour. I'm just
wanting to try to not introduce another race condition.

What about setting ALM0MTH to 0x1F before reading the control registers?
You could also read only the first 3 registers as all the others are
overwritten. And finally, you only need to write 9 bytes instead of 10
(register 0x10 is reserved). While not eliminating it completely, this
will definitively reduce the race condition window.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
