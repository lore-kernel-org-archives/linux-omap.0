From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Fri, 26 Apr 2013 16:25:21 -0500
Message-ID: <517AF0C1.60009@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com> <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com> <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com> <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com> <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com> <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com> <516C31C3.9040505@wwwdotorg.org> <516C7C43.3040105@wwwdotorg.org> <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org> <516DA60A.5070000@ti.com> <516DCC
 A8.3070108@wwwdotorg.org> <516DDB4D.9020500@ti.com> <516EC2AF.9090905@wwwdotorg.org> <CACRpkdaOOrooK7kff2Y-7gH6L6m-MsiU7PfHnqBkPpc=tk_iWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47660 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754787Ab3DZVZr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Apr 2013 17:25:47 -0400
In-Reply-To: <CACRpkdaOOrooK7kff2Y-7gH6L6m-MsiU7PfHnqBkPpc=tk_iWA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, Javier Martinez Canillas <martinez.javier@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 04/26/2013 02:27 AM, Linus Walleij wrote:
> On Wed, Apr 17, 2013 at 5:41 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 04/16/2013 05:14 PM, Jon Hunter wrote:
> 
>>>> c) I have the feeling that hooking the of_xlate function for this is a
>>>> bit of an abuse of the function.
>>>
>>> I was wondering about that. So I was grep'ing through the various xlate
>>> implementations and found this [1]. Also you may recall that in the
>>> of_dma_simple_xlate() we call the dma_request_channel() to allocate the
>>> channel, which is very similar. However, I don't wish to get a
>>> reputation as abusing APIs so would be good to know if this really is
>>> abuse or not ;-)
>>>
>>> Cheers
>>> Jon
>>>
>>> [1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/195124
>>
>> Interesting.
>>
>> This is really something that the core DT and GPIO and IRQ maintainers
>> should weigh in on. Hence, changing them from Cc: to To: in this message
>> and/or adding them.
> 
> So I guess it is OK for a driver or DT node to use a GPIO as IRQ
> *only*, and then have the GPIO requested implicitly through the
> xlate function in the irqdomain.
> 
> It's the use cases where one and the same driver tries to use the
> same GPIO line *also* by requesting it using gpio_request()
> that madness starts. In such cases the driver deserves to have
> an error thrown back at it, as it definately knows the GPIO pin
> and can be refactored to use gpio_to_irq() to translate it into
> an IRQ rather than having it implicitly done in the xlate function.
> 
> You will just have to give the xlate function information about which
> GPIOs are used as IRQs only, and only request the GPIO on these.

That should not be necessary. The xlate is only called in the case where
the gpio controller is declared as the interrupt controller in the
device tree source ...

eth@0 {
	compatible = "ks8851";
	...
	interrupt-parent = <&gpio2>;
	interrupts = <2 8>; /* gpio line 34, low triggered */
	...
};

So in the case where you have a driver call gpio_request() and then
request_irq(), in the device tree source, the gpio controller will not
be declared as an interrupt controller. It will just list the gpios ...

sdhci@c8000200 {
	...
	cd-gpios = <&gpio 69 0>; /* gpio PI5 */
	wp-gpios = <&gpio 57 0>; /* gpio PH1 */
	...
};

> And I recently suggested a mechanism to do that, and that is
> what I called GPIO input-hogs, which means that you mark
> (e.g. from the device tree) at probe() of the gpiochip which GPIOs
> will only be used as inputs, so as to generate IRQs.
> 
> This is perfectly OS-neutral information about the how the
> hardware is set up in the system.
> 
> If you only allow these hogges inputs to be translated and
> requested in the xlate function, everything goes smooth.
> 
> It all comes back to this: keep all applicable knowledge in the
> system, so it can make proper decisions, don't try to create
> mechanisms that will half-guess things.

Agreed. However the xlate looks like a good place to request the gpio
without needing to add these "input-hogs" or any other platform code. So
if this is not considered abuse of the xlate, then it seems like an
ideal solution. I have been also implementing a generic xlate so that we
don't need to have a xlate for each platform as well.

Cheers
Jon
