From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 10 Apr 2013 23:28:01 +0200
Message-ID: <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
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
	<CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
	<515319D5.20105@wwwdotorg.org>
	<CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
	<5155C902.7080207@wwwdotorg.org>
	<CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
	<5165CB9D.1090202@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:46891 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab3DJV2C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 17:28:02 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so1175802ieb.23
        for <linux-omap@vger.kernel.org>; Wed, 10 Apr 2013 14:28:02 -0700 (PDT)
In-Reply-To: <5165CB9D.1090202@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 10, 2013 at 10:29 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/10/2013 12:12 PM, Linus Walleij wrote:

>> If the information is there, whether to convert from IRQ to GPIO
>> or from GPIO to IRQ is a technicality and any order should be
>> feasible in some way?
>
> There isn't always a unique 1:1 mapping between GPIOs and IRQs. Put
> another way, a single GPIO would likely only ever trigger a single IRQ,
> but a single IRQ might easily be triggered by any number of GPIOs. This
> is exactly why the function irq_to_gpio() isn't something one should use
> any more. I think there was an effort to outright remove the API,
> although it doesn't look like that's entirely complete yet. I guess you
> know this given your mentions of problem with gpio_to_irq() later on, so
> I'm not quite sure what your paragraph above was supposed to mean.

So the only reason I'm rambing on about this is that it breaks the
connection between GPIOs and their IRQs and at one point
I percieved it as there was going to be some IRQ -> GPIO lookup,
and it would sneak back in. But now I realize that may have been
supposed to be something local to the driver, in it's irqchip portions
and then it's actually no problem for the kernel at large.

Let's restate: I'm also after something fragile here.

IIUC, it will be possible for a GPIO to be set up as input and used
as an IRQ without the GPIO subsystem knowing it. And it will be
possible for the GPIO subsystem to go in and request the same pin
and set it as output and e.g. bit-bang it. I wonder what happens then.

If the drive code is written in such a way that this will be denied,
I'll soften up, but I'd like to see the code first.

Then the same mistake has to be avoided in all drivers.

And that makes me want to probe for solutions tying them
up in the core so no mistakes can be made.

>> Is it not possible to do this in
>> drivers/gpio/gpiolib-of.c: of_gpiochip_add(), if the DT *know*
>> which GPIOs will be used as plain IRQs? That is the point with
>> the gpio hogs I talk about ...
>
> I suppose that if you modified the device tree bindings (schema
> definitions), you could have every GPIO provider DT node indicate which
> GPIOs were used as IRQs instead. However,
>
> a) This would be an incompatible change to the DT bindings, and they're
> supposed to be a stable ABI; old DTBs should work unmodified with new
> kernels.
>
> b) This would place GPIO usage information in multiple places. Right
> now, GPIO consumers list which GPIO(s) they use. The same goes for IRQs.
> If a GPIO provider started listing which GPIOs were really IRQs, then
> that'd mean configuring each GPIO-as-an-IRQ in two places; once in the
> client node to indicate which IRQ it should hook/register, and once in
> the provider node to indicate that the GPIO is really an IRQ. Two places
> is more hassle for people to implement, and more opportunity for mistakes.

Yeah but the current approach AFAICT isn't exactly safe either.

So I need some more convincing... or code rather, I guess.
If I can't point out the problems I see in a piece of code I guess
I'm just plain wrong :-)

Yours,
Linus Walleij
