From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3: mmc-twl4030: Free up MMC regulators while
	cleaning up
Date: Thu, 6 Aug 2009 09:48:22 +0300
Message-ID: <20090806064822.GZ7374@atomide.com>
References: <1245762070-13302-1-git-send-email-ext-roger.quadros@nokia.com> <4A79A45F.2090509@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56988 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbZHFGsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 02:48:23 -0400
Content-Disposition: inline
In-Reply-To: <4A79A45F.2090509@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap@vger.kernel.org

* Roger Quadros <ext-roger.quadros@nokia.com> [090805 18:25]:
> Tony,
>
> any comments on this?

Thanks for pinging me, will add it to my omap-fixes queue.

Tony

> regards,
> -roger
>
> ext Roger Quadros wrote:
>> twl_mmc_cleanup() must free up the regulators that were
>> allocated by twl_mmc_late_init().
>> This eliminates the below error when 'omap_hsmmc' module is
>> repeatedly loaded and unloaded.
>>
>> "sysfs: cannot create duplicate filename '/devices/platform
>>  /mmci-omap-hs.0/microamps_requested_vmmc'"
>>
>> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
>> ---
>>  arch/arm/mach-omap2/mmc-twl4030.c |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
>> index 06b252f..0007115 100644
>> --- a/arch/arm/mach-omap2/mmc-twl4030.c
>> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
>> @@ -119,6 +119,7 @@ static int twl_mmc_late_init(struct device *dev)
>>  				if (i != 0)
>>  					break;
>>  				ret = PTR_ERR(reg);
>> +				hsmmc[i].vcc = NULL;
>>  				goto err;
>>  			}
>>  			hsmmc[i].vcc = reg;
>> @@ -165,8 +166,13 @@ done:
>>  static void twl_mmc_cleanup(struct device *dev)
>>  {
>>  	struct omap_mmc_platform_data *mmc = dev->platform_data;
>> +	int i;
>>   	gpio_free(mmc->slots[0].switch_pin);
>> +	for(i = 0; i < ARRAY_SIZE(hsmmc); i++) {
>> +		regulator_put(hsmmc[i].vcc);
>> +		regulator_put(hsmmc[i].vcc_aux);
>> +	}
>>  }
>>   #ifdef CONFIG_PM
>
