From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource flags
Date: Thu, 18 Apr 2013 14:17:32 +0200
Message-ID: <CAAwP0s2pvCgQALJb_XcNo3HE_zS9mOjB-ZnGR4yPYR1-ESpaVg@mail.gmail.com>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
 <51633F26.7000400@gmail.com> <516341AF.7030207@wwwdotorg.org>
 <51634B1F.4030408@collabora.co.uk> <516380D7.3060000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41581 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967300Ab3DRMRw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 08:17:52 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so1060436ieb.41
        for <linux-omap@vger.kernel.org>; Thu, 18 Apr 2013 05:17:52 -0700 (PDT)
In-Reply-To: <516380D7.3060000@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Apr 9, 2013 at 4:45 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 04/08/2013 05:56 PM, Javier Martinez Canillas wrote:
>> On 04/09/2013 12:16 AM, Stephen Warren wrote:
>>> On 04/08/2013 04:05 PM, Rob Herring wrote:
>>>> On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
>>>>> According to Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>>>> the "#interrupt-cells" property of an "interrupt-controller" is used
>>>>> to define the number of cells needed to specify a single interrupt.
>>> ...
>>>>> But the type is never returned so it can't be saved on the IRQ struct
>>>>> resource flags member.
>>>>>
>>>>> This means that drivers that need the IRQ type/level flags defined in
>>>>> the DT won't be able to get it.
>>>>
>>>> But the interrupt controllers that need the information should be able
>>>> to get to it via irqd_get_trigger_type. What problem exactly are you
>>>> trying to fix? What driver would use this?
>>>
>>> FYI, that is indeed what I did in sound/soc/codecs/wm8903.c. Thinking
>>> back, I'm not sure if that was the right thing or whether I should have
>>> sent this same patch:-)
>>>
>>
>> Hi Stephen,
>>
>> I'm glad you agree :-)
>>
>> I could change drivers/net/ethernet/smsc/smsc911x.c to get the type flags for
>> the IRQ with irqd_get_trigger_type() but I prefer $subject because:
>
> irqd_get_trigger_type probably is not meant for outside of irqchips.
> Creating an irq_get_irq_type function which takes an irq number would be
> the right function as that does not expose struct irq_data.
>

Hi Rob,

I sent a patch-set a few days ago that adds an irq_get_irq_type()
function [1] as you suggested and this function is used on the
smsc911x driver probe function to get the edge/level flags [2].

It would be great if I can get your feedback on this.

Thanks a lot and best regards,
Javier

[1]: http://permalink.gmane.org/gmane.linux.ports.arm.omap/97117
[2]: http://permalink.gmane.org/gmane.linux.network/265587
