From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH for 4.4 1/2] dmaengine: edma: DT: Change memcpy channel
 array from 16bit to 32bit type
Date: Wed, 9 Dec 2015 14:06:37 -0600
Message-ID: <20151209200637.GA27153@rob-hp-laptop>
References: <1449649091-9848-1-git-send-email-peter.ujfalusi@ti.com>
 <1449649091-9848-2-git-send-email-peter.ujfalusi@ti.com>
 <20151209200200.GA22525@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151209200200.GA22525@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 09, 2015 at 02:02:00PM -0600, Rob Herring wrote:
> On Wed, Dec 09, 2015 at 10:18:10AM +0200, Peter Ujfalusi wrote:
> > This change makes the DT file to be easier to read since the memcpy
> > channels array does not need the '/bits/ 16' to be specified, which might
> > confuse some people.
> 
> Why? I don't see the point of this change and plus you are breaking 
> compatibility with the change. There was little reason to do 16-bit 
> values to start with, but that's now the ABI.

Okay, I now see the explanation in cover letter. That should be part of 
this commit message.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  
> Rob
> 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/dma/ti-edma.txt |  5 ++---
> >  drivers/dma/edma.c                                | 22 ++++++++++------------
> >  include/linux/platform_data/edma.h                |  2 +-
> >  3 files changed, 13 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> > index d3d0a4fb1c73..ae8b8f1d6e69 100644
> > --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
> > +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> > @@ -22,8 +22,7 @@ Required properties:
> >  Optional properties:
> >  - ti,hwmods:	Name of the hwmods associated to the eDMA CC
> >  - ti,edma-memcpy-channels: List of channels allocated to be used for memcpy, iow
> > -		these channels will be SW triggered channels. The list must
> > -		contain 16 bits numbers, see example.
> > +		these channels will be SW triggered channels. See example.
> >  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
> >  		the driver, they are allocated to be used by for example the
> >  		DSP. See example.
> > @@ -56,7 +55,7 @@ edma: edma@49000000 {
> >  	ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 7>, <&edma_tptc2 0>;
> >  
> >  	/* Channel 20 and 21 is allocated for memcpy */
> > -	ti,edma-memcpy-channels = /bits/ 16 <20 21>;
> > +	ti,edma-memcpy-channels = <20 21>;
> >  	/* The following PaRAM slots are reserved: 35-45 and 100-110 */
> >  	ti,edma-reserved-slot-ranges = /bits/ 16 <35 10>,
> >  				       /bits/ 16 <100 10>;
> > diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> > index 2af8f32bba0b..89fc17f3a6ff 100644
> > --- a/drivers/dma/edma.c
> > +++ b/drivers/dma/edma.c
> > @@ -1752,16 +1752,14 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
> >  	return ret;
> >  }
> >  
> > -static bool edma_is_memcpy_channel(int ch_num, u16 *memcpy_channels)
> > +static bool edma_is_memcpy_channel(int ch_num, s32 *memcpy_channels)
> >  {
> > -	s16 *memcpy_ch = memcpy_channels;
> > -
> >  	if (!memcpy_channels)
> >  		return false;
> > -	while (*memcpy_ch != -1) {
> > -		if (*memcpy_ch == ch_num)
> > +	while (*memcpy_channels != -1) {
> > +		if (*memcpy_channels == ch_num)
> >  			return true;
> > -		memcpy_ch++;
> > +		memcpy_channels++;
> >  	}
> >  	return false;
> >  }
> > @@ -1775,7 +1773,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
> >  {
> >  	struct dma_device *s_ddev = &ecc->dma_slave;
> >  	struct dma_device *m_ddev = NULL;
> > -	s16 *memcpy_channels = ecc->info->memcpy_channels;
> > +	s32 *memcpy_channels = ecc->info->memcpy_channels;
> >  	int i, j;
> >  
> >  	dma_cap_zero(s_ddev->cap_mask);
> > @@ -1996,16 +1994,16 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
> >  	prop = of_find_property(dev->of_node, "ti,edma-memcpy-channels", &sz);
> >  	if (prop) {
> >  		const char pname[] = "ti,edma-memcpy-channels";
> > -		size_t nelm = sz / sizeof(s16);
> > -		s16 *memcpy_ch;
> > +		size_t nelm = sz / sizeof(s32);
> > +		s32 *memcpy_ch;
> >  
> > -		memcpy_ch = devm_kcalloc(dev, nelm + 1, sizeof(s16),
> > +		memcpy_ch = devm_kcalloc(dev, nelm + 1, sizeof(s32),
> >  					 GFP_KERNEL);
> >  		if (!memcpy_ch)
> >  			return ERR_PTR(-ENOMEM);
> >  
> > -		ret = of_property_read_u16_array(dev->of_node, pname,
> > -						 (u16 *)memcpy_ch, nelm);
> > +		ret = of_property_read_u32_array(dev->of_node, pname,
> > +						 (u32 *)memcpy_ch, nelm);
> >  		if (ret)
> >  			return ERR_PTR(ret);
> >  
> > diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
> > index 105700e62ea1..0a533f94438f 100644
> > --- a/include/linux/platform_data/edma.h
> > +++ b/include/linux/platform_data/edma.h
> > @@ -76,7 +76,7 @@ struct edma_soc_info {
> >  	struct edma_rsv_info	*rsv;
> >  
> >  	/* List of channels allocated for memcpy, terminated with -1 */
> > -	s16			*memcpy_channels;
> > +	s32			*memcpy_channels;
> >  
> >  	s8	(*queue_priority_mapping)[2];
> >  	const s16	(*xbar_chans)[2];
> > -- 
> > 2.6.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
