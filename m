From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 09/18] ARM: OMAP4+: PM: Restore CPU power state to
 ON with clockdomain force wakeup method
Date: Fri, 5 Apr 2013 14:37:01 +0530
Message-ID: <515E9435.6050007@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-10-git-send-email-santosh.shilimkar@ti.com> <87mwtftjvy.fsf@linaro.org> <515D8215.10705@ti.com> <87li8ynqf5.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55043 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab3DEJFE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Apr 2013 05:05:04 -0400
In-Reply-To: <87li8ynqf5.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 11:12 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On Thursday 04 April 2013 02:24 AM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> While waking up CPU from off state using clock domain force wakeup, restore
>>>> the CPU power state to ON state before putting CPU clock domain under
>>>> hardware control. Otherwise CPU wakeup might fail. The change is recommended
>>>> for all OMAP4+ devices though the PRCM weakness was observed on OMAP5
>>>> devices first.
>>>
>>> Sounds reasonable, but can you describe the "weakness" a little more?
>>>
>>> IOW, what exactly happens if this is not done?  It sounds like the CPU
>>> might immediately go back to retention, but how does that happen unless
>>> it does a WFI?
>>>
>> Its more of lock-up inside the hardware state machine and results
>> are UN-predictable. We have seen hard-locks most of the time where system
>> is just frozen. The hardware gets into wrong state machine if the power
>> domain state isn't restored. I will add this information to changelog.
>>
>>> Also, this sounds like a fix to me, and should probably be broken out
>>> accordingly.
>>>
>> Yeah. You mean a separate patch from the series, right ? This patch
>> actually can be independently added.
>>
>> In case you decide to apply it for the fixes branch, updated patch
>> at end of the email.
> 
> Curious which branch you applied it to?  It didn't apply cleanly to
> v3.9-rc5 (but did with fuzz).
> 
Mostly applied on top of the Tony's pull request branches.

> So I've now added it to my for_3.10/fixes/pm branch.
> 
Thanks. I will pull that in to re-base other patches.

Regards,
Santosh

