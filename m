From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 10 Apr 2013 14:29:17 -0600
Message-ID: <5165CB9D.1090202@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com> <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org> <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost> <51391F41.5000303@ti.com> <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com> <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com> <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com> <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com> <515319D5.20105@wwwdot
 org.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com> <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58587 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762837Ab3DJU3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 16:29:22 -0400
In-Reply-To: <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 04/10/2013 12:12 PM, Linus Walleij wrote:
> On Fri, Mar 29, 2013 at 6:01 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 03/27/2013 02:55 PM, Linus Walleij wrote:
>>> On Wed, Mar 27, 2013 at 5:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>
>>> This is the case for some SMSC911x clients like the snowball
>>> routing it to a GPIO, whereas I think the RealView and Integrator/CP
>>> has a dedicated IRQ line for it on the FPGA so it's a good example.
>>>
>>> In such cases the right thing to do is for the platform
>>> code populating the platform data with the int irq field, or device tree
>>> core, or whatever piece of code that knows about
>>> the actual GPIO shall start from the GPIO, request it and
>>> then convert it to an IRQ.
>>
>> So board code could easily do that; plenty of opportunity to put
>> whatever custom code is needed right there.
>>
>> For DT core code to do that, we'd need some alternative way of
>> specifying interrupts. That would change the DT bindings for interrupts.
>> I don't think we can do that...
> 
> Sorry, I'm probably not knowledgeable about DT to understand this.
> The information for what GPIO corresponds to what IRQ is
> present in the device tree, is it not?

No, I don't think so. DT treats the IRQ and GPIO numbering spaces as
entirely unrelated things, just like the kernel APIs do.

The fact that some DT nodes (device/drivers) happen to be both GPIO and
IRQ providers (implement gpio_chip and irq_chip) and happen to use the
same numbering scheme for both GPIO and IRQ IDs is purely an
implementation detail within individual drivers (or rather, of specific
DT binding definitions really), and not a general truism.

> If the information is there, whether to convert from IRQ to GPIO
> or from GPIO to IRQ is a technicality and any order should be
> feasible in some way?

There isn't always a unique 1:1 mapping between GPIOs and IRQs. Put
another way, a single GPIO would likely only ever trigger a single IRQ,
but a single IRQ might easily be triggered by any number of GPIOs. This
is exactly why the function irq_to_gpio() isn't something one should use
any more. I think there was an effort to outright remove the API,
although it doesn't look like that's entirely complete yet. I guess you
know this given your mentions of problem with gpio_to_irq() later on, so
I'm not quite sure what your paragraph above was supposed to mean.

> I just can't get the necessity to do it one way preferred over the
> other through my head, sorry...
> 
>>> If it seems like identical boilerplate in every machine we can
>>> simply centralize it to gpiolib. Something like
>>>
>>> int gpio_add_single_irq_resource(struct platform_device *pdev, int
>>> gpio, unsigned flags)
>> ... [code to convert GPIO to IRQ and create IORESOURCE_IRQ from it]
>>
>>> int gpio_populate_irq_resource(struct platform_device *pdev, int gpio,
>>>                               unsigned flags, struct resource *r)
>> ... [code to create IORESOURCE_IRQ from the IRQ]
>>
>> ...
>>> gpio_populate_irq_resource(&ethernet, 17,
>>>      IORESOURCE_IRQ_HIGHEDGE, &ethernet_res[1]);
>>> platform_device_register(&ethernet);
>>>
>>> That populates the device with the single GPIO IRQ from
>>> the GPIO number in a smooth way.
>>>
>>> Of course it has to be done after the GPIO driver is up
>>> and running so may require some other refactoring,
>>> but it should work.
>>
>> That latter issue also somewhat scuppers this approach; then you have to
>> somehow run a bunch of your board file code inter-mixed with various
>> driver probe() calls. That will quickly get nasy.
> 
> No, just use a module_init() for the above code in the board
> file and it will defer just like any other initcall.

Using initcalls to order things is rather fragile. Perhaps it could work
out OK with board files, but it's certainly something that's frowned
upon now for DT-based systems, since deferred probe solves it much more
generally, and without any maintenance issues (e.g. continual
re-shuffling of the initcall order, not having enough initcall levels if
you end up with more dependencies being added, etc.).

>> And it doesn't address how the DT core will know when to call
>> gpio_add_single_irq_resource() vs. gpio_populate_irq_resource() without
>> changing the DT binding for interrupts.
> 
> Is it not possible to do this in
> drivers/gpio/gpiolib-of.c: of_gpiochip_add(), if the DT *know*
> which GPIOs will be used as plain IRQs? That is the point with
> the gpio hogs I talk about ...

I suppose that if you modified the device tree bindings (schema
definitions), you could have every GPIO provider DT node indicate which
GPIOs were used as IRQs instead. However,

a) This would be an incompatible change to the DT bindings, and they're
supposed to be a stable ABI; old DTBs should work unmodified with new
kernels.

b) This would place GPIO usage information in multiple places. Right
now, GPIO consumers list which GPIO(s) they use. The same goes for IRQs.
If a GPIO provider started listing which GPIOs were really IRQs, then
that'd mean configuring each GPIO-as-an-IRQ in two places; once in the
client node to indicate which IRQ it should hook/register, and once in
the provider node to indicate that the GPIO is really an IRQ. Two places
is more hassle for people to implement, and more opportunity for mistakes.
