From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [RFC 1/1] drivers: i2c: omap: Add slave support
Date: Mon, 17 Oct 2016 08:15:50 +0200
Message-ID: <CAALWOA8_bt8aBM6W3fstHzKFVoo4cybgc5YZLOkjOOSTtmMOSA@mail.gmail.com>
References: <20160525141119.14486-1-rk@ti.com>
 <20160525141119.14486-2-rk@ti.com>
 <20160825171430.GM2856@katana>
 <CAALWOA-XP+mfTcVPc1LZZofAaCK-KtKhFKKKHu2PyHWFrfir3A@mail.gmail.com>
 <20160827172211.GA1601@katana>
 <CAALWOA8mtMAszBv6rcXdMzE_mRrrh-wmn6ECMJ32z4cJcfcOjw@mail.gmail.com>
 <20160828053502.GA1601@katana>
 <20160829034301.GA21292@squirrel.local>
 <ee8779c1-6203-b694-84ac-7f6780eafc79@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ee8779c1-6203-b694-84ac-7f6780eafc79@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ravikumar <rk@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 14 October 2016 at 09:56, Ravikumar <a0131654@ti.com> wrote:
> Dynamic switching on OMAP I2C IP could be a difficult task.

In fact I wouldn't even bother trying. The thread I linked to received
some follow-up by someone wrestling with this and it actually resulted
in the suggestion to use separate master-only and slave-only peripherals
on the same bus just to avoid the horrible race conditions:
https://e2e.ti.com/support/arm/sitara_arm/f/791/p/514961/1990938#1990938


On 14 October 2016 at 10:57, Ravikumar <rk@ti.com> wrote:
>
> On Monday 29 August 2016 09:13 AM, Matthijs van Duin wrote:
>> its irq registers *look* like the usual set { rawstatus, status, en, dis }
>> that's their current standard ("Highlander") for peripherals. They do
>> not however *behave* like the standard set however:
>>    1. status isn't always (rawstatus & enabled)
>>    2. status != 0 does not always imply the irq output is asserted
>>    3. some enable-bits also change the behaviour of rawstatus
>> All of these misbehaviours are unprecedented afaik.
>
> If I understand #1 correctly, you mean that bit value is different in raw vs
> status registers. I've seen some times there was a delay in the value
> reflecting the status register.

I've never seen that myself, in fact how do you even observe that?  I'd
expect such propagation to require at most one cycle, and I don't expect
an irq output would get updated until it does.

> Now #2 and #3 would be crazy, do you have further notes on this?

I'll clarify what I meant.

Normally you can partition the irq bits into two types: level and event.
Level bits reflect some internal status line and cannot be manually set
or cleared.  Handling these involves taking some action to clear the
underlying condition, or disabling its reporting if you no longer care.

Event bits are set by a peripheral when some event occurs, and need to
be manually cleared as part of irq handling.  They can also be manually
set, e.g. for debugging.

The standard irq combiner in modern ("Highlander") TI peripherals can be
modeled roughly by the following code:


#define IRQ_BITS (EVENT_BITS | LEVEL_BITS)

// irq combiner private state
static u32 latched;	// subset of EVENT_BITS
static u32 rawstatus;	// subset of IRQ_BITS
static u32 enabled;	// subset of IRQ_BITS

// signals from peripheral
extern u32 input;	// subset of IRQ_BITS

// irq output signal
bool output;

// propagate signals
void update()
{
	latched |= input & EVENT_BITS;
	rawstatus = latched | input;
	output = !!(rawstatus & enabled);
}

// register interface
u32 read_rawstatus() {  return rawstatus;  }
u32 read_status() {  return rawstatus & enabled;  }
u32 read_enable() {  return enabled;  }
u32 read_disable() {  return enabled;  }
void write_rawstatus(u32 x) {  latched |= x & EVENT_BITS;  update();  }
void write_status(u32 x) {  latched &= ~(x & EVENT_BITS);  update();  }
void write_enable(u32 x) {  enabled |= x & IRQ_BITS;  update();  }
void write_disable(u32 x) {  enabled &= ~(x & IRQ_BITS);  update();  }


(Some variations exist, e.g. u64 instead of u32.)



Now the omap-i2c peripheral's irq combiner looks like this at first
sight, but it violates its semantics in several ways:


#define LEVEL_BITS (BB | ((XUDF | ROVR) & ~enabled))
#define EVENT_BITS (0x7fff & ~BB)
#define IRQ_BITS EVENT_BITS  // BB isn't an irq at all

void update()
{
	latched |= input & EVENT_BITS;
	rawstatus = (latched & ~LEVEL_BITS) | (input & LEVEL_BITS);
	// note: (rawstatus & enabled) == (latched & enabled)
	output = !!(rawstatus & enabled);
}

u32 read_status() {  return rawstatus & (enabled | LEVEL_BITS);  }


Hence:

1. level irqs are visible in status even if not enabled.

2. as direct consequence, read_status() != 0 doesn't necessarily mean
irq output is asserted.

3. when XUDF or ROVR is disabled it shows the level version in both
rawstatus and status.  It is then however still latched, and the latched
version will show up when you enable it.  You can set and clear the
latched bit also when it is disabled (hence invisible).

Also:

4. BB isn't even something reported via irq, what is it doing here?

5. Even though all inputs are latched, some of them are actually level
status signals from the peripheral, which means that to handle them you
have to clear the underlying condition and then additionally clear the
latch.  Very convenient.  XRDY behaves like this in master mode, but is
a normal event (pulsed) in slave mode.  Yay for consistency!

I also have more comments on it in this thread:

https://e2e.ti.com/support/arm/sitara_arm/f/791/p/533394/1966122#1966122

> But, at least the description has been updated on Jacinto 6 device.
>
> I see all 'status' bits are write 1 to clear except for Bus Busy (intended).
>
> While the 'raw' status register bits can not be cleared by writing 1,
> the description says write 1 to set the bit for debug purpose.

That looks like mostly a copy-paste of the documentation of the standard
register interface.  It still appears to be wrong, unless the behaviour
has actually changed since the dm814x.


>> * No ability to selectively ACK/NACK when addressed as slave. If you're
>> unable to respond for some time then you'd end up blocking the bus with
>> clock stretching.  You could temporarily deconfigure your slave address
>> but the TRM states changing slave address is forbidden while bus busy.
>
> Does this lead to bus lock up?

No idea.


Matthijs
