From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/5] dmaengine: Support for querying maximum trasnfer
 length (of an SG element)
Date: Tue, 26 Sep 2017 22:24:13 +0530
Message-ID: <20170926165413.GQ30097@localhost>
References: <20170912104424.18495-1-peter.ujfalusi@ti.com>
 <20170912104424.18495-4-peter.ujfalusi@ti.com>
 <20170921171451.GG30097@localhost>
 <02509904-4ae8-c6f8-3514-5f77d665c9a6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <02509904-4ae8-c6f8-3514-5f77d665c9a6@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 22, 2017 at 12:39:38PM +0300, Peter Ujfalusi wrote:
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> On 2017-09-21 20:14, Vinod Koul wrote:
> > On Tue, Sep 12, 2017 at 01:44:22PM +0300, Peter Ujfalusi wrote:
> >> Certain DMA engines have limitation on the maximum size of a transfer they
> >> can support. This size limitation is per SG element or for period length in
> >> cyclic transfers.
> >> In TI's eDMA and sDMA this limitation is not really a length limit, but it
> >> is the number of bursts that we can support in one transfer.
> >>
> >> With this callback the DMA drivers can provide hints to clients on how they
> >> should set up their buffers (sglist, cyclic buffer). Without this the
> >> clients must have open coded workarounds in place for each and every DMA
> >> engine they might be interfacing with to have correct length for the
> >> transfers.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  include/linux/dmaengine.h | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> >> index 8319101170fc..739824b94c1b 100644
> >> --- a/include/linux/dmaengine.h
> >> +++ b/include/linux/dmaengine.h
> >> @@ -705,6 +705,9 @@ struct dma_filter {
> >>   * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
> >>   * @device_config: Pushes a new configuration to a channel, return 0 or an error
> >>   *	code
> >> + * @device_get_max_len: Get the maximum supported length in bytes of a slave
> >> + *	transfer based on the set dma_slave_config. The length limitation
> >> + *	applies to each SG element's length.
> >>   * @device_pause: Pauses any transfer happening on a channel. Returns
> >>   *	0 or an error code
> >>   * @device_resume: Resumes any transfer on a channel previously
> >> @@ -792,6 +795,8 @@ struct dma_device {
> >>  
> >>  	int (*device_config)(struct dma_chan *chan,
> >>  			     struct dma_slave_config *config);
> >> +	u32 (*device_get_max_len)(struct dma_chan *chan,
> >> +				  enum dma_transfer_direction dir);
> >>  	int (*device_pause)(struct dma_chan *chan);
> >>  	int (*device_resume)(struct dma_chan *chan);
> >>  	int (*device_terminate_all)(struct dma_chan *chan);
> >> @@ -812,6 +817,15 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
> >>  	return -ENOSYS;
> >>  }
> >>  
> >> +static inline u32 dmaengine_slave_get_max_len(struct dma_chan *chan,
> >> +					      enum dma_transfer_direction dir)
> >> +{
> >> +	if (chan->device->device_get_max_len)
> >> +		return chan->device->device_get_max_len(chan, dir);
> > 
> > not another callback :)
> > 
> > on a serious note, why shouldn't this be one more capability in
> > dma_slave_caps. looking at next patch it seems static
> 
> It is not really static, the size in bytes depends on the dev_width and
> the maxburst:
> dev_width * burst * (SZ_64K - 1);

well DMAengines work on FIFOs, in above you are giving length as SZ_64K - 1
'items' which IIUC in DMAengine terms for bytes would always refer wrt width
used and burst applied.

Return length in bytes does make sense (from user PoV), but then you need to
"know" the applied  width and burst. How do you decide those?

> 
> The number of (dev_width * burst) is static, yes. Other DMA engines
> might have similar interpretation, but returning the maximum length in
> bytes sounded more generic for other engines to be able to adopt.
> 
> Initially I had maxburst_cnt in struct dma_device for maximum burst
> count within one SG, but it felt clumsy and not too intuitive either.

> 
> - Péter
> 

-- 
~Vinod
