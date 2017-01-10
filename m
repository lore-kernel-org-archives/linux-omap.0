From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dmaengine: cppi41: Ignore EINPROGRESS for PM
 runtime in interrupt handler
Date: Tue, 10 Jan 2017 12:34:23 +0100
Message-ID: <7be08973-1233-a19a-a263-3ca194c4854c@baylibre.com>
References: <20170109170337.6957-1-abailon@baylibre.com>
 <20170109170337.6957-3-abailon@baylibre.com>
 <20170109183946.GK2630@atomide.com>
 <7f446fd6-23ac-392c-6a2e-6b63843e0299@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7f446fd6-23ac-392c-6a2e-6b63843e0299-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/09/2017 08:11 PM, Grygorii Strashko wrote:
> 
> 
> On 01/09/2017 12:39 PM, Tony Lindgren wrote:
>> * Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [170109 09:04]:
>>> We can occasionally get -EINPROGRESS for pm_runtime_get.
>>> This is happening when an interrupt is fired before PM runtime had time
>>> to update the PM state to RESUMED.
>>> In that case, don't print any error.
>>
>> Hmm if the cppi41 interrupt fires, the device has resumed :)
>>
>> I think we should have a cppi41.c specific flag that we can set
>> at the end of cppi41_resume() instead of list_empty() or
>> pm_runtime_active().
>>
>> Regars,
>>
>> Tony
>>
>>
>>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>> ---
>>>  drivers/dma/cppi41.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
>>> index 025fee4..2306020 100644
>>> --- a/drivers/dma/cppi41.c
>>> +++ b/drivers/dma/cppi41.c
>>> @@ -320,7 +320,7 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>>>  			int error;
>>>  
>>>  			error = pm_runtime_get(cdd->ddev.dev);
>>> -			if (error < 0)
>>> +			if ((error != -EINPROGRESS) && error < 0)
>>>  				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
>>>  					__func__, error);
> 
> Another question of curiosity :) -EINPROGRESS and pm_runtime_get() in general doesn't
> guarantee that device is powered on and accessible immediately after this call, but
> few lines below there are code which try to access registers 
> 	desc = cppi41_pop_desc(cdd, q_num);
> Is it ok?
I guess it is ok.
I think the interrupt can only be fired if the device is active.
And the interrupt happen because the one descriptor queued during the
resume has been moved to completion queue
(so device is clocked and operational).
> 
>>>  
>>> @@ -492,8 +492,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
>>>  		 */
>>>  		if (error == -EINPROGRESS) {
>>>  			spin_lock_irqsave(&cdd->lock, flags);
>>> -			if (list_empty(&cdd->pending))
>>> -				active = true;
>>> +			active = !!list_empty(&cdd->pending);
>>>  			spin_unlock_irqrestore(&cdd->lock, flags);
>>>  		}
>>>  	}
>>> -- 
>>> 2.10.2
> 
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
