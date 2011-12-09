From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c_omap: correct OMAP_I2C_SYSC_REG offset
Date: Fri, 09 Dec 2011 09:51:44 -0800
Message-ID: <87iplphbv3.fsf@ti.com>
References: <1323355433-8508-1-git-send-email-a.aring@phytec.de>
	<87obvjj5l5.fsf@ti.com> <4EE11091.20404@ti.com>
	<4EE1AEA8.6000008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EE1AEA8.6000008-l0cyMroinI0@public.gmane.org> (shubhrajyoti-l0cyMroinI0@public.gmane.org's message of "Fri,
	09 Dec 2011 12:16:00 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, Alexander Aring <a.aring-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> On Friday 09 December 2011 01:01 AM, Jon Hunter wrote:
>> Hi Kevin,
>>
>> On 12/8/2011 12:12, Kevin Hilman wrote:
>>> Alexander Aring<a.aring-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>  writes:
>>>
>>>> Correct OMAP_I2C_SYSC_REG offset in omap4 register map.
>>>> Offset 0x20 is reserved and OMAP_I2C_SYSC_REG has 0x10 as offset.
>>>>
>>>> Signed-off-by: Alexander Aring<a.aring-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
>>>
>>> Thanks for the patch!
>>>
>>> A different approach to fix this is being done by Shubhrajyoti[1] as
>>> part of his reset series.
>>>
>>> However, I think we should probably apply this patch for v3.2 and also
>>> send to the stable kernel for v3.0&  v3.1.
>>>
>>> Shubhrajyoti/Jon, any objections to me queuing this fix for v3.2 (and
>>> stable.)  It would just mean rebasing your other fixes and cleanup
>>> series on top of this.
>>
>> I have no issue with that and I am in favour of getting the fix in now.
> I too have no issues.

OK, I've added this to my for_3.2/fixes/i2c branch.

Thanks,

Kevin
