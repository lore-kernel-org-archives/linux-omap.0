From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] MUSB: fix memory corruption when using more than max
	endpoints
Date: Wed, 10 Sep 2008 14:26:56 +0300
Message-ID: <20080910112656.GR16796@gandalf.research.nokia.com>
References: <1221026036-26477-1-git-send-email-khilman@deeprootsystems.com> <20080910103616.GQ16796@gandalf.research.nokia.com> <48C7AD83.60703@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63786 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbYIJL1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 07:27:05 -0400
Content-Disposition: inline
In-Reply-To: <48C7AD83.60703@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Sep 10, 2008 at 02:20:35PM +0300, ext Kevin Hilman wrote:
> Felipe Balbi wrote:
>> Let's keep linux-usb on the loop for musb related patches ;-)
>>
>> On Wed, Sep 10, 2008 at 08:53:56AM +0300, ext Kevin Hilman wrote:
>>> There is no check if platform code passes in more endpoints (num_eps)
>>> than the maximum number of enpoints (MUSB_C_NUM_EPS.)  The result is
>>> that allocate_instance() happily writes past the end of 'struct musb'
>>> corrupting memory.
>>>
>>> The fix below increases the max to 32 (used on omap3) and also adds a
>>> BUG() if the platform code requests more than the max.
>>>
>>> This memory corruption was triggering various forms of crashes/panics
>>> with kmem_cache_alloc() in the backtrace.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Looks ok, I'll put to my series.
>>
>>> ---
>>>  drivers/usb/musb/musb_core.c |    1 +
>>>  drivers/usb/musb/musb_core.h |    2 +-
>>>  2 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>>> index c939f81..a132d9f 100644
>>> --- a/drivers/usb/musb/musb_core.c
>>> +++ b/drivers/usb/musb/musb_core.c
>>> @@ -1806,6 +1806,7 @@ allocate_instance(struct device *dev,
>>>  	musb->ctrl_base = mbase;
>>>  	musb->nIrq = -ENODEV;
>>>  	musb->config = config;
>>> +	BUG_ON(musb->config->num_eps > MUSB_C_NUM_EPS);
>>
>> It's good to have this check here.
>>
>>>  	for (epnum = 0, ep = musb->endpoints;
>>>  			epnum < musb->config->num_eps;
>>>  			epnum++, ep++) {
>>> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
>>> index 8222725..5040ceb 100644
>>> --- a/drivers/usb/musb/musb_core.h
>>> +++ b/drivers/usb/musb/musb_core.h
>>> @@ -153,7 +153,7 @@ static inline void musb_host_rx(struct musb *m, u8 e) {}
>>>  /****************************** CONSTANTS ********************************/
>>>   #ifndef MUSB_C_NUM_EPS
>>> -#define MUSB_C_NUM_EPS ((u8)16)
>>> +#define MUSB_C_NUM_EPS ((u8)32)
>>
>> 16 is the right number.
>>
>
> If 16 is the right number, arch/arm/mach-omap2/usb-musb.c going to trigger 
> this BUG every time since it sets num_eps = 32.
>
> I don't know much about MUSB enbpoints, but if 16 is the correct max, then 
> the platform code should be updated.

Check recent Dave's patches to usb-musb.c ;-)

-- 
balbi
