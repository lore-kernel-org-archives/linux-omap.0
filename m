From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v8 01/11] OMAP: GPIO: prepare for platform driver
Date: Thu, 9 Dec 2010 22:33:48 +0100
Message-ID: <4D014B3C.7040806@ti.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>	<1290689318-10191-2-git-send-email-charu@ti.com> <8762v292ld.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45747 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab0LIVdx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 16:33:53 -0500
In-Reply-To: <8762v292ld.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>

Salut Kevin,

On 12/9/2010 8:18 PM, Kevin Hilman wrote:
> Hi Charu,
>
> "Varadarajan, Charulatha"<charu@ti.com>  writes:
>
>> Prepare for implementing GPIO as a platform driver.
>>
>> Modifies omap_gpio_init() to make use of omap_gpio_chip_init()
>> and omap_gpio_mod_init(). omap_gpio_mod_init() does the module init
>> by clearing the status register and initializing the GPIO control register.
>> omap_gpio_chip_init() initializes the chip request, free, get, set and
>> other function pointers and sets the gpio irq handler.
>>
>> This is only to reorganize the code so that the "omap gpio platform driver
>> implementation patch" looks cleaner and better to review.
>>
>> Signed-off-by: Charulatha V<charu@ti.com>
>
> I just noticed while testing on 36xx/Zoom3 that GPIO wakeups are no
> longer working after this series.
>
> The problem seems to be that for OMAP2+, this series removed manual
> SYSCONFIG register setting in favor of using omap_hwmod (which is good),
> however some of the SYSCONFIG values, specifically, in the current code,
> the ENAWAKEUP bit was set in each bank, but this is no longer the
> default with omap_hwmod.

That part is strange, because Rajendra did a patch to enable the wakeup 
bit during _omap_hwmod_enable as soon as the idlemode is set to smartidle.

/* If slave port is in SMARTIDLE, also enable wakeup */
if ((sf & SYSC_HAS_SIDLEMODE) && (s_idlemode == HWMOD_IDLEMODE_SMART))
	_enable_wakeup(oh);

The _disable_wakeup is never called, so in theory once it is set, it 
should remain enabled.

Does that mean that this the GPIO is not in smartidle anymore in your case?

Regards,
Benoit

>> -#ifdef CONFIG_ARCH_OMAP2PLUS
>> -		if ((bank->method == METHOD_GPIO_24XX) ||
>> -				(bank->method == METHOD_GPIO_44XX)) {
>> -			static const u32 non_wakeup_gpios[] = {
>> -				0xe203ffc0, 0x08700040
>> -			};
>> -
>> -			if (cpu_is_omap44xx()) {
>> -				__raw_writel(0xffffffff, bank->base +
>> -						OMAP4_GPIO_IRQSTATUSCLR0);
>> -				__raw_writew(0x0015, bank->base +
>> -						OMAP4_GPIO_SYSCONFIG);
>> -				__raw_writel(0x00000000, bank->base +
>> -						 OMAP4_GPIO_DEBOUNCENABLE);
>> -				/*
>> -				 * Initialize interface clock ungated,
>> -				 * module enabled
>> -				 */
>> -				__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
>> -			} else {
>> -				__raw_writel(0x00000000, bank->base +
>> -						OMAP24XX_GPIO_IRQENABLE1);
>> -				__raw_writel(0xffffffff, bank->base +
>> -						OMAP24XX_GPIO_IRQSTATUS1);
>> -				__raw_writew(0x0015, bank->base +
>> -						OMAP24XX_GPIO_SYSCONFIG);
>
> Here bit 2 (ENAWAKEUP) is set, and is not reconfigured anywhere in this
> series.  Same for OMAP4 above.
>
> Here's a quick fix to preserve current functionality (will post
> w/changelog shortly), but it shows that GPIO wakeups were not fully
> tested with this series.  In the future, along with reporting what
> platforms it was testing on, it would be very helpful to include a
> summary of how the series was tested.
>
> Thanks,
>
> Kevin
>
>
>
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 413de18..05a123f 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -75,6 +75,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>   		return -EINVAL;
>   	}
>
> +	omap_hwmod_enable_wakeup(oh);
>   	od = omap_device_build(name, id - 1, oh, pdata,
>   				sizeof(*pdata),	omap_gpio_latency,
>   				ARRAY_SIZE(omap_gpio_latency),

