From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 3/3] dmaengine: ti: edma: Support for polled (memcpy)
 completion
Date: Sat, 13 Jul 2019 00:05:43 +0300
Message-ID: <d695a2fa-61d4-e312-11d9-b501b6bc18a7@ti.com>
References: <20190618132148.26468-1-peter.ujfalusi@ti.com>
 <20190618132148.26468-4-peter.ujfalusi@ti.com>
 <20190705061714.GU2911@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190705061714.GU2911@vkoul-mobl>
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



On 5.7.2019 9.17, Vinod Koul wrote:
>> @@ -1840,18 +1847,40 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
>>  {
>>  	struct edma_chan *echan = to_edma_chan(chan);
>>  	struct virt_dma_desc *vdesc;
>> +	struct dma_tx_state txstate_tmp;
>>  	enum dma_status ret;
>>  	unsigned long flags;
>>  
>>  	ret = dma_cookie_status(chan, cookie, txstate);
>> -	if (ret == DMA_COMPLETE || !txstate)
>> +
>> +	/* Provide a dummy dma_tx_state for completion checking */
>> +	if (ret != DMA_COMPLETE && !txstate)
>> +		txstate = &txstate_tmp;
>> +
>> +	if (ret == DMA_COMPLETE)
>>  		return ret;
> 
> why not do:
> 
>         if (ret == DMA_COMPLETE)
>                 return ret;
> 
>         if (!txstate)
>                 txstate = &txstate_tmp;
>

Indeed it is much cleaner this way. Will send an updated series next week.

>> +	txstate->residue = 0;
>>  	spin_lock_irqsave(&echan->vchan.lock, flags);
>>  	if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie)
>>  		txstate->residue = edma_residue(echan->edesc);
>>  	else if ((vdesc = vchan_find_desc(&echan->vchan, cookie)))
>>  		txstate->residue = to_edma_desc(&vdesc->tx)->residue;
>> +
>> +	/*
>> +	 * Mark the cookie completed if the residue is 0 for non cyclic
>> +	 * transfers
>> +	 */
>> +	if (ret != DMA_COMPLETE && !txstate->residue &&
>> +	    echan->edesc && echan->edesc->polled &&
>> +	    echan->edesc->vdesc.tx.cookie == cookie) {
>> +		edma_stop(echan);
>> +		vchan_cookie_complete(&echan->edesc->vdesc);
>> +		echan->edesc = NULL;
>> +		edma_execute(echan);
>> +		ret = DMA_COMPLETE;
>> +	}
>> +
>>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
>>  
>>  	return ret;
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
