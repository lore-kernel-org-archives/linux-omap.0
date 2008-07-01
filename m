From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 09/11] gpio context save/restore
Date: Tue, 1 Jul 2008 21:31:35 +0300
Message-ID: <20080701183036.GH9696@kedavra.cpe.vivax.com.br>
References: <004601c8db85$110717f0$68bf18ac@ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58360 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYGASb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 14:31:57 -0400
Content-Disposition: inline
In-Reply-To: <004601c8db85$110717f0$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Jul 01, 2008 at 07:46:34PM +0530, Rajendra Nayak wrote:
> +#ifdef CONFIG_ARCH_OMAP34XX
> +/* save the registers of bank 2-6 */
> +void omap_gpio_save(void)
> +{
> +	int i;
> +	/* saving banks from 2-6 only */
> +	for (i = 1; i < gpio_bank_count; i++) {
> +		struct gpio_bank *bank = &gpio_bank[i];
> +		gpio_restore_banks[i].gpio_sysconfig =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_SYSCONFIG);
> +		gpio_restore_banks[i].gpio_wake_en =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
> +		gpio_restore_banks[i].gpio_ctrl =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +		gpio_restore_banks[i].gpio_oe =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
> +		gpio_restore_banks[i].gpio_leveldetect0 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
> +		gpio_restore_banks[i].gpio_leveldetect1 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
> +		gpio_restore_banks[i].gpio_risingdetect =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
> +		gpio_restore_banks[i].gpio_fallingdetect =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
> +		gpio_restore_banks[i].gpio_dataout =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
> +		gpio_restore_banks[i].gpio_setwkuena =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_SETWKUENA);
> +		gpio_restore_banks[i].gpio_setdataout =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_SETDATAOUT);
> +	}
> +}
> +EXPORT_SYMBOL(omap_gpio_save);
> +
> +/* restore the required registers of bank 2-6 */
> +void omap_gpio_restore(void)
> +{
> +	int i;
> +	for (i = 1; i < gpio_bank_count; i++) {
> +		struct gpio_bank *bank = &gpio_bank[i];
> +		__raw_writel(gpio_restore_banks[i].gpio_sysconfig,
> +				bank->base + OMAP24XX_GPIO_SYSCONFIG);
> +		__raw_writel(gpio_restore_banks[i].gpio_wake_en,
> +				bank->base + OMAP24XX_GPIO_WAKE_EN);
> +		__raw_writel(gpio_restore_banks[i].gpio_ctrl,
> +				bank->base + OMAP24XX_GPIO_CTRL);
> +		__raw_writel(gpio_restore_banks[i].gpio_oe,
> +				bank->base + OMAP24XX_GPIO_OE);
> +		__raw_writel(gpio_restore_banks[i].gpio_leveldetect0,
> +				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
> +		__raw_writel(gpio_restore_banks[i].gpio_leveldetect1,
> +				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
> +		__raw_writel(gpio_restore_banks[i].gpio_risingdetect,
> +				bank->base + OMAP24XX_GPIO_RISINGDETECT);
> +		__raw_writel(gpio_restore_banks[i].gpio_fallingdetect,
> +				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
> +		__raw_writel(gpio_restore_banks[i].gpio_dataout,
> +				bank->base + OMAP24XX_GPIO_DATAOUT);
> +		__raw_writel(gpio_restore_banks[i].gpio_setwkuena,
> +				bank->base + OMAP24XX_GPIO_SETWKUENA);
> +		__raw_writel(gpio_restore_banks[i].gpio_setdataout,
> +				bank->base + OMAP24XX_GPIO_SETDATAOUT);
> +	}
> +}
> +EXPORT_SYMBOL(omap_gpio_restore);

#else
inline void omap_gpio_save(void) {}
inline void omap_gpio_restore(void) {}

otherwise ifndef OMAP3 we're gonna get undef reference

or maybe do it in the header, but then use static inline, instead of
inline only.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
