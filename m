From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/8] mfd: twl-core: Rename TWL4030_CORE Kconfig option to
 TWL_CORE
Date: Wed, 30 Mar 2016 18:34:21 +0300
Message-ID: <56FBF1FD.8090903@ti.com>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
 <1459279341-17389-3-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459279341-17389-3-git-send-email-contact-W9ppeneeCTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
> Since the twl-core mfd driver is not limited to twl4030 support, but also
> supports other chips of the TWL family, it makes sense to rename its matching
> Kconfig opton to a non-model-specific name.

Personally I don't see too much reason for this, but it's up to maintainers to decide.
Regarding this patch - pls, do not mix Kconfig and code changes.

And it will be good to have cover letter.

> 
> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> ---
>   arch/arm/mach-omap2/Kconfig     | 2 +-
>   arch/arm/mach-omap2/Makefile    | 2 +-
>   arch/arm/mach-omap2/pm.h        | 2 +-
>   arch/arm/plat-omap/Kconfig      | 2 +-
>   drivers/gpio/Kconfig            | 2 +-
>   drivers/iio/adc/Kconfig         | 4 ++--
>   drivers/input/keyboard/Kconfig  | 2 +-
>   drivers/input/misc/Kconfig      | 4 ++--
>   drivers/mfd/Kconfig             | 6 +++---
>   drivers/mfd/Makefile            | 2 +-
>   drivers/mfd/twl4030-irq.c       | 6 +++---
>   drivers/phy/Kconfig             | 2 +-
>   drivers/power/Kconfig           | 2 +-
>   drivers/pwm/Kconfig             | 4 ++--
>   drivers/regulator/Kconfig       | 2 +-
>   drivers/rtc/Kconfig             | 2 +-
>   drivers/usb/phy/Kconfig         | 2 +-
>   drivers/video/backlight/Kconfig | 2 +-
>   drivers/watchdog/Kconfig        | 2 +-
>   include/linux/i2c/twl.h         | 4 ++--
>   sound/soc/codecs/Kconfig        | 2 +-
>   sound/soc/omap/Kconfig          | 4 ++--
>   22 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0517f0c..ada4c7a1 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -124,7 +124,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>   	select PM
>   	select REGULATOR
>   	select REGULATOR_FIXED_VOLTAGE
> -	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
> +	select TWL_CORE if ARCH_OMAP3 || ARCH_OMAP4
>   	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
>   	select VFP
>   	help
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 0ba6a0e..6eb680a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -27,7 +27,7 @@ ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
>   obj-y += mcbsp.o
>   endif
>   
> -obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
> +obj-$(CONFIG_TWL_CORE) += omap_twl.o
>   obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o
>   
>   # SMP support ONLY available for OMAP4
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index b668719..bf4dac2 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -123,7 +123,7 @@ static inline int omap_devinit_smartreflex(void)
>   static inline void omap_enable_smartreflex_on_init(void) {}
>   #endif
>   
> -#ifdef CONFIG_TWL4030_CORE
> +#ifdef CONFIG_TWL_CORE
>   extern int omap3_twl_init(void);
>   extern int omap4_twl_init(void);
>   extern int omap3_twl_set_sr_bit(bool enable);
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index d055db3..8631a45 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -44,7 +44,7 @@ config POWER_AVS_OMAP
>   
>   config POWER_AVS_OMAP_CLASS3
>   	bool "Class 3 mode of Smartreflex Implementation"
> -	depends on POWER_AVS_OMAP && TWL4030_CORE
> +	depends on POWER_AVS_OMAP && TWL_CORE
>   	help
>   	  Say Y to enable Class 3 implementation of Smartreflex
>   
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5f3429f..62ca9b4 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -933,7 +933,7 @@ config GPIO_TPS65912
>   
>   config GPIO_TWL4030
>   	tristate "TWL4030, TWL5030, and TPS659x0 GPIOs"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	help
>   	  Say yes here to access the GPIO signals of various multi-function
>   	  power management chips from Texas Instruments.
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af4aea7..3360492 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -440,7 +440,7 @@ config TI_AM335X_ADC
>   
>   config TWL4030_MADC
>   	tristate "TWL4030 MADC (Monitoring A/D Converter)"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	help
>   	  This driver provides support for Triton TWL4030-MADC. The
>   	  driver supports both RT and SW conversion methods.
> @@ -450,7 +450,7 @@ config TWL4030_MADC
>   
>   config TWL6030_GPADC
>   	tristate "TWL6030 GPADC (General Purpose A/D Converter) Support"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	default n
>   	help
>   	  Say yes here if you want support for the TWL6030/TWL6032 General
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 509608c..9cfa09b 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -653,7 +653,7 @@ config KEYBOARD_TC3589X
>   
>   config KEYBOARD_TWL4030
>   	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	select INPUT_MATRIXKMAP
>   	help
>   	  Say Y here if your board use the keypad controller on
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 1f2337a..6abb6df 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -461,7 +461,7 @@ config INPUT_AXP20X_PEK
>   
>   config INPUT_TWL4030_PWRBUTTON
>   	tristate "TWL4030 Power button Driver"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	help
>   	  Say Y here if you want to enable power key reporting via the
>   	  TWL4030 family of chips.
> @@ -471,7 +471,7 @@ config INPUT_TWL4030_PWRBUTTON
>   
>   config INPUT_TWL4030_VIBRA
>   	tristate "Support for TWL4030 Vibrator"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	select MFD_TWL4030_AUDIO
>   	select INPUT_FF_MEMLESS
>   	help
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index eea61e3..28bfe3d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1266,7 +1266,7 @@ config MFD_TPS80031
>   	  ADC, RTC, 2 PWM, System Voltage Regulator/Battery Charger with
>   	  Power Path from USB, 32K clock generator.
>   
> -config TWL4030_CORE
> +config TWL_CORE
>   	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
>   	depends on I2C=y
>   	select IRQ_DOMAIN
> @@ -1284,7 +1284,7 @@ config TWL4030_CORE
>   
>   config TWL4030_POWER
>   	bool "TI TWL4030 power resources"
> -	depends on TWL4030_CORE && ARM
> +	depends on TWL_CORE && ARM
>   	help
>   	  Say yes here if you want to use the power resources on the
>   	  TWL4030 family chips.  Most of these resources are regulators,
> @@ -1297,7 +1297,7 @@ config TWL4030_POWER
>   
>   config MFD_TWL4030_AUDIO
>   	bool "TI TWL4030 Audio"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	select MFD_CORE
>   	default n
>   
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5eaa6465d..7daeab5 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -81,7 +81,7 @@ obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
>   obj-$(CONFIG_MFD_TPS80031)	+= tps80031.o
>   obj-$(CONFIG_MENELAUS)		+= menelaus.o
>   
> -obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
> +obj-$(CONFIG_TWL_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
>   obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
>   obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
>   obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index 40e51b0..52dc294 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -54,7 +54,7 @@
>    *	base + 8  .. base + 15	SIH for PWR_INT
>    *	base + 16 .. base + 33	SIH for GPIO
>    */
> -#define TWL4030_CORE_NR_IRQS	8
> +#define TWL_CORE_NR_IRQS	8
>   #define TWL4030_PWR_NR_IRQS	8
>   
>   /* PIH register offsets */
> @@ -693,7 +693,7 @@ int twl4030_init_irq(struct device *dev, int irq_num)
>   	 * the hwirqs numbers are defined contiguously from 1 to 15.
>   	 * Create only one domain for both.
>   	 */
> -	nr_irqs = TWL4030_PWR_NR_IRQS + TWL4030_CORE_NR_IRQS;
> +	nr_irqs = TWL4030_PWR_NR_IRQS + TWL_CORE_NR_IRQS;
>   
>   	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
>   	if (IS_ERR_VALUE(irq_base)) {
> @@ -704,7 +704,7 @@ int twl4030_init_irq(struct device *dev, int irq_num)
>   	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
>   			      &irq_domain_simple_ops, NULL);
>   
> -	irq_end = irq_base + TWL4030_CORE_NR_IRQS;
> +	irq_end = irq_base + TWL_CORE_NR_IRQS;
>   
>   	/*
>   	 * Mask and clear all TWL4030 interrupts since initially we do
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 26566db..6193565 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -164,7 +164,7 @@ config TI_PIPE3
>   
>   config TWL4030_USB
>   	tristate "TWL4030 USB Transceiver Driver"
> -	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
> +	depends on TWL_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
>   	depends on USB_SUPPORT
>   	select GENERIC_PHY
>   	select USB_PHY
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 421770d..cc5fe9a 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -323,7 +323,7 @@ config CHARGER_MAX8903
>   
>   config CHARGER_TWL4030
>   	tristate "OMAP TWL4030 BCI charger driver"
> -	depends on IIO && TWL4030_CORE
> +	depends on IIO && TWL_CORE
>   	help
>   	  Say Y here to enable support for TWL4030 Battery Charge Interface.
>   
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c182efc..6318f19 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -413,7 +413,7 @@ config  PWM_TIPWMSS
>   
>   config PWM_TWL
>   	tristate "TWL4030/6030 PWM support"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	help
>   	  Generic PWM framework driver for TWL4030/6030.
>   
> @@ -422,7 +422,7 @@ config PWM_TWL
>   
>   config PWM_TWL_LED
>   	tristate "TWL4030/6030 PWM support for LED drivers"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	help
>   	  Generic PWM framework driver for TWL4030/6030 LED terminals.
>   
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index c77dc08..b62b4b4 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -803,7 +803,7 @@ config REGULATOR_TPS80031
>   
>   config REGULATOR_TWL4030
>   	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0 PMIC"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	help
>   	  This driver supports the voltage regulators provided by
>   	  this family of companion chips.
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 3e84315..198ac54 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -462,7 +462,7 @@ config RTC_DRV_TWL92330
>   
>   config RTC_DRV_TWL4030
>   	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	help
>   	  If you say yes here you get support for the RTC on the
>   	  TWL4030/TWL5030/TWL6030 family chips, used mostly with OMAP3 platforms.
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index c690474..2911b11 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -80,7 +80,7 @@ config SAMSUNG_USBPHY
>   
>   config TWL6030_USB
>   	tristate "TWL6030 USB Transceiver Driver"
> -	depends on TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
> +	depends on TWL_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
>   	help
>   	  Enable this to support the USB OTG transceiver on TWL6030
>   	  family chips. This TWL6030 transceiver has the VBUS and ID GND
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 5ffa4b4..8d6e4e0 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -412,7 +412,7 @@ config BACKLIGHT_OT200
>   
>   config BACKLIGHT_PANDORA
>   	tristate "Backlight driver for Pandora console"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	help
>   	  If you have a Pandora console, say Y to enable the
>   	  backlight driver.
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index fb94765..4b24418 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -462,7 +462,7 @@ config COH901327_WATCHDOG
>   
>   config TWL4030_WATCHDOG
>   	tristate "TWL4030 Watchdog"
> -	depends on TWL4030_CORE
> +	depends on TWL_CORE
>   	select WATCHDOG_CORE
>   	help
>   	  Support for TI TWL4030 watchdog.  Say 'Y' here to enable the
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 4e7ea5f..2decb190 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -214,7 +214,7 @@ int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
>   int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>   
>   /* Card detect Configuration for MMC1 Controller on OMAP4 */
> -#ifdef CONFIG_TWL4030_CORE
> +#ifdef CONFIG_TWL_CORE
>   int twl6030_mmc_card_detect_config(void);
>   #else
>   static inline int twl6030_mmc_card_detect_config(void)
> @@ -225,7 +225,7 @@ static inline int twl6030_mmc_card_detect_config(void)
>   #endif
>   
>   /* MMC1 Controller on OMAP4 uses Phoenix irq for Card detect */
> -#ifdef CONFIG_TWL4030_CORE
> +#ifdef CONFIG_TWL_CORE
>   int twl6030_mmc_card_detect(struct device *dev, int slot);
>   #else
>   static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 649e92a..009feb4 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -134,7 +134,7 @@ config SND_SOC_ALL_CODECS
>   	select SND_SOC_TPA6130A2 if I2C
>   	select SND_SOC_TLV320DAC33 if I2C
>   	select SND_SOC_TS3A227E if I2C
> -	select SND_SOC_TWL4030 if TWL4030_CORE
> +	select SND_SOC_TWL4030 if TWL_CORE
>   	select SND_SOC_TWL6040 if TWL6040_CORE
>   	select SND_SOC_UDA134X
>   	select SND_SOC_UDA1380 if I2C
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index 5185a38..49af002 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -85,7 +85,7 @@ config SND_OMAP_SOC_AM3517EVM
>   
>   config SND_OMAP_SOC_OMAP_TWL4030
>   	tristate "SoC Audio support for TI SoC based boards with twl4030 codec"
> -	depends on TWL4030_CORE && SND_OMAP_SOC
> +	depends on TWL_CORE && SND_OMAP_SOC
>   	select SND_OMAP_SOC_MCBSP
>   	select SND_SOC_TWL4030
>   	help
> @@ -117,7 +117,7 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
>   
>   config SND_OMAP_SOC_OMAP3_PANDORA
>   	tristate "SoC Audio support for OMAP3 Pandora"
> -	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
> +	depends on TWL_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
>   	select SND_OMAP_SOC_MCBSP
>   	select SND_SOC_TWL4030
>   	help
> 


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
