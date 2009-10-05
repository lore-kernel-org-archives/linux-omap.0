From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/28] OMAP3: PM: GPIO context save/restore
Date: Mon, 05 Oct 2009 10:35:05 -0700
Message-ID: <87k4z9ycae.fsf@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
	<1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
	<1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
	<4AC7655F.6080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:47875 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbZJERgV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 13:36:21 -0400
Received: by pzk7 with SMTP id 7so3146224pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 10:35:07 -0700 (PDT)
In-Reply-To: <4AC7655F.6080604@gmail.com> (Nishanth Menon's message of "Sat\, 03 Oct 2009 09\:53\:19 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Nishanth Menon <menon.nishanth@gmail.com> writes:

> Kevin Hilman said the following on 10/01/2009 06:58 PM:
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  arch/arm/plat-omap/gpio.c              |   92 ++++++++++++++++++++++++++++++++
>>  arch/arm/plat-omap/include/mach/gpio.h |    3 +-
>>  2 files changed, 94 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index b0c7361..9850ade 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> +
>> +/* restore the required registers of bank 2-6 */
>> +void omap3_gpio_restore_context(void)
>> +{
>> +	int i;
>> +	for (i = 1; i < gpio_bank_count; i++) {
>> +		struct gpio_bank *bank = &gpio_bank[i];
>> +		__raw_writel(gpio_context[i].sysconfig,
>> +				bank->base + OMAP24XX_GPIO_SYSCONFIG);
>> +		__raw_writel(gpio_context[i].irqenable1,
>> +				bank->base + OMAP24XX_GPIO_IRQENABLE1);
>> +		__raw_writel(gpio_context[i].irqenable2,
>> +				bank->base + OMAP24XX_GPIO_IRQENABLE2);
>>   
> do you want to write to the IRQENABLE register even before configuring
> the rest of the registers (such as data direction etc?
> usually my understanding was:
> configure the device,
> enable the irq..

IIUC, the save/restore sequence was taken directly from TI internal
kernels, so I'm not sure of the history there.  Rajendra should speak
to that as the original author of this patch.

That being said, this sequence is being done in the idle path with
interrupts disabled, so by the time interrupts are enabled, the GPIO
banks will be fully configured.

Kevin


