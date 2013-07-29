From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 12:27:35 +0200
Message-ID: <51F64397.2090107@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com> <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com> <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com> <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com> <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com> <CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com> <CAAwP0s2ETdSwmFjh=QJP+LwU+hsBR_KQ0mYGX94BYYfjx3+QVA@mail.gmail.com> <51F60E81.7090103@ahsoftware.de> <CAAwP0s2ZF8_qwkHYTn4RBbMFjzL3otMNcmswsDFC9vXPmnpjwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:46970 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab3G2K20 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 06:28:26 -0400
Received: from eiche.ahsoftware (p57B216E0.dip0.t-ipconnect.de [87.178.22.224])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 41633423C272
	for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 12:28:24 +0200 (CEST)
In-Reply-To: <CAAwP0s2ZF8_qwkHYTn4RBbMFjzL3otMNcmswsDFC9vXPmnpjwg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Am 29.07.2013 10:17, schrieb Javier Martinez Canillas:
> Hi Alexander,
> 
> On Mon, Jul 29, 2013 at 8:41 AM, Alexander Holler <holler@ahsoftware.de> wrote:
>> Am 28.07.2013 21:06, schrieb Javier Martinez Canillas:
>>
>>> On Sun, Jul 28, 2013 at 8:22 PM, Linus Walleij <linus.walleij@linaro.org>
>>> wrote:
>>>>
>>>> On Sun, Jul 28, 2013 at 7:33 PM, Javier Martinez Canillas
>>>> <martinez.javier@gmail.com> wrote:
>>>>
>>>>> According to Documentation/devicetree/bindings/mmc/mmc.txt:
>>>>>
>>>>> cd-gpios: Specify GPIOs for card detection, see gpio binding
>>>>>
>>>>> So it just says that it is a GPIO for card detection and not an IRQ so
>>>>> this assumption comes from either the omap_hsmmc driver or Alexander'
>>>>> DTS is missing something like:
>>>>>
>>>>>                  interrupt-parent = <&gpio6>;
>>>>>                  interrupts = <16 8>;
>>
>>
>> What do the values 16 and 8 mean here? GPIO numbers?
>> And where do I have to place that?
>>
> 
> If you look at Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> for the two cells interrupt controllers definition:
> 
>   b) two cells
>   ------------
>   The #interrupt-cells property is set to 2 and the first cell defines the
>   index of the interrupt within the controller, while the second cell is used

I had read that. And there is written, "index of the interrupt". So may
I ask the question how you think people are translating GPIO number to
interrupt index?. And if it's the same, will GPIO0_0 map to IRQ 0 or how
is the magic formular people are supposed to use?

Besides that, the existing standard DTS I've modified into my
"non-standard" dts is arch/arm/boot/dts/am335x-bone.dts.

if you look at the definition of the GPIO bank 0 in
arch/arm/boot/dts/am33xx.dtsi, you see

#interrupt-cells = <1>;

Anyway, thanks for your time, but I don't want to spend more time on
that topic.

Regards,

Alexander Holler
