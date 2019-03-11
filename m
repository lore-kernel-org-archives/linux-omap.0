From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: Nokia N900: wl1251 spi3.0: EOW timed out on
Date: Mon, 11 Mar 2019 12:51:57 +0530
Message-ID: <ddfababf-3d3c-85c1-e1d8-762b4c41f19c@ti.com>
References: <3819003e-2ab3-0325-de0d-9fa07b51ee9f@wizzup.org>
 <436a9a35-539a-3fe8-2225-36b45c7e5412@wizzup.org>
 <165d492e-435b-40a8-f784-5f2d08803514@ti.com>
 <1b2918b4-1765-5aba-4752-1d04bdfea925@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1b2918b4-1765-5aba-4752-1d04bdfea925-tF0PIh4TN3odnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Merlijn Wajer <merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org>, "kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 11/03/19 12:53 AM, Merlijn Wajer wrote:
> Hi,
> 
> On 10/03/2019 05:16, Vignesh Raghavendra wrote:
>> Hi.
>>
>> On 10-Mar-19 6:23 AM, Merlijn Wajer wrote:
>>>
>>> Hi,
>>>
>>> On 10/03/2019 00:22, Merlijn Wajer wrote:
>>>> Hi,
>>>>
>>>> I just migrated to Linux 5.0  (from 4.15) on my Nokia N900, and I'm
>>>> getting a lot of messages like this:
>>>>
>>>>> wl1251 spi3.0: EOW timed out
>>
>>
>> Could you try if this patch fixes the issue? This is part of latest mainline tree but not part of 5.0:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=baf8b9f8d260c55a86405f70a384c29cda888476
> 
> This seems to fix the issue. Would it make sense to queue this for an
> upcoming fixes release for 5.0?
> 

Patch carries "Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" tag. So, will be backported
to stable trees. It will be part of one of 5.0.y stable releases.

> Cheers,
> Merlijn
> 

-- 
Regards
Vignesh
