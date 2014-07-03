From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: atmel_mxt_ts: defaulting irqflags to IRQF_TRIGGER_FALLING
Date: Thu, 3 Jul 2014 11:45:58 +0530
Message-ID: <53B4F51E.5010004@ti.com>
References: <53B284AE.3070302@ti.com> <5995217832cc40f5bcf132ac5c6c2546@HQMAIL105.nvidia.com> <53B3E3A8.4070605@ti.com> <53B3F2F2.90707@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <53B3F2F2.90707@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>, Stephen Warren <swarren@nvidia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 02 July 2014 05:24 PM, Nick Dyer wrote:
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

Sounds good.

> I have to leave it in in the case where there is neither static platform
> data, or device tree node, because that is used for some systems, but that
> shouldn't affect either of you.
> 
> BTW, I do have a set of patches ready to send, once this change is made.

It will be great if you could CC me on that posting so I could test and
ack.

Regards,
Sekhar
