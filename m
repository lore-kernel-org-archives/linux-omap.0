From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/28] OMAP3: PM: GPIO context save/restore
Date: Mon, 05 Oct 2009 11:21:45 -0700
Message-ID: <873a5xwvk6.fsf@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
	<1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
	<1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
	<4AC7655F.6080604@gmail.com> <87k4z9ycae.fsf@deeprootsystems.com>
	<4ACA34B0.7080405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:43794 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbZJESW7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 14:22:59 -0400
Received: by pzk7 with SMTP id 7so3183907pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 11:21:47 -0700 (PDT)
In-Reply-To: <4ACA34B0.7080405@ti.com> (Nishanth Menon's message of "Mon\, 5 Oct 2009 13\:02\:24 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 10/05/2009 12:35 PM, the following:
>> Nishanth Menon <menon.nishanth@gmail.com> writes:
>>
>>> Kevin Hilman said the following on 10/01/2009 06:58 PM:
>>>> From: Rajendra Nayak <rnayak@ti.com>
>>>>
>>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>>> ---
>>>>  arch/arm/plat-omap/gpio.c              |   92 ++++++++++++++++++++++++++++++++
>>>>  arch/arm/plat-omap/include/mach/gpio.h |    3 +-
>>>>  2 files changed, 94 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>>>> index b0c7361..9850ade 100644
>>>> --- a/arch/arm/plat-omap/gpio.c
>>>> +++ b/arch/arm/plat-omap/gpio.c
>>>> +
>>>> +/* restore the required registers of bank 2-6 */
>>>> +void omap3_gpio_restore_context(void)
>>>> +{
>>>> +	int i;
>>>> +	for (i = 1; i < gpio_bank_count; i++) {
>>>> +		struct gpio_bank *bank = &gpio_bank[i];
>>>> +		__raw_writel(gpio_context[i].sysconfig,
>>>> +				bank->base + OMAP24XX_GPIO_SYSCONFIG);
>>>> +		__raw_writel(gpio_context[i].irqenable1,
>>>> +				bank->base + OMAP24XX_GPIO_IRQENABLE1);
>>>> +		__raw_writel(gpio_context[i].irqenable2,
>>>> +				bank->base + OMAP24XX_GPIO_IRQENABLE2);
>>>>   
>>> do you want to write to the IRQENABLE register even before configuring
>>> the rest of the registers (such as data direction etc?
>>> usually my understanding was:
>>> configure the device,
>>> enable the irq..
>>
>> IIUC, the save/restore sequence was taken directly from TI internal
>> kernels, so I'm not sure of the history there.  Rajendra should speak
>> to that as the original author of this patch.
>>
>> That being said, this sequence is being done in the idle path with
>> interrupts disabled, so by the time interrupts are enabled, the GPIO
>> banks will be fully configured.
>
> Still troublesome to my amateur eyes. if ENABLE bit is set -it means
> that GPIO block can assert interrupt & as part of the rest of the
> half-baked configuration, there is a possibility of event happening
> (as we configure, there will be intermediate configured state), we do
> not want an event to be set at all. irq_locked state will just ensure
> that my isr will be called/not called - if the events are banked,
> there could be spurious events detected - but again might be a
> theoretical thought here.

I agree that this is potentially troublesome.

However, I hesitated to change this since this sequence has been used
on TI internal kernels as well as the PM branch for a while now.
Until a changed sequence can be tested and patch proposed with test
results, I prefer to keep this one.

Kevin

