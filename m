From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: omap-device: add missed callback for suspend-to-disk
Date: Wed, 25 Feb 2015 17:52:41 +0200
Message-ID: <54EDEFC9.606@ti.com>
References: <1424873630-6054-1-git-send-email-grygorii.strashko@linaro.org> <20150225154445.GO11056@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43891 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbbBYPxJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 10:53:09 -0500
In-Reply-To: <20150225154445.GO11056@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, grygorii.strashko@linaro.org
Cc: nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-arm-kernel@lists.infradead.org

On 02/25/2015 05:44 PM, Tony Lindgren wrote:
> * grygorii.strashko@linaro.org <grygorii.strashko@linaro.org> [150225 06:17]:
>> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>
>> Add missed callback needed for supporting suspend-to-disk (hibernation) mode.
>
> Is this needed as a fix for the -rc series or are there still
> other missing dependencies?
>

This one is not critical fix.

>
>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>> ---
>>   arch/arm/mach-omap2/omap_device.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
>> index fcd2c9e..345e18e 100644
>> --- a/arch/arm/mach-omap2/omap_device.c
>> +++ b/arch/arm/mach-omap2/omap_device.c
>> @@ -739,6 +739,9 @@ struct dev_pm_domain omap_device_pm_domain = {
>>   		USE_PLATFORM_PM_SLEEP_OPS
>>   		.suspend_noirq = _od_suspend_noirq,
>>   		.resume_noirq = _od_resume_noirq,
>> +		.freeze_noirq = _od_suspend_noirq,
>> +		.thaw_noirq = _od_resume_noirq,
>> +		.restore_noirq = _od_resume_noirq,
>>   	}
>>   };
>>
>> --
>> 1.9.1
>>

regards,
-grygorii
