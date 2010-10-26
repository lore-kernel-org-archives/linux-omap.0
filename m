From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 01/13] OMAP: DMA: Replace read/write macros with functions
Date: Tue, 26 Oct 2010 09:48:58 -0500
Message-ID: <4CC6EA5A.8070302@ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com> <1288099513-1854-2-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34704 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759807Ab0JZOtE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 10:49:04 -0400
In-Reply-To: <1288099513-1854-2-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

G, Manjunath Kondaiah had written, on 10/26/2010 08:25 AM, the following:
[...]
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index f5c5b8d..77241e2 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -40,6 +40,147 @@
> 
>  #undef DEBUG
> 
> +enum {
> +       GCR1 = 0,       GSCR,           GRST,           HW_ID,
> +       PCH2_ID,        PCH0_ID,        PCH1_ID,        PCHG_ID,
> +       PCHD_ID,        CAPS1_0_U,      CAPS1_0_L,      CAPS1_1_U,
> +       CAPS1_1_L,      CAPS1_2,        CAPS1_3,        CAPS1_4,
> +       PCH2_SR,        PCH0_SR,        PCH1_SR,        PCHD_SR,
[...]

> +};
> +
> +static u16 reg_map_omap1[] = {
> +       [GCR1]          = 0x400,
> +       [GSCR]          = 0x404,
> +       [GRST]          = 0x408,
> +       [HW_ID]         = 0x442,
> +       [PCH2_ID]       = 0x444,
> +       [PCH0_ID]       = 0x446,
> +       [PCH1_ID]       = 0x448,
> +       [PCHG_ID]       = 0x44a,
> +       [PCHD_ID]       = 0x44c,
[...]
> +       [LCH_CTRL]      = 0x2a,
> +};
> +
> +enum {
> +       REVISION = 0,   GCR2,           IRQSTATUS_L0,   IRQSTATUS_L1,
> +       IRQSTATUS_L2,   IRQSTATUS_L3,   IRQENABLE_L0,   IRQENABLE_L1,
[...]
> +
> +       /* OMAP4 specific registers */
> +       CDP,            CNDP,           CCDN,
> +
> +       OMAP2_CH_COMMON_END,
> +};
> +
> +static u16 reg_map_omap2[] = {
> +       [REVISION]              = 0x00,
> +       [GCR2]                  = 0x78,
> +       [IRQSTATUS_L0]          = 0x08,
> +       [IRQSTATUS_L1]          = 0x0c,
[..]
> +       /* OMAP4 specific registers */
> +       [CDP]                   = 0xd0,
> +       [CNDP]                  = 0xd4,
> +       [CCDN]                  = 0xd8,
> +};
> +
dumb question: any reason why a struct wont do?
struct reg_map_omap2 {
u16 revision;
...
...
}

