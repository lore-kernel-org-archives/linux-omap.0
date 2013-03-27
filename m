From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 27 Mar 2013 10:09:57 -0600
Message-ID: <515319D5.20105@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com> <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org> <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost> <51391F41.5000303@ti.com> <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com> <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com> <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com> <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:42771 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab3C0QKB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 12:10:01 -0400
In-Reply-To: <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 03/27/2013 07:52 AM, Linus Walleij wrote:
> On Fri, Mar 22, 2013 at 11:52 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>> On 03/22/2013 10:33 AM, Stephen Warren wrote:
>>> On 03/22/2013 02:10 AM, Linus Walleij wrote:
>>>> This is just turning everything on it's head. The normal order of things
>>>> is this sequence for GPIO 14 something like:
>>>>
>>>> gpio_request(14);
>>>> int irq = gpio_to_irq(14);
>>>> request_any_context_irq(irq);
>>>
>>> That doesn't make any sense at all. Drivers don't want to care whether
>>> the IRQ number they receive is a GPIO-that-can-act-like-an-IRQ or a pure
>>> dedicated IRQ input.
>>>
>>> To fully support the model you proprose, a driver would have to:
>>>
>>> if (gpio_is_valid(pdata->gpio)) {
>>>       gpio_request_one(pdata->gpio, GPIOF_IN, "foo irq");
>>>       irq = gpio_to_irq(pdata->gpio);
>>> } else
>>>       irq = pdata->irq;
>>> request_irq(...);
>>>
>>> which means complex code in each driver, plus requiring some indication
>>> in platform data and/or device tree re: whether the IRQ is hosted by a
>>> GPIO or not.
> 
> I suspect the above is just referring to the DT or similar usecases
> (such as ACPI)?
...
> What worries me is changing kernel semantics to fit device tree,
> I think it is better to try to confine this to the drivers/gpio/gpiolib-of.c
> file.

No, this has absolutely noting to do with device tree; the example I
gave above is purely based on platform data.

It's simply that if a device emits an IRQ, there's no reason to assume
that the IRQ is in fact a GPIO. It might be a dedicated IRQ input pin
and not something that gpiolib (or any other GPIO API) knows about.

One possibility:

(Device IRQ output wired into GPIO input on SoC which then generates an
interrupt)

+----------------------------+
| SoC                        |         +--------+
|     IRQ 5 +------+ GPIO 10 | DEV_IRQ | Device |
| GIC <---- | GPIO | <-------|---------|-IRQ    |
|           +------+         |         +--------+
+----------------------------+

Another possibility:

(Device IRQ output wired directly into dedicated IRQ input pin, and that
pin has no GPIO capabilities)

+----------------------------+
| SoC                        |         +--------+
|      IRQ 5                 | DEV_IRQ | Device |
| GIC <----------------------|---------|-IRQ    |
|                            |         +--------+
+----------------------------+

As such, the driver /must/ receive an "int irq" in platform data. If it
received an "int gpio", then there would be no way for the driver to
support boards that routed that interrupt signal to a dedicated IRQ pin
on the SoC, rather than to a GPIO pin that just happened to have
interrupt generation capabilities.

And then, given that irq_to_gpio() isn't semantically possible, there's
no way for the driver to be able to gpio_request() anything, since it
doesn't, can't, and shouldn't know whether there is in fact any GPIO ID
that it should request, let alone what that GPIO ID is.

And finally, even if we ignore dedicated IRQ input pins, and assume that
every IRQ input is really a GPIO, why should the driver be forced to
call both request_irq() and gpio_request(); that's something that should
really be dealt with inside the IRQ subsystem or relevant IRQ driver.
Otherwise, every other driver that uses IRQs has to be burdened with the
code to do that.
