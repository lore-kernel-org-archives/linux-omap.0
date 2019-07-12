From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Improved memcpy polling support
Date: Sat, 13 Jul 2019 00:10:04 +0300
Message-ID: <b180a077-a2c7-9f1e-cf0b-5bdf986a78fc@ti.com>
References: <20190618132416.26874-1-peter.ujfalusi@ti.com>
 <20190705062334.GV2911@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190705062334.GV2911@vkoul-mobl>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 5.7.2019 9.23, Vinod Koul wrote:
> On 18-06-19, 16:24, Peter Ujfalusi wrote:
>> When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
>> does not want to use interrupts for DMA completion or because it can not
>> rely on DMA interrupts due to executing the memcpy when interrupts are
>> disabled it will poll the status of the transfer.
>>
>> If the interrupts are enabled then the cookie will be set completed in the
>> interrupt handler so only check in HW completion when the polling is really
>> needed.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> This patch fine-tunes the omap-dma polled memcpy support to be inline with how
>> the EDMA driver is handling it.
>>
>> The polled completion can be tested by applying:
>> https://patchwork.kernel.org/patch/10966499/
>>
>> and run the dmatest with polled = 1 on boards where sDMA is used.
>>
>> Or boot up any dra7 family device with display enabled. The workaround for DMM
>> errata i878 uses polled DMA memcpy.
>>
>> Regards,
>> Peter
>>
>>  drivers/dma/ti/omap-dma.c | 37 ++++++++++++++++++++++++-------------
>>  1 file changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
>> index 5ba7d8485026..75d8f7e13c8d 100644
>> --- a/drivers/dma/ti/omap-dma.c
>> +++ b/drivers/dma/ti/omap-dma.c
>> @@ -94,6 +94,7 @@ struct omap_desc {
>>  	bool using_ll;
>>  	enum dma_transfer_direction dir;
>>  	dma_addr_t dev_addr;
>> +	bool polled;
>>  
>>  	int32_t fi;		/* for OMAP_DMA_SYNC_PACKET / double indexing */
>>  	int16_t ei;		/* for double indexing */
>> @@ -834,20 +835,10 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
>>  
>>  	ret = dma_cookie_status(chan, cookie, txstate);
>>  
>> -	if (!c->paused && c->running) {
>> -		uint32_t ccr = omap_dma_chan_read(c, CCR);
>> -		/*
>> -		 * The channel is no longer active, set the return value
>> -		 * accordingly
>> -		 */
>> -		if (!(ccr & CCR_ENABLE))
>> -			ret = DMA_COMPLETE;
>> -	}
>> -
>> +	spin_lock_irqsave(&c->vc.lock, flags);
>>  	if (ret == DMA_COMPLETE || !txstate)
>> -		return ret;
>> +		goto out;
>>  
>> -	spin_lock_irqsave(&c->vc.lock, flags);
>>  	vd = vchan_find_desc(&c->vc, cookie);
>>  	if (vd) {
>>  		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
>> @@ -868,6 +859,23 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
>>  	}
>>  	if (ret == DMA_IN_PROGRESS && c->paused)
>>  		ret = DMA_PAUSED;
>> +
>> +out:
>> +	if (ret == DMA_IN_PROGRESS && c->running && c->desc &&
>> +	    c->desc->polled && c->desc->vd.tx.cookie == cookie) {
> 
> heh, that makes quite a read!
> 
> checking DMA_IN_PROGRESS should not make sense, as we should bail out at
> the start if it is completed
> 
> I think other can be optimzed to make it a better read!

True, a simple re-ordering should make it easier to read or to split
them up as two if() checks. I'll try to figure out something to simplify it.

> 
>> +		uint32_t ccr = omap_dma_chan_read(c, CCR);
>> +		/*
>> +		 * The channel is no longer active, set the return value
>> +		 * accordingly
>> +		 */
>> +		if (!(ccr & CCR_ENABLE)) {
>> +			struct omap_desc *d = c->desc;
>> +			ret = DMA_COMPLETE;
>> +			omap_dma_start_desc(c);
>> +			vchan_cookie_complete(&d->vd);
>> +		}
>> +	}
>> +
>>  	spin_unlock_irqrestore(&c->vc.lock, flags);
>>  
>>  	return ret;
>> @@ -1233,7 +1241,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
>>  	d->ccr = c->ccr;
>>  	d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_POSTINC;
>>  
>> -	d->cicr = CICR_DROP_IE | CICR_FRAME_IE;
>> +	if (tx_flags & DMA_PREP_INTERRUPT)
>> +		d->cicr |= CICR_FRAME_IE;
>> +	else
>> +		d->polled = true;
>>  
>>  	d->csdp = data_type;
>>  
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
