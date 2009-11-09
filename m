From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH V2] [OMAP] GPIO Module disable when all pins are inactive
Date: Mon, 9 Nov 2009 20:45:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB92F9E5@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE3B6A9D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41985 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbZKIPP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 10:15:57 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA9FG0cp005223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 Nov 2009 09:16:02 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA9FFwNM012348
	for <linux-omap@vger.kernel.org>; Mon, 9 Nov 2009 20:45:59 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE3B6A9D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

>> Subject: [PATCH V2] [OMAP] GPIO Module disable when all pins 
>> are inactive
>> 
>> From: Charulatha V <charu@ti.com>
>> 
>> This patch disables a GPIO module when all pins of a GPIO
>> module are inactive (clock gating forced at module level) and
>> enables the module when any gpio in the module is requested.
>> 
>> The module is enabled only when mod_usage indicates that no GPIO
>> in that  module is currently active and the GPIO being requested
>> is the 1st one to be active in that module.
>
>[sp] This para reads quite confusing. The subject talks of disable
>     but this para indicates process for 'enable'.
Shall change the subject to "GPIO module enable/disable".
 
>
>> 
>> Each module would be disabled in omap_gpio_free() API when all
>> GPIOs in a particular module becomes inactive. The module is
>> re-enabled in omap_gpio_request() API when a GPIO is requested
>> from the module that was previously disabled.
>
>> 
>> Since individual GPIO's bookkeeping is introduced automatically
>> in this patch(mod_usage), the same is used in 
>omap_set_gpio_debounce()
>
>[sp] Is book-keeping 'automatically introduced' or added in this
>     patch?
The intention of the patch is not to introduce bookkeeping. But the 
implementation has brought in bookkeeping concept modulewise.
I shall change it to "added" instead of "automatically introduced".

>
>> & omap_set_gpio_debounce_time() APIs to ensure that the gpio being
>> used is actually "requested" prior to being used (Nishant Menon's
>> <nm@ti.com> Suggestion)
>> 
>> Higher layer keeps track of GPIOs individually. This patch
>> introduces bookkeeping information, modulewise in lower layer
>> since disabling clock is done at module level. GPIO module level
>> details are specific to hardware and introducing APIs in higher
>> level layer to handle them might not be correct. Hence GPIO module
>> level information (mod_usage) has to be handled only in
>> low-level layer.
>
>[sp] Again the description seems to be quite confusing between the
>     higher layer and lower layer contexts.
I shall remove the above para and keep it as:
GPIO module level details are specific to hardware and hence introducing
this patch in low level layer (plat-omap/gpio.c).
>
>> 
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> ---
>>  arch/arm/plat-omap/gpio.c |   35 +++++++++++++++++++++++++++++++++++
>>  1 files changed, 35 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index 4c35f9f..5ee6a60 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -199,6 +199,7 @@ struct gpio_bank {
>>  	struct gpio_chip chip;
>>  	struct clk *dbck;
>>  	u32 dbck_enable_mask;
>> +	u32 mod_usage;
>>  };
>>  
>>  #define METHOD_MPUIO		0
>> @@ -691,6 +692,12 @@ void omap_set_gpio_debounce(int gpio, 
>int enable)
>>  	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
>>  #endif
>>  
>> +	if ((cpu_is_omap24xx() || cpu_is_omap34xx() || 
>> cpu_is_omap44xx())
>> +			&& (!(bank->mod_usage & l))) {
>[sp] Is the AND operation really needed?
Yes, inorder to check if this GPIO was "requested" before calling 
omap_set_gpio_debounce
>
>> +		printk(KERN_ERR "GPIO not requested\n");
>> +		return;
>> +	}
>> +
<Snip>
>>  	reg += OMAP4_GPIO_DEBOUNCINGTIME;
>> @@ -1219,6 +1232,16 @@ static int omap_gpio_request(struct 
>> gpio_chip *chip, unsigned offset)
>>  		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
>>  	}
>>  #endif
>> +	if (cpu_is_omap24xx() || cpu_is_omap34xx() || 
>> cpu_is_omap44xx()) {
>> +		u32 ctrl;
>
>[sp] This should move into next "if" where it is used.
Ok.
>
>> +		if (!bank->mod_usage) {
>> +			ctrl = __raw_readl(bank->base + 
<Snip>