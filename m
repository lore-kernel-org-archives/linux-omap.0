From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from plat-omap to mach-omap
Date: Tue, 22 Apr 2008 09:29:50 +0300
Message-ID: <a0580c510804212329p141712d7g97bf9f07dbd59621@mail.gmail.com>
References: <20080414181827.GE4463@kedavra.cpe.vivax.com.br>
	 <1208203891-11225-1-git-send-email-edubezval@gmail.com>
	 <1208203891-11225-2-git-send-email-edubezval@gmail.com>
	 <20080421183305.GB12099@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:3318 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbYDVG3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 02:29:53 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3662776waf.23
        for <linux-omap@vger.kernel.org>; Mon, 21 Apr 2008 23:29:50 -0700 (PDT)
In-Reply-To: <20080421183305.GB12099@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Tony,

I'll apply your comments and re-write mcbsp driver as a platform driver.

On top of that, each mcbsp will have a platformdata. This way we can get
struct device for each of configured mcbsp. And then use correctly the
clock framework. Of cource, modifications on mcbsp clock definitions is also
required.

I'll also try to keep the mcbsp API to another drivers which may need it,
so other part of the code will not be broken. A separeted series to
change the API
may be need. But for now let's update the mcbsp driver.

I'll repost this patch as another series soon.

Cheers,

