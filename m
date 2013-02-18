From: Kevin Hilman <khilman@linaro.org>
Subject: Re: OMAP EHCI having clock problems?
Date: Mon, 18 Feb 2013 06:47:44 -0800
Message-ID: <87a9r165m7.fsf@linaro.org>
References: <87halea4s3.fsf@linaro.org> <511DE9AB.5080403@ti.com>
	<87fw0x608o.fsf@linaro.org> <5121F945.1020907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48039 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab3BROrs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Feb 2013 09:47:48 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so2814001pad.35
        for <linux-omap@vger.kernel.org>; Mon, 18 Feb 2013 06:47:47 -0800 (PST)
In-Reply-To: <5121F945.1020907@ti.com> (Roger Quadros's message of "Mon, 18
	Feb 2013 11:49:57 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Mike Turquette <mturquette@linaro.com>

Roger Quadros <rogerq@ti.com> writes:

> On 02/15/2013 05:54 PM, Kevin Hilman wrote:
>> Roger Quadros <rogerq@ti.com> writes:
>> 
>>> Hi Kevin,
>>>
>>> On 02/15/2013 12:50 AM, Kevin Hilman wrote:
>>>> Felipe, Roger,
>>>>
>>>> Using Tony's current master branch, and enabling EHCI support, I see 
>>>> the clock framework spitting loudly about the EHCI driver (full boot log
>>>> below.)   The same thing happens on v3.8-rc7.
>>>>
>>>> Any idea what's going on?  Am I missing a set of fixes that's already
>>>> been posted?
>>>
>>> Thanks for pointing out. This series should fix the issues
>>> https://lkml.org/lkml/2013/1/23/155
>>>
>>> They should be on their way to linux-next.
>> 
>> Great.  But what about v3.8?  I see the same problems in v3.8-rc7.
>> 
>
> Kevin, the fix is below for older kernels.

Tested-by: Kevin Hilman <khilman@linaro.org>

Thanks, tested on v3.8-rc and works great.  Are you planning on
submitting this for v3.8 via stable? 

Thanks,

Kevin
