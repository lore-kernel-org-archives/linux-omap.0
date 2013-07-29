From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 08:41:05 +0200
Message-ID: <51F60E81.7090103@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com> <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com> <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com> <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com> <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com> <CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com> <CAAwP0s2ETdSwmFjh=QJP+LwU+hsBR_KQ0mYGX94BYYfjx3+QVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:47416 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab3G2Glu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 02:41:50 -0400
Received: from eiche.ahsoftware (p57B216E0.dip0.t-ipconnect.de [87.178.22.224])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 83546423C1E2
	for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 08:41:47 +0200 (CEST)
In-Reply-To: <CAAwP0s2ETdSwmFjh=QJP+LwU+hsBR_KQ0mYGX94BYYfjx3+QVA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Am 28.07.2013 21:06, schrieb Javier Martinez Canillas:
> On Sun, Jul 28, 2013 at 8:22 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sun, Jul 28, 2013 at 7:33 PM, Javier Martinez Canillas
>> <martinez.javier@gmail.com> wrote:
>>
>>> According to Documentation/devicetree/bindings/mmc/mmc.txt:
>>>
>>> cd-gpios: Specify GPIOs for card detection, see gpio binding
>>>
>>> So it just says that it is a GPIO for card detection and not an IRQ so
>>> this assumption comes from either the omap_hsmmc driver or Alexander'
>>> DTS is missing something like:
>>>
>>>                  interrupt-parent = <&gpio6>;
>>>                  interrupts = <16 8>;

What do the values 16 and 8 mean here? GPIO numbers?
And where do I have to place that?

I've now tried the following:

--
&mmc1 {
	vmmc-supply = <&vmmcsd_fixed>;
	status = "okay";
	pinctrl-names = "default";
	pinctrl-0 = <&mmc1_pins>; /* pinmux for GPIO0__6 */
	interrupt-parent = <&gpio0>;
	interrupts = <6>;
	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
	cd-inverted;
};
--
(the gpio which should be used for the IRQ is GPIO0_6)

The result was that the gpio_request() failed with -EBUSY.
Then I've commented out that, because it isn't necessary anymore as the
gpio should be set as input automatically (as I've understood the commit
msg).

The result was

[    1.397100] genirq: Flags mismatch irq 144. 00002003 (mmc0) vs.
00000000 (mmc0)

and request_threaded_irq() returned with -EBUSY.


To stop that discussion about some "non-standard" dts I'm using (I 
wonder where the standard is), I try to formulate a clear question:

If a driver uses
--
irq = gpio_to_irq(some_gpio_number);
/*
gpio_request();
gpio_direction_input();
*/
request_threaded_irq(irq);
--

How should the dts or the driver be changed that this works with 3.11-rc2?

Regards,

Alexander Holler
