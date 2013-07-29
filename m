From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 17:23:14 +0530
Message-ID: <51F657AA.6040409@ti.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com> <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com> <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com> <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com> <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com> <CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com> <CAAwP0s2ETdSwmFjh=QJP+LwU+hsBR_KQ0mYGX94BYYfjx3+QVA@mail.gmail.com> <51F60E81.7090103@ahsoftware.de> <CAAwP0s2ZF8_qwkHYTn4RBbMFjzL3otMNcmswsDFC9vXPmnpjwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36524 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030Ab3G2Lxq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 07:53:46 -0400
In-Reply-To: <CAAwP0s2ZF8_qwkHYTn4RBbMFjzL3otMNcmswsDFC9vXPmnpjwg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Alexander Holler <holler@ahsoftware.de>, Linus Walleij <linus.walleij@linaro.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Monday 29 July 2013 01:47 PM, Javier Martinez Canillas wrote:
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
>>>>>                   interrupt-parent = <&gpio6>;
>>>>>                   interrupts = <16 8>;
>>
>>
>> What do the values 16 and 8 mean here? GPIO numbers?
>> And where do I have to place that?
>>
>
> If you look at Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> for the two cells interrupt controllers definition:
>
>    b) two cells
>    ------------
>    The #interrupt-cells property is set to 2 and the first cell defines the
>    index of the interrupt within the controller, while the second cell is used
>    to specify any of the following flags:
>      - bits[3:0] trigger type and level flags
>          1 = low-to-high edge triggered
>          2 = high-to-low edge triggered
>          4 = active high level-sensitive
>          8 = active low level-sensitive
>
> So, the first cell in this example means the 16th GPIO in the omap
> gpio6 controller using the edge/level flag IRQ_TYPE_LEVEL_LOW.
>
>> I've now tried the following:
>>
>> --
>> &mmc1 {
>>          vmmc-supply = <&vmmcsd_fixed>;
>>          status = "okay";
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&mmc1_pins>; /* pinmux for GPIO0__6 */
>>          interrupt-parent = <&gpio0>;
>>          interrupts = <6>;
>>
>>          cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
>>          cd-inverted;
>> };
>> --
>> (the gpio which should be used for the IRQ is GPIO0_6)
>>
>> The result was that the gpio_request() failed with -EBUSY.
>> Then I've commented out that, because it isn't necessary anymore as the
>> gpio should be set as input automatically (as I've understood the commit
>> msg).
>>
>
> Indeed, drivers shouldn't explicitly call gpio_request() when booting
> with DT. This only made sense with legacy boot. So maybe the
> omap_hsmmc driver has not been completely converted to be used with DT
> booting when using the "cd-gpios" property?
>
>> The result was
>>
>> [    1.397100] genirq: Flags mismatch irq 144. 00002003 (mmc0) vs.
>> 00000000 (mmc0)
>>
>> and request_threaded_irq() returned with -EBUSY.
>
> By looking at kernel/irq/manage.c, this error comes from __setup_irq()
> because the same interrupt line is tried to be shared by two users
> with different trigger (edge/level) type flags. Don't know what is
> triggering that with your DTS though.
>
>>
>>
>> To stop that discussion about some "non-standard" dts I'm using (I wonder
>> where the standard is), I try to formulate a clear question:
>>
>> If a driver uses
>> --
>> irq = gpio_to_irq(some_gpio_number);
>> /*
>> gpio_request();
>> gpio_direction_input();
>> */
>> request_threaded_irq(irq);
>> --
>>
>> How should the dts or the driver be changed that this works with 3.11-rc2?
>>
>
> Drivers shouldn't do that IMHO, they should just use IRQ (virtual)
> numbers and request them. Drivers shouldn't care whether it is a GPIO
> line acting as an IRQ number or a real IRQ from an interrupt
> controller.
>
> My understanding is that defining:
>
> interrupt-parent = <&phandle>;
> interrupts = <index type_flags>;
>
> *should* be enough to make the sequence you are mentioning to work.
> Now, you said that this breaks your DTS when using the "cd-gpios"
> property with the omap hsmmc driver. Unfortunately I'm not familiar
> with neither the omap hsmmc driver nor the mmc "cd-gpios" property so
> I can't be of too much help here. I guess Balaji can take a step
> forward here and shed some light on this.
>
> My guess is that it was working on your setup because the omap hsmmc
> driver is handling GPIO-IRQ in the same way that board files do and it
> was not even described in your DTS because support for GPIO-IRQ was
> not really working for DT in OMAP (an explicit call to gpio_request
> had to be made anyways).
>
> So, I would like to first check if this really is a regression (bug)
> introduced by these changes or is an issue with the omap hsmmc driver,
> how it handles the "cd-gpios" binding or your DTS definition and
> reverting the patch-set will just hide the real problem.
>
Hi,

omap_hsmmc received the gpio number from cd-gpios and configured
it for card detect gpio interrupt. omap_hsmmc driver did gpio_request(),
gpio_direction_input() as it was required to do so, as in legacy board
case.

> As I said, I don't mind if these patches are reverted although many
> people (Jon, Santosh, Grant and myself) think that this is the right
> approach and reverting them will break DTS for OMAP boards that are
> already in mainline.

Since cd-gpios dts binding for omap boards is not in mainline,
omap_hsmmc driver can be patched with new binding added.

>
> Yes, it is a PITA that things get broken but is the price of progress
> I think, I'll prefer fixing them than just blindly reverting patches
> because they show hidden issues. If I'm proven to be wrong I'll be
> happy if these patches get reverted though.
>
>> Regards,
>>
>> Alexander Holler
>
> Thanks a lot and best regards,
> Javier
>

