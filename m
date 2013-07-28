From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 21:06:58 +0200
Message-ID: <CAAwP0s2ETdSwmFjh=QJP+LwU+hsBR_KQ0mYGX94BYYfjx3+QVA@mail.gmail.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
 <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
 <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
 <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com>
 <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com>
 <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com> <CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:45360 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab3G1THT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 15:07:19 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so11084594oah.25
        for <linux-omap@vger.kernel.org>; Sun, 28 Jul 2013 12:07:19 -0700 (PDT)
In-Reply-To: <CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Alexander Holler <holler@ahsoftware.de>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

On Sun, Jul 28, 2013 at 8:22 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Jul 28, 2013 at 7:33 PM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:
>
>> According to Documentation/devicetree/bindings/mmc/mmc.txt:
>>
>> cd-gpios: Specify GPIOs for card detection, see gpio binding
>>
>> So it just says that it is a GPIO for card detection and not an IRQ so
>> this assumption comes from either the omap_hsmmc driver or Alexander'
>> DTS is missing something like:
>>
>>                 interrupt-parent = <&gpio6>;
>>                 interrupts = <16 8>;
>>
>> which will call irq_create_of_mapping() and the mapping for the
>> GPIO-IRQ will be created, thus making
>>
>> irq = gpio_to_irq(gpio);
>> request[_threaded]_irq(irq, ...);
>>
>> to succeed.
>
> So if I understand this correctly, the issue is that some out-of-tree,
> i.e. unreviewed DTS files are not following the style of the in-tree
> DTS files, which mandate attributing the consumer drivers with
> interrupts=  and therefore they fail?
>

Yes, that's my understanding of the issue. The fact that it was
working before is that the gpio-omap driver used to call
irq_create_mapping() for all the GPIO in the bank. e.g:

(j = 0; j < bank->width; j++) {
               int irq = irq_create_mapping(bank->domain, j);

But for DT this is wrong since we use the "interrupt-parent" property
to specify the controller to which interrupts are routed (an OMAP GPIO
controller in this case) and defining an "interrupts" property will
make the IRQ core to call irq_create_of_mapping().

So, $subject changes the gpio-omap driver to not do an explicit
irq_create_mapping() call for each GPIO and let the core handle that.

The sequence:

irq = gpio_to_irq(gpio);
request[_threaded]_irq(irq, ...);

only works with $subject reverted because a mapping for *every* GPIO
was created so gpio_to_irq() worked but that is wrong in the DT case
IMHO.

> I don't feel we have an obligation to support any strange DTS
> files out there, and the ones that are in-tree for the reference
> designs should showcase the vast majority of expected
> usecases for DT boots. Else please add more DTS files for
> ever more systems so we get proper coverage, don't be shy :-)
>
> I wish we already had the DTS schema parser and checks
> in place. In that case I could just ask if the DTS is well-formed,
> and you could say "yes" or "no", and if it was no, it's just an
> invalid DTS file.
>
> Yours,
> Linus Walleij

Thanks a lot and best regards,
Javier
