From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH] [OMAP] GPIO Module disable if all pins inactive
Date: Sat, 24 Oct 2009 09:35:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE5@dbde02.ent.ti.com>
References: <1256313317-24653-1-git-send-email-charu@ti.com>,<4AE24BD7.2040506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33427 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbZJXEFe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Oct 2009 00:05:34 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9O45aMh002618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 23:05:39 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9O45Z4m004076
	for <linux-omap@vger.kernel.org>; Sat, 24 Oct 2009 09:35:36 +0530 (IST)
In-Reply-To: <4AE24BD7.2040506@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>Varadarajan, Charu Latha had written, on 10/23/2009 10:55 AM, the following:
>> From: Charulatha V <charu@ti.com>>
>>
>> This patch disables a GPIO module when all the pins of GPIO
>> module are inactive (clock gating forced at module level) and
>> enables the module when any gpio in the module is requested.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>>
>> ---
>>  arch/arm/plat-omap/gpio.c |   22 ++++++++++++++++++++++
>>  1 files changed, 22 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index cdc2a58..2304a5d 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -194,6 +194,7 @@ struct gpio_bank {
>>        spinlock_t lock;
>>        struct gpio_chip chip;
>>        struct clk *dbck;
>> +     u32 gpio_status;
>please rename this as gpio_usage?
okay

>maybe OMAP1 could also benefit out of this..
>>  };
>> 
>>  #define METHOD_MPUIO         0
>> @@ -1080,6 +1081,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>>  {
>>        struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
>>        unsigned long flags;
>> +     u32 ctrl = 0;
>Remove this to the {} no point in wasting stack space when you dont need
>to + you will generate warning for OMAP1 platforms.
>> 
>>        spin_lock_irqsave(&bank->>lock, flags);
>> 
>> @@ -1097,6 +1099,15 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>>                __raw_writel(__raw_readl(reg) | (1 << offset), reg);
>>        }
>>  #endif
>> +     if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
>> +             if (!bank->>gpio_status) {
>> +                     ctrl = __raw_readl(bank->>base + OMAP24XX_GPIO_CTRL);
>> +                     /* Module is enabled, clocks are not gated */
>> +                     ctrl &= 0xFFFFFFFE;
>> +                     __raw_writel(ctrl, bank->>base + OMAP24XX_GPIO_CTRL);
>> +             }
>> +             bank->>gpio_status |= 1 << offset;
>> +     }
>why do this every time a gpio is enabled? why not do this iff gpio was
>never used before.. how about the following:
The module is enabled only when gpio_status indicates that no GPIO 
in that  module is currently active and the GPIO being requested is the 1st one 
to be active in that module.
Each module would be disabled in free() API when all GPIOs in a particular module 
becomes inactive. The module is re-enabled in request() API when a GPIO is 
requested from the module that was previously disabled.
>if (!bank->>gpio_status && (cpu_is_omap24xx() || cpu_is_omap34xx() ||
>cpu_is_omap44xx())) {
>        u32 ctrl = __raw_readl(bank->>base + OMAP24XX_GPIO_CTRL);
>        /* Module is enabled, clocks are not gated */
>        ctrl &= 0xFFFFFFFE;
>        __raw_writel(ctrl, bank->>base + OMAP24XX_GPIO_CTRL);
>}
>bank->>gpio_status |= 1 << offset;
Why to touch gpio_status if not used (for other than 34xx/24xx/44xx cases)? 
>>        spin_unlock_irqrestore(&bank->>lock, flags);
>> 
>>        return 0;
>> @@ -1106,6 +1117,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>>  {
>>        struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
>>        unsigned long flags;
>> +     u32 ctrl = 0;
>used just once ->> move it to the {} + warning to OMAP1
>> 
>>        spin_lock_irqsave(&bank->>lock, flags);
>>  #ifdef CONFIG_ARCH_OMAP16XX
>> @@ -1123,6 +1135,15 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>>                __raw_writel(1 << offset, reg);
>>        }
>>  #endif
>> +     if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
>> +             bank->>gpio_status &= ~(1 << offset);
>> +             if (!bank->>gpio_status) {
>> +                     ctrl = __raw_readl(bank->>base + OMAP24XX_GPIO_CTRL);
>> +                     /* Module is disabled, clocks are gated */
>> +                     ctrl |= 1;
>> +                     __raw_writel(ctrl, bank->>base + OMAP24XX_GPIO_CTRL);
>> +             }
>> +     }
>how about this:
>        bank->>gpio_status &= ~(1 << offset);
>if (!bank->>gpio_status && (cpu_is_omap24xx() || cpu_is_omap34xx() ||
>cpu_is_omap44xx())) {
>        u32 ctrl = __raw_readl(bank->>base + OMAP24XX_GPIO_CTRL);
>        /* Module is disabled, clocks are gated */
>        ctrl |= 1;
>        __raw_writel(ctrl, bank->>base + OMAP24XX_GPIO_CTRL);
>}
Why to touch gpio_status if not used (for other than 24xx/34xx/44xx cases)? 
>>        _reset_gpio(bank, bank->>chip.base + offset);
>>        spin_unlock_irqrestore(&bank->>lock, flags);
>>  }
>> @@ -1700,6 +1721,7 @@ static int __init _omap_gpio_init(void)
>>                        gpio_count = 32;
>>                }
>>  #endif
>> +             bank->>gpio_status = 0;
>>                /* REVISIT eventually switch from OMAP-specific gpio structs
>>                 * over to the generic ones
>>                 */
