From: Pramod <pramod.gurav@ti.com>
Subject: Re: [PATCH] OMAP: Fix compilation warnings
Date: Mon, 4 Oct 2010 14:38:44 +0530
Message-ID: <4CA9999C.4000402@ti.com>
References: <1285913039-2873-1-git-send-email-pramod.gurav@ti.com> <87hbh5aoof.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36768 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824Ab0JDJIh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 05:08:37 -0400
In-Reply-To: <87hbh5aoof.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 01 October 2010 09:30 PM, Kevin Hilman wrote:
> pramod.gurav@ti.com writes:
>
>> From: Pramod Gurav<pramod.gurav@ti.com>
>
> patch is missing
> - more descriptive subject
> - more descriptive changelog (preferably incluing compilation error)
> - signoff (should've been noticed when running checkpatch)
>
> And after the '---', which tree this applies to since it does not apply
> to current l-o master.  In fact, it appears that all these issues have
> already been fixed in l-o master.
>

I was working out of l-o pm branch. Sorry for the confusion!

> Kevin
>
>> ---
>>   arch/arm/mach-omap2/board-omap4panda.c |    2 --
>>   arch/arm/mach-omap2/mux.c              |    2 +-
>>   arch/arm/plat-omap/gpio.c              |    4 ++--
>>   3 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
>> index c03d1d5..96f5bbb 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -274,8 +274,6 @@ static int __init omap4_panda_i2c_init(void)
>>   }
>>   static void __init omap4_panda_init(void)
>>   {
>> -	int status;
>> -
>>   	omap4_panda_i2c_init();
>>   	omap_serial_init();
>>   	omap4_twl6030_hsmmc_init(mmc);
>> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
>> index ab403b2..6c2f8f0 100644
>> --- a/arch/arm/mach-omap2/mux.c
>> +++ b/arch/arm/mach-omap2/mux.c
>> @@ -87,7 +87,7 @@ static char *omap_mux_options;
>>   int __init omap_mux_init_gpio(int gpio, int val)
>>   {
>>   	struct omap_mux_entry *e;
>> -	struct omap_mux *gpio_mux;
>> +	struct omap_mux *gpio_mux = NULL;
>>   	u16 old_mode;
>>   	u16 mux_mode;
>>   	int found = 0;
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index f6c03a7..22f175f 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -2223,7 +2223,7 @@ void omap2_gpio_prepare_for_idle(int power_state)
>>
>>   	for (i = min; i<  gpio_bank_count; i++) {
>>   		struct gpio_bank *bank =&gpio_bank[i];
>> -		u32 l1, l2;
>> +		u32 l1 = 0, l2 = 0;
>>   		int j;
>>
>>   		for (j = 0; j<  hweight_long(bank->dbck_enable_mask); j++)
>> @@ -2291,7 +2291,7 @@ void omap2_gpio_resume_after_idle(void)
>>   		min = 1;
>>   	for (i = min; i<  gpio_bank_count; i++) {
>>   		struct gpio_bank *bank =&gpio_bank[i];
>> -		u32 l, gen, gen0, gen1;
>> +		u32 l = 0, gen, gen0, gen1;
>>   		int j;
>>
>>   		for (j = 0; j<  hweight_long(bank->dbck_enable_mask); j++)

