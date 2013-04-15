From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Mon, 15 Apr 2013 15:00:31 -0500
Message-ID: <516C5C5F.4060106@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <512D3AB1.1080202@wwwdotorg.org> <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost> <51391F41.5000303@ti.com> <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com> <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com> <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com> <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com> <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com> <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com> <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com> <51671D7B.5060303@wwwdotorg.org> <CACRpkd
 bf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com> <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com> <516C3076.3000107@wwwdotor!
 g.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60381 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab3DOUAm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Apr 2013 16:00:42 -0400
In-Reply-To: <516C3076.3000107@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 04/15/2013 11:53 AM, Stephen Warren wrote:
> On 04/13/2013 07:35 PM, Javier Martinez Canillas wrote:
> ...
>> Is the following inlined patch [1] what you were thinking that would
>> be the right approach?
> ...
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> ...
>> +static int omap_gpio_irq_request(struct irq_data *d)
>> +{
>> +	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
>> +
>> +	return omap_gpio_request(&bank->chip, d->hwirq);
> 
> If you want the GPIO usage to be known to the GPIO subsystem, then
> wouldn't you call gpio_request() here rather than omap_gpio_request()?
> The above code will certainly do enough so that the OMAP GPIO HW is
> fully enabled as you need, but I thought the idea was to also prevent
> some other code successfully running gpio_request() on that same GPIO?

Also, although omap gpios default to being inputs, we should not assume
that. So may be you should call gpio_request_one() here passing as flags
GPIOF_IN to configure as an input.

Cheers
Jon
