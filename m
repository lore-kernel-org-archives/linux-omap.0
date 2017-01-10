From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dmaengine: cppi41: Fix list not empty warning on
 runtime suspend
Date: Tue, 10 Jan 2017 10:46:27 +0100
Message-ID: <ccf7e299-958b-9197-05df-c4bbf6ea4296@baylibre.com>
References: <20170109170337.6957-1-abailon@baylibre.com>
 <20170109170337.6957-2-abailon@baylibre.com>
 <bc8f9562-b33a-1270-ee8f-b2925664172a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bc8f9562-b33a-1270-ee8f-b2925664172a-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/09/2017 07:16 PM, Grygorii Strashko wrote:
> 
> 
> On 01/09/2017 11:03 AM, Alexandre Bailon wrote:
>> Sometime, a transfer may not be queued due to a race between runtime pm
>> and cppi41_dma_issue_pending().
>> Sometime, cppi41_runtime_resume() may be interrupted right before to
>> update device PM state to RESUMED.
>> When it happens, if a new dma transfer is issued, because the device is not
>> in active state, the descriptor will be added to the pendding list.
>> But because the descriptors in the pendding list are only queued to cppi41
>> on runtime resume, the descriptor will not be queued.
>> On runtime suspend, the list is not empty, which is causing a warning.
>> Queue the descriptor if the device is active or resuming.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/dma/cppi41.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
>> index d5ba43a..025fee4 100644
>> --- a/drivers/dma/cppi41.c
>> +++ b/drivers/dma/cppi41.c
>> @@ -471,6 +471,8 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
>>  {
>>  	struct cppi41_channel *c = to_cpp41_chan(chan);
>>  	struct cppi41_dd *cdd = c->cdd;
>> +	unsigned long flags;
>> +	bool active;
>>  	int error;
>>  
>>  	error = pm_runtime_get(cdd->ddev.dev);
>> @@ -482,7 +484,21 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
>>  		return;
>>  	}
>>  
>> -	if (likely(pm_runtime_active(cdd->ddev.dev)))
>> +	active = pm_runtime_active(cdd->ddev.dev);
>> +	if (!active) {
> 
> just curious, what does prevent from using pm_runtime_get_sync() here and in
> cppi41_dma_issue_pending()?
This function is called from atomic or interrupt context.
> 
>> +		/*
>> +		 * Runtime resume may be interrupted before runtime_status
>> +		 * has been updated. Test if device has resumed.
>> +		 */
>> +		if (error == -EINPROGRESS) {
>> +			spin_lock_irqsave(&cdd->lock, flags);
>> +			if (list_empty(&cdd->pending))
>> +				active = true;
>> +			spin_unlock_irqrestore(&cdd->lock, flags);
>> +		}
>> +	}
>> +
>> +	if (likely(active))
>>  		push_desc_queue(c);
>>  	else
>>  		pending_desc(c);
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
