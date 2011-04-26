From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 10/15] OMAP: GPIO: conslidate enable/disable of GPIO IRQs,
 remove ifdefs
Date: Tue, 26 Apr 2011 18:03:32 +0530
Message-ID: <BANLkTi=ivNqfTTscWJYk2gCEznMus_Qd-Q@mail.gmail.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com> <1303513327-14532-11-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49587 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129Ab1DZMeO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 08:34:14 -0400
Received: by mail-iw0-f180.google.com with SMTP id 6so727345iwn.39
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 05:34:12 -0700 (PDT)
In-Reply-To: <1303513327-14532-11-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin,

On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
> Cleanup GPIO IRQ enable/disable handling by removing SoC-specific
>
> Also split enable/disable IRQ into separate functions for better
> readability and also facilitate potentially moving to generic irq_chi=
p
> in the future.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---

<<snip>>

> =A0static struct __initdata omap_gpio_platform_data omap16xx_gpio1_co=
nfig =3D {
> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio=
7xx.c
> index 35e8b31..880f3cb 100644
> --- a/arch/arm/mach-omap1/gpio7xx.c
> +++ b/arch/arm/mach-omap1/gpio7xx.c
> @@ -44,6 +44,8 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs=
 =3D {
> =A0 =A0 =A0 =A0.datain =A0 =A0 =A0 =A0 =3D OMAP_MPUIO_INPUT_LATCH / 2=
,
> =A0 =A0 =A0 =A0.dataout =A0 =A0 =A0 =A0=3D OMAP_MPUIO_OUTPUT / 2,
> =A0 =A0 =A0 =A0.irqstatus =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_INT / 2,
> + =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_MASKIT / 2,
> + =A0 =A0 =A0 .irqenable_inv =A0=3D true,
> =A0};
>
> =A0static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_=
config =3D {
> @@ -82,6 +84,8 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs =
=3D {
> =A0 =A0 =A0 =A0.datain =A0 =A0 =A0 =A0 =3D OMAP7XX_GPIO_DATA_INPUT,
> =A0 =A0 =A0 =A0.dataout =A0 =A0 =A0 =A0=3D OMAP7XX_GPIO_DATA_OUTPUT,
> =A0 =A0 =A0 =A0.irqstatus =A0 =A0 =A0=3D OMAP7XX_GPIO_INT_STATUS,
> + =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP7XX_GPIO_INT_MASK,
> + =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D true,

irqenable_inv should be true and not irqenable.

> =A0};
>
> =A0static struct __initdata omap_gpio_platform_data omap7xx_gpio1_con=
fig =3D {

<<snip>>

> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 4f875cf..17833c8 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c

<<snip>>

> -static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_ma=
sk, int enable)
> +static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_ma=
sk)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *reg =3D bank->base;
> =A0 =A0 =A0 =A0u32 l;
>
> - =A0 =A0 =A0 switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP1
> - =A0 =A0 =A0 case METHOD_MPUIO:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP_MPUIO_GPIO_MASKIT / bank-=
>stride;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D __raw_readl(reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(gpio_mask);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D gpio_mask;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP15XX
> - =A0 =A0 =A0 case METHOD_GPIO_1510:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP1510_GPIO_INT_MASK;
> + =A0 =A0 =A0 if (bank->regs->set_irqenable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->set_irqenable;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D gpio_mask;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->irqenable;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D __raw_readl(reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(gpio_mask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bank->regs->irqenable_inv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~gpio_mask;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D gpio_mask;

This else case code is required for _disable_gpio_irqbank() only.
There should be no else part here.

> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP16XX
> - =A0 =A0 =A0 case METHOD_GPIO_1610:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP1610_GPIO_=
SET_IRQENABLE1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP1610_GPIO_=
CLEAR_IRQENABLE1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 __raw_writel(l, reg);
> +}
> +
> +static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_m=
ask)
> +{
> + =A0 =A0 =A0 void __iomem *reg =3D bank->base;
> + =A0 =A0 =A0 u32 l;
> +
> + =A0 =A0 =A0 if (bank->regs->clr_irqenable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->clr_irqenable;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D gpio_mask;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> - =A0 =A0 =A0 case METHOD_GPIO_7XX:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP7XX_GPIO_INT_MASK;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->irqenable;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D __raw_readl(reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(gpio_mask);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bank->regs->irqenable_inv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D gpio_mask;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> - =A0 =A0 =A0 case METHOD_GPIO_24XX:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP24XX_GPIO_=
SETIRQENABLE1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP24XX_GPIO_=
CLEARIRQENABLE1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D gpio_mask;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> - =A0 =A0 =A0 case METHOD_GPIO_44XX:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP4_GPIO_IRQ=
STATUSSET0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP4_GPIO_IRQ=
STATUSCLR0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D gpio_mask;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -#endif
> - =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~gpio_mask;

This else case code is required for _enable_gpio_irqbank() only.
There should be no else part here.

> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0__raw_writel(l, reg);
> =A0}
>

-V Charulatha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
