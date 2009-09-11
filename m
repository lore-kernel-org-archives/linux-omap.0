From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH] [ARM] omap: resource: Make resource_refresh() thread
 safe.
Date: Thu, 10 Sep 2009 23:12:38 -0500
Message-ID: <4AA9CE36.3080903@ti.com>
References: <1252019887-4463-1-git-send-email-mike@android.com> <87eiqhkqch.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58494 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbZIKEMt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Sep 2009 00:12:49 -0400
In-Reply-To: <87eiqhkqch.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Mike Chan <mike@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman wrote:
> Mike Chan <mike@android.com> writes:
> 
>> Need to lock the res_mutex when traversing the res_list.
>>
>> Signed-off-by: Mike Chan <mike@android.com>
> 
> Looks good, thanks.

This patch causes a hang for me when transitioning to OFF mode.  This 
was tested on the Android 2.6.29 tree and is 100% reproducible.  The 
moment a user runs 'echo 1 > /sys/power/enable_off_mode' the board hangs 
without any further output.

Reverting the patch allows me to hit OFF mode again.  I haven't yet 
tested this on vanilla 2.6.29 or latest L-O.

Mike

> Pushed to PM branch and pm-2.6.29.
> 
> Kevin
> 
>> ---
>>  arch/arm/plat-omap/resource.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
>> index 25072cd..4631912 100644
>> --- a/arch/arm/plat-omap/resource.c
>> +++ b/arch/arm/plat-omap/resource.c
>> @@ -234,11 +234,13 @@ int resource_refresh(void)
>>  	struct shared_resource *resp = NULL;
>>  	int ret = 0;
>>  
>> +	down(&res_mutex);
>>  	list_for_each_entry(resp, &res_list, node) {
>>  		ret = update_resource_level(resp);
>>  		if (ret)
>>  			break;
>>  	}
>> +	up(&res_mutex);
>>  	return ret;
>>  }
>>  
>> -- 
>> 1.5.4.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

