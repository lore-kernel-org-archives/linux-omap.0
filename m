From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 7/7] omap hsmmc: fix the hsmmc driver for am3517.
Date: Thu, 13 May 2010 19:53:13 +0800
Message-ID: <4BEBE829.8020801@windriver.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com> <1271745212-4474-8-git-send-email-stanley.miao@windriver.com> <20100511232656.GO13931@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37264 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758708Ab0EMLnN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 07:43:13 -0400
In-Reply-To: <20100511232656.GO13931@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, hvaibhav@ti.com, srk@ti.com, anuj.aggarwal@ti.com

Tony Lindgren wrote:
> Hi,
>
> Some requests to make this more future proof.
>
> * Stanley.Miao <stanley.miao@windriver.com> [100419 23:20]:
>   
>> AM3517 don't have the register OMAP343X_CONTROL_PBIAS_LITE and the regulators
>> like "vmmc", so we set a noop "set_power" function for it.
>>
>> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
>> ---
>>  arch/arm/mach-omap2/hsmmc.c |   32 ++++++++++++++++++++++++--------
>>  1 files changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
>> index 9ad2295..5f46797 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -139,6 +139,12 @@ static void hsmmc23_before_set_reg(struct device *dev, int slot,
>>  	}
>>  }
>>  
>> +static int am3517_mmc_set_power(struct device *dev, int slot, int power_on,
>> +								int vdd)
>> +{
>> +	return 0;
>> +}
>> +
>>     
>
> Please rename this to nop_mmc_set_power or similar. Other omaps may
> need it too.
>   

Accepted.

>   
>>  static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
>>  
>>  void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>> @@ -150,7 +156,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>>  	if (cpu_is_omap2430()) {
>>  		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
>>  		control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
>> -	} else {
>> +	} else if (!cpu_is_omap3517() && !cpu_is_omap3505()) {
>>  		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
>>  		control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
>>  	}
>>     
>
> Let's get rid of multiple cpu_is_omapxxxx tests please. Could you please
> update this along the lines of something like this:
>
> #define HSMMC_HAS_PBIAS		(1 << 0)
> #define HSMMC_HAS_WHATEVER	(1 << 1)
> ...
>
> 	if (!(cpu_is_omap3517() || cpu_is_omap3505())
> 		mmc->slots[i].features |= HSMMC_HAS_PBIAS;
>   

Accepted.

We can move other features into the variable "features", such as 
"nonremovable", "power_saving".

Stanley.

>   
>> @@ -216,12 +222,25 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>>  		 */
>>  		mmc->slots[0].ocr_mask = c->ocr_mask;
>>  
>> +		if (!cpu_is_omap3517() && !cpu_is_omap3505()) {
>> +			switch (c->mmc) {
>> +			case 1:
>> +				/* on-chip level shifting via PBIAS0/PBIAS1 */
>> +				mmc->slots[0].before_set_reg = hsmmc1_before_set_reg;
>> +				mmc->slots[0].after_set_reg = hsmmc1_after_set_reg;
>> +				break;
>> +			case 2:
>> +			case 3:
>> +				/* off-chip level shifting, or none */
>> +				mmc->slots[0].before_set_reg = hsmmc23_before_set_reg;
>> +				mmc->slots[0].after_set_reg = NULL;
>> +				break;
>> +			}
>> +		} else /* cpu_is_omap3517() || cpu_is_omap3505() */
>> +			mmc->slots[0].set_power = am3517_mmc_set_power;
>> +
>>     
>
> Then you can test for that flag here too. When new omaps get added, it
> just a question of setting the features flags right.
>
> Regards,
>
> Tony
>
>   

