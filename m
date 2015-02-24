From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] thermal: ti-soc-thermal: bandgap: Fix build warning if
 !CONFIG_PM_SLEEP
Date: Tue, 24 Feb 2015 18:01:23 +0200
Message-ID: <54ECA053.8000809@linaro.org>
References: <1423234546-10458-1-git-send-email-grygorii.strashko@linaro.org> <20150209150106.GB21362@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:43879 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbbBXQB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2015 11:01:27 -0500
Received: by labhv19 with SMTP id hv19so4014016lab.10
        for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2015 08:01:26 -0800 (PST)
In-Reply-To: <20150209150106.GB21362@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Paul Walmsley <paul@pwsan.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org

Hi Rui,

On 02/09/2015 05:01 PM, Nishanth Menon wrote:
> On 16:55-20150206, grygorii.strashko@linaro.org wrote:
>> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>
>> Fix following build warning if CONFIG_PM_SLEEP is not set:
>>
>> drivers/thermal/ti-soc-thermal/ti-bandgap.c:1478:12: warning: 'ti_bandgap_suspend' defined but not used [-Wunused-function]
>>   static int ti_bandgap_suspend(struct device *dev)
>>              ^
>> drivers/thermal/ti-soc-thermal/ti-bandgap.c:1492:12: warning: 'ti_bandgap_resume' defined but not used [-Wunused-function]
>>   static int ti_bandgap_resume(struct device *dev)
>>              ^
>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>> ---
>>   drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>> index 74c0e34..5d46660 100644
>> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>> @@ -1402,7 +1402,7 @@ int ti_bandgap_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> -#ifdef CONFIG_PM
>> +#ifdef CONFIG_PM_SLEEP
>>   static int ti_bandgap_save_ctxt(struct ti_bandgap *bgp)
>>   {
>>   	int i;
>> -- 
>> 1.9.1
>>
> 
> Suggest aligning with Paul as well:
> https://patchwork.kernel.org/patch/5795391/

^Paul Walmsley wrote: Oh, nothing to be confused by, I just missed the
 earlier patch. I withdraw mine.

> 
> Otherwise:
> Acked-by: Nishanth Menon <nm@ti.com>
> 

It looks like this patch is missed in 4.0-rc1, so could it be merged
during rc cycle or you'd like me to resend it?
(I've rechecked - it can be applied on top of Linux 4.0-rc1 without any issues)


-- 
regards,
-grygorii
