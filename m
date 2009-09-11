From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] [ARM] omap: resource: Make resource_refresh() thread safe.
Date: Fri, 11 Sep 2009 14:10:37 -0700
Message-ID: <87ws455gs2.fsf@deeprootsystems.com>
References: <1252019887-4463-1-git-send-email-mike@android.com>
	<87eiqhkqch.fsf@deeprootsystems.com> <4AA9CE36.3080903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:46599 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbZIKVKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 17:10:36 -0400
Received: by pxi27 with SMTP id 27so1078866pxi.15
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 14:10:39 -0700 (PDT)
In-Reply-To: <4AA9CE36.3080903@ti.com> (Mike Turquette's message of "Thu\, 10 Sep 2009 23\:12\:38 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: Mike Chan <mike@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mike Turquette <mturquette@ti.com> writes:

> Kevin Hilman wrote:
>> Mike Chan <mike@android.com> writes:
>>
>>> Need to lock the res_mutex when traversing the res_list.
>>>
>>> Signed-off-by: Mike Chan <mike@android.com>
>>
>> Looks good, thanks.
>
> This patch causes a hang for me when transitioning to OFF mode.  This
> was tested on the Android 2.6.29 tree and is 100% reproducible.  The
> moment a user runs 'echo 1 > /sys/power/enable_off_mode' the board
> hangs without any further output.
>
> Reverting the patch allows me to hit OFF mode again.  I haven't yet
> tested this on vanilla 2.6.29 or latest L-O.
>

OK, reverting this in both PM branches.  Looks like a deadlock to me,
as update_resource_level() must cause a call to something else that
takes the mutex.

Kevin

>
>> Pushed to PM branch and pm-2.6.29.
>>
>> Kevin
>>
>>> ---
>>>  arch/arm/plat-omap/resource.c |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
>>> index 25072cd..4631912 100644
>>> --- a/arch/arm/plat-omap/resource.c
>>> +++ b/arch/arm/plat-omap/resource.c
>>> @@ -234,11 +234,13 @@ int resource_refresh(void)
>>>  	struct shared_resource *resp = NULL;
>>>  	int ret = 0;
>>>  +	down(&res_mutex);
>>>  	list_for_each_entry(resp, &res_list, node) {
>>>  		ret = update_resource_level(resp);
>>>  		if (ret)
>>>  			break;
>>>  	}
>>> +	up(&res_mutex);
>>>  	return ret;
>>>  }
>>>  -- 
>>> 1.5.4.5
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
