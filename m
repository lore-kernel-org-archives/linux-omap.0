From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] omapdss: use devm_clk_get()
Date: Wed, 10 Apr 2013 14:07:12 +0530
Message-ID: <516524B8.60205@ti.com>
References: <1365411346-30611-1-git-send-email-archit@ti.com> <51651F25.3020302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44133 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab3DJIiH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 04:38:07 -0400
In-Reply-To: <51651F25.3020302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 10 April 2013 01:43 PM, Tomi Valkeinen wrote:
> On 2013-04-08 11:55, Archit Taneja wrote:
>> Use devm_clk_get() instead of clk_get() for dss, and for outputs hdmi and venc.
>> This reduces reduces code and simplifies error handling.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dss.c  |   18 +++---------------
>>   drivers/video/omap2/dss/hdmi.c |   16 ++--------------
>>   drivers/video/omap2/dss/venc.c |   10 +---------
>>   3 files changed, 6 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
>> index 054c2a2..645b3bc 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -767,13 +767,11 @@ int dss_dpi_select_source(enum omap_channel channel)
>>   static int dss_get_clocks(void)
>>   {
>>   	struct clk *clk;
>> -	int r;
>>
>> -	clk = clk_get(&dss.pdev->dev, "fck");
>> +	clk = devm_clk_get(&dss.pdev->dev, "fck");
>>   	if (IS_ERR(clk)) {
>>   		DSSERR("can't get clock fck\n");
>> -		r = PTR_ERR(clk);
>> -		goto err;
>> +		return PTR_ERR(clk);
>>   	}
>>
>>   	dss.dss_clk = clk;
>> @@ -782,8 +780,7 @@ static int dss_get_clocks(void)
>>   		clk = clk_get(NULL, dss.feat->clk_name);
>>   		if (IS_ERR(clk)) {
>>   			DSSERR("Failed to get %s\n", dss.feat->clk_name);
>> -			r = PTR_ERR(clk);
>> -			goto err;
>> +			return PTR_ERR(clk);
>>   		}
>>   	} else {
>>   		clk = NULL;
>> @@ -792,21 +789,12 @@ static int dss_get_clocks(void)
>>   	dss.dpll4_m4_ck = clk;
>>
>>   	return 0;
>> -
>> -err:
>> -	if (dss.dss_clk)
>> -		clk_put(dss.dss_clk);
>> -	if (dss.dpll4_m4_ck)
>> -		clk_put(dss.dpll4_m4_ck);
>> -
>> -	return r;
>>   }
>
> Why didn't you use devm_clk_get for the dpll4_m4_ck clock also?

clk_get of dpll4_m4_ck isn't tied to a device:

	clk = clk_get(NULL, dss.feat->clk_name);

We can't use devm_clk_get() if we don't tie it to a device, right?

I think the dss.dss_clk clock above is same as the dpll4_m4_ck for all 
OMAPs. We could probably remove the dpll4_m4_clk all together, and use 
dss_clk to get the rate of DSS_FCK coming from PRCM.

Archit

