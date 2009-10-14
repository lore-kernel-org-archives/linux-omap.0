From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/27] OMAP3: PM: GPIO context save/restore
Date: Wed, 14 Oct 2009 15:13:41 -0700
Message-ID: <20091014221340.GM12700@atomide.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [091014 15:08]:
> From: Rajendra Nayak <rnayak@ti.com>

This one should have a description of the patch here.

Also one comment below.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/plat-omap/gpio.c              |   93 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/gpio.h |    3 +-
>  2 files changed, 95 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index b1af0c2..48ce218 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -260,6 +260,23 @@ static struct gpio_bank gpio_bank_34xx[6] = {
>  	{ OMAP34XX_GPIO6_BASE, INT_34XX_GPIO_BANK6, IH_GPIO_BASE + 160, METHOD_GPIO_24XX },
>  };
>  
> +struct omap3_gpio_regs {
> +	u32 sysconfig;
> +	u32 irqenable1;
> +	u32 irqenable2;
> +	u32 wake_en;
> +	u32 ctrl;
> +	u32 oe;
> +	u32 leveldetect0;
> +	u32 leveldetect1;
> +	u32 risingdetect;
> +	u32 fallingdetect;
> +	u32 dataout;
> +	u32 setwkuena;
> +	u32 setdataout;
> +};
> +
> +static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
>  #endif
>  
>  #ifdef CONFIG_ARCH_OMAP4
> @@ -2002,6 +2019,82 @@ void omap2_gpio_resume_after_retention(void)
>  
>  #endif
>  
> +#ifdef CONFIG_ARCH_OMAP34XX
> +/* save the registers of bank 2-6 */
> +void omap3_gpio_save_context(void)
> +{
> +	int i;
> +
> +	/* saving banks from 2-6 only since GPIO1 is in WKUP */
> +	for (i = 1; i < gpio_bank_count; i++) {
> +		struct gpio_bank *bank = &gpio_bank[i];
> +		gpio_context[i].sysconfig =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_SYSCONFIG);
> +		gpio_context[i].irqenable1 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
> +		gpio_context[i].irqenable2 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
> +		gpio_context[i].wake_en =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
> +		gpio_context[i].ctrl =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +		gpio_context[i].oe =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
> +		gpio_context[i].leveldetect0 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
> +		gpio_context[i].leveldetect1 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
> +		gpio_context[i].risingdetect =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
> +		gpio_context[i].fallingdetect =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
> +		gpio_context[i].dataout =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
> +		gpio_context[i].setwkuena =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_SETWKUENA);
> +		gpio_context[i].setdataout =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_SETDATAOUT);
> +	}
> +}
> +EXPORT_SYMBOL(omap3_gpio_save_context);

This function looks like it should work on most omaps.
Maybe it should be named just omap_gpio_save_context()?

> +
> +/* restore the required registers of bank 2-6 */
> +void omap3_gpio_restore_context(void)
> +{
> +	int i;
> +	for (i = 1; i < gpio_bank_count; i++) {
> +		struct gpio_bank *bank = &gpio_bank[i];
> +		__raw_writel(gpio_context[i].sysconfig,
> +				bank->base + OMAP24XX_GPIO_SYSCONFIG);
> +		__raw_writel(gpio_context[i].irqenable1,
> +				bank->base + OMAP24XX_GPIO_IRQENABLE1);
> +		__raw_writel(gpio_context[i].irqenable2,
> +				bank->base + OMAP24XX_GPIO_IRQENABLE2);
> +		__raw_writel(gpio_context[i].wake_en,
> +				bank->base + OMAP24XX_GPIO_WAKE_EN);
> +		__raw_writel(gpio_context[i].ctrl,
> +				bank->base + OMAP24XX_GPIO_CTRL);
> +		__raw_writel(gpio_context[i].oe,
> +				bank->base + OMAP24XX_GPIO_OE);
> +		__raw_writel(gpio_context[i].leveldetect0,
> +				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
> +		__raw_writel(gpio_context[i].leveldetect1,
> +				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
> +		__raw_writel(gpio_context[i].risingdetect,
> +				bank->base + OMAP24XX_GPIO_RISINGDETECT);
> +		__raw_writel(gpio_context[i].fallingdetect,
> +				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
> +		__raw_writel(gpio_context[i].dataout,
> +				bank->base + OMAP24XX_GPIO_DATAOUT);
> +		__raw_writel(gpio_context[i].setwkuena,
> +				bank->base + OMAP24XX_GPIO_SETWKUENA);
> +		__raw_writel(gpio_context[i].setdataout,
> +				bank->base + OMAP24XX_GPIO_SETDATAOUT);
> +	}
> +}
> +EXPORT_SYMBOL(omap3_gpio_restore_context);

This too?


> +#endif
> +
>  /*
>   * This may get called early from board specific init
>   * for boards that have interrupts routed via FPGA.
> diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/mach/gpio.h
> index 633ff68..7310414 100644
> --- a/arch/arm/plat-omap/include/mach/gpio.h
> +++ b/arch/arm/plat-omap/include/mach/gpio.h
> @@ -76,7 +76,8 @@ extern void omap2_gpio_prepare_for_retention(void);
>  extern void omap2_gpio_resume_after_retention(void);
>  extern void omap_set_gpio_debounce(int gpio, int enable);
>  extern void omap_set_gpio_debounce_time(int gpio, int enable);
> -
> +extern void omap3_gpio_save_context(void);
> +extern void omap3_gpio_restore_context(void);
>  /*-------------------------------------------------------------------------*/
>  
>  /* Wrappers for "new style" GPIO calls, using the new infrastructure
> -- 
> 1.6.4.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
