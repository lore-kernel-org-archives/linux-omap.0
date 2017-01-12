From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dmaengine: cppi41: Fix list not empty warning on
 runtime suspend
Date: Thu, 12 Jan 2017 18:41:29 +0100
Message-ID: <e17b04c8-037c-fc6d-84b8-60f968de3b4f@baylibre.com>
References: <20170109170337.6957-1-abailon@baylibre.com>
 <20170109170337.6957-2-abailon@baylibre.com>
 <20170109183416.GJ2630@atomide.com> <20170112170900.GG2630@atomide.com>
 <ac236cf1-d1e1-8f1f-fb62-b63cabf746d6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ac236cf1-d1e1-8f1f-fb62-b63cabf746d6-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/12/2017 06:23 PM, Grygorii Strashko wrote:
> 
> 
> On 01/12/2017 11:09 AM, Tony Lindgren wrote:
>> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170109 10:35]:
>>> Hi,
>>>
>>> * Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [170109 09:04]:
>>>> Sometime, a transfer may not be queued due to a race between runtime pm
>>>> and cppi41_dma_issue_pending().
>>>> Sometime, cppi41_runtime_resume() may be interrupted right before to
>>>> update device PM state to RESUMED.
>>>> When it happens, if a new dma transfer is issued, because the device is not
>>>> in active state, the descriptor will be added to the pendding list.
>>>> But because the descriptors in the pendding list are only queued to cppi41
>>>> on runtime resume, the descriptor will not be queued.
>>>> On runtime suspend, the list is not empty, which is causing a warning.
>>>> Queue the descriptor if the device is active or resuming.
>>>>
>>>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>>> ---
>>>>  drivers/dma/cppi41.c | 18 +++++++++++++++++-
>>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
>>>> index d5ba43a..025fee4 100644
>>>> --- a/drivers/dma/cppi41.c
>>>> +++ b/drivers/dma/cppi41.c
>>>> @@ -471,6 +471,8 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
>>>>  {
>>>>  	struct cppi41_channel *c = to_cpp41_chan(chan);
>>>>  	struct cppi41_dd *cdd = c->cdd;
>>>> +	unsigned long flags;
>>>> +	bool active;
>>>>  	int error;
>>>>  
>>>>  	error = pm_runtime_get(cdd->ddev.dev);
>>>> @@ -482,7 +484,21 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
>>>>  		return;
>>>>  	}
>>>>  
>>>> -	if (likely(pm_runtime_active(cdd->ddev.dev)))
>>>> +	active = pm_runtime_active(cdd->ddev.dev);
>>>> +	if (!active) {
>>>> +		/*
>>>> +		 * Runtime resume may be interrupted before runtime_status
>>>> +		 * has been updated. Test if device has resumed.
>>>> +		 */
>>>> +		if (error == -EINPROGRESS) {
>>>> +			spin_lock_irqsave(&cdd->lock, flags);
>>>> +			if (list_empty(&cdd->pending))
>>>> +				active = true;
>>>> +			spin_unlock_irqrestore(&cdd->lock, flags);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (likely(active))
>>>>  		push_desc_queue(c);
>>>>  	else
>>>>  		pending_desc(c);
>>>
>>> What guarantees that the PM runtime state is really active few lines later?
>>>
>>> A safer approach might be to check the queue for new entries by in
>>> cppi41_runtime_resume() using "while (!list_empty())" instead of
>>> list_for_each_entry(). That releases the spinlock between each entry
>>> and rechecks the list.
>>>
>>> And instead of doing WARN_ON(!list_empty(&cdd->pending)) it seems we
>>> should run the queue also on cppi41_runtime_suspend()?
>>
>> Hmm so I started seeing these issues too with Linux next just plugging
>> in USB cable on bbb while configured as a USB peripheral :)
>>
>> Below is what seems to fix issues for me, not seeing any more warnings
>> either.
>>
>> Care to give it a try with your USB headset?
This solves the issue but I still have a bad playback quality.
I don't remember if I have spoken about it so I will describe it.
When I play audio (with your patch or mine), the music cut a lot.
The issue go away when the MUSB driver is built in PIO mode only.
Some experimentation I made today let me think it is related to
PM runtime.
I guess I should probably start another thread about that.
> 
> This looks more close to what is provided in Documentation\power\runtime_pm.txt
> (example at the end of the file),
> but as per this document custom locking is required to access .active var.
> 
> 
>>
>> 8< --------------------------
>> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
>> --- a/drivers/dma/cppi41.c
>> +++ b/drivers/dma/cppi41.c
>> @@ -153,6 +153,8 @@ struct cppi41_dd {
>>  
>>  	/* context for suspend/resume */
>>  	unsigned int dma_tdfdq;
>> +
>> +	bool active;
>>  };
>>  
>>  #define FIST_COMPLETION_QUEUE	93
>> @@ -320,7 +322,8 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>>  			int error;
>>  
>>  			error = pm_runtime_get(cdd->ddev.dev);
>> -			if (error < 0)
>> +			if (((error != -EINPROGRESS) && error < 0) ||
>> +			    !cdd->active)
>>  				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
>>  					__func__, error);
>>  
>> @@ -482,7 +485,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
>>  		return;
>>  	}
>>  
>> -	if (likely(pm_runtime_active(cdd->ddev.dev)))
>> +	if (likely(cdd->active))
>>  		push_desc_queue(c);
>>  	else
>>  		pending_desc(c);
>> @@ -1151,6 +1154,7 @@ static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
>>  {
>>  	struct cppi41_dd *cdd = dev_get_drvdata(dev);
>>  
>> +	cdd->active = false;
>>  	WARN_ON(!list_empty(&cdd->pending));
>>  
>>  	return 0;
>> @@ -1159,13 +1163,20 @@ static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
>>  static int __maybe_unused cppi41_runtime_resume(struct device *dev)
>>  {
>>  	struct cppi41_dd *cdd = dev_get_drvdata(dev);
>> -	struct cppi41_channel *c, *_c;
>> +	struct cppi41_channel *c;
>>  	unsigned long flags;
>>  
>> +	cdd->active = true;
>> +
>>  	spin_lock_irqsave(&cdd->lock, flags);
>> -	list_for_each_entry_safe(c, _c, &cdd->pending, node) {
>> -		push_desc_queue(c);
>> +	while (!list_empty(&cdd->pending)) {
>> +		c = list_first_entry(&cdd->pending,
>> +				     struct cppi41_channel,
>> +				     node);
>>  		list_del(&c->node);
>> +		spin_unlock_irqrestore(&cdd->lock, flags);
>> +		push_desc_queue(c);
>> +		spin_lock_irqsave(&cdd->lock, flags);
>>  	}
>>  	spin_unlock_irqrestore(&cdd->lock, flags);
>>  
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
