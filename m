From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 19:33:08 +0200
Message-ID: <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
 <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
 <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
 <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com> <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61649 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab3G1Rd3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 13:33:29 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so11344622oag.33
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 10:33:29 -0700 (PDT)
In-Reply-To: <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Alexander Holler <holler@ahsoftware.de>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Hello,

Being the author of these patches I'm ashamed that they are causing a
regression. I did my best to make sure that it would work on OMAP1 and
OMAP2+ platforms booting with both legacy board files and DT.

Also, I didn't come with this solution in a vacuum. This was deeply
discussed with Jon Hunter, Grant Likely, Jean-Christophe
PLAGNIOL-VILLARD and others on a 90+ emails linux-omap thread [1] and
over IRC in #linaro-kernel channel.

The final agreement was that when a GPIO line is mapped in the IRQ
domain with irq_create_of_mapping(), the core has to take care to
request the GPIO and configure it as input.

But until we have this general solution we have to do it on a per irq
chip driver basis and the less hack-ish solution is to have a custom
.map function handler that request the GPIO used as IRQ.

Now, this assumes that irq_create_of_mapping() will always be called
for all GPIO lines that are going to be used as an IRQ. But this
doesn't seem to be true for the omap_hsmmc driver when the "cd-gpios"
mmc property is used in the omap-mmc device node.

I'm ok if you decide to revert these patches but I think we should do
it with care and be sure that the assumption that a IRQ-GPIO mapping
can happen without an explicit call to irq_create_of_mapping() is
actually true and this is not and issue in the omap_hsmmc driver or
its DT bindings.

According to Documentation/devicetree/bindings/mmc/mmc.txt:

cd-gpios: Specify GPIOs for card detection, see gpio binding

So it just says that it is a GPIO for card detection and not an IRQ so
this assumption comes from either the omap_hsmmc driver or Alexander'
DTS is missing something like:

                interrupt-parent = <&gpio6>;
                interrupts = <16 8>;

which will call irq_create_of_mapping() and the mapping for the
GPIO-IRQ will be created, thus making

irq = gpio_to_irq(gpio);
request[_threaded]_irq(irq, ...);

to succeed.

On Sun, Jul 28, 2013 at 6:29 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Jul 28, 2013 at 4:37 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>
>> I think the default OMAP DT files will continue to work with
>>  these patches applied and mostly doesn't break anything
>> in default configuration.
>
> What does "mostly" mean? Hm hm. OK I feel a little
> bit better about this now...
>

I think Santosh meant that

$ grep cd-gpios arch/arm/boot/dts/omap*

doesn't find any usage of the cd-gpios property so that's why this
issue was not found on my tests.

>> Ofcourse with the DT modification as done
>> by Alexander will expose the issue.
>
> So this is all caused by non-upstream code or
> non-upstream DTS files?
>

It seems so, I'm not familiar with the omap_hsmmc so I'm not sure if
this issue is with Alexander DTS, the omap_hsmmc driver or my
assumption that irq_create_of_mapping() will always be called for GPIO
mapped as IRQ is wrong.

>> I really wanted to have the auto request GPIO supported
>> when used as IRQ line but surely not at expense of
>> breaking the client drivers.
>
> If things are working for the default DTS files in the
> kernel then I am OK with it.
>

It's working with the default DTS afaict. At least I didn't find any
regression with my tests using an OMAP3 and OMAP4 boards and neither
did Enric whose tested-by I have in the patches.

> However moving forward to support the cases that
> Alexander is highlighting, I really really thin we need
> to put the information about taken GPIOs "input-hogs"
> into the gpio DT node.
>

I do agree with you that this information should be added to the DT to
prevent this kind of issues.

> Yours,
> Linus Walleij
> --

Hope this helps...

Thanks a lot and best regards,
Javier
