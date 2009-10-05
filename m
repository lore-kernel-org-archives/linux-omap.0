From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 02/28] OMAP3: PM: GPIO context save/restore
Date: Mon, 5 Oct 2009 13:02:24 -0500
Message-ID: <4ACA34B0.7080405@ti.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>	<1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>	<1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>	<4AC7655F.6080604@gmail.com> <87k4z9ycae.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33486 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180AbZJESDF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Oct 2009 14:03:05 -0400
In-Reply-To: <87k4z9ycae.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

Kevin Hilman had written, on 10/05/2009 12:35 PM, the following:
> Nishanth Menon <menon.nishanth@gmail.com> writes:
> 
>> Kevin Hilman said the following on 10/01/2009 06:58 PM:
>>> From: Rajendra Nayak <rnayak@ti.com>
>>>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> ---
>>>  arch/arm/plat-omap/gpio.c              |   92 ++++++++++++++++++++++++++++++++
>>>  arch/arm/plat-omap/include/mach/gpio.h |    3 +-
>>>  2 files changed, 94 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>>> index b0c7361..9850ade 100644
>>> --- a/arch/arm/plat-omap/gpio.c
>>> +++ b/arch/arm/plat-omap/gpio.c
>>> +
>>> +/* restore the required registers of bank 2-6 */
>>> +void omap3_gpio_restore_context(void)
>>> +{
>>> +	int i;
>>> +	for (i = 1; i < gpio_bank_count; i++) {
>>> +		struct gpio_bank *bank = &gpio_bank[i];
>>> +		__raw_writel(gpio_context[i].sysconfig,
>>> +				bank->base + OMAP24XX_GPIO_SYSCONFIG);
>>> +		__raw_writel(gpio_context[i].irqenable1,
>>> +				bank->base + OMAP24XX_GPIO_IRQENABLE1);
>>> +		__raw_writel(gpio_context[i].irqenable2,
>>> +				bank->base + OMAP24XX_GPIO_IRQENABLE2);
>>>   
>> do you want to write to the IRQENABLE register even before configuring
>> the rest of the registers (such as data direction etc?
>> usually my understanding was:
>> configure the device,
>> enable the irq..
> 
> IIUC, the save/restore sequence was taken directly from TI internal
> kernels, so I'm not sure of the history there.  Rajendra should speak
> to that as the original author of this patch.
> 
> That being said, this sequence is being done in the idle path with
> interrupts disabled, so by the time interrupts are enabled, the GPIO
> banks will be fully configured.
Still troublesome to my amateur eyes. if ENABLE bit is set -it means 
that GPIO block can assert interrupt & as part of the rest of the 
half-baked configuration, there is a possibility of event happening (as 
we configure, there will be intermediate configured state), we do not 
want an event to be set at all. irq_locked state will just ensure that 
my isr will be called/not called - if the events are banked, there could 
be spurious events detected - but again might be a theoretical thought here.

-- 
Regards,
Nishanth Menon
