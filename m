From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 2/5] ARM: edma: Get IP information from HW when booting
 with DT
Date: Thu, 15 May 2014 18:18:56 +0530
Message-ID: <5374B7B8.4060604@ti.com>
References: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com> <1399977032-26469-3-git-send-email-peter.ujfalusi@ti.com> <53748070.4080706@ti.com> <5374B34D.2060904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5374B34D.2060904@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, joelf@ti.com
Cc: linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On Thursday 15 May 2014 06:00 PM, Peter Ujfalusi wrote:

> The second controller is not handled because in DT boot we only handle 1 cc as
> far as I know. I don't know why, but this is how the DT support has been
> written and used.

Its just because none of the platforms under heavy development use two
controllers. Joel promised to work on it at some point ;)

> 
>> I was wondering why we never read the hardware for this information
>> before, and strangely enough cannot find any SoC where the CCCFG
>> register does not publish this information correctly. I have tested on
>> DA850, DA830, DM365, DM355 and DM6467.
> 
> Good question. I was also puzzled about this.
> 
>> Instead of keeping this specific to OF case, the code can be simplified
>> much better if we read from hardware all the time. We can directly
>> populate the equivalent variables in the internal structure 'struct
>> edma' instead of populating them in 'struct edma_soc_info' and then
>> copying then over.
> 
> Yes, we can switch the non DT boot to this mode as well, true. At first I
> wanted to change code which I can test easily. For non DT boot I would need to
> set up my old daVinci board ;)

I can help testing (and even with writing the DaVinci platform specific
patches).

>>> +	pdata->n_cc = 1;
>>> +
>>> +	queue_tc_map = devm_kzalloc(dev, (n_tc + 1) * sizeof(s8), GFP_KERNEL);
>>> +	if (!queue_tc_map)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < n_tc; i++) {
>>> +		queue_tc_map[i][0] = i;
>>> +		queue_tc_map[i][1] = i;
>>> +	}
>>> +	queue_tc_map[i][0] = -1;
>>> +	queue_tc_map[i][1] = -1;
>>> +
>>> +	pdata->queue_tc_mapping = queue_tc_map;
>>> +
>>> +	queue_priority_map = devm_kzalloc(dev, (n_tc + 1) * sizeof(s8),
>>> +					  GFP_KERNEL);
>>> +	if (!queue_priority_map)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < n_tc; i++) {
>>> +		queue_priority_map[i][0] = i;
>>> +		queue_priority_map[i][1] = i;
>>> +	}
>>> +	queue_priority_map[i][0] = -1;
>>> +	queue_priority_map[i][1] = -1;
>>> +
>>> +	pdata->queue_priority_mapping = queue_priority_map;
>>> +
>>> +	pdata->default_queue = 0;
>>
>> This is part is not really setting up from hardware (rather falling back
>> to some sane defaults for the DT case). Could you leave them in
>> edma_of_parse_dt()?
> 
> Not really since the number of tc is not know as early as edma_of_parse_dt(),
> we used to a magic number of 3 in place for n_tc previously.
> We are doing similar things as previously done in edma_of_parse_dt() but with
> 'correct' number of tc.

Okay. I did not notice the n_tc hardcoding. In that case to make this
function usable on non-DT case we will have to do something like:

	/* Default to 1 if nothing passed */
	if (!pdata->n_cc)
		pdata->n_cc = 1;

	if (!pdata->queue_priority_mapping) {
		queue_priority_map = devm_kzalloc(...)
	}

I was hoping we could avoid that.

>>> @@ -1655,6 +1679,12 @@ static int edma_probe(struct platform_device *pdev)
>>>  		if (IS_ERR(edmacc_regs_base[j]))
>>>  			return PTR_ERR(edmacc_regs_base[j]);
>>>  
>>> +		if (node) {
>>> +			/* Get eDMA3 configuration from IP */
>>> +			ret = edma_setup_info_from_hw(dev, info[j]);
>>> +			if (ret)
>>> +				return ret;
>>
>> No need to do this only for the DT case, I think. Also, once we get rid
>> of the edma_soc_info dependency, just pass edma_cc[] directly
>>
>> 		edma_setup_info_from_hw(dev, j, edma_cc[j]);
> 
> Yes, let's do this for DT and not DT boot as well.
> I will keep the queue_tc_map and queue_priority_map setup in there I think to
> be done in case of DT boot.

Right.

> 
> I'll try to craft v3 as soon as I can.

Thanks.

Regards,
Sekhar

