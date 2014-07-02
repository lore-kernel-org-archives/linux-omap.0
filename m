From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: atmel_mxt_ts: defaulting irqflags to IRQF_TRIGGER_FALLING
Date: Wed, 2 Jul 2014 16:19:12 +0530
Message-ID: <53B3E3A8.4070605@ti.com>
References: <53B284AE.3070302@ti.com> <5995217832cc40f5bcf132ac5c6c2546@HQMAIL105.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <5995217832cc40f5bcf132ac5c6c2546@HQMAIL105.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>, Nick Dyer <nick.dyer@itdev.co.uk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 01 July 2014 09:44 PM, Stephen Warren wrote:
> Sekhar Nori wrote at Tuesday, July 01, 2014 3:52 AM:
>> Nick,
>>
>> I have been using your for-next branch to base my development of
>> touchscreen support on TI's DRA7x EVM. With the recent updates,
>> it has worked out great and once I got the configuration right,
>> it was just a question of adding DT data for the platform.
>>
>> Now, there is one problem with Stephen's patch defaulting the irqflags
>> to IRQF_TRIGGER_FALLING. The interrupt controller I am using (ARM GIC)
>> does not seem to support that and the device fails to probe:
> 
> On the Tegra systems I have, IRQF_TRIGGER_FALLING is the correct (or at
> least a valid) choice. That's probably because the Atmel IRQ signal is
> routed to our GPIO controller, which is also an IRQ controller, and then
> "forwarded" up the chain to the GIC, with the polarity the GIC expects.
> 
> If IRQ_TRIGGER_FALLING doesn't work everywhere, then we'll need to add
> some kind of DT property to configure the polarity of the IRQ output.

Yeah, I think so too.

Nick,

If you are going to rebase your branch, will you be able to fold in the
patch in my previous e-mail? Else, I can send a more formal patch to you.

Thanks,
Sekhar

