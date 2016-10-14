From: Ravikumar <rk@ti.com>
Subject: Re: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Fri, 14 Oct 2016 14:27:35 +0530
Message-ID: <ee8779c1-6203-b694-84ac-7f6780eafc79@ti.com>
References: <20160525141119.14486-1-rk@ti.com>
 <20160525141119.14486-2-rk@ti.com> <20160825171430.GM2856@katana>
 <CAALWOA-XP+mfTcVPc1LZZofAaCK-KtKhFKKKHu2PyHWFrfir3A@mail.gmail.com>
 <20160827172211.GA1601@katana>
 <CAALWOA8mtMAszBv6rcXdMzE_mRrrh-wmn6ECMJ32z4cJcfcOjw@mail.gmail.com>
 <20160828053502.GA1601@katana> <20160829034301.GA21292@squirrel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160829034301.GA21292@squirrel.local>
Sender: linux-i2c-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Monday 29 August 2016 09:13 AM, Matthijs van Duin wrote:
> On 28 August 2016 at 07:35, Wolfram Sang <wsa@the-dreams.de> wrote:
>> Well, I2C is simple, what could go wrong? :/
> Actually I2C is elegant and *seems* simple, but in all its
> asynchronicity there are actually a surprising number of fine details
> you can trip over.  Maybe that's why so many i2c controllers suck: since
> i2c looks simple enough manufacturers are easily tempted to roll their
> own instead of licensing a good implementation.
>
> Having said that, most of the inconsistency and obnoxiousness of the TI
> I2C controller is not even excusable by that argument.  For example its
> irq registers *look* like the usual set { rawstatus, status, en, dis }
> that's their current standard ("Highlander") for peripherals. They do
> not however *behave* like the standard set however:
>    1. status isn't always (rawstatus & enabled)
>    2. status != 0 does not always imply the irq output is asserted
>    3. some enable-bits also change the behaviour of rawstatus
> All of these misbehaviours are unprecedented afaik.
If I understand #1 correctly, you mean that bit value is different in 
raw vs status registers.
I've seen some times there was a delay in the value reflecting the 
status register.
So I choose to use the raw register.


Now #2 and #3 would be crazy, do you have further notes on this?
If I can reproduce these then I will follow up with the IP/HW team.
> Normally you'd also expect each irq (raw)status bit to either
>    a. be an event, set by hw and can be cleared by software any time, or
>    b. be a level status, unaffected by software attempts to set/clear.
> Again the i2c controller decided this is far too little diversity.

yeah, seems so on dm814x.

But, at least the description has been updated on Jacinto 6 device.

I see all 'status' bits are write 1 to clear except for Bus Busy (intended).

While the 'raw' status register bits can not be cleared by writing 1,
the description says write 1 to set the bit for debug purpose.

>> So, it is possible to make a proper I2C slave with OMAP, but you need
>> to know those 100 gory details?
> Mostly.  There are some limitations such as:
>
> * No ability to selectively ACK/NACK when addressed as slave. If you're
> unable to respond for some time then you'd end up blocking the bus with
> clock stretching.  You could temporarily deconfigure your slave address
> but the TRM states changing slave address is forbidden while bus busy.
Does this lead to bus lock up?
> * According to my notes it always ACKs a General Call and this cannot
> even be stalled using the SBLOCK register.  Since I don't care about GC
> there's no more details in my notes, but if this is true then on any bus
> where GC is used, irq handling will have real-time deadlines to avoid
> losing track of transaction boundaries and misinterpreting data.
>
> Finally, as my first link pointed out, various protocol errors can lock
> up the peripheral's internal state machine.  When operating as slave
> this is basically undetectable: all registers look normal and the
> bus-busy bit will continue to track start/stop, but the peripheral will
> not ACK any slave address anymore until you reset it.
>
> You could argue "well, but that requires bus protocol errors" but it is
> nevertheless a direct violation of the I2C standard:
>
> 	I2C-bus compatible devices must reset their bus logic on receipt
> 	of a START or repeated START condition such that they all
> 	anticipate the sending of a slave address, even if these START
> 	conditions are not positioned according to the proper format.
>
> Also, my testing showed pulsing SDA low on an idle bus sufficed to
> trigger this state.  It needs to pass the glitch filter of course, but
> this filter is implemented by sampling the bus requiring two consecutive
> samples to agree.  Two small glitches with just the right timing would
> therefore suffice.  Rather unlikely for random noise, but having lots of
> signals on your pcb that ultimately derive from the same clock source
> probably makes the odds a lot more favorable.
>
> Matthijs
Thanks for sharing the steps to reproduce.

Regards,
RK
