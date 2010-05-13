From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 6/7] omap: init the gpio pinmux for mmc
Date: Thu, 13 May 2010 14:02:23 +0800
Message-ID: <4BEB95EF.1050506@windriver.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com> <1271745212-4474-7-git-send-email-stanley.miao@windriver.com> <20100511231306.GM13931@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41155 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab0EMFwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 01:52:23 -0400
In-Reply-To: <20100511231306.GM13931@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, hvaibhav@ti.com, srk@ti.com, anuj.aggarwal@ti.com

Tony Lindgren wrote:
> * Stanley.Miao <stanley.miao@windriver.com> [100419 23:20]:
>   
>> There is two gpio for mmc use, one is for card detecting, another is
>> used for checking write protect. Intialize its pinmux in case the bootloader
>> doesn't set it.
>>
>> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
>> ---
>>  arch/arm/mach-omap2/devices.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>> index 23e4d77..df9c62a 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -591,6 +591,13 @@ static inline void omap_hsmmc_reset(void) {}
>>  static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
>>  			int controller_nr)
>>  {
>> +	if (mmc_controller->slots[0].switch_pin > 0)
>> +		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
>> +					OMAP_PIN_INPUT_PULLUP);
>> +	if (mmc_controller->slots[0].gpio_wp > 0)
>> +		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
>> +					OMAP_PIN_INPUT_PULLUP);
>> +
>>  	if (cpu_is_omap2420() && controller_nr == 0) {
>>  		omap_cfg_reg(H18_24XX_MMC_CMD);
>>  		omap_cfg_reg(H15_24XX_MMC_CLKI);
>>     
>
> The problem I see with this patch is that it attempts to mux
> even for the GPIO pins on the companion chips, such as twl4030.
>
> Got any ideas on how to prevent that?
>   

Hi, Tony,

The gpios on companion chips are greater than OMAP_MAX_GPIO_LINES, they 
are not defined
in mux34xx.c, so omap_mux_init_gpio will do nothing.

However, I will add "if(gpio_wp < OMAP_MAX_GPIO_LINES)" to prevent from 
invoking omap_mux_init_gpio().

Stanley.

> Tony
>
>   

