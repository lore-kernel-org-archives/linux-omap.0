From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] i2c-omap: Trigger bus recovery in lockup case
Date: Tue, 3 Oct 2017 16:02:15 +0530
Message-ID: <e9b43138-6c01-bc99-9bac-355823bc0c19@ti.com>
References: <1505403549-12992-1-git-send-email-claudio.foellmi@ergon.ch>
 <9d3e3029-f775-a9aa-8025-badccb699ed8@ti.com>
 <48ddc9bc-2b83-97c9-fbd7-90d4da9f2687@ti.com>
 <0a506277-6c9b-1407-dea3-f9895fdc3e63@ergon.ch>
 <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
 <3778fa75-0327-0c36-1721-e89e23a782b6@ergon.ch>
 <20170929125213.by5mwverw2a47lmo@earth>
 <ad684ace-272a-1e45-f65b-b280be86ffc2@ergon.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <ad684ace-272a-1e45-f65b-b280be86ffc2@ergon.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Claudio Foellmi <claudio.foellmi@ergon.ch>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: "Strashko, Grygorii" <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Friday 29 September 2017 08:47 PM, Claudio Foellmi wrote:
[...]
>>>> I hit a situation where when communicating with a faulty i2c device, the
>>>> last transaction on the bus does not end with proper STOP condition on
>>>> the i2c bus. Since, STOP condition was not detected by IP, Bus Busy will
>>>> remain set even though both SCL and SDA are high. Thus,
>>>> omap_i2c_wait_for_bb() function would end up calling bus recovery. And
>>>> as soon as TMODE is set to 0x3 and ST_EN to 0x1, there is a flood of
>>>> XRDY & RRDY interrupts.
>>>>
>>>> This spurious irqs can be reproduced easily by setting TMODE to 0x3 and
>>>> ST_EN to 0x1 in OMAP_I2C_SYSTEST_REG when both SCL and SDA are high (bus
>>>> is idle) even on AM335x.
>>>>
>>>> So, if you are not seeing irq flood when SCL/SDA is stuck low, then
>>>> maybe its safe to enter TMODE 0x3 in such cases. Could you modify the
>>>> patch to test whether or not SDA is stuck low before initiating bus
>>>> recovery?
>>>>
>>>
>>> This sounds more like a problem with the interrupt handler than with
>>> bus recovery, so I'm a bit hesitant to just add such a workaround.

I would not say its a workaround. As per I2C spec, bus recovery is to be
tried only when SDA is stuck low. My suggestion is to check this
condition before requesting recovery.

>>> Instead, I spent a few hours looking through the interrupt handling
>>> (and poking my i2c bus with a wire to induce random faults), and
>>> I suspect to have found the underlying cause, or at least part of it:
>>>
>>> We sometimes ignore some interrupts (such as RRDY if we think we are
>>> not in receiving mode), but don't really deal with their cause.
>>> As a result, the same interrupt will just be raised again as soon as
>>> we leave the handler. It will then be ignored again, and raised again...
>>>
>>> I'm still not quite sure how we can reliably get into such situations in
>>> the first place, but not sending a stop condition seems to be part of it.
>>> Maybe it is somehow connected to the automatic internal state change
>>> that happens as part of AL or NACK interrupts.
>>>
>>>
>>> Below is a small patch that should test my assumptions.
>>> It clears the incoming fifo and acks the ignored RRDY interrupts.
>>>
>>> Sebastian, can you please check if this helps with your problems on N950?
>>> If it does, I'll turn it into a proper standalone patch.
>>
>> No, it does not. Also no interrupts ignoring messages appearing
>> in dmesg:
>>
>> n950# dmesg | grep -E "48072000.i2c|lp5523x"
>> [    0.791046] omap_i2c 48072000.i2c: bus 1 rev4.4 at 400 kHz
>> [    4.934265] lp5523x 1-0032: reset command sent (no ACK)!
>> [    6.003875] omap_i2c 48072000.i2c: controller timed out
>> [    6.033874] lp5523x 1-0032: device detection err: -110
>> [    6.039154] lp5523x: probe of 1-0032 failed with error -110
>>
> 
> Hi Sebastian
> 
> Thank you for trying it out.
> It seems that your symptoms are quite different from the ones that Vignesh
> described earlier. He had never-ending storms of spurious interrupts
> (which that patch would have addressed), but you don't seem to get
> any interrupts at all. Not even the NACK one, which just looks wrong.
> 
> If you want to still dig deeper, you can enable debug logs for i2c-omap,
> so you can see every single interrupt. But if there are none, I don't see
> what we could possibly do to fix it.
> 
> 
> Vignesh, do you still have access to any of those devices with interrupt
> floods? If so, could you try the previous patch on one of them?

In past, I had tried to ACK all the IRQs instead of ignoring, but that
did not help. Anyway, I tried your patch, but unfortunately that does
not help either. I see interrupts being ignored, but the IRQ flood
continues. Here is the log:
http://pastebin.ubuntu.com/25666141/

> 
> Also note that Sebastian's issue is definitely not caused (or helped)
> by bus recovery, the timeout he sees resets the adapter right away.
> So he is not affected by my original patch either way.
> 
> -- Claudio
> 

-- 
Regards
Vignesh
