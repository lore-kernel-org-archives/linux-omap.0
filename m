From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the mcp794xx alarm
 after programming time
Date: Tue, 21 Apr 2015 20:59:15 -0500
Message-ID: <55370073.3060809@ti.com>
References: <1429577494-15087-1-git-send-email-nm@ti.com> <20150421234139.GF8539@piout.net> <5536E433.90103@ti.com> <20150422010925.GH8539@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43668 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756563AbbDVB7y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Apr 2015 21:59:54 -0400
In-Reply-To: <20150422010925.GH8539@piout.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com

On 04/21/2015 08:09 PM, Alexandre Belloni wrote:
> On 21/04/2015 at 18:58:43 -0500, Nishanth Menon wrote :
>>>
>>> Consider the following use case: a platform is setting the RTC alarm
>>> before going to suspend to ram. Before your patch, it may be woken up
>> ^^ precisely what I am trying to solve.
>>
>>> quite quickly, before expected. After your patch, it may never wake at
>>> all.
>>
>> Why is that so? when set alarm is requested for time X, you want
>> interrupt at time X, not an interrupt for previous configured RTC
>> alarm time!
>>
> 
> You expect at least an interrupt.

And you will get an interrupt if the event occurs before the i2c burst
starts. Once the i2cburst does start, you are committing to the new time.

> 
>> If the time X is > the point when ALM0 is programmed, then you will
>> get an interrupt.
>>
> 
> You are eluding my point. What happens if the alarm expires before ALM0
> is programmed? Your system is probably dead because it will never wake
> up.

if the previous alarm does expire before the new alarm is programmed
(before the burst is started), you will get an event - why does this
patch change this? the case you are concerned seem to be the case where
the time you program is in the past at the point when alarm interrupt is
enabled.

Lets see the current behavior(before this patch): time currently
requested is in the past, you are dead anyways. this can happen since
the decision of programming the time is done in userspace(example with
rtcwake) and there are latencies as part of suspend path (file sync)
that can cause the possible cases - consider "rtcwake -s 1" - and for
the moment, lets assume that rtc event is the only wakeup event possible
for the system (to address your point).

a) If the rtcwake progams time before initiating suspend state and prior
to suspend_no_irq is hit event triggers, irq is handled by rtc driver,
and we proceed on to suspend state - but no further irqs can be expected
"dead state"
b) predicted time occurs before suspend_no_irq level is reached, but
before the system actually enters suspend -> event occurs with irq
disabled and depending on smartness of platform code, it can detect that
the wakeup event occurred prior to attempting suspend (hence "dead state")
c) If rtcwake's set_alarm invocation is slowed due to filesystem or
other load activities, the time requested to wakeup is already in the
past, you are in deadstate as the wakeup event has already occurred
prior to entering suspend path.

Note: even with android alarm driver(at least the last time i looked at
it a few years ago), this situation is probably escaping (a), but (b)
and (c) is still real and has to be properly anticipated.

My patch does nothing different to this behavior - only point changed is
*if the previous event does not take place prior to new request being
initiated, then we have to assume that the new time is what we wanted
wakeup event for*. That I strongly believe is necessary.

Point being - using a time for wake attempted to be predicted ahead of
time of suspend path is a a bunch of empirical data analysis - you can
have a dead system today and this code does not change that behavior - I
doubt you can ever get a clean fix without a constant latency.

>> If you get an interrupt (like my screenshot shows) because the new
>> value has not yet been programmed (just because we enabled interrupt
>> before programming time), it is unexpected event and wrong!
>>
>> Another scenario: Take the following time points A < B < C < D
>> we program at time (A), an interrupt for time (C).
>> but at time B, we intiate a new time request for time (D).
>> if we happen to send the first ALM0EN at time C (before programming
>> D), you will generate an interrupt, but before the irq handler can
>> handle (since we are doing burst i2c), we program D which clears the
>> irq status (as can be seen in waveform).
>>
>> This does not make sense for a predictable behavior! Yeah, it will
>> wakeup quickly, but when we go and read irqstatus (ALM0IF), it will be
>> 0 and nothing will get reported to rtc subsystem. So:
>> a) we woke up at a time not requested - this is wrong
>> b) our irq handler has nothing to handle! - this is wrong as well.
>>
>> in short, the behavior you are asking for is quiet the wrong behavior!
>>
> 
> I agree that an unexpected event is wrong but it is still better than a
> dead system. I'm not asking to keep the current behaviour. I'm just
> wanting to try to not introduce another race condition.
> 
> What about setting ALM0MTH to 0x1F before reading the control registers?

Ummm.... why is that any different? In effect, you are just disabling
the compare logic inside the RTC differently and that said, I am not
entirely sure if I want to test the MCP794xx RTL designer's logic with
invalid dates being programmed for month/date etc.. ;)

> You could also read only the first 3 registers as all the others are
> overwritten. And finally, you only need to write 9 bytes instead of 10

True - had noticed that as well. have'nt had time to optimize the path yet.

> (register 0x10 is reserved). While not eliminating it completely, this
> will definitively reduce the race condition window.

Yep - was planning on fixing 10 to 9 - But that is not related to this
patch anyways. I will do that follow on patch next time I get a break :)

yet another patch that I need to do is to check for OSCRUN before
attempting to program time or alarm -> no point in setting time is
oscillator is non-functional even after waiting for oscillator
stabilization time after ST bit is set.. again.. need to do that
separate from this patch.

-- 
Regards,
Nishanth Menon
