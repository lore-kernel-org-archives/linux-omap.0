From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: atmel_mxt_ts: defaulting irqflags to IRQF_TRIGGER_FALLING
Date: Wed, 2 Jul 2014 10:25:36 -0700
Message-ID: <CAKdAkRTueVK8ynFR7AJeeJL7SPK60U0EHESeONqqoBF_vXJQxA@mail.gmail.com>
References: <53B284AE.3070302@ti.com>
	<5995217832cc40f5bcf132ac5c6c2546@HQMAIL105.nvidia.com>
	<53B3E3A8.4070605@ti.com>
	<53B3F2F2.90707@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <53B3F2F2.90707@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Stephen Warren <swarren@nvidia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 2, 2014 at 4:54 AM, Nick Dyer <nick.dyer@itdev.co.uk> wrote:
> On 02/07/14 11:49, Sekhar Nori wrote:
>> On Tuesday 01 July 2014 09:44 PM, Stephen Warren wrote:
>>> On the Tegra systems I have, IRQF_TRIGGER_FALLING is the correct (or at
>>> least a valid) choice. That's probably because the Atmel IRQ signal is
>>> routed to our GPIO controller, which is also an IRQ controller, and then
>>> "forwarded" up the chain to the GIC, with the polarity the GIC expects.
>>>
>>> If IRQ_TRIGGER_FALLING doesn't work everywhere, then we'll need to add
>>> some kind of DT property to configure the polarity of the IRQ output.
>>
>> Yeah, I think so too.
>>
>> Nick,
>>
>> If you are going to rebase your branch, will you be able to fold in the
>> patch in my previous e-mail? Else, I can send a more formal patch to you.
>
> Either IRQF_TRIGGER_FALLING or IRQF_TRIGGER_LOW will work with these chips
> (it isn't a question of polarity but whether it's edge- or level-
> triggered). There isn't a sensible default. Atmel prefer IRQF_TRIGGER_LOW,
> however I've seen some IRQ controllers will revert to a polled mode for
> IRQF_TRIGGER_LOW, which kills performance.
>
> So, the sensible course of action seems to be to remove the default
> IRQF_TRIGGER_FALLING in the device tree parsing, and provide a device tree
> parameter for the flags. If you agree, I will sort this out at my end, you
> don't need to send a patch.
>
> I have to leave it in in the case where there is neither static platform
> data, or device tree node, because that is used for some systems, but that
> shouldn't affect either of you.

In this case board code should take care of setting up the interrupt
properly and the driver should simply use 0 as flags in request_irq().
By the way, doesn't generic DT infrastructure already allow specifying
interrupt triggers and sets them up properly?

Thanks.

-- 
Dmitry
