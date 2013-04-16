From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Tue, 16 Apr 2013 12:40:05 -0600
Message-ID: <516D9B05.1000501@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com> <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com> <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com> <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com> <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com> <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com> <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com> <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com> <CACRpkda4h+qXTvsirPAS7E7sjXhM
 LE62q=VDy53W8UchsYjbNg@mail.gmail.com> <516C31C3.9040505@wwwdotorg.org> <516C73C6.5050409@ti.co m> <516C7C43.3040105@wwwdotorg.org> <516C8760.2050500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44109 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab3DPSkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 14:40:10 -0400
In-Reply-To: <516C8760.2050500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <martinez.javier@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 04/15/2013 05:04 PM, Jon Hunter wrote:
> 
> On 04/15/2013 05:16 PM, Stephen Warren wrote:
>> On 04/15/2013 03:40 PM, Jon Hunter wrote:
...
>>> mmc {
>>> 	label = "pandaboard::status2";
>>>  	gpios = <&gpio1 8 0>;
>>> 	...
>>> };
>>
>> But that's a gpio-leds instance, not an MMC controller... I really
>> really hope there's no DT node using "gpios" to mean "interrupts"... And
>> it wouldn't make any sense for an on-SoC device anyway.
> 
> Oops yes, I overlooked that. However, the omap mmc driver
> (drivers/mmc/host/omap_hsmmc.c) does call gpio_request() and
> request_threaded_irq() for the mmc card-detect interrupt. I believe
> tegra is doing the same ...
> 
> sdhci@78000000 {
> 	...
> 	cd-gpios = <&gpio 69 0>; /* gpio PI5 */
> 	...	
> };

Ah true. I guess at least all MMC drivers are likely hooking cd-gpios as
an interrupt, /and/ requesting it as a GPIO so that they can read the
current state when the GPIO goes off.

That tends to imply that no core code can possibly call gpio_request()
in response to request_irq(), since doing so likely will conflict with
quite a few drivers...

>>> Both these devices are using a gpio as an interrupt source, but the mmc
>>> driver is requesting the gpio directly. In the first case the xlate
>>> function for the gpio irq domain will be called where as it is not used
>>> in the 2nd case. Therefore, we could add a custom xlate function. For
>>> example ...
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>
>>> +int omap_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
>> ...
>>> +       gpio_request_one(irq_to_gpio(bank, intspec[0]), GPIOF_IN, ctrlr->name);
>>
>> I guess that could work, but:
>>
>> a) It still means doing the gpio_request() in each driver instead of
>> centrally.
> 
> Right this is device specific, but it avoids exposing irq_to_gpio for a
> device. However, we could make this generic if we did expose irq_to_gpio
> for each device.
> 
>> b) This approach doesn't solve the issue where some client driver has
>> already requested the GPIO. This code would simply prevent that call
>> from succeeding, which would probably make the driver probe() error out,
>> which isn't any different to the equivalent proposed centralized
>> gpio_request() inside some request_irq() failing, and causing the
>> device's probe() to error out.
> 
> If some driver is calling gpio_request() directly, then they will most
> likely just call gpio_to_irq() when requesting the interrupt and so the
> xlate function would not be called in this case (mmc drivers are a good
> example). So I don't see that as being a problem. In fact that's the
> benefit of this approach as AFAICT it solves this problem.

Oh. That assumption seems very fragile. What about drivers that actually
do have platform data (or DT bindings) that provide both the IRQ and
GPIO IDs, and hence don't use gpio_to_irq()? That's entirely possible.

Given all this, I guess simply having each GPIO+IRQ driver's set_type
function simply do whatever is required in HW to set up that GPIO
actually does seem like the best idea. Admittedly that isn't
centralized, but I'm not sure now that any centralized implementation is
possible, without significant rework of a bunch of drivers. This is what
the Tegra GPIO driver already does, and I think one of the earlier
patches in this thread did exactly that for OMAP IRQs too right?

BTW, just so you know, I'm on vacation for 2 weeks starting Wed
afternoon, so replies will be non-existent or spotty during that time.
