From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 01/11] OMAP: GPIO: Modify init() in preparation for platform
 device implementation
Date: Wed, 19 May 2010 10:01:45 +0200
Message-ID: <4BF39AE9.1090107@ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com> <1274194260-16401-2-git-send-email-charu@ti.com> <20100518234100.GU5818@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C5666364@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56411 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab0ESIB6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 04:01:58 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5666364@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On 5/19/2010 9:23 AM, Varadarajan, Charulatha wrote:
>
>> From: Tony Lindgren [mailto:tony@atomide.com]
>> Sent: Wednesday, May 19, 2010 5:11 AM
>>
>> * Charulatha V<charu@ti.com>  [100518 07:44]:
>>> This is in prepartion for implementing GPIO as a platform device.
>>> gpio bank's base addresses are moved from gpio.c to plat/gpio.h.
>>>
>>> This patch also modifies omap_gpio_init() to make use of
>>> omap_gpio_chip_init() and omap_gpio_mod_init(). omap_gpio_mod_init() does
>>> the module init by clearing the status register and initializing the
>>> GPIO control register. omap_gpio_chip_init() initializes the chip request,
>>> free, get, set and other function pointers and sets the gpio irq handler.
>>
>> <snip>
>>
>>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-
>> omap/include/plat/gpio.h
>>> index de7c547..a06acb6 100644
>>> --- a/arch/arm/plat-omap/include/plat/gpio.h
>>> +++ b/arch/arm/plat-omap/include/plat/gpio.h
>>> @@ -29,7 +29,8 @@
>>>   #include<linux/io.h>
>>>   #include<mach/irqs.h>
>>>
>>> -#define OMAP1_MPUIO_BASE			0xfffb5000
>>> +#define OMAP1_MPUIO_BASE		0xfffb5000
>>> +#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
>>>
>>>   #if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
>>>
>>> @@ -62,8 +63,73 @@
>>>   #define OMAP_MPUIO_LATCH		0x34
>>>   #endif
>>>
>>> +/*
>>> + * OMAP1510 GPIO base addresses
>>> + */
>>> +#define OMAP1510_GPIO_BASE		0xfffce000
>>> +#define OMAP1510_IH_GPIO_BASE		64
>>> +
>>> +/*
>>> + * OMAP1610 GPIO base addresses
>>> + */
>>> +#define OMAP1610_GPIO1_BASE		0xfffbe400
>>> +#define OMAP1610_GPIO2_BASE		0xfffbec00
>>> +#define OMAP1610_GPIO3_BASE		0xfffbb400
>>> +#define OMAP1610_GPIO4_BASE		0xfffbbc00
>>> +
>>> +/*
>>> + * OMAP7XX GPIO base addresses
>>> + */
>>> +#define OMAP7XX_GPIO1_BASE		0xfffbc000
>>> +#define OMAP7XX_GPIO2_BASE		0xfffbc800
>>> +#define OMAP7XX_GPIO3_BASE		0xfffbd000
>>> +#define OMAP7XX_GPIO4_BASE		0xfffbd800
>>> +#define OMAP7XX_GPIO5_BASE		0xfffbe000
>>> +#define OMAP7XX_GPIO6_BASE		0xfffbe800
>>
>> Please move these into the mach-omap1/gpio1xxx.c instead,
>> they should not be needed anywhere else. We don't want
>> to have the GPIO registers available in the common headers
>> as otherwise we'll get tons of drivers that suddenly
>> start tinkering with these registers directly..
>>
>>> +/*
>>> + * omap24xx GPIO base addresses
>>> + */
>>> +#define OMAP242X_GPIO1_BASE		0x48018000
>>> +#define OMAP242X_GPIO2_BASE		0x4801a000
>>> +#define OMAP242X_GPIO3_BASE		0x4801c000
>>> +#define OMAP242X_GPIO4_BASE		0x4801e000
>>> +
>>> +#define OMAP243X_GPIO1_BASE		0x4900C000
>>> +#define OMAP243X_GPIO2_BASE		0x4900E000
>>> +#define OMAP243X_GPIO3_BASE		0x49010000
>>> +#define OMAP243X_GPIO4_BASE		0x49012000
>>> +#define OMAP243X_GPIO5_BASE		0x480B6000
>>
>> These should go into mach-omap2/gpioxxxx.c. The same
>> for the others.
>
> They are used in omap_hwmod_xxxx_data.c files. That is why they are
> moved to plat-omap/gpio.h files.
> 1. Instead of having them in common headers, I can move them to mach-omapx/gpio.h.
 > 2. Else, hard code these addresses directly in hwmod data structures 
and avoid
 > moving these definitions to header files.

What was agreed on that is to eventually move all the SoC base address 
in a single header file (omapXXXX.h) that should be used only by the 
omap_hwmod_xxxx_data.c file.

Benoit

