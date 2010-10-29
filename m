From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 01/13] OMAP: DMA: Replace read/write macros with
 functions
Date: Fri, 29 Oct 2010 13:45:00 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBF58654@dbde02.ent.ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
 <1288099513-1854-2-git-send-email-manjugk@ti.com> <4CC6EA5A.8070302@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DBEBEC0B@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C014FD7F3FE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42464 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab0J2IPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 04:15:12 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C014FD7F3FE@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Wednesday, October 27, 2010 7:56 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Cousson, Benoit; Kevin 
> Hilman; Shilimkar, Santosh
> Subject: RE: [PATCH v3 01/13] OMAP: DMA: Replace read/write 
> macros with functions
> 
[...]
> > This approach is as per i2c driver as suggested by kevin.
> > http://www.spinics.net/lists/linux-omap/msg36446.html
> Thanks for pointing this out. I2c has what 18 registers while 
> dma has over 40 registers :( patch 11 [1] now I understand 
> this step -> this merges 
> together at later patchset - it starts to make sense now. It 
> becomes reg_map. Thanks - looks like a good change in the 
> eventual code.
> 
> 
> [...]
> > > > +static inline void dma_write(u32 val, int reg, int lch) {
> > > > +       if (cpu_class_is_omap1()) {
> > > > +               if (reg > OMAP1_CH_COMMON_START)
> > > > +                       __raw_writew(val, dma_base +
> > > > +                               (reg_map_omap1[reg] + 
> 0x40 * lch));
> > > > +               else
> > > > +                       __raw_writew(val, dma_base +
> > > reg_map_omap1[reg]);
> > > > +       } else {
> > > > +               if (reg > OMAP2_CH_COMMON_START)
> > > > +                       __raw_writel(val, dma_base +
> > > > +                               (reg_map_omap2[reg] + 
> 0x60 * lch));
> > > > +               else
> > > > +                       __raw_writel(val, dma_base +
> > > reg_map_omap2[reg]);
> > > > +       }
> > > > +}
> Eventual code looks like this:
> 
> 62 static inline void dma_write(u32 val, int reg, int lch)
> 63 {
> 64         if (d->dev_caps & IS_WORD_16) {
> 65                 if (reg >= CH_COMMON_START)
> 66                         __raw_writew(val, dma_base +
> 67                                 (reg_map[reg] + 0x40 * lch));
> 68                 else
> 69                         __raw_writew(val, dma_base + reg_map[reg]);
> 70         } else {
> 71                 if (reg > CH_COMMON_START)
> 72                         __raw_writel(val, dma_base +
> 73                                 (reg_map[reg] + 0x60 * lch));
> 74                 else
> 75                         __raw_writel(val, dma_base + reg_map[reg]);
> 76         }
> 77 }
> I don't really see how inline will really help here!
> 
> > > > +
> > > > +static inline u32 dma_read(int reg, int lch) {
> > > > +       u32 val;
> > > > +
> > > > +       if (cpu_class_is_omap1()) {
> > > > +               if (reg > OMAP1_CH_COMMON_START)
> > > > +                       val = __raw_readw(dma_base +
> > > > +                                       (reg_map_omap1[reg]
> > > + 0x40 * lch));
> > > > +               else
> > > > +                       val = __raw_readw(dma_base +
> > > reg_map_omap1[reg]);
> > > > +       } else {
> > > > +               if (reg > OMAP2_CH_COMMON_START)
> > > > +                       val = __raw_readl(dma_base +
> > > > +                                       (reg_map_omap2[reg]
> > > + 0x60 * lch));
> > > > +               else
> > > > +                       val = __raw_readl(dma_base +
> > > reg_map_omap2[reg]);
> > > > +       }
> > > > +       return val;
> > > > +}
> > > What is the benefit of using inline function here? would'nt
> > > we increase code size? cant we use a function pointer
> > > initialized to class1 or rest?
> > > Quote from CodingStyle (15):
> > > "A reasonable rule of thumb is to not put inline at functions
> > > that have more than 3 lines of code in them. An exception to
> > > this rule are the cases where a parameter is known to be a
> > > compiletime constant, and as a result of this constantness
> > > you *know* the compiler will be able to optimize most of your
> > > function away at compile time. For a good example of this
> > > later case, see the kmalloc() inline function.
> > > "
> > > is the expectation that cpu_class_is_omap1 compile time
> > > constant hence the actual compiled in code is smaller
> > > -candidate for inline?
> > 
> > Detailed discussion and alignment can be found at:
> > http://www.spinics.net/lists/linux-omap/thrd6.html
> Better link:
> http://marc.info/?t=128264802300006&r=1&w=2
> 
> > 
> > Search for:
> > [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
> 
> http://marc.info/?l=linux-omap&m=128464661906497&w=2
> my question is slightly different here - debate of suggestion 
> to use inline
> is based on the size of code involved, the discussion in the thread 
> discussed around 3 lines of code, which made sense, 
> unfortunately, the 
> thread does not answer my question unfortunately for *this* 
> specific patch
> - OR do you wish to point me to some specific link which answers this?

for plat-omap dma code, these read/write api's can be replaced with function
pointers.

-Manjunath
