From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 20:06:06 +0200
Message-ID: <CACRpkdYb7jBpZofLn5VLL7pcMdh5P227ZpwYfV2HJAszFwUEig@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
	<51F529D6.8030809@ahsoftware.de>
	<CACRpkdYKSMcCe+uNiB2Jbc8GbUwvJxyq+7EiLM-xdOevVRK-wQ@mail.gmail.com>
	<51F54A98.80601@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:38952 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab3G1SGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 14:06:06 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so2966577oag.29
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 11:06:06 -0700 (PDT)
In-Reply-To: <51F54A98.80601@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Grant Likely <grant.likely@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Balaji T K <balajitk@ti.com>

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

This has been a major debate in the kernel in recent months, and we are
agreed to remove 0 as a valid Linux IRQ number. The fact that up until
two years ago the ARM kernel allowed it is a historical artifact.

Please see this article for background:
http://lwn.net/Articles/470820/

Which falls back to this posting from Torvalds:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-11/7628.html

> gpio.txt states:
>
> ----
> Non-error values returned from gpio_to_irq() can be passed to request_irq()
> or free_irq().  They will often be stored into IRQ resources for platform

While IRQ 0 is not an error, it means that this particular GPIO line
does not have an IRQ, or cannot be translated into an IRQ, and
should not be passed to request_irq().

Patches to the documentation is welcome.

> With the new patches gpio_to_irq() returns 0.

This is not good. Under which circumstances does that happen?

> Documentation/IRQ-domain.txt:
> ----
> The legacy map should only be used if fixed IRQ mappings must be
> supported.  For example, ISA controllers would use the legacy map for
> mapping Linux IRQs 0-15 so that existing ISA drivers get the correct IRQ
> numbers.
> ----
>
> You see the 0 too?

Is OMAP still using the legacy map? I don't think that works
on any system utilizing the GIC driver. It is called legacy because
it is not supposed to be used :-/

> Of ourse, I might be wrong, but you just stated that 0 isn't valid, and
> I would be happy to find a source for your statement.

See above.

Yours,
Linus Walleij
