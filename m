From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP: Introduce cpu_class_is_omap3()
Date: Thu, 24 Apr 2008 10:06:54 -0700
Message-ID: <20080424170653.GB16834@atomide.com>
References: <1209044786-9244-1-git-send-email-felipe.balbi@nokia.com> <1209044786-9244-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58589 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbYDXRGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 13:06:55 -0400
Content-Disposition: inline
In-Reply-To: <1209044786-9244-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, khasim@ti.com

* Felipe Balbi <felipe.balbi@nokia.com> [080424 06:47]:
> Add cpu_class_is_omap3().

Well I thinks cpu_class_is_omap2() currently should cover both 24xx
and 34xx. This should be only used to differentiate between mach-omap1
and mach-omap2.

Tony


> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/plat-omap/common.c     |    2 +-
>  arch/arm/plat-omap/dma.c        |   58 +++++++++++++++++++-------------------
>  arch/arm/plat-omap/dmtimer.c    |   10 +++---
>  arch/arm/plat-omap/gpio.c       |   14 +++++-----
>  arch/arm/plat-omap/sram.c       |    4 +-
>  arch/arm/plat-omap/usb.c        |    2 +-
>  include/asm-arm/arch-omap/cpu.h |    3 +-
>  7 files changed, 47 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index fd6f329..d4dfe4c 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -240,7 +240,7 @@ static int __init omap_init_clocksource_32k(void)
>  	static char err[] __initdata = KERN_ERR
>  			"%s: can't register clocksource!\n";
>  
> -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> +	if (cpu_is_omap16xx() || cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		struct clk *sync_32k_ick;
>  
>  		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index c00eda5..c16ea64 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -211,7 +211,7 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
>  		omap_writel(l, reg);
>  	}
>  
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		if (priority)
>  			OMAP_DMA_CCR_REG(lch) |= (1 << 6);
>  		else
> @@ -236,7 +236,7 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
>  			OMAP1_DMA_CCR2_REG(lch) |= 1 << 2;
>  	}
>  
> -	if (cpu_class_is_omap2() && dma_trigger) {
> +	if ((cpu_class_is_omap2() || cpu_class_is_omap3()) && dma_trigger) {
>  		u32 val = OMAP_DMA_CCR_REG(lch);
>  
>  		val &= ~(3 << 19);
> @@ -276,7 +276,7 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
>  
>  	BUG_ON(omap_dma_in_1510_mode());
>  
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		REVISIT_24XX();
>  		return;
>  	}
> @@ -308,7 +308,7 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
>  
>  void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
>  {
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		OMAP_DMA_CSDP_REG(lch) &= ~(0x3 << 16);
>  		OMAP_DMA_CSDP_REG(lch) |= (mode << 16);
>  	}
> @@ -332,7 +332,7 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
>  		OMAP1_DMA_CSSA_L_REG(lch) = src_start;
>  	}
>  
> -	if (cpu_class_is_omap2())
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		OMAP2_DMA_CSSA_REG(lch) = src_start;
>  
>  	OMAP_DMA_CSEI_REG(lch) = src_ei;
> @@ -359,7 +359,7 @@ void omap_set_dma_params(int lch, struct omap_dma_channel_params * params)
>  
>  void omap_set_dma_src_index(int lch, int eidx, int fidx)
>  {
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		REVISIT_24XX();
>  		return;
>  	}
> @@ -383,13 +383,13 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
>  	case OMAP_DMA_DATA_BURST_DIS:
>  		break;
>  	case OMAP_DMA_DATA_BURST_4:
> -		if (cpu_class_is_omap2())
> +		if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  			burst = 0x1;
>  		else
>  			burst = 0x2;
>  		break;
>  	case OMAP_DMA_DATA_BURST_8:
> -		if (cpu_class_is_omap2()) {
> +		if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  			burst = 0x2;
>  			break;
>  		}
> @@ -398,7 +398,7 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
>  		 * fall through
>  		 */
>  	case OMAP_DMA_DATA_BURST_16:
> -		if (cpu_class_is_omap2()) {
> +		if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  			burst = 0x3;
>  			break;
>  		}
> @@ -429,7 +429,7 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
>  		OMAP1_DMA_CDSA_L_REG(lch) = dest_start;
>  	}
>  
> -	if (cpu_class_is_omap2())
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		OMAP2_DMA_CDSA_REG(lch) = dest_start;
>  
>  	OMAP_DMA_CDEI_REG(lch) = dst_ei;
> @@ -438,7 +438,7 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
>  
>  void omap_set_dma_dest_index(int lch, int eidx, int fidx)
>  {
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		REVISIT_24XX();
>  		return;
>  	}
> @@ -462,19 +462,19 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
>  	case OMAP_DMA_DATA_BURST_DIS:
>  		break;
>  	case OMAP_DMA_DATA_BURST_4:
> -		if (cpu_class_is_omap2())
> +		if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  			burst = 0x1;
>  		else
>  			burst = 0x2;
>  		break;
>  	case OMAP_DMA_DATA_BURST_8:
> -		if (cpu_class_is_omap2())
> +		if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  			burst = 0x2;
>  		else
>  			burst = 0x3;
>  		break;
>  	case OMAP_DMA_DATA_BURST_16:
> -		if (cpu_class_is_omap2()) {
> +		if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  			burst = 0x3;
>  			break;
>  		}
> @@ -496,7 +496,7 @@ static inline void omap_enable_channel_irq(int lch)
>  	/* Clear CSR */
>  	if (cpu_class_is_omap1())
>  		status = OMAP_DMA_CSR_REG(lch);
> -	else if (cpu_class_is_omap2())
> +	else if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		OMAP_DMA_CSR_REG(lch) = OMAP2_DMA_CSR_CLEAR_MASK;
>  
>  	/* Enable some nice interrupts. */
> @@ -507,7 +507,7 @@ static inline void omap_enable_channel_irq(int lch)
>  
>  static void omap_disable_channel_irq(int lch)
>  {
> -	if (cpu_class_is_omap2())
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		OMAP_DMA_CICR_REG(lch) = 0;
>  }
>  
> @@ -547,7 +547,7 @@ static inline void disable_lnk(int lch)
>  		OMAP_DMA_CLNK_CTRL_REG(lch) |= 1 << 14;
>  	}
>  
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		omap_disable_channel_irq(lch);
>  		/* Clear the ENABLE_LNK bit */
>  		OMAP_DMA_CLNK_CTRL_REG(lch) &= ~(1 << 15);
> @@ -560,7 +560,7 @@ static inline void omap2_enable_irq_lch(int lch)
>  {
>  	u32 val;
>  
> -	if (!cpu_class_is_omap2())
> +	if (!cpu_class_is_omap2() || cpu_class_is_omap3())
>  		return;
>  
>  	val = omap_readl(OMAP_DMA4_IRQENABLE_L0);
> @@ -594,7 +594,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	if (cpu_class_is_omap1())
>  		clear_lch_regs(free_ch);
>  
> -	if (cpu_class_is_omap2())
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		omap_clear_dma(free_ch);
>  
>  	spin_unlock_irqrestore(&dma_chan_lock, flags);
> @@ -610,7 +610,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  
>  	if (cpu_class_is_omap1())
>  		chan->enabled_irqs |= OMAP1_DMA_TOUT_IRQ;
> -	else if (cpu_class_is_omap2())
> +	else if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		chan->enabled_irqs |= OMAP2_DMA_MISALIGNED_ERR_IRQ |
>  			OMAP2_DMA_TRANS_ERR_IRQ;
>  
> @@ -627,7 +627,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  		OMAP_DMA_CCR_REG(free_ch) = dev_id;
>  	}
>  
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		omap2_enable_irq_lch(free_ch);
>  
>  		omap_enable_channel_irq(free_ch);
> @@ -664,7 +664,7 @@ void omap_free_dma(int lch)
>  		OMAP_DMA_CCR_REG(lch) = 0;
>  	}
>  
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		u32 val;
>  		/* Disable interrupts */
>  		val = omap_readl(OMAP_DMA4_IRQENABLE_L0);
> @@ -699,7 +699,7 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
>  {
>  	u32 reg;
>  
> -	if (!cpu_class_is_omap2()) {
> +	if (!cpu_class_is_omap2() && !cpu_class_is_omap3()) {
>  		printk(KERN_ERR "FIXME: no %s on 15xx/16xx\n", __func__);
>  		return;
>  	}
> @@ -763,7 +763,7 @@ void omap_clear_dma(int lch)
>  		status = OMAP_DMA_CSR_REG(lch);
>  	}
>  
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		int i;
>  		u32 lch_base = OMAP_DMA4_BASE + lch * 0x60 + 0x80;
>  		for (i = 0; i < 0x44; i += 4)
> @@ -799,7 +799,7 @@ void omap_start_dma(int lch)
>  
>  			cur_lch = next_lch;
>  		} while (next_lch != -1);
> -	} else if (cpu_class_is_omap2()) {
> +	} else if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		/* Errata: Need to write lch even if not using chaining */
>  		OMAP_DMA_CLNK_CTRL_REG(lch) = lch;
>  	}
> @@ -890,7 +890,7 @@ dma_addr_t omap_get_dma_src_pos(int lch)
>  		offset = (dma_addr_t) (OMAP1_DMA_CSSA_L_REG(lch) |
>  				       (OMAP1_DMA_CSSA_U_REG(lch) << 16));
>  
> -	if (cpu_class_is_omap2())
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		offset = OMAP_DMA_CSAC_REG(lch);
>  
>  	return offset;
> @@ -912,7 +912,7 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
>  		offset = (dma_addr_t) (OMAP1_DMA_CDSA_L_REG(lch) |
>  				       (OMAP1_DMA_CDSA_U_REG(lch) << 16));
>  
> -	if (cpu_class_is_omap2())
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		offset = OMAP_DMA_CDAC_REG(lch);
>  
>  	return offset;
> @@ -2140,7 +2140,7 @@ static int __init omap_init_dma(void)
>  			w &= ~(1 << 8);
>  			omap_writew(w, OMAP1610_DMA_LCD_CTRL);
>  		}
> -	} else if (cpu_class_is_omap2()) {
> +	} else if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		u8 revision = omap_readb(OMAP_DMA4_REVISION);
>  		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
>  		       revision >> 4, revision & 0xf);
> @@ -2187,7 +2187,7 @@ static int __init omap_init_dma(void)
>  		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
>  				DMA_DEFAULT_FIFO_DEPTH, 0);
>  
> -	if (cpu_class_is_omap2())
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
>  
>  	/* FIXME: Update LCD DMA to work on 24xx */
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 822b6bb..e64f3d4 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -309,7 +309,7 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
>  {
>  	u32 l;
>  
> -	if (!cpu_class_is_omap2() || timer != &dm_timers[0]) {
> +	if (!(cpu_class_is_omap2() && cpu_class_is_omap3()) || timer != &dm_timers[0]) {
>  		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
>  		omap_dm_timer_wait_for_reset(timer);
>  	}
> @@ -324,7 +324,7 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
>  	 * FIXME: All timers should have wake-up enabled and clear
>  	 * PRCM status.
>  	 */
> -	if (cpu_class_is_omap2() && (timer == &dm_timers[0]))
> +	if ((cpu_class_is_omap2() || cpu_class_is_omap3()) && (timer == &dm_timers[0]))
>  		l |= 1 << 2;
>  	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
>  
> @@ -650,7 +650,7 @@ int __init omap_dm_timer_init(void)
>  	struct omap_dm_timer *timer;
>  	int i;
>  
> -	if (!(cpu_is_omap16xx() || cpu_class_is_omap2()))
> +	if (!(cpu_is_omap16xx() || cpu_class_is_omap2() || cpu_class_is_omap3()))
>  		return -ENODEV;
>  
>  	spin_lock_init(&dm_timer_lock);
> @@ -667,7 +667,7 @@ int __init omap_dm_timer_init(void)
>  		dm_source_clocks = (struct clk **)omap3_dm_source_clocks;
>  	}
>  
> -	if (cpu_class_is_omap2())
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3())
>  		for (i = 0; dm_source_names[i] != NULL; i++)
>  			dm_source_clocks[i] = clk_get(NULL, dm_source_names[i]);
>  
> @@ -678,7 +678,7 @@ int __init omap_dm_timer_init(void)
>  		timer = &dm_timers[i];
>  		timer->io_base = (void __iomem *)io_p2v(timer->phys_base);
>  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -		if (cpu_class_is_omap2()) {
> +		if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  			char clk_name[16];
>  			sprintf(clk_name, "gpt%d_ick", i + 1);
>  			timer->iclk = clk_get(NULL, clk_name);
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 1903a34..70bedcb 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -628,7 +628,7 @@ static int gpio_irq_type(unsigned irq, unsigned type)
>  	int retval;
>  	unsigned long flags;
>  
> -	if (!cpu_class_is_omap2() && irq > IH_MPUIO_BASE)
> +	if (!(cpu_class_is_omap2() && cpu_class_is_omap3()) && irq > IH_MPUIO_BASE)
>  		gpio = OMAP_MPUIO(irq - IH_MPUIO_BASE);
>  	else
>  		gpio = irq - IH_GPIO_BASE;
> @@ -640,7 +640,7 @@ static int gpio_irq_type(unsigned irq, unsigned type)
>  		return -EINVAL;
>  
>  	/* OMAP1 allows only only edge triggering */
> -	if (!cpu_class_is_omap2()
> +	if (!(cpu_class_is_omap2() && cpu_class_is_omap3())
>  			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
>  		return -EINVAL;
>  
> @@ -1026,7 +1026,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
>  			isr &= 0x0000ffff;
>  
> -		if (cpu_class_is_omap2()) {
> +		if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  			level_mask = bank->level_mask & enabled;
>  		}
>  
> @@ -1328,7 +1328,7 @@ static int __init _omap_gpio_init(void)
>  	}
>  #endif
>  #if defined(CONFIG_ARCH_OMAP2)
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		gpio_ick = clk_get(NULL, "gpios_ick");
>  		if (IS_ERR(gpio_ick))
>  			printk("Could not get gpios_ick\n");
> @@ -1532,7 +1532,7 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
>  {
>  	int i;
>  
> -	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
> +	if (!cpu_class_is_omap2() && !cpu_class_is_omap3() && !cpu_is_omap16xx())
>  		return 0;
>  
>  	for (i = 0; i < gpio_bank_count; i++) {
> @@ -1727,7 +1727,7 @@ static int __init omap_gpio_sysinit(void)
>  	mpuio_init();
>  
>  #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> +	if (cpu_is_omap16xx() || cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		if (ret == 0) {
>  			ret = sysdev_class_register(&omap_gpio_sysclass);
>  			if (ret == 0)
> @@ -1789,7 +1789,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
>  
>  		if (bank_is_mpuio(bank))
>  			gpio = OMAP_MPUIO(0);
> -		else if (cpu_class_is_omap2() || cpu_is_omap730())
> +		else if (cpu_class_is_omap2() || cpu_class_is_omap3() || cpu_is_omap730())
>  			bankwidth = 32;
>  
>  		for (j = 0; j < bankwidth; j++, gpio++, mask <<= 1) {
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 2fc8f61..4596ba5 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -136,7 +136,7 @@ void __init omap_detect_sram(void)
>  {
>  	unsigned long reserved;
>  
> -	if (cpu_class_is_omap2()) {
> +	if (cpu_class_is_omap2() || cpu_class_is_omap3()) {
>  		if (is_sram_locked()) {
>  			if (cpu_is_omap34xx()) {
>  				omap_sram_base = OMAP3_SRAM_PUB_VA;
> @@ -466,7 +466,7 @@ int __init omap_sram_init(void)
>  	omap_detect_sram();
>  	omap_map_sram();
>  
> -	if (!(cpu_class_is_omap2()))
> +	if (!(cpu_class_is_omap2() || cpu_class_is_omap3()))
>  		omap1_sram_init();
>  	else if (cpu_is_omap24xx())
>  		omap24xx_sram_init();
> diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
> index a619475..b7365c3 100644
> --- a/arch/arm/plat-omap/usb.c
> +++ b/arch/arm/plat-omap/usb.c
> @@ -170,7 +170,7 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
>  	}
>  
>  	/* internal transceiver (unavailable on 17xx, 24xx) */
> -	if (!cpu_class_is_omap2() && nwires == 2) {
> +	if (!(cpu_class_is_omap2() || cpu_class_is_omap3()) && nwires == 2) {
>  		// omap_cfg_reg(P9_USB_DP);
>  		// omap_cfg_reg(R8_USB_DM);
>  
> diff --git a/include/asm-arm/arch-omap/cpu.h b/include/asm-arm/arch-omap/cpu.h
> index 2626fbd..3b73ad5 100644
> --- a/include/asm-arm/arch-omap/cpu.h
> +++ b/include/asm-arm/arch-omap/cpu.h
> @@ -317,7 +317,8 @@ IS_OMAP_TYPE(3430, 0x3430)
>  /* Macros to detect if we have OMAP1 or OMAP2 */
>  #define cpu_class_is_omap1()	(cpu_is_omap730() || cpu_is_omap15xx() || \
>  				cpu_is_omap16xx())
> -#define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx())
> +#define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap243x())
> +#define cpu_class_is_omap3()	cpu_is_omap34xx()
>  
>  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  /*
> -- 
> 1.5.5.1.57.g5909c
> 
