From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 17 Apr 2013 09:41:35 -0600
Message-ID: <516EC2AF.9090905@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <514CE0AB.6060207@ti.com> <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com> <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com> <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com> <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com> <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com> <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com> <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com> <516C31C3.9040505@wwwdotorg.org> <516C73C6.5050409@ti.co m> <51
 6C7C43.3040105@wwwdotorg.org> <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org> <516DA60A.5070000@ti.com> <516DCCA8.3070108@wwwdotorg.org> <516DDB4D.9020500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43611 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965189Ab3DQPlj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Apr 2013 11:41:39 -0400
In-Reply-To: <516DDB4D.9020500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 04/16/2013 05:14 PM, Jon Hunter wrote:
> 
> On 04/16/2013 05:11 PM, Stephen Warren wrote:
>> On 04/16/2013 01:27 PM, Jon Hunter wrote:
>>>
>>> On 04/16/2013 01:40 PM, Stephen Warren wrote:
>>>> On 04/15/2013 05:04 PM, Jon Hunter wrote:
>> ...
>>>>> If some driver is calling gpio_request() directly, then they will most
>>>>> likely just call gpio_to_irq() when requesting the interrupt and so the
>>>>> xlate function would not be called in this case (mmc drivers are a good
>>>>> example). So I don't see that as being a problem. In fact that's the
>>>>> benefit of this approach as AFAICT it solves this problem.
>>>>
>>>> Oh. That assumption seems very fragile. What about drivers that actually
>>>> do have platform data (or DT bindings) that provide both the IRQ and
>>>> GPIO IDs, and hence don't use gpio_to_irq()? That's entirely possible.
>>>
>>> Right. In the DT case though, if someone does provide the IRQ and GPIO
>>> IDs then at least they would use a different xlate function. Another
>>> option to consider would be defining the #interrupt-cells = <3> where we
>>> would have ...
>>>
>>> cell-#1 --> IRQ domain ID
>>> cell-#2 --> Trigger type
>>> cell-#3 --> GPIO ID
>>>
>>> Then we could have a generic xlate for 3 cells that would also request
>>> the GPIO. Again not sure if people are against a gpio being requested in
>>> the xlate but just an idea. Or given that irq_of_parse_and_map() calls
>>> the xlate, we could have this function call gpio_request() if the
>>> interrupt controller is a gpio and there are 3 cells.
>>
>> I rather dislike this approach since:
>>
>> a) It requires changes to the DT bindings, which are already defined.
>> Admittedly it's backwards-compatible, but still.
>>
>> b) There isn't really any need for the DT to represent this; the
>> GPIO+IRQ driver itself already knows which IRQ ID is which GPIO ID and
>> vice-versa (if the HW has such a concept), so there's no need for the DT
>> to contain this information. This seems like pushing Linux's internal
>> requirements into the design of the DT binding.
> 
> Yes, so the only alternative is to use irq_to_gpio to avoid this.
> 
>> c) I have the feeling that hooking the of_xlate function for this is a
>> bit of an abuse of the function.
> 
> I was wondering about that. So I was grep'ing through the various xlate
> implementations and found this [1]. Also you may recall that in the
> of_dma_simple_xlate() we call the dma_request_channel() to allocate the
> channel, which is very similar. However, I don't wish to get a
> reputation as abusing APIs so would be good to know if this really is
> abuse or not ;-)
> 
> Cheers
> Jon
> 
> [1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/195124
> 

Interesting.

This is really something that the core DT and GPIO and IRQ maintainers
should weigh in on. Hence, changing them from Cc: to To: in this message
and/or adding them.
