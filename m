From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: dra7-atl-clock: fix a memory leak
Date: Mon, 29 Sep 2014 11:52:21 +0300
Message-ID: <54291DC5.1020907@ti.com>
References: <1410529147-19950-1-git-send-email-t-kristo@ti.com> <5416ABD8.4040906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42586 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbaI2Ivf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2014 04:51:35 -0400
In-Reply-To: <5416ABD8.4040906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

On 09/15/2014 12:05 PM, Peter Ujfalusi wrote:
> On 09/12/2014 04:39 PM, Tero Kristo wrote:
>> of_clk_add_provider makes an internal copy of the parent_names property
>> while its called, thus it is no longer needed after this call and can
>> be freed.
>
> Thanks Tero, indeed this was overlooked in the original driver.
>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied to for-v3.18/ti-clk-driver.

-Tero

>
>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   drivers/clk/ti/clk-dra7-atl.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
>> index 4a65b41..3f9308a 100644
>> --- a/drivers/clk/ti/clk-dra7-atl.c
>> +++ b/drivers/clk/ti/clk-dra7-atl.c
>> @@ -199,6 +199,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
>>
>>   	if (!IS_ERR(clk)) {
>>   		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +		kfree(parent_names);
>>   		return;
>>   	}
>>   cleanup:
>>
>
>

