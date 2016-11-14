From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] dmaengine: omap-dma: Support for slave devices with
 data port window
Date: Mon, 14 Nov 2016 11:44:33 +0200
Message-ID: <11c9dee6-1ddf-f2d3-e616-73fbac7cfd4f@ti.com>
References: <20161025105019.24475-1-peter.ujfalusi@ti.com>
 <20161025105019.24475-3-peter.ujfalusi@ti.com>
 <20161114043517.GO3000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114043517.GO3000@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: dan.j.williams@intel.com, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On 11/14/2016 06:35 AM, Vinod Koul wrote:
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
> 
> and that would be..?

0, but I like to have a define for this as we might need to use this mode in
the future and the bit field is defined like this.

> 
>> +	CSDP_WRITE_POSTED	= (1 << 16),
>> +	CSDP_WRITE_LAST_NON_POSTED = (2 << 16),
>>  
>>  	CICR_TOUT_IE		= BIT(0),	/* OMAP1 only */
>>  	CICR_DROP_IE		= BIT(1),
>> @@ -883,15 +886,18 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>>  	unsigned i, es, en, frame_bytes;
>>  	bool ll_failed = false;
>>  	u32 burst;
>> +	int32_t port_window;
> 
> not u32?

Yeah, it can be u32.

> 
>>  
>>  	if (dir == DMA_DEV_TO_MEM) {
>>  		dev_addr = c->cfg.src_addr;
>>  		dev_width = c->cfg.src_addr_width;
>>  		burst = c->cfg.src_maxburst;
>> +		port_window = c->cfg.src_port_window_size;
>>  	} else if (dir == DMA_MEM_TO_DEV) {
>>  		dev_addr = c->cfg.dst_addr;
>>  		dev_width = c->cfg.dst_addr_width;
>>  		burst = c->cfg.dst_maxburst;
>> +		port_window = c->cfg.dst_port_window_size;
>>  	} else {
>>  		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
>>  		return NULL;
>> @@ -923,11 +929,39 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>>  
>>  	d->ccr = c->ccr | CCR_SYNC_FRAME;
>>  	if (dir == DMA_DEV_TO_MEM) {
>> -		d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_CONSTANT;
>>  		d->csdp = CSDP_DST_BURST_64 | CSDP_DST_PACKED;
>> +
>> +		d->ccr |= CCR_DST_AMODE_POSTINC;
>> +		if (port_window) {
>> +			d->ccr |= CCR_SRC_AMODE_DBLIDX;
>> +			d->ei = 1;
>> +			d->fi = (-1) * (port_window - 1);
>> +
>> +			if (port_window / 64)
>> +				d->csdp = CSDP_SRC_BURST_64 | CSDP_SRC_PACKED;
>> +			else if (port_window / 32)
>> +				d->csdp = CSDP_SRC_BURST_32 | CSDP_SRC_PACKED;
>> +			else if (port_window / 16)
>> +				d->csdp = CSDP_SRC_BURST_16 | CSDP_SRC_PACKED;
>> +		} else {
>> +			d->ccr |= CCR_SRC_AMODE_CONSTANT;
> 
> okay does all your hw support this mode, should this not be checked to be
> supported, perhpas a DT property which describes thsi capablity and then you
> use it, if supported

yes, burst and packed mode is supported by all sDMA versions.

> 
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
> what does these mean?

To optimize the speed on the write side. First check if the window size is
multiple of 64 bytes, we enable the 64byte burst and packed transfer, if not
try the 32bytes, then 16bytes.
Same for the opposite direction previously.

> 
>> +		} else {
>> +			d->ccr |= CCR_DST_AMODE_CONSTANT;
>> +		}
>>  	}
>>  
>>  	d->cicr = CICR_DROP_IE | CICR_BLOCK_IE;
>> @@ -945,6 +979,9 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>>  			d->ccr |= CCR_TRIGGER_SRC;
>>  
>>  		d->cicr |= CICR_MISALIGNED_ERR_IE | CICR_TRANS_ERR_IE;
>> +
>> +		if (port_window)
>> +			d->csdp |= CSDP_WRITE_LAST_NON_POSTED;
>>  	}
>>  	if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
>>  		d->clnk_ctrl = c->dma_ch;
>> @@ -970,6 +1007,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>>  		osg->addr = sg_dma_address(sgent);
>>  		osg->en = en;
>>  		osg->fn = sg_dma_len(sgent) / frame_bytes;
>> +		if (port_window && dir == DMA_MEM_TO_DEV) {
>> +			osg->ei = 1;
>> +			osg->fi = (-1) * (port_window - 1);
>> +		}
> 
> can you describe what you are trying here..

The DMA is set up so one frame covers the port window. When the frame is
finished we need to start reading the next frame from the start of the window
again. The FI as (-1) * (port_window - 1) will take us to the start of the
window. When the frame is finished the DMA is pointing to the last byte of the
window.

> 


-- 
Péter
