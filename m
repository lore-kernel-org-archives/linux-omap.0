From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] rtc: rename so the tps6586x-rtc module can be autoloaded
 at boot
Date: Tue, 10 May 2016 17:02:27 -0600
Message-ID: <57326883.6020000@wwwdotorg.org>
References: <1462876002-6462-1-git-send-email-kwizart@gmail.com>
 <573201AD.7080705@wwwdotorg.org>
 <CABr+WTnFodrRSThovUCwY+8Th0TjeOPSAFkCKcupfjAXE4bUAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABr+WTnFodrRSThovUCwY+8Th0TjeOPSAFkCKcupfjAXE4bUAA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/10/2016 03:44 PM, Nicolas Chauvet wrote:
> 2016-05-10 17:43 GMT+02:00 Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>:
>> On 05/10/2016 04:26 AM, Nicolas Chauvet wrote:
>>>
>>> This module is loaded by the related mfd driver which has
>>> the needed MODULE_DEVICE_TABLE(i2c,...).
>>>
>>> This patch fix the modalias when the rtc driver is built
>>> as a module, so the right name is used.
>>> Everything operates correctly when this module is builtin.
>>
>>
>> I'm sure this used to work. Do you know when/why it broke? Perhaps a Fixes:
>> tag would be useful, and perhaps a Cc: stable?
>
> I don't remember autoloading of rtc-tps6586x.ko has ever worked. Then
> there is still the issue of rtc modules loaded too late for the kernel
> (or the kernel not capable to defer the read of hw clock), but that's
> another issue.
>
> I first tried to report the issue on this bug tracker and at that
> time, autoloading wasn't working (was in 2014).
> https://bugzilla.redhat.com/show_bug.cgi?id=1074002
>
> I'm sure current distros using an arm generic kernel (with all
> modules) will rebase on kernel 4.4, but technically the bug is present
> in kernel 3.10 from the oldest current maintained branch (since the
> driver introduction).

Ah, all the cases I used previous did indeed have the RTC driver 
built-in not a module, so that explains it.
