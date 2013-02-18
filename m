From: Roger Quadros <rogerq@ti.com>
Subject: Re: OMAP EHCI having clock problems?
Date: Mon, 18 Feb 2013 16:51:47 +0200
Message-ID: <51224003.5080705@ti.com>
References: <87halea4s3.fsf@linaro.org> <511DE9AB.5080403@ti.com> <87fw0x608o.fsf@linaro.org> <5121F945.1020907@ti.com> <87a9r165m7.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48369 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab3BROvw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 09:51:52 -0500
In-Reply-To: <87a9r165m7.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Mike Turquette <mturquette@linaro.com>

On 02/18/2013 04:47 PM, Kevin Hilman wrote:
> Roger Quadros <rogerq@ti.com> writes:
> 
>> On 02/15/2013 05:54 PM, Kevin Hilman wrote:
>>> Roger Quadros <rogerq@ti.com> writes:
>>>
>>>> Hi Kevin,
>>>>
>>>> On 02/15/2013 12:50 AM, Kevin Hilman wrote:
>>>>> Felipe, Roger,
>>>>>
>>>>> Using Tony's current master branch, and enabling EHCI support, I see 
>>>>> the clock framework spitting loudly about the EHCI driver (full boot log
>>>>> below.)   The same thing happens on v3.8-rc7.
>>>>>
>>>>> Any idea what's going on?  Am I missing a set of fixes that's already
>>>>> been posted?
>>>>
>>>> Thanks for pointing out. This series should fix the issues
>>>> https://lkml.org/lkml/2013/1/23/155
>>>>
>>>> They should be on their way to linux-next.
>>>
>>> Great.  But what about v3.8?  I see the same problems in v3.8-rc7.
>>>
>>
>> Kevin, the fix is below for older kernels.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> Thanks, tested on v3.8-rc and works great.  Are you planning on
> submitting this for v3.8 via stable? 
> 

OK I'll do that.

cheers,
-roger
