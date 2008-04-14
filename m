From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from
	plat-omap to mach-omap
Date: Mon, 14 Apr 2008 21:18:28 +0300
Message-ID: <20080414181827.GE4463@kedavra.cpe.vivax.com.br>
References: <1208188381-29638-1-git-send-email-edubezval@gmail.com> <1208188381-29638-2-git-send-email-edubezval@gmail.com> <1208188381-29638-3-git-send-email-edubezval@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39395 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765644AbYDNSQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 14:16:40 -0400
Content-Disposition: inline
In-Reply-To: <1208188381-29638-3-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

On Mon, Apr 14, 2008 at 11:53:01AM -0400, Eduardo Valentin wrote:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> This patch gets ride of ifdefs on mcbsp.c code.
> It moves the mach specific code to mach-omap*.

I don't see the new files here. Did you forgot to git add them?

in any case, this is a really good idea ;-)

> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> ---
>  arch/arm/mach-omap1/Makefile      |    2 +
>  arch/arm/mach-omap2/Makefile      |    2 +
>  arch/arm/plat-omap/mcbsp.c        |  346 +++++--------------------------------
>  include/asm-arm/arch-omap/mcbsp.h |   19 ++
>  4 files changed, 70 insertions(+), 299 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index 6ebf23b..09246a7 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -5,6 +5,8 @@
>  # Common support
>  obj-y := io.o id.o clock.o irq.o mux.o serial.o devices.o
>  
> +obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
> +
>  obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
>  obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
>  
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 5157ff2..771f8e7 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -6,6 +6,8 @@
>  obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
>  		devices.o serial.o gpmc.o timer-gp.o
>  
> +obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
> +
>  # Functions loaded to SRAM
>  obj-$(CONFIG_ARCH_OMAP2)		+= sram24xx.o
>  
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 28cd501..416bf7d 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -24,11 +24,8 @@
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  
> -#include <asm/arch/dma.h>
> -#include <asm/arch/mux.h>
> -#include <asm/arch/irqs.h>
> -#include <asm/arch/dsp_common.h>
>  #include <asm/arch/mcbsp.h>
> +#include <asm/arch/dma.h>
>  
>  #ifdef CONFIG_MCBSP_DEBUG
>  #define DBG(x...)	printk(x)
> @@ -64,17 +61,10 @@ struct omap_mcbsp {
>  };
>  
>  static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
> -#ifdef CONFIG_ARCH_OMAP1
> -static struct clk *mcbsp_dsp_ck;
> -static struct clk *mcbsp_api_ck;
> -static struct clk *mcbsp_dspxor_ck;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct clk *mcbsp1_ick;
> -static struct clk *mcbsp1_fck;
> -static struct clk *mcbsp2_ick;
> -static struct clk *mcbsp2_fck;
> -#endif
> +static const struct omap_mcbsp_board_cfg *mcbsp_config;
> +
> +#define omap_mcbsp_check_invalid_id(id)	(mcbsp_config && mcbsp_config->check \
> +					&& (mcbsp_config->check(id) < 0))
>  
>  static void omap_mcbsp_dump_reg(u8 id)
>  {
> @@ -174,90 +164,13 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
>  }
>  EXPORT_SYMBOL(omap_mcbsp_config);
>  
> -static int omap_mcbsp_check(unsigned int id)
> -{
> -	if (cpu_is_omap730()) {
> -		if (id > OMAP_MAX_MCBSP_COUNT - 1) {
> -		       printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
> -				id + 1);
> -		       return -1;
> -		}
> -		return 0;
> -	}
> -
> -	if (cpu_is_omap15xx() || cpu_is_omap16xx() || cpu_is_omap24xx()) {
> -		if (id > OMAP_MAX_MCBSP_COUNT) {
> -			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
> -				id + 1);
> -			return -1;
> -		}
> -		return 0;
> -	}
> -
> -	return -1;
> -}
> -
> -#ifdef CONFIG_ARCH_OMAP1
> -static void omap_mcbsp_dsp_request(void)
> -{
> -	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
> -		int ret;
> -
> -		ret = omap_dsp_request_mem();
> -		if (ret < 0) {
> -			printk(KERN_ERR "Could not get dsp memory: %i\n", ret);
> -			return;
> -		}
> -
> -		clk_enable(mcbsp_dsp_ck);
> -		clk_enable(mcbsp_api_ck);
> -
> -		/* enable 12MHz clock to mcbsp 1 & 3 */
> -		clk_enable(mcbsp_dspxor_ck);
> -
> -		/*
> -		 * DSP external peripheral reset
> -		 * FIXME: This should be moved to dsp code
> -		 */
> -		__raw_writew(__raw_readw(DSP_RSTCT2) | 1 | 1 << 1,
> -			     DSP_RSTCT2);
> -	}
> -}
> -
> -static void omap_mcbsp_dsp_free(void)
> -{
> -	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
> -		omap_dsp_release_mem();
> -		clk_disable(mcbsp_dspxor_ck);
> -		clk_disable(mcbsp_dsp_ck);
> -		clk_disable(mcbsp_api_ck);
> -	}
> -}
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -static void omap2_mcbsp2_mux_setup(void)
> -{
> -	if (cpu_is_omap2420()) {
> -		omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
> -		omap_cfg_reg(R14_24XX_MCBSP2_FSX);
> -		omap_cfg_reg(W15_24XX_MCBSP2_DR);
> -		omap_cfg_reg(V15_24XX_MCBSP2_DX);
> -		omap_cfg_reg(V14_24XX_GPIO117);
> -	}
> -	/*
> -	 * Need to add MUX settings for OMAP 2430 SDP
> -	 */
> -}
> -#endif
> -
>  /*
>   * We can choose between IRQ based or polled IO.
>   * This needs to be called before omap_mcbsp_request().
>   */
>  int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type)
>  {
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return -EINVAL;
>  
>  	spin_lock(&mcbsp[id].lock);
> @@ -281,29 +194,11 @@ int omap_mcbsp_request(unsigned int id)
>  {
>  	int err;
>  
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return -EINVAL;
>  
> -#ifdef CONFIG_ARCH_OMAP1
> -	/*
> -	 * On 1510, 1610 and 1710, McBSP1 and McBSP3
> -	 * are DSP public peripherals.
> -	 */
> -	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
> -		omap_mcbsp_dsp_request();
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -	if (cpu_is_omap24xx()) {
> -		if (id == OMAP_MCBSP1) {
> -			clk_enable(mcbsp1_ick);
> -			clk_enable(mcbsp1_fck);
> -		} else {
> -			clk_enable(mcbsp2_ick);
> -			clk_enable(mcbsp2_fck);
> -		}
> -	}
> -#endif
> +	if (mcbsp_config && mcbsp_config->request)
> +		mcbsp_config->request(id);
>  
>  	spin_lock(&mcbsp[id].lock);
>  	if (!mcbsp[id].free) {
> @@ -348,27 +243,11 @@ EXPORT_SYMBOL(omap_mcbsp_request);
>  
>  void omap_mcbsp_free(unsigned int id)
>  {
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return;
>  
> -#ifdef CONFIG_ARCH_OMAP1
> -	if (cpu_class_is_omap1()) {
> -		if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
> -			omap_mcbsp_dsp_free();
> -	}
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -	if (cpu_is_omap24xx()) {
> -		if (id == OMAP_MCBSP1) {
> -			clk_disable(mcbsp1_ick);
> -			clk_disable(mcbsp1_fck);
> -		} else {
> -			clk_disable(mcbsp2_ick);
> -			clk_disable(mcbsp2_fck);
> -		}
> -	}
> -#endif
> +	if (mcbsp_config && mcbsp_config->free)
> +		mcbsp_config->free(id);
>  
>  	spin_lock(&mcbsp[id].lock);
>  	if (mcbsp[id].free) {
> @@ -399,7 +278,7 @@ void omap_mcbsp_start(unsigned int id)
>  	u32 io_base;
>  	u16 w;
>  
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return;
>  
>  	io_base = mcbsp[id].io_base;
> @@ -434,7 +313,7 @@ void omap_mcbsp_stop(unsigned int id)
>  	u32 io_base;
>  	u16 w;
>  
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return;
>  
>  	io_base = mcbsp[id].io_base;
> @@ -532,7 +411,7 @@ void omap_mcbsp_xmit_word(unsigned int id, u32 word)
>  	u32 io_base;
>  	omap_mcbsp_word_length word_length = mcbsp[id].tx_word_length;
>  
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return;
>  
>  	io_base = mcbsp[id].io_base;
> @@ -551,7 +430,7 @@ u32 omap_mcbsp_recv_word(unsigned int id)
>  	u16 word_lsb, word_msb = 0;
>  	omap_mcbsp_word_length word_length = mcbsp[id].rx_word_length;
>  
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return -EINVAL;
>  
>  	io_base = mcbsp[id].io_base;
> @@ -691,7 +570,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
>  	int dest_port = 0;
>  	int sync_dev = 0;
>  
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return -EINVAL;
>  
>  	if (omap_request_dma(mcbsp[id].dma_tx_sync, "McBSP TX",
> @@ -712,7 +591,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
>  		src_port = OMAP_DMA_PORT_TIPB;
>  		dest_port = OMAP_DMA_PORT_EMIFF;
>  	}
> -	if (cpu_is_omap24xx())
> +	if (cpu_class_is_omap2())
>  		sync_dev = mcbsp[id].dma_tx_sync;
>  
>  	omap_set_dma_transfer_params(mcbsp[id].dma_tx_lch,
> @@ -748,7 +627,7 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
>  	int dest_port = 0;
>  	int sync_dev = 0;
>  
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return -EINVAL;
>  
>  	if (omap_request_dma(mcbsp[id].dma_rx_sync, "McBSP RX",
> @@ -769,7 +648,7 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
>  		src_port = OMAP_DMA_PORT_TIPB;
>  		dest_port = OMAP_DMA_PORT_EMIFF;
>  	}
> -	if (cpu_is_omap24xx())
> +	if (cpu_class_is_omap2())
>  		sync_dev = mcbsp[id].dma_rx_sync;
>  
>  	omap_set_dma_transfer_params(mcbsp[id].dma_rx_lch,
> @@ -808,7 +687,7 @@ void omap_mcbsp_set_spi_mode(unsigned int id,
>  {
>  	struct omap_mcbsp_reg_cfg mcbsp_cfg;
>  
> -	if (omap_mcbsp_check(id) < 0)
> +	if (omap_mcbsp_check_invalid_id(id))
>  		return;
>  
>  	memset(&mcbsp_cfg, 0, sizeof(struct omap_mcbsp_reg_cfg));
> @@ -870,162 +749,19 @@ EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
>   * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
>   * 730 has only 2 McBSP, and both of them are MPU peripherals.
>   */
> -struct omap_mcbsp_info {
> -	u32 virt_base;
> -	u8 dma_rx_sync, dma_tx_sync;
> -	u16 rx_irq, tx_irq;
> -};
> -
> -#ifdef CONFIG_ARCH_OMAP730
> -static const struct omap_mcbsp_info mcbsp_730[] = {
> -	[0] = { .virt_base = io_p2v(OMAP730_MCBSP1_BASE),
> -		.dma_rx_sync = OMAP_DMA_MCBSP1_RX,
> -		.dma_tx_sync = OMAP_DMA_MCBSP1_TX,
> -		.rx_irq = INT_730_McBSP1RX,
> -		.tx_irq = INT_730_McBSP1TX },
> -	[1] = { .virt_base = io_p2v(OMAP730_MCBSP2_BASE),
> -		.dma_rx_sync = OMAP_DMA_MCBSP3_RX,
> -		.dma_tx_sync = OMAP_DMA_MCBSP3_TX,
> -		.rx_irq = INT_730_McBSP2RX,
> -		.tx_irq = INT_730_McBSP2TX },
> -};
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP15XX
> -static const struct omap_mcbsp_info mcbsp_1510[] = {
> -	[0] = { .virt_base = OMAP1510_MCBSP1_BASE,
> -		.dma_rx_sync = OMAP_DMA_MCBSP1_RX,
> -		.dma_tx_sync = OMAP_DMA_MCBSP1_TX,
> -		.rx_irq = INT_McBSP1RX,
> -		.tx_irq = INT_McBSP1TX },
> -	[1] = { .virt_base = io_p2v(OMAP1510_MCBSP2_BASE),
> -		.dma_rx_sync = OMAP_DMA_MCBSP2_RX,
> -		.dma_tx_sync = OMAP_DMA_MCBSP2_TX,
> -		.rx_irq = INT_1510_SPI_RX,
> -		.tx_irq = INT_1510_SPI_TX },
> -	[2] = { .virt_base = OMAP1510_MCBSP3_BASE,
> -		.dma_rx_sync = OMAP_DMA_MCBSP3_RX,
> -		.dma_tx_sync = OMAP_DMA_MCBSP3_TX,
> -		.rx_irq = INT_McBSP3RX,
> -		.tx_irq = INT_McBSP3TX },
> -};
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP16XX)
> -static const struct omap_mcbsp_info mcbsp_1610[] = {
> -	[0] = { .virt_base = OMAP1610_MCBSP1_BASE,
> -		.dma_rx_sync = OMAP_DMA_MCBSP1_RX,
> -		.dma_tx_sync = OMAP_DMA_MCBSP1_TX,
> -		.rx_irq = INT_McBSP1RX,
> -		.tx_irq = INT_McBSP1TX },
> -	[1] = { .virt_base = io_p2v(OMAP1610_MCBSP2_BASE),
> -		.dma_rx_sync = OMAP_DMA_MCBSP2_RX,
> -		.dma_tx_sync = OMAP_DMA_MCBSP2_TX,
> -		.rx_irq = INT_1610_McBSP2_RX,
> -		.tx_irq = INT_1610_McBSP2_TX },
> -	[2] = { .virt_base = OMAP1610_MCBSP3_BASE,
> -		.dma_rx_sync = OMAP_DMA_MCBSP3_RX,
> -		.dma_tx_sync = OMAP_DMA_MCBSP3_TX,
> -		.rx_irq = INT_McBSP3RX,
> -		.tx_irq = INT_McBSP3TX },
> -};
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP24XX)
> -static const struct omap_mcbsp_info mcbsp_24xx[] = {
> -	[0] = { .virt_base = IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
> -		.dma_rx_sync = OMAP24XX_DMA_MCBSP1_RX,
> -		.dma_tx_sync = OMAP24XX_DMA_MCBSP1_TX,
> -		.rx_irq = INT_24XX_MCBSP1_IRQ_RX,
> -		.tx_irq = INT_24XX_MCBSP1_IRQ_TX,
> -		},
> -	[1] = { .virt_base = IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
> -		.dma_rx_sync = OMAP24XX_DMA_MCBSP2_RX,
> -		.dma_tx_sync = OMAP24XX_DMA_MCBSP2_TX,
> -		.rx_irq = INT_24XX_MCBSP2_IRQ_RX,
> -		.tx_irq = INT_24XX_MCBSP2_IRQ_TX,
> -		},
> -};
> -#endif
> -
> -static int __init omap_mcbsp_init(void)
> +int __init omap_mcbsp_init(void)
>  {
> -	int mcbsp_count = 0, i;
> -	static const struct omap_mcbsp_info *mcbsp_info;
> +	int i;
>  
> -	printk(KERN_INFO "Initializing OMAP McBSP system\n");
> -
> -#ifdef CONFIG_ARCH_OMAP1
> -	mcbsp_dsp_ck = clk_get(0, "dsp_ck");
> -	if (IS_ERR(mcbsp_dsp_ck)) {
> -		printk(KERN_ERR "mcbsp: could not acquire dsp_ck handle.\n");
> -		return PTR_ERR(mcbsp_dsp_ck);
> -	}
> -	mcbsp_api_ck = clk_get(0, "api_ck");
> -	if (IS_ERR(mcbsp_api_ck)) {
> -		printk(KERN_ERR "mcbsp: could not acquire api_ck handle.\n");
> -		return PTR_ERR(mcbsp_api_ck);
> -	}
> -	mcbsp_dspxor_ck = clk_get(0, "dspxor_ck");
> -	if (IS_ERR(mcbsp_dspxor_ck)) {
> -		printk(KERN_ERR "mcbsp: could not acquire dspxor_ck handle.\n");
> -		return PTR_ERR(mcbsp_dspxor_ck);
> -	}
> -#endif
> -#ifdef CONFIG_ARCH_OMAP2
> -	mcbsp1_ick = clk_get(0, "mcbsp1_ick");
> -	if (IS_ERR(mcbsp1_ick)) {
> -		printk(KERN_ERR "mcbsp: could not acquire "
> -				"mcbsp1_ick handle.\n");
> -		return PTR_ERR(mcbsp1_ick);
> -	}
> -	mcbsp1_fck = clk_get(0, "mcbsp1_fck");
> -	if (IS_ERR(mcbsp1_fck)) {
> -		printk(KERN_ERR "mcbsp: could not acquire "
> -				"mcbsp1_fck handle.\n");
> -		return PTR_ERR(mcbsp1_fck);
> -	}
> -	mcbsp2_ick = clk_get(0, "mcbsp2_ick");
> -	if (IS_ERR(mcbsp2_ick)) {
> -		printk(KERN_ERR "mcbsp: could not acquire "
> -				"mcbsp2_ick handle.\n");
> -		return PTR_ERR(mcbsp2_ick);
> -	}
> -	mcbsp2_fck = clk_get(0, "mcbsp2_fck");
> -	if (IS_ERR(mcbsp2_fck)) {
> -		printk(KERN_ERR "mcbsp: could not acquire "
> -				"mcbsp2_fck handle.\n");
> -		return PTR_ERR(mcbsp2_fck);
> +	if (!mcbsp_config) {
> +		printk(KERN_ERR "McBSP initialized without configuration\n");
> +		return -EINVAL;
>  	}
> -#endif
>  
> -#ifdef CONFIG_ARCH_OMAP730
> -	if (cpu_is_omap730()) {
> -		mcbsp_info = mcbsp_730;
> -		mcbsp_count = ARRAY_SIZE(mcbsp_730);
> -	}
> -#endif
> -#ifdef CONFIG_ARCH_OMAP15XX
> -	if (cpu_is_omap15xx()) {
> -		mcbsp_info = mcbsp_1510;
> -		mcbsp_count = ARRAY_SIZE(mcbsp_1510);
> -	}
> -#endif
> -#if defined(CONFIG_ARCH_OMAP16XX)
> -	if (cpu_is_omap16xx()) {
> -		mcbsp_info = mcbsp_1610;
> -		mcbsp_count = ARRAY_SIZE(mcbsp_1610);
> -	}
> -#endif
> -#if defined(CONFIG_ARCH_OMAP24XX)
> -	if (cpu_is_omap24xx()) {
> -		mcbsp_info = mcbsp_24xx;
> -		mcbsp_count = ARRAY_SIZE(mcbsp_24xx);
> -		omap2_mcbsp2_mux_setup();
> -	}
> -#endif
> +	printk(KERN_INFO "Initializing OMAP McBSP system\n");
> +
>  	for (i = 0; i < OMAP_MAX_MCBSP_COUNT ; i++) {
> -		if (i >= mcbsp_count) {
> +		if (i >= ARRAY_SIZE(mcbsp_config->mcbsp_infos)) {
>  			mcbsp[i].io_base = 0;
>  			mcbsp[i].free = 0;
>  			continue;
> @@ -1035,17 +771,29 @@ static int __init omap_mcbsp_init(void)
>  		mcbsp[i].dma_tx_lch = -1;
>  		mcbsp[i].dma_rx_lch = -1;
>  
> -		mcbsp[i].io_base = mcbsp_info[i].virt_base;
> +		mcbsp[i].io_base = mcbsp_config->mcbsp_infos[i].virt_base;
>  		/* Default I/O is IRQ based */
>  		mcbsp[i].io_type = OMAP_MCBSP_IRQ_IO;
> -		mcbsp[i].tx_irq = mcbsp_info[i].tx_irq;
> -		mcbsp[i].rx_irq = mcbsp_info[i].rx_irq;
> -		mcbsp[i].dma_rx_sync = mcbsp_info[i].dma_rx_sync;
> -		mcbsp[i].dma_tx_sync = mcbsp_info[i].dma_tx_sync;
> +		mcbsp[i].tx_irq = mcbsp_config->mcbsp_infos[i].tx_irq;
> +		mcbsp[i].rx_irq = mcbsp_config->mcbsp_infos[i].rx_irq;
> +		mcbsp[i].dma_rx_sync = mcbsp_config->mcbsp_infos[i].dma_rx_sync;
> +		mcbsp[i].dma_tx_sync = mcbsp_config->mcbsp_infos[i].dma_tx_sync;
>  		spin_lock_init(&mcbsp[i].lock);
>  	}
>  
>  	return 0;
>  }
>  
> -arch_initcall(omap_mcbsp_init);
> +int omap_mcbsp_register_board_cfg(const struct omap_mcbsp_board_cfg *config)
> +{
> +	if (!config || !config->request || !config->free) {
> +		printk(KERN_ERR "Invalid McBSP configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	mcbsp_config = config;
> +
> +	return 0;
> +
> +}
> +
> diff --git a/include/asm-arm/arch-omap/mcbsp.h b/include/asm-arm/arch-omap/mcbsp.h
> index b53c3b2..fc53a45 100644
> --- a/include/asm-arm/arch-omap/mcbsp.h
> +++ b/include/asm-arm/arch-omap/mcbsp.h
> @@ -40,6 +40,9 @@
>  #define OMAP24XX_MCBSP1_BASE	0x48074000
>  #define OMAP24XX_MCBSP2_BASE	0x48076000
>  
> +#define OMAP34XX_MCBSP1_BASE	0x48074000
> +#define OMAP34XX_MCBSP2_BASE	0x49022000
> +
>  #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730)
>  
>  #define OMAP_MCBSP_REG_DRR2	0x00
> @@ -298,6 +301,22 @@ struct omap_mcbsp_spi_cfg {
>  	omap_mcbsp_word_length		word_length;
>  };
>  
> +/* Board specific configuration */
> +struct omap_mcbsp_info {
> +	u32 virt_base;
> +	u8 dma_rx_sync, dma_tx_sync;
> +	u16 rx_irq, tx_irq;
> +};
> +
> +struct omap_mcbsp_board_cfg {
> +	void (*request)(unsigned int);
> +	void (*free)(unsigned int);
> +	int (*check)(unsigned int);
> +	struct omap_mcbsp_info mcbsp_infos[OMAP_MAX_MCBSP_COUNT];
> +};
> +
> +int omap_mcbsp_init(void);
> +int omap_mcbsp_register_board_cfg(const struct omap_mcbsp_board_cfg *config);
>  void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
>  int omap_mcbsp_request(unsigned int id);
>  void omap_mcbsp_free(unsigned int id);
> -- 
> 1.5.5-rc3.GIT
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
