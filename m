From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 01/13] OMAP: DMA: Replace read/write macros with
 functions
Date: Wed, 10 Nov 2010 19:31:52 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBD@dbde02.ent.ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-2-git-send-email-manjugk@ti.com>
 <87y692mb4e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37136 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755816Ab0KJOCB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 09:02:01 -0500
In-Reply-To: <87y692mb4e.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, November 10, 2010 3:08 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Cousson, Benoit; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v3 01/13] OMAP: DMA: Replace read/write 
> macros with functions
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > The low level read/write macros are replaced with static 
> inline functions
> > and register offsets are handled through static register 
> offset tables
> > mapped through enumeration constants.
> >
> > The objective of this patch is to prepare for omap dma 
> driver cleanup
> > and dma hwmod implementation. The code optimization and 
> moving machine
> > specific code to respective mach-omapx dma file will be 
> handled in the
> > rest of this patch series.
> 
> [...]
> 
> > -#define dma_write(val, reg)				
> 		\
> > -({								
> 	\
> > -	if (cpu_class_is_omap1())				
> 	\
> > -		__raw_writew((u16)(val), omap_dma_base + 
> OMAP1_DMA_##reg); \
> > -	else							
> 	\
> > -		__raw_writel((val), omap_dma_base + 
> OMAP_DMA4_##reg);	\
> > -})
> > +static inline void dma_write(u32 val, int reg, int lch)
> > +{
> > +	if (cpu_class_is_omap1()) {
> 
> Reminder: any use of cpu_is_* checks outside of init code 
> will be NAK'd.
> 
> cpu_is_* check do not belong at runtime, especially in a crucial path
> like this.  

ok. removed cpu_is_* checks and taken care in init.

> 
> > +		if (reg > OMAP1_CH_COMMON_START)
> > +			__raw_writew(val, dma_base +
> > +				(reg_map_omap1[reg] + 0x40 * lch));
> > +		else
> > +			__raw_writew(val, dma_base + 
> reg_map_omap1[reg]);
> > +	} else {
> > +		if (reg > OMAP2_CH_COMMON_START)
> > +			__raw_writel(val, dma_base +
> > +				(reg_map_omap2[reg] + 0x60 * lch));
> > +		else
> > +			__raw_writel(val, dma_base + 
> reg_map_omap2[reg]);
> > +	}
> > +}
> 
> The register base offset, register array and the stride 
> (offset between
> instances: 0x40 or 0x60) are detectable at init time, and there's no
> reason to have conditional code for them.  IOW, they should 
> be init time
> constants.  Doing so would greatly simply these functions.  
> In fact the
> CH_COMMON_START could also be an init time constant as well.  
> So, given
> the following init_time constants: dma_ch_common_start, dma_stride,
> reg_map, the above would be reduced to something actually worth
> inlining, for example (not actually tested):
> 
> static inline void dma_write(u32 val, int reg, int lch)
> {
>         u8 stride = (reg > dma_ch_common_start) ? dma_stride : 0;
> 
>         __raw_writel(val, dma_base + (reg_map[reg] + stride * lch));
> }
> 
> Same applies to dma_read().

Thanks for the suggestion. It is taken care along with Tony's comment
for handling these read/write's between omap1 and omap2+.

Here is code snippet for handling both omap1(includes 16 bit
registers) and omap2+ 

static inline void dma_write(u32 val, int reg, int lch)
{
        u8  stride;
        u32 offset;

        stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
        offset = reg_map[reg] + (stride * lch);

        if (dma_stride  == 0x40) {
                __raw_writew(val, omap_dma_base + offset);
                if ((reg > CLNK_CTRL && reg < CCR2) ||
                                (reg > PCHD_ID && reg < CAPS_2)) {
                        u32 offset2 = reg_map[reg] + 2 + (stride * lch);
                        __raw_writew(val >> 16, omap_dma_base + offset2);
                }
        } else
                __raw_writel(val, omap_dma_base + offset);
}

static inline u32 dma_read(int reg, int lch)
{
        u8 stride;
        u32 offset, val;

        stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
        offset = reg_map[reg] + (stride * lch);

        if (dma_stride  == 0x40) {
                val = __raw_readw(omap_dma_base + offset);
                if ((reg > CLNK_CTRL && reg < CCR2) ||
                                (reg > PCHD_ID && reg < CAPS_2)) {
                        u16 upper;
                        u32 offset2 = reg_map[reg] + 2 + (stride * lch);
                        upper = __raw_readw(omap_dma_base + offset2);
                        val |= (upper << 16);
                }
        } else
                val = __raw_readl(omap_dma_base + offset);
        return val;
}

-Manjunath
