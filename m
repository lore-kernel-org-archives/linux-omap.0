From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM related changes:McSPI
Date: Tue, 5 Aug 2008 14:06:23 +0300
Message-ID: <20080805110622.GT7193@atomide.com>
References: <38610.192.168.10.88.1217418871.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60717 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbYHELG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 07:06:27 -0400
Content-Disposition: inline
In-Reply-To: <38610.192.168.10.88.1217418871.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Girish. S. G." <girishsg@ti.com>
Cc: linux-omap@vger.kernel.org

* Girish. S. G. <girishsg@ti.com> [080730 14:55]:
> PM related changes for McSPI

This should be sent to spi-devel-general@lists.sourceforge.net, please
also Cc linux-omap list.

Thanks,

Tony


> Signed-off-by: Girish S G <girishsg@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   26 ++++-
>  drivers/spi/omap2_mcspi.c     |  195 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 204 insertions(+), 17 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c	2008-07-30
> 16:49:21.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/devices.c	2008-07-30 16:57:53.000000000
> +0530
> @@ -168,6 +168,11 @@
>  		.end		= OMAP2_MCSPI1_BASE + 0xff,
>  		.flags		= IORESOURCE_MEM,
>  	},
> +
> +	{
> +		.start		= INT_24XX_SPI1_IRQ,
> +		.flags		= IORESOURCE_IRQ,
> +	},
>  };
> 
>  static struct platform_device omap2_mcspi1 = {
> @@ -190,6 +195,11 @@
>  		.end		= OMAP2_MCSPI2_BASE + 0xff,
>  		.flags		= IORESOURCE_MEM,
>  	},
> +
> +	{
> +		.start		= INT_24XX_SPI2_IRQ,
> +		.flags		= IORESOURCE_IRQ,
> +	},
>  };
> 
>  static struct platform_device omap2_mcspi2 = {
> @@ -209,9 +219,14 @@
> 
>  static struct resource omap2_mcspi3_resources[] = {
>  	{
> -	.start		= OMAP2_MCSPI3_BASE,
> -	.end		= OMAP2_MCSPI3_BASE + 0xff,
> -	.flags		= IORESOURCE_MEM,
> +		.start		= OMAP2_MCSPI3_BASE,
> +		.end		= OMAP2_MCSPI3_BASE + 0xff,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +
> +	{
> +		.start		= INT_24XX_SPI3_IRQ,
> +		.flags		= IORESOURCE_IRQ,
>  	},
>  };
> 
> @@ -237,6 +252,11 @@
>  		.end		= OMAP2_MCSPI4_BASE + 0xff,
>  		.flags		= IORESOURCE_MEM,
>  	},
> +
> +	{
> +		.start		= INT_34XX_SPI4_IRQ,
> +		.flags		= IORESOURCE_IRQ,
> +	},
>  };
> 
>  static struct platform_device omap2_mcspi4 = {
> Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c	2008-07-30 16:49:59.000000000
> +0530
> +++ linux-omap-2.6/drivers/spi/omap2_mcspi.c	2008-07-30 17:11:23.000000000 +0530
> @@ -35,6 +35,8 @@
> 
>  #include <linux/spi/spi.h>
> 
> +#include <asm/system.h>
> +#include <asm/irq.h>
>  #include <asm/arch/dma.h>
>  #include <asm/arch/clock.h>
> 
> @@ -61,8 +63,11 @@
> 
>  #define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
>  #define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	(1 << 1)
> +#define OMAP2_AFTR_RST_SET_MASTER	(0 << 2)
> 
>  #define OMAP2_MCSPI_SYSSTATUS_RESETDONE	(1 << 0)
> +#define OMAP2_MCSPI_SYS_CON_LVL_1 1
> +#define OMAP2_MCSPI_SYS_CON_LVL_2 2
> 
>  #define OMAP2_MCSPI_MODULCTRL_SINGLE	(1 << 0)
>  #define OMAP2_MCSPI_MODULCTRL_MS	(1 << 2)
> @@ -84,6 +89,11 @@
>  #define OMAP2_MCSPI_CHCONF_TURBO	(1 << 19)
>  #define OMAP2_MCSPI_CHCONF_FORCE	(1 << 20)
> 
> +#define OMAP2_MCSPI_SYSCFG_WKUP		(1 << 2)
> +#define OMAP2_MCSPI_SYSCFG_IDL		(2 << 3)
> +#define OMAP2_MCSPI_SYSCFG_CLK		(2 << 8)
> +#define OMAP2_MCSPI_WAKEUP_EN		(1 << 1)
> +#define OMAP2_MCSPI_IRQ_WKS		(1 << 16)
>  #define OMAP2_MCSPI_CHSTAT_RXS		(1 << 0)
>  #define OMAP2_MCSPI_CHSTAT_TXS		(1 << 1)
>  #define OMAP2_MCSPI_CHSTAT_EOT		(1 << 2)
> @@ -128,6 +138,15 @@
>  	int			word_len;
>  };
> 
> +#if defined(CONFIG_OMAP34XX_OFFMODE) && defined(CONFIG_OMAP3_PM)
> +struct omap_mcspi_regs {
> +	u32 sysconfig;
> +	u32 modulctrl;
> +	u32 chconf0;
> +	u32 chconf1;
> +};
> +static struct omap_mcspi_regs mcspi_ctx[4];
> +#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */
>  static struct workqueue_struct *omap2_mcspi_wq;
> 
>  #define MOD_REG_BIT(val, mask, set) do { \
> @@ -152,6 +171,14 @@
>  	return __raw_readl(mcspi->base + idx);
>  }
> 
> +static inline void mcspi_write_wkup_reg(struct spi_master *master,
> +				      int idx, u32 val)
> +{
> +	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
> +
> +	__raw_writel(val, mcspi->base + idx);
> +}
> +
>  static inline void mcspi_write_cs_reg(const struct spi_device *spi,
>  		int idx, u32 val)
>  {
> @@ -214,6 +241,99 @@
>  	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>  }
> 
> +static void omap_mcspi_wakeup_enable(struct spi_master *spi_cntrl, int level)
> +{
> +	if (level == OMAP2_MCSPI_SYS_CON_LVL_1)
> +	mcspi_write_wkup_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
> +			(mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG) |
> +			 OMAP2_MCSPI_SYSCFG_WKUP | OMAP2_MCSPI_SYSCFG_IDL |
> +			 OMAP2_MCSPI_SYSCFG_CLK |
> +					OMAP2_MCSPI_SYSCONFIG_AUTOIDLE));
> +
> +	if (level == OMAP2_MCSPI_SYS_CON_LVL_2)
> +	mcspi_write_wkup_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
> +			(mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG) |
> +			OMAP2_MCSPI_SYSCFG_WKUP | OMAP2_MCSPI_SYSCFG_IDL |
> +			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE));
> +
> +	mcspi_write_wkup_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
> +				 OMAP2_MCSPI_WAKEUP_EN);
> +
> +	/* enable wakeup interrupt*/
> +	mcspi_write_wkup_reg(spi_cntrl, OMAP2_MCSPI_IRQENABLE,
> +				 (mcspi_read_reg(spi_cntrl,
> +				 OMAP2_MCSPI_IRQENABLE) | OMAP2_MCSPI_IRQ_WKS));
> +}
> +
> +#if defined(CONFIG_OMAP34XX_OFFMODE) && defined(CONFIG_OMAP3_PM)
> +static void omap2_mcspi_save_ctx(struct omap2_mcspi *mcspi)
> +{
> +	struct spi_master *spi_cntrl;
> +	spi_cntrl = mcspi->master;
> +
> +	/* McSPI : context save */
> +	mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl = mcspi_read_reg(spi_cntrl,
> +							OMAP2_MCSPI_MODULCTRL);
> +	mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig = mcspi_read_reg(spi_cntrl,
> +							OMAP2_MCSPI_SYSCONFIG);
> +
> +	mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 = mcspi_read_reg(spi_cntrl,
> +							OMAP2_MCSPI_CHCONF0);
> +	if (spi_cntrl->bus_num != 4)
> +		mcspi_ctx[spi_cntrl->bus_num - 1].chconf1 =
> +			mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0 + 0x14);
> +}
> +
> +static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
> +{
> +	struct spi_master *spi_cntrl;
> +	spi_cntrl = mcspi->master;
> +
> +	/*McSPI : context restore */
> +	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
> +				mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
> +	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
> +				mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
> +
> +	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
> +				mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);
> +	if (spi_cntrl->bus_num != 4)
> +		mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0 + 0x14,
> +				mcspi_ctx[spi_cntrl->bus_num - 1].chconf1);
> +}
> +
> +#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */
> +
> +static int omap_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
> +
> +{
> +	struct spi_master      *spi_cntrl = mcspi->master;
> +	if (clk_enable(mcspi->ick))
> +		return -ENODEV;
> +	if (clk_enable(mcspi->fck)) {
> +		clk_disable(mcspi->ick);
> +		return -ENODEV;
> +	}
> +#if defined(CONFIG_OMAP34XX_OFFMODE) && defined(CONFIG_OMAP3_PM)
> +	if (context_restore_required(mcspi->fck))
> +		omap2_mcspi_restore_ctx(mcspi);
> +#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */
> +	omap_mcspi_wakeup_enable(spi_cntrl, OMAP2_MCSPI_SYS_CON_LVL_1);
> +	return 0;
> +}
> +
> +static void omap_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
> +
> +{
> +	struct spi_master      *spi_cntrl = mcspi->master;
> +	omap_mcspi_wakeup_enable(spi_cntrl, OMAP2_MCSPI_SYS_CON_LVL_2);
> +#if defined(CONFIG_OMAP34XX_OFFMODE) && defined(CONFIG_OMAP3_PM)
> +	omap2_mcspi_save_ctx(mcspi);
> +#endif /* #ifdef CONFIG_OMAP34XX_OFFMODE */
> +	clk_disable(mcspi->ick);
> +	clk_disable(mcspi->fck);
> +}
> +
>  static unsigned
>  omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  {
> @@ -475,6 +595,29 @@
>  	return count - c;
>  }
> 
> +static irqreturn_t
> +omap_mcspi_isr(int irq, void *mcspi_id)
> +{
> +	struct omap2_mcspi *mcspi = mcspi_id;
> +	u32 flags;
> +	u32 irqstatus = 0;
> +
> +	omap_mcspi_enable_clocks(mcspi);
> +
> +	irqstatus = mcspi_read_reg((struct spi_master *)mcspi->master,
> +					OMAP2_MCSPI_IRQSTATUS);
> +	if (irqstatus & OMAP2_MCSPI_IRQ_WKS) {
> +		spin_lock_irqsave(&mcspi->lock, flags);
> +
> +		/* clear the wakeup interrupt */
> +		mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS,
> +				OMAP2_MCSPI_IRQ_WKS);
> +		spin_unlock_irqrestore(&mcspi->lock, flags);
> +	}
> +	omap_mcspi_disable_clocks(mcspi);
> +
> +	return IRQ_HANDLED;
> +}
>  /* called only when no transfer is active to this device */
>  static int omap2_mcspi_setup_transfer(struct spi_device *spi,
>  		struct spi_transfer *t)
> @@ -643,11 +786,12 @@
>  			return ret;
>  	}
> 
> -	clk_enable(mcspi->ick);
> -	clk_enable(mcspi->fck);
> +	if (omap_mcspi_enable_clocks(mcspi)) {
> +		dev_dbg(&spi->dev, "Unable to get SPI clocks");
> +		return -ENODEV;
> +	}
>  	ret = omap2_mcspi_setup_transfer(spi, NULL);
> -	clk_disable(mcspi->fck);
> -	clk_disable(mcspi->ick);
> +	omap_mcspi_disable_clocks(mcspi);
> 
>  	return ret;
>  }
> @@ -679,8 +823,7 @@
>  	mcspi = container_of(work, struct omap2_mcspi, work);
>  	spin_lock_irq(&mcspi->lock);
> 
> -	clk_enable(mcspi->ick);
> -	clk_enable(mcspi->fck);
> +	omap_mcspi_enable_clocks(mcspi);
> 
>  	/* We only enable one channel at a time -- the one whose message is
>  	 * at the head of the queue -- although this controller would gladly
> @@ -871,8 +1014,8 @@
>  	struct spi_master	*master = mcspi->master;
>  	u32			tmp;
> 
> -	clk_enable(mcspi->ick);
> -	clk_enable(mcspi->fck);
> +	if (omap_mcspi_enable_clocks(mcspi))
> +		return -ENODEV;
> 
>  	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
>  			OMAP2_MCSPI_SYSCONFIG_SOFTRESET);
> @@ -880,14 +1023,12 @@
>  		tmp = mcspi_read_reg(master, OMAP2_MCSPI_SYSSTATUS);
>  	} while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
> 
> -	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
> -			/* (3 << 8) | (2 << 3) | */
> -			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE);
> +	/* call wakeup function to set sysconfig as per pm activity*/
> +	omap_mcspi_wakeup_enable(master, OMAP2_MCSPI_SYS_CON_LVL_1);
> 
>  	omap2_mcspi_set_master_mode(master);
> 
> -	clk_disable(mcspi->fck);
> -	clk_disable(mcspi->ick);
> +	omap_mcspi_disable_clocks(mcspi);
>  	return 0;
>  }
> 
> @@ -941,7 +1082,7 @@
>  {
>  	struct spi_master	*master;
>  	struct omap2_mcspi	*mcspi;
> -	struct resource		*r;
> +	struct resource		*r, *r_irq;
>  	int			status = 0, i;
>  	const u8		*rxdma_id, *txdma_id;
>  	unsigned		num_chipselect;
> @@ -1025,6 +1166,19 @@
>  		goto err2;
>  	}
> 
> +	r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (r_irq == NULL) {
> +		status = -ENODEV;
> +		goto err1;
> +	}
> +
> +	/* request irq for the channel*/
> +	if (request_irq(r_irq->start, omap_mcspi_isr,
> +			 IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
> +			"omap_mcspi_isr", mcspi)) {
> +		printk(KERN_ERR "MCSPI ERROR: couldnt allocate irq\n");
> +	}
> +
>  	mcspi->dma_channels = kcalloc(master->num_chipselect,
>  			sizeof(struct omap2_mcspi_dma),
>  			GFP_KERNEL);
> @@ -1061,6 +1215,17 @@
>  	return status;
>  }
> 
> +static int __devexit omap2_mcspi_suspend(struct platform_device *pdev,
> +						 pm_message_t state)
> +{
> +	/* do nothing as of now */
> +	return 0;
> +}
> +static int __devexit omap2_mcspi_resume(struct platform_device *pdev)
> +{
> +	/* do nothing as of now: agressive power managment */
> +	return 0;
> +}
>  static int __exit omap2_mcspi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master	*master;
> @@ -1092,6 +1257,8 @@
>  		.name =		"omap2_mcspi",
>  		.owner =	THIS_MODULE,
>  	},
> +	.suspend = 	omap2_mcspi_suspend,
> +	.resume = 	omap2_mcspi_resume,
>  	.remove =	__exit_p(omap2_mcspi_remove),
>  };
> 
