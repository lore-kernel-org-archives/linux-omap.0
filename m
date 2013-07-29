From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 13:30:08 +0200
Message-ID: <51F65240.4010308@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com> <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com> <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com> <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com> <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com> <CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com> <CAAwP0s2ETdSwmFjh=QJP+LwU+hsBR_KQ0mYGX94BYYfjx3+QVA@mail.gmail.com> <51F60E81.7090103@ahsoftware.de> <CAAwP0s2ZF8_qwkHYTn4RBbMFjzL3otMNcmswsDFC9vXPmnpjwg@mail.gmail.com> <51F64397.2090107@ahsoftware.de> <2AF86F5A-DEF4-47BD-A08D-7292753A51EC@collabora
 .co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:55914 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab3G2Lb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 07:31:27 -0400
Received: from eiche.ahsoftware (p57B216E0.dip0.t-ipconnect.de [87.178.22.224])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id BA9EE423C03C
	for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 13:31:24 +0200 (CEST)
In-Reply-To: <2AF86F5A-DEF4-47BD-A08D-7292753A51EC@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Am 29.07.2013 13:11, schrieb Javier Martinez Canillas:
> On 29/07/2013, at 12:27, Alexander Holler <holler@ahsoftware.de> wrote:
>
>> Am 29.07.2013 10:17, schrieb Javier Martinez Canillas:
>>> Hi Alexander,
>>>
>>> On Mon, Jul 29, 2013 at 8:41 AM, Alexander Holler <holler@ahsoftware.de> wrote:
>>>> Am 28.07.2013 21:06, schrieb Javier Martinez Canillas:
>>>>
>>>>> On Sun, Jul 28, 2013 at 8:22 PM, Linus Walleij <linus.walleij@linaro.org>
>>>>> wrote:
>>>>>>
>>>>>> On Sun, Jul 28, 2013 at 7:33 PM, Javier Martinez Canillas
>>>>>> <martinez.javier@gmail.com> wrote:
>>>>>>
>>>>>>> According to Documentation/devicetree/bindings/mmc/mmc.txt:
>>>>>>>
>>>>>>> cd-gpios: Specify GPIOs for card detection, see gpio binding
>>>>>>>
>>>>>>> So it just says that it is a GPIO for card detection and not an IRQ so
>>>>>>> this assumption comes from either the omap_hsmmc driver or Alexander'
>>>>>>> DTS is missing something like:
>>>>>>>
>>>>>>>                  interrupt-parent = <&gpio6>;
>>>>>>>                  interrupts = <16 8>;
>>>>
>>>>
>>>> What do the values 16 and 8 mean here? GPIO numbers?
>>>> And where do I have to place that?
>>>
>>> If you look at Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>> for the two cells interrupt controllers definition:
>>>
>>>   b) two cells
>>>   ------------
>>>   The #interrupt-cells property is set to 2 and the first cell defines the
>>>   index of the interrupt within the controller, while the second cell is used
>>
>> I had read that. And there is written, "index of the interrupt". So may
>> I ask the question how you think people are translating GPIO number to
>> interrupt index?. And if it's the same, will GPIO0_0 map to IRQ 0 or how
>> is the magic formular people are supposed to use?
>>
>
> Yes, the GPIO-IRQ is a especial case since the chip is both a GPIO and a IRQ controller. In this context the "index of the interrupt" is the physical index of the GPIO line within that GPIO bank. Since each OMAP GPIO bank has 32 GPIO lines, in this example, gpio6 + 16 = GPIO 176.
>
> You define the hardware interrupt (GPIO line in this case) but that is not what drivers see, they see the virtual IRQ number mapped to the hardware IRQ which is just a cookie and the actual number depends on what GPIO to IRQ domain mapping is being used.
>
>> Besides that, the existing standard DTS I've modified into my
>> "non-standard" dts is arch/arm/boot/dts/am335x-bone.dts.
>>
>> if you look at the definition of the GPIO bank 0 in
>> arch/arm/boot/dts/am33xx.dtsi, you see
>>
>> #interrupt-cells = <1>;
>>
>
> Yes, that's probably because no one is using the edge/level flags on am33xx but that is a bug and has to be changed to #interrupt-cells = <2>
>
> This has been fixed recently for omap3.dtsi recently too.
>
>> Anyway, thanks for your time, but I don't want to spend more time on
>> that topic.
>>
>
> Thanks a lot for your time and sorry for the inconvenience. It seems these patches are going to be reverted anyways since it causes another regression on older OMAP1 platforms so you probably can forget about this issue.

Hopefully I'm not the reason for the revert. I don't want to block new 
approaches and it seems to make sense to not map an irq for every 
possible gpio. I've just tried to dig out how one is supposed to use the 
new feature with existing drivers which do use gpio_to_irq().

>
> A different "GPIO hogs" approach will be used to pre-define which GPIO are going to be used as IRQ so the core can request them and setup as input.
>
> I expect you will have the same issue with this new approach though since the omap hsmmc driver will try to call gpio_request() on a previously requested GPIO.
>
> So I think the driver has to be changed independently of the approach for auto request GPIO used.

Maybe, but that isn't much effort. I had done that in 3 minutes (ok, 
without the would be necessary #ifdef CONFIG_OF_GPIO). But you have a 
chicken and egg situation here, because you can't change drivers without 
the new patch and you can't introduce the new patch without changes to 
drivers.

As I had mentioned before, another approach could be to map the irq when 
gpio_to_irq() is called. I think that would be downward compatible 
without the need for some changes in a dts.

Regards,

Alexander Holler
