From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v7 01/11] OMAP: GPIO: prepare for platform driver
Date: Thu, 25 Nov 2010 22:38:29 -0600
Message-ID: <20101126043829.GB6598@lixom.net>
References: <1290524213-395-1-git-send-email-charu@ti.com>
	<1290524213-395-2-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1290524213-395-2-git-send-email-charu@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Nov 23, 2010 at 08:26:43PM +0530, Varadarajan, Charulatha wrote:
> +static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
> +{
> +	if (cpu_class_is_omap2()) {

Why check class when you're checking for all possible variants anyway?

> +		if (cpu_is_omap44xx()) {
> +			__raw_writel(0xffffffff, bank->base +
> +					OMAP4_GPIO_IRQSTATUSCLR0);
> +			__raw_writel(0x00000000, bank->base +
> +					 OMAP4_GPIO_DEBOUNCENABLE);
> +			/* Initialize interface clk ungated, module enabled */
> +			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
> +		} else if (cpu_is_omap34xx()) {
> +			__raw_writel(0x00000000, bank->base +
> +					OMAP24XX_GPIO_IRQENABLE1);
> +			__raw_writel(0xffffffff, bank->base +
> +					OMAP24XX_GPIO_IRQSTATUS1);
> +			__raw_writel(0x00000000, bank->base +
> +					OMAP24XX_GPIO_DEBOUNCE_EN);
> +
> +			/* Initialize interface clk ungated, module enabled */
> +			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> +		} else if (cpu_is_omap24xx()) {
> +			static const u32 non_wakeup_gpios[] = {
> +				0xe203ffc0, 0x08700040
> +			};
> +			if (id < ARRAY_SIZE(non_wakeup_gpios))
> +				bank->non_wakeup_gpios = non_wakeup_gpios[id];
> +		}
> +	} else if (cpu_class_is_omap1()) {
> +		if (bank_is_mpuio(bank))
> +			__raw_writew(0xffff, bank->base
> +						+ OMAP_MPUIO_GPIO_MASKIT);

Above is using else if, this is using if. I don't see how you can ever
hit more than one of these anyway.

Besides, why check for both cpu and method? When do they ever
diverge? (same goes for other places)

The plat-omap/gpio.c driver is pretty hard to read because of all the
ifdeffing and tests for platforms. It would make sense to abstract out
some of the operations into separate functions and use function pointers
for them, IMHO. (Not an issue for this patch, just a reflection).

> +		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
> +			__raw_writew(0xffff, bank->base
> +						+ OMAP1510_GPIO_INT_MASK);
> +			__raw_writew(0x0000, bank->base
> +						+ OMAP1510_GPIO_INT_STATUS);
> +		}
> +		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
> +			__raw_writew(0x0000, bank->base
> +						+ OMAP1610_GPIO_IRQENABLE1);
> +			__raw_writew(0xffff, bank->base
> +						+ OMAP1610_GPIO_IRQSTATUS1);
> +			__raw_writew(0x0014, bank->base
> +						+ OMAP1610_GPIO_SYSCONFIG);
> +
> +			/*
> +			 * Enable system clock for GPIO module.
> +			 * The CAM_CLK_CTRL *is* really the right place.
> +			 */
> +			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
> +						ULPD_CAM_CLK_CTRL);
> +		}
> +		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
> +			__raw_writel(0xffffffff, bank->base
> +						+ OMAP7XX_GPIO_INT_MASK);
> +			__raw_writel(0x00000000, bank->base
> +						+ OMAP7XX_GPIO_INT_STATUS);
> +		}
> +	}
> +}
> +
> +static void __init omap_gpio_chip_init(struct gpio_bank *bank)
> +{
> +	int j, bank_width = 16;
> +	static int gpio;
> +
> +	if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX)
> +		bank_width = 32; /* 7xx has 32-bit GPIOs */
> +
> +	if ((bank->method == METHOD_GPIO_24XX) ||
> +			(bank->method == METHOD_GPIO_44XX))
> +		bank_width = 32;
> +
> +	bank->mod_usage = 0;
> +	/*
> +	 * REVISIT eventually switch from OMAP-specific gpio structs
> +	 * over to the generic ones
> +	 */
> +	bank->chip.request = omap_gpio_request;
> +	bank->chip.free = omap_gpio_free;
> +	bank->chip.direction_input = gpio_input;
> +	bank->chip.get = gpio_get;
> +	bank->chip.direction_output = gpio_output;
> +	bank->chip.set_debounce = gpio_debounce;
> +	bank->chip.set = gpio_set;
> +	bank->chip.to_irq = gpio_2irq;
> +	if (bank_is_mpuio(bank)) {
> +		bank->chip.label = "mpuio";
> +#ifdef CONFIG_ARCH_OMAP16XX
> +		bank->chip.dev = &omap_mpuio_device.dev;
> +#endif
> +		bank->chip.base = OMAP_MPUIO(0);
> +	} else {
> +		bank->chip.label = "gpio";
> +		bank->chip.base = gpio;
> +		gpio += bank_width;
> +	}
> +	bank->chip.ngpio = bank_width;
> +
> +	gpiochip_add(&bank->chip);
> +
> +	for (j = bank->virtual_irq_start;
> +		     j < bank->virtual_irq_start + bank_width; j++) {
> +		lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
> +		set_irq_chip_data(j, bank);
> +		if (bank_is_mpuio(bank))
> +			set_irq_chip(j, &mpuio_irq_chip);
> +		else
> +			set_irq_chip(j, &gpio_irq_chip);
> +		set_irq_handler(j, handle_simple_irq);
> +		set_irq_flags(j, IRQF_VALID);
> +	}
> +	set_irq_chained_handler(bank->irq, gpio_irq_handler);
> +	set_irq_data(bank->irq, bank);
> +}
> +
>  static int __init _omap_gpio_init(void)
>  {
>  	int i;
> -	int gpio = 0;
>  	struct gpio_bank *bank;
>  	int bank_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
>  	char clk_name[11];
> @@ -1828,7 +1941,6 @@ static int __init _omap_gpio_init(void)
>  	}
>  #endif
>  	for (i = 0; i < gpio_bank_count; i++) {
> -		int j, gpio_count = 16;
>  
>  		bank = &gpio_bank[i];
>  		spin_lock_init(&bank->lock);
> @@ -1840,107 +1952,8 @@ static int __init _omap_gpio_init(void)
>  			continue;
>  		}
>  
> -		if (bank_is_mpuio(bank))
> -			__raw_writew(0xffff, bank->base + OMAP_MPUIO_GPIO_MASKIT);
> -		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
> -			__raw_writew(0xffff, bank->base + OMAP1510_GPIO_INT_MASK);
> -			__raw_writew(0x0000, bank->base + OMAP1510_GPIO_INT_STATUS);
> -		}
> -		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
> -			__raw_writew(0x0000, bank->base + OMAP1610_GPIO_IRQENABLE1);
> -			__raw_writew(0xffff, bank->base + OMAP1610_GPIO_IRQSTATUS1);
> -			__raw_writew(0x0014, bank->base + OMAP1610_GPIO_SYSCONFIG);
> -		}
> -		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
> -			__raw_writel(0xffffffff, bank->base + OMAP7XX_GPIO_INT_MASK);
> -			__raw_writel(0x00000000, bank->base + OMAP7XX_GPIO_INT_STATUS);
> -
> -			gpio_count = 32; /* 7xx has 32-bit GPIOs */
> -		}
> -
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -		if ((bank->method == METHOD_GPIO_24XX) ||
> -				(bank->method == METHOD_GPIO_44XX)) {
> -			static const u32 non_wakeup_gpios[] = {
> -				0xe203ffc0, 0x08700040
> -			};
> -
> -			if (cpu_is_omap44xx()) {
> -				__raw_writel(0xffffffff, bank->base +
> -						OMAP4_GPIO_IRQSTATUSCLR0);
> -				__raw_writew(0x0015, bank->base +
> -						OMAP4_GPIO_SYSCONFIG);
> -				__raw_writel(0x00000000, bank->base +
> -						 OMAP4_GPIO_DEBOUNCENABLE);
> -				/*
> -				 * Initialize interface clock ungated,
> -				 * module enabled
> -				 */
> -				__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
> -			} else {
> -				__raw_writel(0x00000000, bank->base +
> -						OMAP24XX_GPIO_IRQENABLE1);
> -				__raw_writel(0xffffffff, bank->base +
> -						OMAP24XX_GPIO_IRQSTATUS1);
> -				__raw_writew(0x0015, bank->base +
> -						OMAP24XX_GPIO_SYSCONFIG);
> -				__raw_writel(0x00000000, bank->base +
> -						OMAP24XX_GPIO_DEBOUNCE_EN);
> -
> -				/*
> -				 * Initialize interface clock ungated,
> -				 * module enabled
> -				 */
> -				__raw_writel(0, bank->base +
> -						OMAP24XX_GPIO_CTRL);
> -			}
> -			if (cpu_is_omap24xx() &&
> -			    i < ARRAY_SIZE(non_wakeup_gpios))
> -				bank->non_wakeup_gpios = non_wakeup_gpios[i];
> -			gpio_count = 32;
> -		}
> -#endif
> -
> -		bank->mod_usage = 0;
> -		/* REVISIT eventually switch from OMAP-specific gpio structs
> -		 * over to the generic ones
> -		 */
> -		bank->chip.request = omap_gpio_request;
> -		bank->chip.free = omap_gpio_free;
> -		bank->chip.direction_input = gpio_input;
> -		bank->chip.get = gpio_get;
> -		bank->chip.direction_output = gpio_output;
> -		bank->chip.set_debounce = gpio_debounce;
> -		bank->chip.set = gpio_set;
> -		bank->chip.to_irq = gpio_2irq;
> -		if (bank_is_mpuio(bank)) {
> -			bank->chip.label = "mpuio";
> -#ifdef CONFIG_ARCH_OMAP16XX
> -			bank->chip.dev = &omap_mpuio_device.dev;
> -#endif
> -			bank->chip.base = OMAP_MPUIO(0);
> -		} else {
> -			bank->chip.label = "gpio";
> -			bank->chip.base = gpio;
> -			gpio += gpio_count;
> -		}
> -		bank->chip.ngpio = gpio_count;
> -
> -		gpiochip_add(&bank->chip);
> -
> -		for (j = bank->virtual_irq_start;
> -		     j < bank->virtual_irq_start + gpio_count; j++) {
> -			lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
> -			set_irq_chip_data(j, bank);
> -			if (bank_is_mpuio(bank))
> -				set_irq_chip(j, &mpuio_irq_chip);
> -			else
> -				set_irq_chip(j, &gpio_irq_chip);
> -			set_irq_handler(j, handle_simple_irq);
> -			set_irq_flags(j, IRQF_VALID);
> -		}
> -		set_irq_chained_handler(bank->irq, gpio_irq_handler);
> -		set_irq_data(bank->irq, bank);
> +		omap_gpio_mod_init(bank, i);
> +		omap_gpio_chip_init(bank);
>  
>  		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>  			sprintf(clk_name, "gpio%d_dbck", i + 1);
> @@ -1950,17 +1963,6 @@ static int __init _omap_gpio_init(void)
>  		}
>  	}
>  
> -	/* Enable system clock for GPIO module.
> -	 * The CAM_CLK_CTRL *is* really the right place. */
> -	if (cpu_is_omap16xx())
> -		omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04, ULPD_CAM_CLK_CTRL);
> -
> -	/* Enable autoidle for the OCP interface */
> -	if (cpu_is_omap24xx())
> -		omap_writel(1 << 0, 0x48019010);
> -	if (cpu_is_omap34xx())
> -		omap_writel(1 << 0, 0x48306814);
> -
>  	omap_gpio_show_rev();
>  
>  	return 0;
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
