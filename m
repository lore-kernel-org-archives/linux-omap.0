From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap_hsmmc: Add missing probe handler hook
Date: Fri, 2 Oct 2009 14:38:17 -0700
Message-ID: <20091002213816.GT16865@atomide.com>
References: <1254486160-7117-1-git-send-email-ext-roger.quadros@nokia.com> <4AC5F186.9010007@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51389 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbZJBViP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 17:38:15 -0400
Content-Disposition: inline
In-Reply-To: <4AC5F186.9010007@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Roger Quadros <ext-roger.quadros@nokia.com> [091002 05:27]:
> Quadros Roger (EXT-Teleca/Helsinki) wrote:
>> The missing probe handler hook will never probe the driver. Add it back.
>> Fixes broken MMC on OMAP.
>>
>> We use platform_driver_probe() API since omap_hsmmc is not a hot-pluggable
>> device.
>>
>> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
>> ---
>>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 4487cc0..0aecaae 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -2013,7 +2013,7 @@ static struct platform_driver omap_hsmmc_driver = {
>>  static int __init omap_hsmmc_init(void)
>>  {
>>  	/* Register the MMC driver */
>> -	return platform_driver_register(&omap_hsmmc_driver);
>> +	return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_probe);
>>  }
>>   static void __exit omap_hsmmc_cleanup(void)
>
> Tony,
>
>  Since you've already applied my earlier patch (v1), you may used the 
> attached version instead. The attached patch will apply on current head 
> with commit id
>
> 30e0c4a059d83886690381222e14f35540c7f017

Thanks, will update in omap-fixes-testing.

Tony
