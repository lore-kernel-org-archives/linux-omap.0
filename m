From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 01/13] OMAP: DMA: Replace read/write macros with
 functions
Date: Wed, 27 Oct 2010 09:24:49 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBEBEC0B@dbde02.ent.ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
 <1288099513-1854-2-git-send-email-manjugk@ti.com> <4CC6EA5A.8070302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49170 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab0J0DzA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 23:55:00 -0400
In-Reply-To: <4CC6EA5A.8070302@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Tuesday, October 26, 2010 8:19 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Cousson, Benoit; Kevin 
> Hilman; Shilimkar, Santosh
> Subject: Re: [PATCH v3 01/13] OMAP: DMA: Replace read/write 
> macros with functions
> 
> G, Manjunath Kondaiah had written, on 10/26/2010 08:25 AM, 
> the following:
> [...]
> > 
> > diff --git a/arch/arm/plat-omap/dma.c 
> b/arch/arm/plat-omap/dma.c index 
> > f5c5b8d..77241e2 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -40,6 +40,147 @@
> > 
[...]
> > +static u16 reg_map_omap2[] = {
> > +       [REVISION]              = 0x00,
> > +       [GCR2]                  = 0x78,
> > +       [IRQSTATUS_L0]          = 0x08,
> > +       [IRQSTATUS_L1]          = 0x0c,
> [..]
> > +       /* OMAP4 specific registers */
> > +       [CDP]                   = 0xd0,
> > +       [CNDP]                  = 0xd4,
> > +       [CCDN]                  = 0xd8,
> > +};
> > +
> dumb question: any reason why a struct wont do?
> struct reg_map_omap2 {
> u16 revision;
> ...
> ...
> }

This approach is as per i2c driver as suggested by kevin. 
http://www.spinics.net/lists/linux-omap/msg36446.html

> 
> [..]
> > 
> > -#define dma_read(reg)                                      
>             \
> > -({                                                         
>             \
> > -       u32 __val;                                          
>             \
> > -       if (cpu_class_is_omap1())                           
>             \
> > -               __val = __raw_readw(omap_dma_base + 
> OMAP1_DMA_##reg);   \
> > -       else                                                
>             \
> > -               __val = __raw_readl(omap_dma_base + 
> OMAP_DMA4_##reg);   \
> > -       __val;                                              
>             \
> > -})
> > -
> > -#define dma_write(val, reg)                                
>             \
> > -({                                                         
>             \
> > -       if (cpu_class_is_omap1())                           
>             \
> > -               __raw_writew((u16)(val), omap_dma_base + 
> OMAP1_DMA_##reg); \
> > -       else                                                
>             \
> > -               __raw_writel((val), omap_dma_base + 
> OMAP_DMA4_##reg);   \
> > -})
> > +static inline void dma_write(u32 val, int reg, int lch) {
> > +       if (cpu_class_is_omap1()) {
> > +               if (reg > OMAP1_CH_COMMON_START)
> > +                       __raw_writew(val, dma_base +
> > +                               (reg_map_omap1[reg] + 0x40 * lch));
> > +               else
> > +                       __raw_writew(val, dma_base + 
> reg_map_omap1[reg]);
> > +       } else {
> > +               if (reg > OMAP2_CH_COMMON_START)
> > +                       __raw_writel(val, dma_base +
> > +                               (reg_map_omap2[reg] + 0x60 * lch));
> > +               else
> > +                       __raw_writel(val, dma_base + 
> reg_map_omap2[reg]);
> > +       }
> > +}
> > +
> > +static inline u32 dma_read(int reg, int lch) {
> > +       u32 val;
> > +
> > +       if (cpu_class_is_omap1()) {
> > +               if (reg > OMAP1_CH_COMMON_START)
> > +                       val = __raw_readw(dma_base +
> > +                                       (reg_map_omap1[reg] 
> + 0x40 * lch));
> > +               else
> > +                       val = __raw_readw(dma_base + 
> reg_map_omap1[reg]);
> > +       } else {
> > +               if (reg > OMAP2_CH_COMMON_START)
> > +                       val = __raw_readl(dma_base +
> > +                                       (reg_map_omap2[reg] 
> + 0x60 * lch));
> > +               else
> > +                       val = __raw_readl(dma_base + 
> reg_map_omap2[reg]);
> > +       }
> > +       return val;
> > +}
> What is the benefit of using inline function here? would'nt 
> we increase code size? cant we use a function pointer 
> initialized to class1 or rest? 
> Quote from CodingStyle (15):
> "A reasonable rule of thumb is to not put inline at functions 
> that have more than 3 lines of code in them. An exception to 
> this rule are the cases where a parameter is known to be a 
> compiletime constant, and as a result of this constantness 
> you *know* the compiler will be able to optimize most of your 
> function away at compile time. For a good example of this 
> later case, see the kmalloc() inline function.
> "
> is the expectation that cpu_class_is_omap1 compile time 
> constant hence the actual compiled in code is smaller 
> -candidate for inline?

Detailed discussion and alignment can be found at:
http://www.spinics.net/lists/linux-omap/thrd6.html

Search for:
[PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration


> 
> > 
> >  #ifdef CONFIG_ARCH_OMAP15XX
> >  /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 
> >         if (cpu_class_is_omap1()) {
[...]
> >                 u16 ccr;
> > 
> > -               ccr = dma_read(CCR(lch));
> > +               l = dma_read(CSDP1, lch);
> > +               l &= ~0x03;
> > +               l |= data_type;
> > +               dma_write(l, CSDP1, lch);
> > +
> > +               ccr = dma_read(CCR1, lch);
> >                 ccr &= ~(1 << 5);
> >                 if (sync_mode == OMAP_DMA_SYNC_FRAME)
> >                         ccr |= 1 << 5;
> > -               dma_write(ccr, CCR(lch));
> > +               dma_write(ccr, CCR1, lch);
> > 
> > -               ccr = dma_read(CCR2(lch));
> > +               ccr = dma_read(CCR1_2, lch);
> >                 ccr &= ~(1 << 2);
> >                 if (sync_mode == OMAP_DMA_SYNC_BLOCK)
> >                         ccr |= 1 << 2;
> > -               dma_write(ccr, CCR2(lch));
> > +               dma_write(ccr, CCR1_2, lch);
> >         }
> > 
> >         if (cpu_class_is_omap2() && dma_trigger) {
> >                 u32 val;
> > 
> > -               val = dma_read(CCR(lch));
> > +               l = dma_read(CSDP2, lch);
> > +               l &= ~0x03;
> > +               l |= data_type;
> > +               dma_write(l, CSDP2, lch);
> This seems to me to be a replication mess :( compared to the original
> CSDP(lch) - which mapped to class1 or class2 as needed - same 
> elsewhere. 
> Code is becoming pretty much needing a refactoring as a result :(
> 
> [...]

This is interim patch towards hwmod and driver cleanup. As mentioned in the
patch description, objective is to replace lowlevel read/write macros with 
inline functions. For few registers(between omap1 and omap2+), the offset is 
different. Earlier, this offset difference was handled through macros. 
Now, it is replaced with inline functions, the code should be seperated for 
handling between omap1 and omap2+. It will get cleaned up once the code is 
moved respective mach-omapx directories.

You can have look at: PATCH 11/13 


-Manjunath