[..]
> 
> -#define dma_read(reg)                                                  \
> -({                                                                     \
> -       u32 __val;                                                      \
> -       if (cpu_class_is_omap1())                                       \
> -               __val = __raw_readw(omap_dma_base + OMAP1_DMA_##reg);   \
> -       else                                                            \
> -               __val = __raw_readl(omap_dma_base + OMAP_DMA4_##reg);   \
> -       __val;                                                          \
> -})
> -
> -#define dma_write(val, reg)                                            \
> -({                                                                     \
> -       if (cpu_class_is_omap1())                                       \
> -               __raw_writew((u16)(val), omap_dma_base + OMAP1_DMA_##reg); \
> -       else                                                            \
> -               __raw_writel((val), omap_dma_base + OMAP_DMA4_##reg);   \
> -})
> +static inline void dma_write(u32 val, int reg, int lch)
> +{
> +       if (cpu_class_is_omap1()) {
> +               if (reg > OMAP1_CH_COMMON_START)
> +                       __raw_writew(val, dma_base +
> +                               (reg_map_omap1[reg] + 0x40 * lch));
> +               else
> +                       __raw_writew(val, dma_base + reg_map_omap1[reg]);
> +       } else {
> +               if (reg > OMAP2_CH_COMMON_START)
> +                       __raw_writel(val, dma_base +
> +                               (reg_map_omap2[reg] + 0x60 * lch));
> +               else
> +                       __raw_writel(val, dma_base + reg_map_omap2[reg]);
> +       }
> +}
> +
> +static inline u32 dma_read(int reg, int lch)
> +{
> +       u32 val;
> +
> +       if (cpu_class_is_omap1()) {
> +               if (reg > OMAP1_CH_COMMON_START)
> +                       val = __raw_readw(dma_base +
> +                                       (reg_map_omap1[reg] + 0x40 * lch));
> +               else
> +                       val = __raw_readw(dma_base + reg_map_omap1[reg]);
> +       } else {
> +               if (reg > OMAP2_CH_COMMON_START)
> +                       val = __raw_readl(dma_base +
> +                                       (reg_map_omap2[reg] + 0x60 * lch));
> +               else
> +                       val = __raw_readl(dma_base + reg_map_omap2[reg]);
> +       }
> +       return val;
> +}
What is the benefit of using inline function here? would'nt we increase 
code size? cant we use a function pointer initialized to class1 or rest? 
Quote from CodingStyle (15):
"A reasonable rule of thumb is to not put inline at functions that have more
than 3 lines of code in them. An exception to this rule are the cases where
a parameter is known to be a compiletime constant, and as a result of this
constantness you *know* the compiler will be able to optimize most of your
function away at compile time. For a good example of this later case, see
the kmalloc() inline function.
"
is the expectation that cpu_class_is_omap1 compile time constant hence 
the actual compiled in code is smaller -candidate for inline?

> 
>  #ifdef CONFIG_ARCH_OMAP15XX
>  /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 otherwise */
> @@ -209,11 +369,10 @@ static inline void set_gdma_dev(int req, int dev)
>  /* Omap1 only */
>  static void clear_lch_regs(int lch)
>  {
> -       int i;
> -       void __iomem *lch_base = omap_dma_base + OMAP1_DMA_CH_BASE(lch);
> +       int i = OMAP1_CH_COMMON_START;
> 
> -       for (i = 0; i < 0x2c; i += 2)
> -               __raw_writew(0, lch_base + i);
> +       for (; i <= OMAP1_CH_COMMON_END; i += 1)
> +               dma_write(0, i, lch);
>  }
> 
>  void omap_set_dma_priority(int lch, int dst_port, int priority)
> @@ -248,12 +407,12 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
>         if (cpu_class_is_omap2()) {
>                 u32 ccr;
> 
> -               ccr = dma_read(CCR(lch));
> +               ccr = dma_read(CCR2, lch);
>                 if (priority)
>                         ccr |= (1 << 6);
>                 else
>                         ccr &= ~(1 << 6);
> -               dma_write(ccr, CCR(lch));
> +               dma_write(ccr, CCR2, lch);
>         }
>  }
>  EXPORT_SYMBOL(omap_set_dma_priority);
> @@ -264,31 +423,36 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
>  {
>         u32 l;
> 
> -       l = dma_read(CSDP(lch));
> -       l &= ~0x03;
> -       l |= data_type;
> -       dma_write(l, CSDP(lch));
> -
>         if (cpu_class_is_omap1()) {
>                 u16 ccr;
> 
> -               ccr = dma_read(CCR(lch));
> +               l = dma_read(CSDP1, lch);
> +               l &= ~0x03;
> +               l |= data_type;
> +               dma_write(l, CSDP1, lch);
> +
> +               ccr = dma_read(CCR1, lch);
>                 ccr &= ~(1 << 5);
>                 if (sync_mode == OMAP_DMA_SYNC_FRAME)
>                         ccr |= 1 << 5;
> -               dma_write(ccr, CCR(lch));
> +               dma_write(ccr, CCR1, lch);
> 
> -               ccr = dma_read(CCR2(lch));
> +               ccr = dma_read(CCR1_2, lch);
>                 ccr &= ~(1 << 2);
>                 if (sync_mode == OMAP_DMA_SYNC_BLOCK)
>                         ccr |= 1 << 2;
> -               dma_write(ccr, CCR2(lch));
> +               dma_write(ccr, CCR1_2, lch);
>         }
> 
>         if (cpu_class_is_omap2() && dma_trigger) {
>                 u32 val;
> 
> -               val = dma_read(CCR(lch));
> +               l = dma_read(CSDP2, lch);
> +               l &= ~0x03;
> +               l |= data_type;
> +               dma_write(l, CSDP2, lch);
This seems to me to be a replication mess :( compared to the original 
CSDP(lch) - which mapped to class1 or class2 as needed - same elsewhere. 
Code is becoming pretty much needing a refactoring as a result :(

[...]

-- 
Regards,
Nishanth Menon
