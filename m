From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [RFC PATCH] gpio/omap: Fix IRQ handling for SPARSE_IRQ
Date: Fri, 24 Feb 2012 18:54:58 +0530
Message-ID: <CAC83ZvJ-mCZFYzOPQ177th7qVC9GBrKnB2pL=R3knMktOeau2g@mail.gmail.com>
References: <4F46C1AF.2040201@ti.com>
	<20120223230821.GD18185@atomide.com>
	<4F47623E.5060908@ti.com>
	<CAC83ZvLm-ruk3pMkeLhiyOMAVVnByk9PPWsM40AyPErSqz=dKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:40571 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755195Ab2BXNZA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 08:25:00 -0500
Received: by mail-qy0-f175.google.com with SMTP id o7so481276qcs.34
        for <linux-omap@vger.kernel.org>; Fri, 24 Feb 2012 05:24:59 -0800 (PST)
In-Reply-To: <CAC83ZvLm-ruk3pMkeLhiyOMAVVnByk9PPWsM40AyPErSqz=dKA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

Hi Benoit,

On Fri, Feb 24, 2012 at 4:07 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Fri, Feb 24, 2012 at 3:41 PM, Cousson, Benoit <b-cousson@ti.com> w=
rote:
>> + Tarun
>>
>>
>> On 2/24/2012 12:08 AM, Tony Lindgren wrote:
>>>
>>> * Cousson, Benoit<b-cousson@ti.com> =A0[120223 14:14]:
>>>>
>>>> The GPIO driver is still relying on internal OMAP IRQ defines that
>>>> are not relevant anymore if OMAP is built with SPARSE_IRQ.
>>>
>>>
>>> Great :)
>>>
>>>> Please note that this patch is still RFC, because I do not know
>>>> how to fix properly the ugly cpu_class_is_omap1 and the dependency
>>>> with IH_MPUIO_BASE to detect a MPUIO.
>>>
>>>
>>> Sounds like gpio_to_irq() needs to be set in the
>>> arch/arm/*omap*/gpio*.c then.
>>
>>
>> In fact, after a second thought, that might even work for OMAP1 beca=
use I'm
>> using the proper base (IRQ and GPIO) to convert the IRQ number.
>>
>>
>> static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq=
)
>> {
>>
>> =A0 =A0 =A0 =A0return gpio_irq - bank->irq_base + bank->chip.base;
>> }
>>
>> But it might be good to test it on OMAP1 platform.
>>
>>
>> Tarun,
>>
>> Do you have an OMAP1 board to test that.
> Yes, I will test on OMAP1 board.
I have booted the image on OMAP1 with following change.
I guess bank->irq_base was a typo?

static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
{
        //return gpio_irq - bank->irq_base + bank->chip.base;
        return gpio_irq - bank->virtual_irq_start + bank->chip.base;
}
--
Tarun
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
