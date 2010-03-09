From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3: GPIO: Added dynamic control logic for pad wakeups
Date: Tue, 9 Mar 2010 09:24:06 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A224FCDB832F@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255695824-17523-1-git-send-email-tero.kristo@nokia.com>
 <873a0awxoj.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29183 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab0CIIYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 03:24:13 -0500
In-Reply-To: <873a0awxoj.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 08 March, 2010 19:06
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] OMAP3: GPIO: Added dynamic control logic 
>for pad wakeups
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Pad wakeups are now enabled if the corresponding GPIO 
>interrupt is enabled.
>>
>> Applies on top of PM branch.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>
>I just discovered this one in patchwork... sorry for the delay.
>
>Changes in wakeup state should not be directly correlated to interrupt
>enabled GPIOs.  Rather, this should only be done for GPIOs that are
>explicitly wakeup enabled (via enable_irq_wake(), which in turn
>calls gpio_wake_enable()).

This logic somehow escapes me... I would guess drivers should not care during dynamic idle whether the device is in off/ret/ina and interrupts should just work. This is done to make this happen. Also, I understood that gpio wakeup logic is needed for the suspend wakeup, which is quite different from dynamic idle wakeup.

However, if this is intended behavior for the kernel, then I will accept it. You are saying the code below should be moved into the gpio_wake_enable() / disable() calls?

>
>A couple other minor comments below...
>
>> ---
>>  arch/arm/plat-omap/gpio.c |   22 +++++++++++++++++++++-
>>  1 files changed, 21 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index e242112..fa79db2 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -267,6 +267,7 @@ static struct gpio_bank gpio_bank_34xx[6] = {
>>  #define OMAP34XX_PAD_SAFE_MODE 0x7
>>  #define OMAP34XX_PAD_IN_PU_GPIO 0x11c
>>  #define OMAP34XX_PAD_IN_PD_GPIO 0x10c
>> +#define OMAP34XX_PAD_WAKE_EN (1 << 14)
>
>Can use BIT(14) here
>
>>  struct omap3_gpio_regs {
>>  	u32 sysconfig;
>> @@ -713,6 +714,8 @@ static inline void 
>set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>>  {
>>  	void __iomem *base = bank->base;
>>  	u32 gpio_bit = 1 << gpio;
>> +	struct gpio_pad *pad;
>> +	int gpio_num;
>>  	u32 val;
>>  
>>  	if (cpu_is_omap44xx()) {
>> @@ -750,6 +753,23 @@ static inline void 
>set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>>  			 * GPIO wakeup request can only be 
>generated on edge
>>  			 * transitions
>>  			 */
>
>The comment above needs to stay with the original code.
>
>> +			pad = gpio_pads;
>> +
>> +			gpio_num = bank->virtual_irq_start - 
>IH_GPIO_BASE +
>> +				gpio;
>> +			/* Find the pad corresponding the GPIO */
>> +			while (pad->gpio >= 0 && pad->gpio != gpio_num)
>> +				pad++;
>> +			/* Enable / disable pad wakeup */
>> +			if (pad->gpio == gpio_num) {
>> +				val = omap_ctrl_readw(pad->offset);
>> +				if (trigger & IRQ_TYPE_EDGE_BOTH)
>> +					val |= OMAP34XX_PAD_WAKE_EN;
>> +				else
>> +					val &= 
>~(u16)OMAP34XX_PAD_WAKE_EN;
>> +				omap_ctrl_writew(val, pad->offset);
>> +			}
>> +
>>  			if (trigger & IRQ_TYPE_EDGE_BOTH)
>>  				__raw_writel(1 << gpio, bank->base
>>  					+ OMAP24XX_GPIO_SETWKUENA);
>> @@ -1654,7 +1674,7 @@ static int __init omap3_gpio_pads_init(void)
>>  	gpio_pads[gpio_amt].gpio = -1;
>>  	return 0;
>>  }
>> -late_initcall(omap3_gpio_pads_init);
>> +early_initcall(omap3_gpio_pads_init);
>
>This change isn't explained in the changelog and appears unrelated to
>this patch.

The reason for this change is that we need the gpio->pad mapping early now to enable wakeups properly. Otherwise some components can enable gpio interrupts early in the boot cycle and they will miss their wakeup setting because the map does not exist yet. I think another way to do this would be to enable wakeups for all enabled interrupts during the omap3_gpio_pads_init().

-Tero
