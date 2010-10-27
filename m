From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH v3 01/13] OMAP: DMA: Replace read/write macros with
 functions
Date: Wed, 27 Oct 2010 09:26:08 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014FD7F3FE@dlee02.ent.ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
 <1288099513-1854-2-git-send-email-manjugk@ti.com> <4CC6EA5A.8070302@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DBEBEC0B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57001 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab0J0O0P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 10:26:15 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBEBEC0B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

> -----Original Message-----
> From: G, Manjunath Kondaiah
> Sent: Tuesday, October 26, 2010 10:55 PM
[..]

> > [...]
> > >
> > > diff --git a/arch/arm/plat-omap/dma.c
> > b/arch/arm/plat-omap/dma.c index
> > > f5c5b8d..77241e2 100644
> > > --- a/arch/arm/plat-omap/dma.c
> > > +++ b/arch/arm/plat-omap/dma.c
> > > @@ -40,6 +40,147 @@
> > >
> [...]
> > > +static u16 reg_map_omap2[] = {
> > > +       [REVISION]              = 0x00,
> > > +       [GCR2]                  = 0x78,
> > > +       [IRQSTATUS_L0]          = 0x08,
> > > +       [IRQSTATUS_L1]          = 0x0c,
> > [..]
> > > +       /* OMAP4 specific registers */
> > > +       [CDP]                   = 0xd0,
> > > +       [CNDP]                  = 0xd4,
> > > +       [CCDN]                  = 0xd8,
> > > +};
> > > +
> > dumb question: any reason why a struct wont do?
> > struct reg_map_omap2 {
> > u16 revision;
> > ...
> > ...
> > }
> 
> This approach is as per i2c driver as suggested by kevin.
> http://www.spinics.net/lists/linux-omap/msg36446.html
Thanks for pointing this out. I2c has what 18 registers while dma has over 40 registers :( patch 11 [1] now I understand this step -> this merges 
together at later patchset - it starts to make sense now. It becomes reg_map. Thanks - looks like a good change in the eventual code.


[...]
> > > +static inline void dma_write(u32 val, int reg, int lch) {
> > > +       if (cpu_class_is_omap1()) {
> > > +               if (reg > OMAP1_CH_COMMON_START)
> > > +                       __raw_writew(val, dma_base +
> > > +                               (reg_map_omap1[reg] + 0x40 * lch));
> > > +               else
> > > +                       __raw_writew(val, dma_base +
> > reg_map_omap1[reg]);
> > > +       } else {
> > > +               if (reg > OMAP2_CH_COMMON_START)
> > > +                       __raw_writel(val, dma_base +
> > > +                               (reg_map_omap2[reg] + 0x60 * lch));
> > > +               else
> > > +                       __raw_writel(val, dma_base +
> > reg_map_omap2[reg]);
> > > +       }
> > > +}
Eventual code looks like this:

62 static inline void dma_write(u32 val, int reg, int lch)
63 {
64         if (d->dev_caps & IS_WORD_16) {
65                 if (reg >= CH_COMMON_START)
66                         __raw_writew(val, dma_base +
67                                 (reg_map[reg] + 0x40 * lch));
68                 else
69                         __raw_writew(val, dma_base + reg_map[reg]);
70         } else {
71                 if (reg > CH_COMMON_START)
72                         __raw_writel(val, dma_base +
73                                 (reg_map[reg] + 0x60 * lch));
74                 else
75                         __raw_writel(val, dma_base + reg_map[reg]);
76         }
77 }
I don't really see how inline will really help here!

> > > +
> > > +static inline u32 dma_read(int reg, int lch) {
> > > +       u32 val;
> > > +
> > > +       if (cpu_class_is_omap1()) {
> > > +               if (reg > OMAP1_CH_COMMON_START)
> > > +                       val = __raw_readw(dma_base +
> > > +                                       (reg_map_omap1[reg]
> > + 0x40 * lch));
> > > +               else
> > > +                       val = __raw_readw(dma_base +
> > reg_map_omap1[reg]);
> > > +       } else {
> > > +               if (reg > OMAP2_CH_COMMON_START)
> > > +                       val = __raw_readl(dma_base +
> > > +                                       (reg_map_omap2[reg]
> > + 0x60 * lch));
> > > +               else
> > > +                       val = __raw_readl(dma_base +
> > reg_map_omap2[reg]);
> > > +       }
> > > +       return val;
> > > +}
> > What is the benefit of using inline function here? would'nt
> > we increase code size? cant we use a function pointer
> > initialized to class1 or rest?
> > Quote from CodingStyle (15):
> > "A reasonable rule of thumb is to not put inline at functions
> > that have more than 3 lines of code in them. An exception to
> > this rule are the cases where a parameter is known to be a
> > compiletime constant, and as a result of this constantness
> > you *know* the compiler will be able to optimize most of your
> > function away at compile time. For a good example of this
> > later case, see the kmalloc() inline function.
> > "
> > is the expectation that cpu_class_is_omap1 compile time
> > constant hence the actual compiled in code is smaller
> > -candidate for inline?
> 
> Detailed discussion and alignment can be found at:
> http://www.spinics.net/lists/linux-omap/thrd6.html
Better link:
http://marc.info/?t=128264802300006&r=1&w=2

> 
> Search for:
> [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration

http://marc.info/?l=linux-omap&m=128464661906497&w=2
my question is slightly different here - debate of suggestion to use inline
is based on the size of code involved, the discussion in the thread 
discussed around 3 lines of code, which made sense, unfortunately, the 
thread does not answer my question unfortunately for *this* specific patch
- OR do you wish to point me to some specific link which answers this?

> 
> 
> >
> > >
> > >  #ifdef CONFIG_ARCH_OMAP15XX
> > >  /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0
> > >         if (cpu_class_is_omap1()) {
> [...]
> > >                 u16 ccr;
> > >
> > > -               ccr = dma_read(CCR(lch));
> > > +               l = dma_read(CSDP1, lch);
> > > +               l &= ~0x03;
> > > +               l |= data_type;
> > > +               dma_write(l, CSDP1, lch);
> > > +
> > > +               ccr = dma_read(CCR1, lch);
> > >                 ccr &= ~(1 << 5);
> > >                 if (sync_mode == OMAP_DMA_SYNC_FRAME)
> > >                         ccr |= 1 << 5;
> > > -               dma_write(ccr, CCR(lch));
> > > +               dma_write(ccr, CCR1, lch);
> > >
> > > -               ccr = dma_read(CCR2(lch));
> > > +               ccr = dma_read(CCR1_2, lch);
> > >                 ccr &= ~(1 << 2);
> > >                 if (sync_mode == OMAP_DMA_SYNC_BLOCK)
> > >                         ccr |= 1 << 2;
> > > -               dma_write(ccr, CCR2(lch));
> > > +               dma_write(ccr, CCR1_2, lch);
> > >         }
> > >
> > >         if (cpu_class_is_omap2() && dma_trigger) {
> > >                 u32 val;
> > >
> > > -               val = dma_read(CCR(lch));
> > > +               l = dma_read(CSDP2, lch);
> > > +               l &= ~0x03;
> > > +               l |= data_type;
> > > +               dma_write(l, CSDP2, lch);
> > This seems to me to be a replication mess :( compared to the original
> > CSDP(lch) - which mapped to class1 or class2 as needed - same
> > elsewhere.
> > Code is becoming pretty much needing a refactoring as a result :(
> >
> > [...]
> 
> This is interim patch towards hwmod and driver cleanup. As mentioned in
> the
> patch description, objective is to replace lowlevel read/write macros with
> inline functions. For few registers(between omap1 and omap2+), the offset
> is
> different. Earlier, this offset difference was handled through macros.
> Now, it is replaced with inline functions, the code should be seperated
> for
> handling between omap1 and omap2+. It will get cleaned up once the code is
> moved respective mach-omapx directories.
> 
> You can have look at: PATCH 11/13

Ok looks like it never made to ML :( [1] as you refered to in a later patch 
Makes sense to me now. Thanks.


[1] http://dev.omapzoom.org/?p=manju/kernel-omap3-dev.git;a=commitdiff;h=7457a6b4248772aaa52dfb13a170f891596a512a
Regards,
Nishanth Menon
