From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 07:24:30 +0200
Message-ID: <51F5FC8E.9010007@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <51F529D6.8030809@ahsoftware.de> <CACRpkdYKSMcCe+uNiB2Jbc8GbUwvJxyq+7EiLM-xdOevVRK-wQ@mail.gmail.com> <51F54A98.80601@ahsoftware.de> <CACRpkdYb7jBpZofLn5VLL7pcMdh5P227ZpwYfV2HJAszFwUEig@mail.gmail.com> <CAAwP0s0q6U6MDYBHiA=u3N_3bJ7CXTPKX_A_wwTrWrqj17mH0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:41301 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab3G2F0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 01:26:13 -0400
Received: from eiche.ahsoftware (p57B216E0.dip0.t-ipconnect.de [87.178.22.224])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 3E544423C03C
	for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 07:26:10 +0200 (CEST)
In-Reply-To: <CAAwP0s0q6U6MDYBHiA=u3N_3bJ7CXTPKX_A_wwTrWrqj17mH0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

Am 28.07.2013 20:50, schrieb Javier Martinez Canillas:
> On Sun, Jul 28, 2013 at 8:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sun, Jul 28, 2013 at 6:45 PM, Alexander Holler <holler@ahsoftware.de> wrote:
>>> Am 28.07.2013 18:25, schrieb Linus Walleij:
>>>> On Sun, Jul 28, 2013 at 4:25 PM, Alexander Holler <holler@ahsoftware.de> wrote:
>>>>
>>>>> By the way, if someone decides to touch omap_hsmmc, the driver wrongly
>>>>> assumes that 0 is not a valid IRQ number and it doesn't check if
>>>>> gpio_to_irq() returns a negative value. ;)
>>>>
>>>> Zero *is* *not* a valid IRQ number.
>>>
>>> Where is that mentioned?
>>
>> This has been a major debate in the kernel in recent months, and we are
>> agreed to remove 0 as a valid Linux IRQ number. The fact that up until
>> two years ago the ARM kernel allowed it is a historical artifact.
>>
>> Please see this article for background:
>> http://lwn.net/Articles/470820/
>>
>> Which falls back to this posting from Torvalds:
>> http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-11/7628.html
>>
>>> gpio.txt states:
>>>
>>> ----
>>> Non-error values returned from gpio_to_irq() can be passed to request_irq()
>>> or free_irq().  They will often be stored into IRQ resources for platform
>>
>> While IRQ 0 is not an error, it means that this particular GPIO line
>> does not have an IRQ, or cannot be translated into an IRQ, and
>> should not be passed to request_irq().
>>
>> Patches to the documentation is welcome.
>>
>>> With the new patches gpio_to_irq() returns 0.
>>
>> This is not good. Under which circumstances does that happen?
>>
>>> Documentation/IRQ-domain.txt:
>>> ----
>>> The legacy map should only be used if fixed IRQ mappings must be
>>> supported.  For example, ISA controllers would use the legacy map for
>>> mapping Linux IRQs 0-15 so that existing ISA drivers get the correct IRQ
>>> numbers.
>>> ----
>>>
>>> You see the 0 too?
>>
>> Is OMAP still using the legacy map? I don't think that works
>> on any system utilizing the GIC driver. It is called legacy because
>> it is not supposed to be used :-/
>>
>
> Not anymore, it was changed recently to use the linear domain mapping
> instead in commit ede4d7a5 ("gpio/omap: convert gpio irq domain to
> linear mapping").
>

I don't really care which mapping is in place. I just care if zero is a 
valid IRQ number for the IRQ and related APIs. And I have to assume that 
those APIs don't switch their internal handling because of the irq 
mapping in place.

Of course, having zero as an invalid IRQ number is a handy thing, but I 
just didn't find a place where this is written down. And the usually 
numbering in IT (starting at zero) makes it very likely that zero could 
be valid IRQ number.

> The commit message says Reported-by: Linus Walleij
> <linus.walleij@linaro.org> ;-)
>
>>> Of ourse, I might be wrong, but you just stated that 0 isn't valid, and
>>> I would be happy to find a source for your statement.
>>
>> See above.

Yeah, as usual, some mail, discussion, thread, article or similiar in 
the small internet everyone has memorized in full. ;)

Once, a maintainer refered me to a discussion and commit which happend 
10 years ago and it sounded like I'm a morron because I didn't know that. ;)

Thanks a lot for the article about NO_IRQ, it describes the pit I fell 
into too, very good.

Maybe it might be worth to suggest using/returning NO_IRQ in (new) 
patches instead of zero. That would make it very clear that the value 0 
isn't to be used later.

Regards,

Alexander Holler
