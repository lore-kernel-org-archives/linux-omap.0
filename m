From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v4 01/13] OMAP: DMA: Replace read/write macros with
 functions
Date: Wed, 10 Nov 2010 19:31:46 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBC@dbde02.ent.ti.com>
References: <1289225272-9767-1-git-send-email-manjugk@ti.com>
 <1289225272-9767-2-git-send-email-manjugk@ti.com>
 <20101109004045.GU9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40405 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab0KJOB6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 09:01:58 -0500
In-Reply-To: <20101109004045.GU9264@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Tuesday, November 09, 2010 6:11 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Cousson, Benoit; Kevin 
> Hilman; Shilimkar, Santosh
> Subject: Re: [PATCH v4 01/13] OMAP: DMA: Replace read/write 
> macros with functions
> 
> Hi,
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [101108 05:58]:
> 
> > +static u16 reg_map_omap1[] = {
> > +	[GCR1]		= 0x400,
> > +	[GSCR]		= 0x404,
> > +	[GRST]		= 0x408,
> ...
> > +};
> 
> The above you should move to mach-omap1/dma.c and pass it in the init
> function to plat-omap/dma.c. Let's try to make the common code clean
> of omap1/2/3/4 specific data.
> 
> > +static u16 reg_map_omap2[] = {
> > +	[REVISION]		= 0x00,
> > +	[GCR2]			= 0x78,
> > +	[IRQSTATUS_L0]		= 0x08,
> ...
> > +};
> 
> And the above you should move to mach-omap2/dma.c.
> 
> It's OK to do it in a later patch if you prefer that, but in that case
> the patch description here should mention it.

It's already taken care in the later patches. I will update the patch
description accordingly.

> 
> >  	if (cpu_class_is_omap2() && dma_trigger) {
> >  		u32 val;
> >  
> > -		val = dma_read(CCR(lch));
> > +		l = dma_read(CSDP2, lch);
> > +		l &= ~0x03;
> > +		l |= data_type;
> > +		dma_write(l, CSDP2, lch);
> > +
> > +		val = dma_read(CCR2, lch);
> 
> This seems to be doing more than just change the read function?
> 
> Please keep any functional changes separate. Let's first get the
> hwmod based initialization done without any functional changes
> to avoid breaking things.
>   
> > @@ -475,11 +654,19 @@ void omap_set_dma_src_data_pack(int 
> lch, int enable)
> >  {
> >  	u32 l;
> >  
> > -	l = dma_read(CSDP(lch));
> > +	if (cpu_class_is_omap1())
> > +		l = dma_read(CSDP1, lch);
> > +	else
> > +		l = dma_read(CSDP2, lch);
> > +
> >  	l &= ~(1 << 6);
> >  	if (enable)
> >  		l |= (1 << 6);
> > -	dma_write(l, CSDP(lch));
> > +
> > +	if (cpu_class_is_omap1())
> > +		dma_write(l, CSDP1, lch);
> > +	else
> > +		dma_write(l, CSDP2, lch);
> >  }
> 
> Since you now have the register mapping table, why do you still need
> to separate between CSDP1 and CSDP2 registers?
> 
> You should now be able to call them just CSDP, and then the register
> can be mapped to the right offset for omap1 and omap2+.
> 
> So this should be just:
> 
> void omap_set_dma_src_data_pack(int lch, int enable)
> {
> 	u32 l;
> 
> 	l = p->dma_read(CSDP, lch);
> 	l &= ~(1 << 6);
> 	if (enable)
> 		l |= (1 << 6);
> 	p->dma_write(l, CSDP, lch);
> }
> 
> Please check the other functions for this too, that should
> leave out quite a bit of if cpu_class_is_omap1 clutter.
> 
> And looking at it more, you should only have one enum for the
> registers, not separate enum for both omap1 and omap2+. The
> enum should be common for all of them. If needed, the enum
> should be separate for common register and channel specific
> registers.

ok. I will use single enum for all omap's in plat/dma.h which
can be accessed by both mach-omap1/dma.c and mach-omap2/dma.c
in later patches.

> 
> Some 32-bit registers for omap1 have the lower and upper registers,
> because of the 16-bit register access. So those still need to be
> handled separately for omap1. That can be handled automatically
> for omap1 (untested):
> 
> static inline u32 omap1_dma_read(int reg, int lch)
> {
> 	u32 va, val, ch_offset = 0;
> 
> 	if (reg > OMAP1_CH_COMMON_START)
> 		ch_offset = 0x40 * lch;
> 
> 	va = dma_base + reg_map_omap1[reg] + ch_offset;
> 	val = __raw_readw(va);
> 
> 	/* Some channel registers also have an associated upper 
> register */
> 	if (reg >= CSSA) {
> 		16 upper = __raw_readw(va + 2);
> 		val |= (upper << 16);
> 	}
> 
> 	return val;
> }

Thanks for the suggestion. It will be taken care with next version 
with some more optimizations such as determining ch_offset between
omap1 and omap2+, reg_map, ch_common_start at init time as suggested
by kevin.

-Manjunath