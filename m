From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 27 Mar 2013 14:52:46 +0100
Message-ID: <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
	<1329321854-24490-4-git-send-email-b-cousson@ti.com>
	<4F44FA56.7020000@gmail.com>
	<4F44FC37.2000701@ti.com>
	<4F452484.5080503@gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
	<4F47AD08.4030504@ti.com>
	<CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
	<512D39DA.7020306@ti.com>
	<512D3AB1.1080202@wwwdotorg.org>
	<512D3EC2.6050408@ti.com>
	<20130302200524.D230F3E1571@localhost>
	<51391F41.5000303@ti.com>
	<CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
	<CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
	<514C79E1.4090106@wwwdotorg.org>
	<514CE0AB.6060207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:62815 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3C0Nwr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 09:52:47 -0400
Received: by mail-ia0-f170.google.com with SMTP id h8so7427847iaa.15
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 06:52:47 -0700 (PDT)
In-Reply-To: <514CE0AB.6060207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 22, 2013 at 11:52 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> On 03/22/2013 10:33 AM, Stephen Warren wrote:
>> On 03/22/2013 02:10 AM, Linus Walleij wrote:
>>> This is just turning everything on it's head. The normal order of things
>>> is this sequence for GPIO 14 something like:
>>>
>>> gpio_request(14);
>>> int irq = gpio_to_irq(14);
>>> request_any_context_irq(irq);
>>
>> That doesn't make any sense at all. Drivers don't want to care whether
>> the IRQ number they receive is a GPIO-that-can-act-like-an-IRQ or a pure
>> dedicated IRQ input.
>>
>> To fully support the model you proprose, a driver would have to:
>>
>> if (gpio_is_valid(pdata->gpio)) {
>>       gpio_request_one(pdata->gpio, GPIOF_IN, "foo irq");
>>       irq = gpio_to_irq(pdata->gpio);
>> } else
>>       irq = pdata->irq;
>> request_irq(...);
>>
>> which means complex code in each driver, plus requiring some indication
>> in platform data and/or device tree re: whether the IRQ is hosted by a
>> GPIO or not.

I suspect the above is just referring to the DT or similar usecases
(such as ACPI)?

We already have a number of platforms passing IRQ numbers
for something that is actually a GPIO pin but we don't really
know and debugfs doesn't say because they never
issue gpio_request() of the pin. And that's something I
don't like.

Because that is loosing control over the GPIO numberspace
not quite knowing which pin is used and which one isn't
and making these things prone to bugs.

What worries me is changing kernel semantics to fit device tree,
I think it is better to try to confine this to the drivers/gpio/gpiolib-of.c
file.

I'd like OF GPIO code to hog the pin using gpio_request(),
then figure out the IRQ number using gpio_to_irq() and pass
that out when picking an IRQ right out of a GPIO controllers
DT node. And I'd like it to be compulsory exercise to list
that one GPIO line as an input hog when used for just
some IRQ line.

This is what I would want to achieve by the GPIO hog concept.

> I tend to agree with Stephen here. When we had discussed this previously
> you had mentioned about adding a platform function to request the gpio
> [1], but I could see this adding a bunch more platform files when we are
> trying to get rid of all the board-xxx.c files for OMAP. So if you don't
> like the approach suggested by Stephen and implemented by Javier, then
> may be we need to means to request/reserve gpios in the dts as you had
> suggested before [1].
>
> So it seems to me that there are two options at the moment ...
>
> 1. Add a irq_chip request as suggested by Stephen.
> 2. Reserve/request gpios in the dts when registering a gpio chip.

This seems like you need to bring in Grant for a second opinion I'm
getting confused by this now... Paging Alexandre who's doing
the GPIO descriptor refactoring as well.

> [1] http://permalink.gmane.org/gmane.linux.ports.arm.omap/92327

Is there anything wrong with the GPIO hog concept as presented in the
mentioned reply?

+                input-hog-gpios = <4>, <5>;

Would result in these GPIOs being requested, so we can keep
track of them in e.g.  drivers/gpio/gpiolib-of.c, then supply
IRQs from these hogged inputs on demand from drivers.

But with the requirement that they be hogged, so we can keep
track of them, and they show up with some sensible
name in <debugfs>/gpio.

Yours,
Linus Walleij
