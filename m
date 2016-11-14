From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] dmaengine: omap-dma: Support for slave devices with
 data port window
Date: Mon, 14 Nov 2016 13:56:30 +0200
Message-ID: <091f6dce-b1d7-6527-b8c6-147becfd8856@ti.com>
References: <20161025105019.24475-1-peter.ujfalusi@ti.com>
 <20161025105019.24475-3-peter.ujfalusi@ti.com>
 <20161114105313.GB23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114105313.GB23750@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, Tony Lindgren <tony@atomide.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On 11/14/2016 12:53 PM, Russell King - ARM Linux wrote:
> On Tue, Oct 25, 2016 at 01:50:19PM +0300, Peter Ujfalusi wrote:
>> Based on the src/dst_port_window_size - if it is set - configure the DMA
>> channel to use double indexing in order to be able to loop within the
>> address window.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/omap-dma.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>> index 025f499cb20d..29350f936154 100644
>> --- a/drivers/dma/omap-dma.c
>> +++ b/drivers/dma/omap-dma.c
>> @@ -166,6 +166,9 @@ enum {
>>  	CSDP_DST_BURST_16	= 1 << 14,
>>  	CSDP_DST_BURST_32	= 2 << 14,
>>  	CSDP_DST_BURST_64	= 3 << 14,
>> +	CSDP_WRITE_NON_POSTED	= (0 << 16),
>> +	CSDP_WRITE_POSTED	= (1 << 16),
>> +	CSDP_WRITE_LAST_NON_POSTED = (2 << 16),
>
> Why the useless parens?

I will get rid of them.

>
>> +		if (port_window) {
>> +			d->ccr |= CCR_SRC_AMODE_DBLIDX;
>> +			d->ei = 1;
>> +			d->fi = (-1) * (port_window - 1);
>
> You know that's 1 - port_window, or -(port_window - 1).

Yes, I know. "-(port_window - 1)" might be a bit better.

>
>> +
>> +			if (port_window / 64)
>> +				d->csdp = CSDP_SRC_BURST_64 | CSDP_SRC_PACKED;
>> +			else if (port_window / 32)
>> +				d->csdp = CSDP_SRC_BURST_32 | CSDP_SRC_PACKED;
>> +			else if (port_window / 16)
>> +				d->csdp = CSDP_SRC_BURST_16 | CSDP_SRC_PACKED;
>
> Why these divisions?  Wouldn't >= be more suitable here?  Do they even
> make sense here?

I'll revisit these.

>
>> +		} else {
>> +			d->ccr |= CCR_SRC_AMODE_CONSTANT;
>> +		}
>>  	} else {
>> -		d->ccr |= CCR_DST_AMODE_CONSTANT | CCR_SRC_AMODE_POSTINC;
>>  		d->csdp = CSDP_SRC_BURST_64 | CSDP_SRC_PACKED;
>> +
>> +		d->ccr |= CCR_SRC_AMODE_POSTINC;
>> +		if (port_window) {
>> +			d->ccr |= CCR_DST_AMODE_DBLIDX;
>> +
>> +			if (port_window / 64)
>> +				d->csdp = CSDP_DST_BURST_64 | CSDP_DST_PACKED;
>> +			else if (port_window / 32)
>> +				d->csdp = CSDP_DST_BURST_32 | CSDP_DST_PACKED;
>> +			else if (port_window / 16)
>> +				d->csdp = CSDP_DST_BURST_16 | CSDP_DST_PACKED;
>
> Ditto.
>
>> +		} else {
>> +			d->ccr |= CCR_DST_AMODE_CONSTANT;
>> +		}
>>  	}
>>
>>  	d->cicr = CICR_DROP_IE | CICR_BLOCK_IE;
>> @@ -945,6 +979,9 @@ static struct dma_async_tx_descriptor
*omap_dma_prep_slave_sg(
>>  			d->ccr |= CCR_TRIGGER_SRC;
>>
>>  		d->cicr |= CICR_MISALIGNED_ERR_IE | CICR_TRANS_ERR_IE;
>> +
>> +		if (port_window)
>> +			d->csdp |= CSDP_WRITE_LAST_NON_POSTED;
>>  	}
>>  	if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
>>  		d->clnk_ctrl = c->dma_ch;
>> @@ -970,6 +1007,10 @@ static struct dma_async_tx_descriptor
*omap_dma_prep_slave_sg(
>>  		osg->addr = sg_dma_address(sgent);
>>  		osg->en = en;
>>  		osg->fn = sg_dma_len(sgent) / frame_bytes;
>> +		if (port_window && dir == DMA_MEM_TO_DEV) {
>> +			osg->ei = 1;
>> +			osg->fi = (-1) * (port_window - 1);
>
> Same as above.
>


-- 
Péter
