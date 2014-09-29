From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/4] rtc: omap: Update Kconfig for OMAP RTC
Date: Mon, 29 Sep 2014 10:55:32 +0530
Message-ID: <5428ED4C.8030306@ti.com>
References: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com> <1411637529-18289-4-git-send-email-lokeshvutla@ti.com> <20140925151117.GL28045@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140925151117.GL28045@saruman>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 25 September 2014 08:41 PM, Felipe Balbi wrote:
> On Thu, Sep 25, 2014 at 03:02:08PM +0530, Lokesh Vutla wrote:
>> From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
>>
>> RTC is present in AM43xx and DRA7xx also. Updating the
>> same in Kconfig.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
>> ---
>> Changes since v1:
>> 	- New patch
>>  drivers/rtc/Kconfig    | 6 +++---
>>  drivers/rtc/rtc-omap.c | 4 ++--
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index a168e96..b092e2f 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -971,11 +971,11 @@ config RTC_DRV_IMXDI
>>  	   will be called "rtc-imxdi".
>>  
>>  config RTC_DRV_OMAP
>> -	tristate "TI OMAP1"
>> -	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX
>> +	tristate "TI OMAP Real Time Clock"
>> +	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX || SOC_DRA7XX || SOC_AM43XX
> 
> do you mind if we just make this "depends on ARCH_OMAP || ARCH_DAVINCI" ? Pretty much
> every incarnation has this anyway.
Ok..will update it and repost.

Thanks and regards,
Lokesh
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