On Mon, Apr 21, 2008 at 9:33 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
>  Some comments below.
>
>  * Eduardo Valentin <edubezval@gmail.com> [080414 13:13]:
>
>
> > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  >
>  > This patch gets ride of ifdefs on mcbsp.c code.
>  > It moves the mach specific code to mach-omap*.
>  >
>  > Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  > ---
>  >  arch/arm/mach-omap1/Makefile      |    2 +
>  >  arch/arm/mach-omap1/mcbsp.c       |  202 +++++++++++++++++++++
>  >  arch/arm/mach-omap2/Makefile      |    2 +
>  >  arch/arm/mach-omap2/mcbsp.c       |  145 ++++++++++++++++
>  >  arch/arm/plat-omap/mcbsp.c        |  346 +++++--------------------------------
>  >  include/asm-arm/arch-omap/mcbsp.h |   19 ++
>  >  6 files changed, 417 insertions(+), 299 deletions(-)
>  >  create mode 100644 arch/arm/mach-omap1/mcbsp.c
>  >  create mode 100644 arch/arm/mach-omap2/mcbsp.c
>  >
>  > diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
>  > index 6ebf23b..09246a7 100644
>  > --- a/arch/arm/mach-omap1/Makefile
>  > +++ b/arch/arm/mach-omap1/Makefile
>  > @@ -5,6 +5,8 @@
>  >  # Common support
>  >  obj-y := io.o id.o clock.o irq.o mux.o serial.o devices.o
>  >
>  > +obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>  > +
>  >  obj-$(CONFIG_OMAP_MPU_TIMER) += time.o
>  >  obj-$(CONFIG_OMAP_32K_TIMER) += timer32k.o
>  >
>  > diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
>  > new file mode 100644
>  > index 0000000..299f036
>  > --- /dev/null
>  > +++ b/arch/arm/mach-omap1/mcbsp.c
>  > @@ -0,0 +1,202 @@
>  > +/*
>  > + * linux/arch/arm/mach-omap1/mcbsp.c
>  > + *
>  > + * Copyright (C) 2008 Instituto Nokia de Tecnologia
>  > + * Contact: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  > + *
>  > + * This program is free software; you can redistribute it and/or modify
>  > + * it under the terms of the GNU General Public License version 2 as
>  > + * published by the Free Software Foundation.
>  > + *
>  > + * Multichannel mode not supported.
>  > + */
>  > +#include <linux/module.h>
>  > +#include <linux/init.h>
>  > +#include <linux/clk.h>
>  > +#include <linux/err.h>
>  > +#include <linux/io.h>
>  > +
>  > +#include <asm/arch/dma.h>
>  > +#include <asm/arch/mux.h>
>  > +#include <asm/arch/cpu.h>
>  > +#include <asm/arch/mcbsp.h>
>  > +#include <asm/arch/dsp_common.h>
>  > +
>  > +static struct clk *mcbsp_dsp_ck;
>  > +static struct clk *mcbsp_api_ck;
>  > +static struct clk *mcbsp_dspxor_ck;
>  > +
>  > +static void omap_mcbsp_dsp_request(void)
>  > +{
>  > +     if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
>  > +             int ret;
>  > +
>  > +             ret = omap_dsp_request_mem();
>  > +             if (ret < 0) {
>  > +                     printk(KERN_ERR "Could not get dsp memory: %i\n", ret);
>  > +                     return;
>  > +             }
>  > +
>  > +             clk_enable(mcbsp_dsp_ck);
>  > +             clk_enable(mcbsp_api_ck);
>  > +
>  > +             /* enable 12MHz clock to mcbsp 1 & 3 */
>  > +             clk_enable(mcbsp_dspxor_ck);
>  > +
>  > +             /*
>  > +              * DSP external peripheral reset
>  > +              * FIXME: This should be moved to dsp code
>  > +              */
>  > +             __raw_writew(__raw_readw(DSP_RSTCT2) | 1 | 1 << 1,
>  > +                          DSP_RSTCT2);
>  > +     }
>  > +}
>
>  How about just do an early return and leave out test for
>  cpu_is_omap15xx/16xx():
>
>  if (cpu_is_omap730())
>         return;
>
>
>
>  > +static void omap_mcbsp_dsp_free(void)
>  > +{
>  > +     if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
>  > +             omap_dsp_release_mem();
>  > +             clk_disable(mcbsp_dspxor_ck);
>  > +             clk_disable(mcbsp_dsp_ck);
>  > +             clk_disable(mcbsp_api_ck);
>  > +     }
>  > +}
>
>  Here too.
>
>
>
>  > +static int omap1_mcbsp_check(unsigned int id)
>  > +{
>  > +     if (cpu_is_omap730()) {
>  > +             if (id > OMAP_MAX_MCBSP_COUNT - 1) {
>  > +                    printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
>  > +                             id + 1);
>  > +                    return -ENODEV;
>  > +             }
>  > +             return 0;
>  > +     }
>  > +
>  > +     if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
>  > +             if (id > OMAP_MAX_MCBSP_COUNT) {
>  > +                     printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
>  > +                             id + 1);
>  > +                     return -ENODEV;
>  > +             }
>  > +             return 0;
>  > +     }
>  > +
>  > +     return -ENODEV;
>  > +}
>  > +
>  > +static void omap1_mcbsp_request(unsigned int id)
>  > +{
>  > +     /*
>  > +      * On 1510, 1610 and 1710, McBSP1 and McBSP3
>  > +      * are DSP public peripherals.
>  > +      */
>  > +     if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
>  > +             omap_mcbsp_dsp_request();
>  > +}
>  > +
>  > +static void omap1_mcbsp_free(unsigned int id)
>  > +{
>  > +     if (cpu_class_is_omap1()) {
>  > +             if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
>  > +                     omap_mcbsp_dsp_free();
>  > +     }
>  > +}
>
>  Since these are all in mach-omap1, cpu_class_is_omap1() is always true,
>  so it can be left out.
>
>
>  > +struct omap_mcbsp_board_cfg omap1_mcbsp_cfg = {
>  > +     .check          = omap1_mcbsp_check,
>  > +     .request        = omap1_mcbsp_request,
>  > +     .free           = omap1_mcbsp_free,
>  > +     .mcbsp_infos    =
>  > +#ifdef CONFIG_ARCH_OMAP730
>  > +     {
>  > +             [0] = {
>  > +                     .virt_base = io_p2v(OMAP730_MCBSP1_BASE),
>  > +                     .dma_rx_sync = OMAP_DMA_MCBSP1_RX,
>  > +                     .dma_tx_sync = OMAP_DMA_MCBSP1_TX,
>  > +                     .rx_irq = INT_730_McBSP1RX,
>  > +                     .tx_irq = INT_730_McBSP1TX,
>  > +             },
>  > +             [1] = {
>  > +                     .virt_base = io_p2v(OMAP730_MCBSP2_BASE),
>  > +                     .dma_rx_sync = OMAP_DMA_MCBSP3_RX,
>  > +                     .dma_tx_sync = OMAP_DMA_MCBSP3_TX,
>  > +                     .rx_irq = INT_730_McBSP2RX,
>  > +                     .tx_irq = INT_730_McBSP2TX
>  > +             },
>  > +     },
>  > +#elif defined(CONFIG_ARCH_OMAP15XX)
>
>  This should not be #elif, it's possible to compile in support for
>  multiple boards.
>
>
>
>  > +     {
>  > +             [0] = {
>  > +                     .virt_base = OMAP1510_MCBSP1_BASE,
>  > +                     .dma_rx_sync = OMAP_DMA_MCBSP1_RX,
>  > +                     .dma_tx_sync = OMAP_DMA_MCBSP1_TX,
>  > +                     .rx_irq = INT_McBSP1RX,
>  > +                     .tx_irq = INT_McBSP1TX
>  > +             },
>  > +             [1] = {
>  > +                     .virt_base = io_p2v(OMAP1510_MCBSP2_BASE),
>  > +                     .dma_rx_sync = OMAP_DMA_MCBSP2_RX,
>  > +                     .dma_tx_sync = OMAP_DMA_MCBSP2_TX,
>  > +                     .rx_irq = INT_1510_SPI_RX,
>  > +                     .tx_irq = INT_1510_SPI_TX
>  > +             },
>  > +             [2] = {
>  > +                     .virt_base = OMAP1510_MCBSP3_BASE,
>  > +                     .dma_rx_sync = OMAP_DMA_MCBSP3_RX,
>  > +                     .dma_tx_sync = OMAP_DMA_MCBSP3_TX,
>  > +                     .rx_irq = INT_McBSP3RX,
>  > +                     .tx_irq = INT_McBSP3TX
>  > +     },
>  > +#elif defined(CONFIG_ARCH_OMAP16XX)
>
>  This too. See how this is handled for example in mux.c.
>
>
>
>
>  > +     {
>  > +             [0] = {
>  > +                     .virt_base = OMAP1610_MCBSP1_BASE,
>  > +                     .dma_rx_sync = OMAP_DMA_MCBSP1_RX,
>  > +                     .dma_tx_sync = OMAP_DMA_MCBSP1_TX,
>  > +                     .rx_irq = INT_McBSP1RX,
>  > +                     .tx_irq = INT_McBSP1TX
>  > +             },
>  > +             [1] = {
>  > +                     .virt_base = io_p2v(OMAP1610_MCBSP2_BASE),
>  > +                     .dma_rx_sync = OMAP_DMA_MCBSP2_RX,
>  > +                     .dma_tx_sync = OMAP_DMA_MCBSP2_TX,
>  > +                     .rx_irq = INT_1610_McBSP2_RX,
>  > +                     .tx_irq = INT_1610_McBSP2_TX
>  > +             },
>  > +             [2] = {
>  > +                     .virt_base = OMAP1610_MCBSP3_BASE,
>  > +                     .dma_rx_sync = OMAP_DMA_MCBSP3_RX,
>  > +                     .dma_tx_sync = OMAP_DMA_MCBSP3_TX,
>  > +                     .rx_irq = INT_McBSP3RX,
>  > +                     .tx_irq = INT_McBSP3TX
>  > +             },
>  > +     },
>  > +#else
>  > +NULL /* For .mcbsp_infos */
>  > +#endif
>  > +};
>  > +
>  > +int __init omap1_mcbsp_init(void)
>  > +{
>  > +     mcbsp_dsp_ck = clk_get(0, "dsp_ck");
>  > +     if (IS_ERR(mcbsp_dsp_ck)) {
>  > +             printk(KERN_ERR "mcbsp: could not acquire dsp_ck handle.\n");
>  > +             return PTR_ERR(mcbsp_dsp_ck);
>  > +     }
>
>  I believe this will return error on 730 and init will fail.
>
>
>
>  > +     mcbsp_api_ck = clk_get(0, "api_ck");
>  > +     if (IS_ERR(mcbsp_api_ck)) {
>  > +             printk(KERN_ERR "mcbsp: could not acquire api_ck handle.\n");
>  > +             return PTR_ERR(mcbsp_api_ck);
>  > +     }
>  > +     mcbsp_dspxor_ck = clk_get(0, "dspxor_ck");
>  > +     if (IS_ERR(mcbsp_dspxor_ck)) {
>  > +             printk(KERN_ERR "mcbsp: could not acquire dspxor_ck handle.\n");
>  > +             return PTR_ERR(mcbsp_dspxor_ck);
>  > +     }
>
>  This one too I guess.
>
>
>
>  > +     omap_mcbsp_register_board_cfg(&omap1_mcbsp_cfg);
>  > +
>  > +     return omap_mcbsp_init();
>  > +}
>  > +arch_initcall(omap1_mcbsp_init);
>  > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>  > index 5157ff2..771f8e7 100644
>  > --- a/arch/arm/mach-omap2/Makefile
>  > +++ b/arch/arm/mach-omap2/Makefile
>  > @@ -6,6 +6,8 @@
>  >  obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
>  >               devices.o serial.o gpmc.o timer-gp.o
>  >
>  > +obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>  > +
>  >  # Functions loaded to SRAM
>  >  obj-$(CONFIG_ARCH_OMAP2)             += sram24xx.o
>  >
>  > diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
>  > new file mode 100644
>  > index 0000000..8c8b97f
>  > --- /dev/null
>  > +++ b/arch/arm/mach-omap2/mcbsp.c
>  > @@ -0,0 +1,145 @@
>  > +/*
>  > + * linux/arch/arm/mach-omap1/mcbsp.c
>  > + *
>
>  Should be mach-omap2 above.
>
>
>
>
>  > + * Copyright (C) 2008 Instituto Nokia de Tecnologia
>  > + * Contact: Eduardo Valentin <eduardo.valentin@indt.org.br>
>  > + *
>  > + * This program is free software; you can redistribute it and/or modify
>  > + * it under the terms of the GNU General Public License version 2 as
>  > + * published by the Free Software Foundation.
>  > + *
>  > + * Multichannel mode not supported.
>  > + */
>  > +#include <linux/module.h>
>  > +#include <linux/init.h>
>  > +#include <linux/clk.h>
>  > +#include <linux/err.h>
>  > +
>  > +#include <asm/arch/dma.h>
>  > +#include <asm/arch/mux.h>
>  > +#include <asm/arch/cpu.h>
>  > +#include <asm/arch/mcbsp.h>
>  > +
>  > +static struct clk *mcbsp1_ick;
>  > +static struct clk *mcbsp1_fck;
>  > +static struct clk *mcbsp2_ick;
>  > +static struct clk *mcbsp2_fck;
>  > +
>  > +static void omap2_mcbsp2_mux_setup(void)
>  > +{
>  > +     if (cpu_is_omap2420()) {
>  > +             omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
>  > +             omap_cfg_reg(R14_24XX_MCBSP2_FSX);
>  > +             omap_cfg_reg(W15_24XX_MCBSP2_DR);
>  > +             omap_cfg_reg(V15_24XX_MCBSP2_DX);
>  > +             omap_cfg_reg(V14_24XX_GPIO117);
>  > +     }
>  > +     /*
>  > +      * Need to add MUX settings for OMAP 2430 SDP
>  > +      */
>  > +}
>  > +
>  > +static int omap2_mcbsp_check(unsigned int id)
>  > +{
>  > +     if (cpu_class_is_omap2()) {
>  > +             if (id > OMAP_MAX_MCBSP_COUNT) {
>  > +                     printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
>  > +                             id + 1);
>  > +                     return -ENODEV;
>  > +             }
>  > +             return 0;
>  > +     }
>  > +
>  > +     return -ENODEV;
>  > +}
>
>  The cpu_class_is_omap2() above is not needed, it's always true.
>
>
>
>  > +static void omap2_mcbsp_request(unsigned int id)
>  > +{
>  > +     if (cpu_class_is_omap2()) {
>  > +             if (id == OMAP_MCBSP1) {
>  > +                     clk_enable(mcbsp1_ick);
>  > +                     clk_enable(mcbsp1_fck);
>  > +             } else {
>  > +                     clk_enable(mcbsp2_ick);
>  > +                     clk_enable(mcbsp2_fck);
>  > +             }
>  > +     }
>  > +}
>
>  Here too. And a line break is missing between this and next function.
>
>
>
>  > +static void omap2_mcbsp_free(unsigned int id)
>  > +{
>  > +     if (cpu_class_is_omap2()) {
>  > +             if (id == OMAP_MCBSP1) {
>  > +                     clk_disable(mcbsp1_ick);
>  > +                     clk_disable(mcbsp1_fck);
>  > +             } else {
>  > +                     clk_disable(mcbsp2_ick);
>  > +                     clk_disable(mcbsp2_fck);
>  > +             }
>  > +     }
>  > +}
>
>  Unnecessary cpu_class_is_omap2() here too.
>
>
>
>  > +static const struct omap_mcbsp_board_cfg mcbsp_24xx_cfg = {
>  > +     .check          = omap2_mcbsp_check,
>  > +     .request        = omap2_mcbsp_request,
>  > +     .free           = omap2_mcbsp_free,
>  > +     .mcbsp_infos    = {
>  > +             [0] = {
>  > +#if defined(CONFIG_ARCH_OMAP24XX)
>  > +                     .virt_base = IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
>  > +#elif defined(CONFIG_ARCH_OMAP34XX)
>  > +                     .virt_base = IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
>  > +#endif
>
>  This #elif will add artificial blocker to compile in both 24xx and 34xx.
>
>
>
>  > +                     .dma_rx_sync = OMAP24XX_DMA_MCBSP1_RX,
>  > +                     .dma_tx_sync = OMAP24XX_DMA_MCBSP1_TX,
>  > +                     .rx_irq = INT_24XX_MCBSP1_IRQ_RX,
>  > +                     .tx_irq = INT_24XX_MCBSP1_IRQ_TX,
>  > +             },
>  > +             [1] = {
>  > +#if defined(CONFIG_ARCH_OMAP24XX)
>  > +                     .virt_base = IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
>  > +#elif defined(CONFIG_ARCH_OMAP34XX)
>  > +                     .virt_base = IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
>  > +#endif
>
>  Here too.
>
>
>
>
>  > +                     .dma_rx_sync = OMAP24XX_DMA_MCBSP2_RX,
>  > +                     .dma_tx_sync = OMAP24XX_DMA_MCBSP2_TX,
>  > +                     .rx_irq = INT_24XX_MCBSP2_IRQ_RX,
>  > +                     .tx_irq = INT_24XX_MCBSP2_IRQ_TX,
>  > +             },
>  > +     },
>  > +};
>  > +
>  > +int __init omap2_mcbsp_init(void)
>  > +{
>  > +     mcbsp1_ick = clk_get(0, "mcbsp1_ick");
>  > +     if (IS_ERR(mcbsp1_ick)) {
>  > +             printk(KERN_ERR "mcbsp: could not acquire "
>  > +                             "mcbsp1_ick handle.\n");
>  > +             return PTR_ERR(mcbsp1_ick);
>  > +     }
>  > +     mcbsp1_fck = clk_get(0, "mcbsp1_fck");
>  > +     if (IS_ERR(mcbsp1_fck)) {
>  > +             printk(KERN_ERR "mcbsp: could not acquire "
>  > +                             "mcbsp1_fck handle.\n");
>  > +             return PTR_ERR(mcbsp1_fck);
>  > +     }
>  > +     mcbsp2_ick = clk_get(0, "mcbsp2_ick");
>  > +     if (IS_ERR(mcbsp2_ick)) {
>  > +             printk(KERN_ERR "mcbsp: could not acquire "
>  > +                             "mcbsp2_ick handle.\n");
>  > +             return PTR_ERR(mcbsp2_ick);
>  > +     }
>  > +     mcbsp2_fck = clk_get(0, "mcbsp2_fck");
>  > +     if (IS_ERR(mcbsp2_fck)) {
>  > +             printk(KERN_ERR "mcbsp: could not acquire "
>  > +                             "mcbsp2_fck handle.\n");
>  > +             return PTR_ERR(mcbsp2_fck);
>  > +     }
>  > +
>  > +     if (cpu_class_is_omap2()) {
>  > +             omap_mcbsp_register_board_cfg(&mcbsp_24xx_cfg);
>  > +             omap2_mcbsp2_mux_setup();
>  > +     }
>
>  Unnecessary cpu_class_is_omap2() here too.
>
>
>
>
>  > +     return omap_mcbsp_init();
>  > +}
>  > +arch_initcall(omap2_mcbsp_init);
>  > diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
>  > index 053de31..fdba002 100644
>  > --- a/arch/arm/plat-omap/mcbsp.c
>  > +++ b/arch/arm/plat-omap/mcbsp.c
>  > @@ -24,11 +24,8 @@
>  >  #include <linux/io.h>
>  >  #include <linux/irq.h>
>  >
>  > -#include <asm/arch/dma.h>
>  > -#include <asm/arch/mux.h>
>  > -#include <asm/arch/irqs.h>
>  > -#include <asm/arch/dsp_common.h>
>  >  #include <asm/arch/mcbsp.h>
>  > +#include <asm/arch/dma.h>
>  >
>  >  #ifdef CONFIG_MCBSP_DEBUG
>  >  #define DBG(x...)    printk(x)
>  > @@ -65,17 +62,10 @@ struct omap_mcbsp {
>  >  };
>  >
>  >  static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
>  > -#ifdef CONFIG_ARCH_OMAP1
>  > -static struct clk *mcbsp_dsp_ck;
>  > -static struct clk *mcbsp_api_ck;
>  > -static struct clk *mcbsp_dspxor_ck;
>  > -#endif
>  > -#ifdef CONFIG_ARCH_OMAP2
>  > -static struct clk *mcbsp1_ick;
>  > -static struct clk *mcbsp1_fck;
>  > -static struct clk *mcbsp2_ick;
>  > -static struct clk *mcbsp2_fck;
>  > -#endif
>  > +static const struct omap_mcbsp_board_cfg *mcbsp_config;
>  > +
>  > +#define omap_mcbsp_check_invalid_id(id)      (mcbsp_config && mcbsp_config->check \
>  > +                                     && (mcbsp_config->check(id) < 0))
>  >
>  >  static void omap_mcbsp_dump_reg(u8 id)
>  >  {
>  > @@ -175,90 +165,13 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
>  >  }
>  >  EXPORT_SYMBOL(omap_mcbsp_config);
>  >
>  > -static int omap_mcbsp_check(unsigned int id)
>  > -{
>  > -     if (cpu_is_omap730()) {
>  > -             if (id > OMAP_MAX_MCBSP_COUNT - 1) {
>  > -                    printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
>  > -                             id + 1);
>  > -                    return -1;
>  > -             }
>  > -             return 0;
>  > -     }
>  > -
>  > -     if (cpu_is_omap15xx() || cpu_is_omap16xx() || cpu_is_omap24xx()) {
>  > -             if (id > OMAP_MAX_MCBSP_COUNT) {
>  > -                     printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
>  > -                             id + 1);
>  > -                     return -1;
>  > -             }
>  > -             return 0;
>  > -     }
>  > -
>  > -     return -1;
>  > -}
>  > -
>  > -#ifdef CONFIG_ARCH_OMAP1
>  > -static void omap_mcbsp_dsp_request(void)
>  > -{
>  > -     if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
>  > -             int ret;
>  > -
>  > -             ret = omap_dsp_request_mem();
>  > -             if (ret < 0) {
>  > -                     printk(KERN_ERR "Could not get dsp memory: %i\n", ret);
>  > -                     return;
>  > -             }
>  > -
>  > -             clk_enable(mcbsp_dsp_ck);
>  > -             clk_enable(mcbsp_api_ck);
>  > -
>  > -             /* enable 12MHz clock to mcbsp 1 & 3 */
>  > -             clk_enable(mcbsp_dspxor_ck);
>  > -
>  > -             /*
>  > -              * DSP external peripheral reset
>  > -              * FIXME: This should be moved to dsp code
>  > -              */
>  > -             __raw_writew(__raw_readw(DSP_RSTCT2) | 1 | 1 << 1,
>  > -                          DSP_RSTCT2);
>  > -     }
>  > -}
>  > -
>  > -static void omap_mcbsp_dsp_free(void)
>  > -{
>  > -     if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
>  > -             omap_dsp_release_mem();
>  > -             clk_disable(mcbsp_dspxor_ck);
>  > -             clk_disable(mcbsp_dsp_ck);
>  > -             clk_disable(mcbsp_api_ck);
>  > -     }
>  > -}
>  > -#endif
>  > -
>  > -#ifdef CONFIG_ARCH_OMAP2
>  > -static void omap2_mcbsp2_mux_setup(void)
>  > -{
>  > -     if (cpu_is_omap2420()) {
>  > -             omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
>  > -             omap_cfg_reg(R14_24XX_MCBSP2_FSX);
>  > -             omap_cfg_reg(W15_24XX_MCBSP2_DR);
>  > -             omap_cfg_reg(V15_24XX_MCBSP2_DX);
>  > -             omap_cfg_reg(V14_24XX_GPIO117);
>  > -     }
>  > -     /*
>  > -      * Need to add MUX settings for OMAP 2430 SDP
>  > -      */
>  > -}
>  > -#endif
>  > -
>  >  /*
>  >   * We can choose between IRQ based or polled IO.
>  >   * This needs to be called before omap_mcbsp_request().
>  >   */
>  >  int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type)
>  >  {
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return -EINVAL;
>  >
>  >       spin_lock(&mcbsp[id].lock);
>  > @@ -282,29 +195,11 @@ int omap_mcbsp_request(unsigned int id)
>  >  {
>  >       int err;
>  >
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return -EINVAL;
>  >
>  > -#ifdef CONFIG_ARCH_OMAP1
>  > -     /*
>  > -      * On 1510, 1610 and 1710, McBSP1 and McBSP3
>  > -      * are DSP public peripherals.
>  > -      */
>  > -     if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
>  > -             omap_mcbsp_dsp_request();
>  > -#endif
>  > -
>  > -#ifdef CONFIG_ARCH_OMAP2
>  > -     if (cpu_is_omap24xx()) {
>  > -             if (id == OMAP_MCBSP1) {
>  > -                     clk_enable(mcbsp1_ick);
>  > -                     clk_enable(mcbsp1_fck);
>  > -             } else {
>  > -                     clk_enable(mcbsp2_ick);
>  > -                     clk_enable(mcbsp2_fck);
>  > -             }
>  > -     }
>  > -#endif
>  > +     if (mcbsp_config && mcbsp_config->request)
>  > +             mcbsp_config->request(id);
>  >
>  >       spin_lock(&mcbsp[id].lock);
>  >       if (!mcbsp[id].free) {
>  > @@ -349,27 +244,11 @@ EXPORT_SYMBOL(omap_mcbsp_request);
>  >
>  >  void omap_mcbsp_free(unsigned int id)
>  >  {
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return;
>  >
>  > -#ifdef CONFIG_ARCH_OMAP1
>  > -     if (cpu_class_is_omap1()) {
>  > -             if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
>  > -                     omap_mcbsp_dsp_free();
>  > -     }
>  > -#endif
>  > -
>  > -#ifdef CONFIG_ARCH_OMAP2
>  > -     if (cpu_is_omap24xx()) {
>  > -             if (id == OMAP_MCBSP1) {
>  > -                     clk_disable(mcbsp1_ick);
>  > -                     clk_disable(mcbsp1_fck);
>  > -             } else {
>  > -                     clk_disable(mcbsp2_ick);
>  > -                     clk_disable(mcbsp2_fck);
>  > -             }
>  > -     }
>  > -#endif
>  > +     if (mcbsp_config && mcbsp_config->free)
>  > +             mcbsp_config->free(id);
>  >
>  >       spin_lock(&mcbsp[id].lock);
>  >       if (mcbsp[id].free) {
>  > @@ -400,7 +279,7 @@ void omap_mcbsp_start(unsigned int id)
>  >       u32 io_base;
>  >       u16 w;
>  >
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return;
>  >
>  >       io_base = mcbsp[id].io_base;
>  > @@ -435,7 +314,7 @@ void omap_mcbsp_stop(unsigned int id)
>  >       u32 io_base;
>  >       u16 w;
>  >
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return;
>  >
>  >       io_base = mcbsp[id].io_base;
>  > @@ -533,7 +412,7 @@ void omap_mcbsp_xmit_word(unsigned int id, u32 word)
>  >       u32 io_base;
>  >       omap_mcbsp_word_length word_length = mcbsp[id].tx_word_length;
>  >
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return;
>  >
>  >       io_base = mcbsp[id].io_base;
>  > @@ -552,7 +431,7 @@ u32 omap_mcbsp_recv_word(unsigned int id)
>  >       u16 word_lsb, word_msb = 0;
>  >       omap_mcbsp_word_length word_length = mcbsp[id].rx_word_length;
>  >
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return -EINVAL;
>  >
>  >       io_base = mcbsp[id].io_base;
>  > @@ -692,7 +571,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
>  >       int dest_port = 0;
>  >       int sync_dev = 0;
>  >
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return -EINVAL;
>  >
>  >       if (omap_request_dma(mcbsp[id].dma_tx_sync, "McBSP TX",
>  > @@ -713,7 +592,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
>  >               src_port = OMAP_DMA_PORT_TIPB;
>  >               dest_port = OMAP_DMA_PORT_EMIFF;
>  >       }
>  > -     if (cpu_is_omap24xx())
>  > +     if (cpu_class_is_omap2())
>  >               sync_dev = mcbsp[id].dma_tx_sync;
>  >
>  >       omap_set_dma_transfer_params(mcbsp[id].dma_tx_lch,
>  > @@ -749,7 +628,7 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
>  >       int dest_port = 0;
>  >       int sync_dev = 0;
>  >
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return -EINVAL;
>  >
>  >       if (omap_request_dma(mcbsp[id].dma_rx_sync, "McBSP RX",
>  > @@ -770,7 +649,7 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
>  >               src_port = OMAP_DMA_PORT_TIPB;
>  >               dest_port = OMAP_DMA_PORT_EMIFF;
>  >       }
>  > -     if (cpu_is_omap24xx())
>  > +     if (cpu_class_is_omap2())
>  >               sync_dev = mcbsp[id].dma_rx_sync;
>  >
>  >       omap_set_dma_transfer_params(mcbsp[id].dma_rx_lch,
>  > @@ -809,7 +688,7 @@ void omap_mcbsp_set_spi_mode(unsigned int id,
>  >  {
>  >       struct omap_mcbsp_reg_cfg mcbsp_cfg;
>  >
>  > -     if (omap_mcbsp_check(id) < 0)
>  > +     if (omap_mcbsp_check_invalid_id(id))
>  >               return;
>  >
>  >       memset(&mcbsp_cfg, 0, sizeof(struct omap_mcbsp_reg_cfg));
>  > @@ -871,162 +750,19 @@ EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
>  >   * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
>  >   * 730 has only 2 McBSP, and both of them are MPU peripherals.
>  >   */
>  > -struct omap_mcbsp_info {
>  > -     u32 virt_base;
>  > -     u8 dma_rx_sync, dma_tx_sync;
>  > -     u16 rx_irq, tx_irq;
>  > -};
>  > -
>  > -#ifdef CONFIG_ARCH_OMAP730
>  > -static const struct omap_mcbsp_info mcbsp_730[] = {
>  > -     [0] = { .virt_base = io_p2v(OMAP730_MCBSP1_BASE),
>  > -             .dma_rx_sync = OMAP_DMA_MCBSP1_RX,
>  > -             .dma_tx_sync = OMAP_DMA_MCBSP1_TX,
>  > -             .rx_irq = INT_730_McBSP1RX,
>  > -             .tx_irq = INT_730_McBSP1TX },
>  > -     [1] = { .virt_base = io_p2v(OMAP730_MCBSP2_BASE),
>  > -             .dma_rx_sync = OMAP_DMA_MCBSP3_RX,
>  > -             .dma_tx_sync = OMAP_DMA_MCBSP3_TX,
>  > -             .rx_irq = INT_730_McBSP2RX,
>  > -             .tx_irq = INT_730_McBSP2TX },
>  > -};
>  > -#endif
>  > -
>  > -#ifdef CONFIG_ARCH_OMAP15XX
>  > -static const struct omap_mcbsp_info mcbsp_1510[] = {
>  > -     [0] = { .virt_base = OMAP1510_MCBSP1_BASE,
>  > -             .dma_rx_sync = OMAP_DMA_MCBSP1_RX,
>  > -             .dma_tx_sync = OMAP_DMA_MCBSP1_TX,
>  > -             .rx_irq = INT_McBSP1RX,
>  > -             .tx_irq = INT_McBSP1TX },
>  > -     [1] = { .virt_base = io_p2v(OMAP1510_MCBSP2_BASE),
>  > -             .dma_rx_sync = OMAP_DMA_MCBSP2_RX,
>  > -             .dma_tx_sync = OMAP_DMA_MCBSP2_TX,
>  > -             .rx_irq = INT_1510_SPI_RX,
>  > -             .tx_irq = INT_1510_SPI_TX },
>  > -     [2] = { .virt_base = OMAP1510_MCBSP3_BASE,
>  > -             .dma_rx_sync = OMAP_DMA_MCBSP3_RX,
>  > -             .dma_tx_sync = OMAP_DMA_MCBSP3_TX,
>  > -             .rx_irq = INT_McBSP3RX,
>  > -             .tx_irq = INT_McBSP3TX },
>  > -};
>  > -#endif
>  > -
>  > -#if defined(CONFIG_ARCH_OMAP16XX)
>  > -static const struct omap_mcbsp_info mcbsp_1610[] = {
>  > -     [0] = { .virt_base = OMAP1610_MCBSP1_BASE,
>  > -             .dma_rx_sync = OMAP_DMA_MCBSP1_RX,
>  > -             .dma_tx_sync = OMAP_DMA_MCBSP1_TX,
>  > -             .rx_irq = INT_McBSP1RX,
>  > -             .tx_irq = INT_McBSP1TX },
>  > -     [1] = { .virt_base = io_p2v(OMAP1610_MCBSP2_BASE),
>  > -             .dma_rx_sync = OMAP_DMA_MCBSP2_RX,
>  > -             .dma_tx_sync = OMAP_DMA_MCBSP2_TX,
>  > -             .rx_irq = INT_1610_McBSP2_RX,
>  > -             .tx_irq = INT_1610_McBSP2_TX },
>  > -     [2] = { .virt_base = OMAP1610_MCBSP3_BASE,
>  > -             .dma_rx_sync = OMAP_DMA_MCBSP3_RX,
>  > -             .dma_tx_sync = OMAP_DMA_MCBSP3_TX,
>  > -             .rx_irq = INT_McBSP3RX,
>  > -             .tx_irq = INT_McBSP3TX },
>  > -};
>  > -#endif
>  > -
>  > -#if defined(CONFIG_ARCH_OMAP24XX)
>  > -static const struct omap_mcbsp_info mcbsp_24xx[] = {
>  > -     [0] = { .virt_base = IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
>  > -             .dma_rx_sync = OMAP24XX_DMA_MCBSP1_RX,
>  > -             .dma_tx_sync = OMAP24XX_DMA_MCBSP1_TX,
>  > -             .rx_irq = INT_24XX_MCBSP1_IRQ_RX,
>  > -             .tx_irq = INT_24XX_MCBSP1_IRQ_TX,
>  > -             },
>  > -     [1] = { .virt_base = IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
>  > -             .dma_rx_sync = OMAP24XX_DMA_MCBSP2_RX,
>  > -             .dma_tx_sync = OMAP24XX_DMA_MCBSP2_TX,
>  > -             .rx_irq = INT_24XX_MCBSP2_IRQ_RX,
>  > -             .tx_irq = INT_24XX_MCBSP2_IRQ_TX,
>  > -             },
>  > -};
>  > -#endif
>  > -
>  > -static int __init omap_mcbsp_init(void)
>  > +int __init omap_mcbsp_init(void)
>  >  {
>  > -     int mcbsp_count = 0, i;
>  > -     static const struct omap_mcbsp_info *mcbsp_info;
>  > +     int i;
>  >
>  > -     printk(KERN_INFO "Initializing OMAP McBSP system\n");
>  > -
>  > -#ifdef CONFIG_ARCH_OMAP1
>  > -     mcbsp_dsp_ck = clk_get(0, "dsp_ck");
>  > -     if (IS_ERR(mcbsp_dsp_ck)) {
>  > -             printk(KERN_ERR "mcbsp: could not acquire dsp_ck handle.\n");
>  > -             return PTR_ERR(mcbsp_dsp_ck);
>  > -     }
>  > -     mcbsp_api_ck = clk_get(0, "api_ck");
>  > -     if (IS_ERR(mcbsp_api_ck)) {
>  > -             printk(KERN_ERR "mcbsp: could not acquire api_ck handle.\n");
>  > -             return PTR_ERR(mcbsp_api_ck);
>  > -     }
>  > -     mcbsp_dspxor_ck = clk_get(0, "dspxor_ck");
>  > -     if (IS_ERR(mcbsp_dspxor_ck)) {
>  > -             printk(KERN_ERR "mcbsp: could not acquire dspxor_ck handle.\n");
>  > -             return PTR_ERR(mcbsp_dspxor_ck);
>  > -     }
>  > -#endif
>  > -#ifdef CONFIG_ARCH_OMAP2
>  > -     mcbsp1_ick = clk_get(0, "mcbsp1_ick");
>  > -     if (IS_ERR(mcbsp1_ick)) {
>  > -             printk(KERN_ERR "mcbsp: could not acquire "
>  > -                             "mcbsp1_ick handle.\n");
>  > -             return PTR_ERR(mcbsp1_ick);
>  > -     }
>  > -     mcbsp1_fck = clk_get(0, "mcbsp1_fck");
>  > -     if (IS_ERR(mcbsp1_fck)) {
>  > -             printk(KERN_ERR "mcbsp: could not acquire "
>  > -                             "mcbsp1_fck handle.\n");
>  > -             return PTR_ERR(mcbsp1_fck);
>  > -     }
>  > -     mcbsp2_ick = clk_get(0, "mcbsp2_ick");
>  > -     if (IS_ERR(mcbsp2_ick)) {
>  > -             printk(KERN_ERR "mcbsp: could not acquire "
>  > -                             "mcbsp2_ick handle.\n");
>  > -             return PTR_ERR(mcbsp2_ick);
>  > -     }
>  > -     mcbsp2_fck = clk_get(0, "mcbsp2_fck");
>  > -     if (IS_ERR(mcbsp2_fck)) {
>  > -             printk(KERN_ERR "mcbsp: could not acquire "
>  > -                             "mcbsp2_fck handle.\n");
>  > -             return PTR_ERR(mcbsp2_fck);
>  > +     if (!mcbsp_config) {
>  > +             printk(KERN_ERR "McBSP initialized without configuration\n");
>  > +             return -EINVAL;
>  >       }
>  > -#endif
>  >
>  > -#ifdef CONFIG_ARCH_OMAP730
>  > -     if (cpu_is_omap730()) {
>  > -             mcbsp_info = mcbsp_730;
>  > -             mcbsp_count = ARRAY_SIZE(mcbsp_730);
>  > -     }
>  > -#endif
>  > -#ifdef CONFIG_ARCH_OMAP15XX
>  > -     if (cpu_is_omap15xx()) {
>  > -             mcbsp_info = mcbsp_1510;
>  > -             mcbsp_count = ARRAY_SIZE(mcbsp_1510);
>  > -     }
>  > -#endif
>  > -#if defined(CONFIG_ARCH_OMAP16XX)
>  > -     if (cpu_is_omap16xx()) {
>  > -             mcbsp_info = mcbsp_1610;
>  > -             mcbsp_count = ARRAY_SIZE(mcbsp_1610);
>  > -     }
>  > -#endif
>  > -#if defined(CONFIG_ARCH_OMAP24XX)
>  > -     if (cpu_is_omap24xx()) {
>  > -             mcbsp_info = mcbsp_24xx;
>  > -             mcbsp_count = ARRAY_SIZE(mcbsp_24xx);
>  > -             omap2_mcbsp2_mux_setup();
>  > -     }
>  > -#endif
>  > +     printk(KERN_INFO "Initializing OMAP McBSP system\n");
>  > +
>  >       for (i = 0; i < OMAP_MAX_MCBSP_COUNT ; i++) {
>  > -             if (i >= mcbsp_count) {
>  > +             if (i >= ARRAY_SIZE(mcbsp_config->mcbsp_infos)) {
>  >                       mcbsp[i].io_base = 0;
>  >                       mcbsp[i].free = 0;
>  >                       continue;
>  > @@ -1036,17 +772,29 @@ static int __init omap_mcbsp_init(void)
>  >               mcbsp[i].dma_tx_lch = -1;
>  >               mcbsp[i].dma_rx_lch = -1;
>  >
>  > -             mcbsp[i].io_base = mcbsp_info[i].virt_base;
>  > +             mcbsp[i].io_base = mcbsp_config->mcbsp_infos[i].virt_base;
>  >               /* Default I/O is IRQ based */
>  >               mcbsp[i].io_type = OMAP_MCBSP_IRQ_IO;
>  > -             mcbsp[i].tx_irq = mcbsp_info[i].tx_irq;
>  > -             mcbsp[i].rx_irq = mcbsp_info[i].rx_irq;
>  > -             mcbsp[i].dma_rx_sync = mcbsp_info[i].dma_rx_sync;
>  > -             mcbsp[i].dma_tx_sync = mcbsp_info[i].dma_tx_sync;
>  > +             mcbsp[i].tx_irq = mcbsp_config->mcbsp_infos[i].tx_irq;
>  > +             mcbsp[i].rx_irq = mcbsp_config->mcbsp_infos[i].rx_irq;
>  > +             mcbsp[i].dma_rx_sync = mcbsp_config->mcbsp_infos[i].dma_rx_sync;
>  > +             mcbsp[i].dma_tx_sync = mcbsp_config->mcbsp_infos[i].dma_tx_sync;
>  >               spin_lock_init(&mcbsp[i].lock);
>  >       }
>  >
>  >       return 0;
>  >  }
>  >
>  > -arch_initcall(omap_mcbsp_init);
>  > +int omap_mcbsp_register_board_cfg(const struct omap_mcbsp_board_cfg *config)
>  > +{
>  > +     if (!config || !config->request || !config->free) {
>  > +             printk(KERN_ERR "Invalid McBSP configuration\n");
>  > +             return -EINVAL;
>  > +     }
>  > +
>  > +     mcbsp_config = config;
>  > +
>  > +     return 0;
>  > +
>  > +}
>  > +
>  > diff --git a/include/asm-arm/arch-omap/mcbsp.h b/include/asm-arm/arch-omap/mcbsp.h
>  > index b53c3b2..fc53a45 100644
>  > --- a/include/asm-arm/arch-omap/mcbsp.h
>  > +++ b/include/asm-arm/arch-omap/mcbsp.h
>  > @@ -40,6 +40,9 @@
>  >  #define OMAP24XX_MCBSP1_BASE 0x48074000
>  >  #define OMAP24XX_MCBSP2_BASE 0x48076000
>  >
>  > +#define OMAP34XX_MCBSP1_BASE 0x48074000
>  > +#define OMAP34XX_MCBSP2_BASE 0x49022000
>  > +
>  >  #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730)
>  >
>  >  #define OMAP_MCBSP_REG_DRR2  0x00
>  > @@ -298,6 +301,22 @@ struct omap_mcbsp_spi_cfg {
>  >       omap_mcbsp_word_length          word_length;
>  >  };
>  >
>  > +/* Board specific configuration */
>  > +struct omap_mcbsp_info {
>  > +     u32 virt_base;
>  > +     u8 dma_rx_sync, dma_tx_sync;
>  > +     u16 rx_irq, tx_irq;
>  > +};
>  > +
>  > +struct omap_mcbsp_board_cfg {
>  > +     void (*request)(unsigned int);
>  > +     void (*free)(unsigned int);
>  > +     int (*check)(unsigned int);
>  > +     struct omap_mcbsp_info mcbsp_infos[OMAP_MAX_MCBSP_COUNT];
>  > +};
>  > +
>  > +int omap_mcbsp_init(void);
>  > +int omap_mcbsp_register_board_cfg(const struct omap_mcbsp_board_cfg *config);
>  >  void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
>  >  int omap_mcbsp_request(unsigned int id);
>  >  void omap_mcbsp_free(unsigned int id);
>  > --
>  > 1.5.5-rc3.GIT
>  >
>  > --
>  > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  > the body of a message to majordomo@vger.kernel.org
>  > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Eduardo Bezerra Valentin
