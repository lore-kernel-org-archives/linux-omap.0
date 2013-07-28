From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 19:47:27 +0200
Message-ID: <CAAwP0s1u4msPEZ9qiP7y5bxsmLQNVmXugHcu0ePGV1o=B6k9oA@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
 <51F4F973.8000303@ahsoftware.de> <51F529D6.8030809@ahsoftware.de>
 <CACRpkdYKSMcCe+uNiB2Jbc8GbUwvJxyq+7EiLM-xdOevVRK-wQ@mail.gmail.com> <51F54A98.80601@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:54075 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab3G1Rrr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 13:47:47 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so7890085oag.3
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 10:47:47 -0700 (PDT)
In-Reply-To: <51F54A98.80601@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

On Sun, Jul 28, 2013 at 6:45 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 28.07.2013 18:25, schrieb Linus Walleij:
>> On Sun, Jul 28, 2013 at 4:25 PM, Alexander Holler <holler@ahsoftware.de> wrote:
>>
>>> By the way, if someone decides to touch omap_hsmmc, the driver wrongly
>>> assumes that 0 is not a valid IRQ number and it doesn't check if
>>> gpio_to_irq() returns a negative value. ;)
>>
>> Zero *is* *not* a valid IRQ number.
>
> Where is that mentioned?
>
> gpio.txt states:
>
> ----
> Non-error values returned from gpio_to_irq() can be passed to request_irq()
> or free_irq().  They will often be stored into IRQ resources for platform
> ----
>
> With the new patches gpio_to_irq() returns 0.
>

Hi Alexander,

gpio_to_irq() returns 0 because omap_gpio_to_irq() calls
irq_find_mapping() and this does:

if (domain == NULL)
       return 0;

So gpio_to_irq() returning zero means that there isn't a GPIO-IRQ
mapping domain not that the 0 is the virtual IRQ number mapped to this
GPIO.

> Documentation/IRQ-domain.txt:
> ----
> The legacy map should only be used if fixed IRQ mappings must be
> supported.  For example, ISA controllers would use the legacy map for
> mapping Linux IRQs 0-15 so that existing ISA drivers get the correct IRQ
> numbers.
> ----
>
> You see the 0 too?
>
> And while browsing some other source I had the impression zero might be
> a valid irq number too, at least in regard to the IRQ apis. If it's a
> valid IRQ nuber on ARM is something else.
>
> Of ourse, I might be wrong, but you just stated that 0 isn't valid, and
> I would be happy to find a source for your statement.
>
> Alexander Holler
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
