From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC PATCH 09/10] OMAP: GPIO: cleanup omap_gpio_free and
 triggering functions
Date: Wed, 18 May 2011 16:33:23 +0530
Message-ID: <BANLkTinMqfxzQN-6M_iCJZViBxuUOm4TBg@mail.gmail.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com> <1305546104-1511-10-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:38326 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932680Ab1ERLEE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 07:04:04 -0400
Received: by mail-iy0-f169.google.com with SMTP id 42so1277999iyh.28
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 04:04:03 -0700 (PDT)
In-Reply-To: <1305546104-1511-10-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

Tarun,

On Mon, May 16, 2011 at 17:11, Tarun Kanti DebBarma <tarun.kanti@ti.com=
> wrote:
> We can get rid of ifdef / if checks of OMAP revision in set_24xx_gpio=
_triggering()
> and omap_gpio_free().
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Charulatha V <charu@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> =A0arch/arm/plat-omap/gpio.c | =A0 38 ++++++++-----------------------=
-------
> =A01 files changed, 8 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 714626a..bc07559 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -269,15 +269,9 @@ static inline void set_24xx_gpio_triggering(stru=
ct gpio_bank *bank, int gpio,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->enabled_non_wake=
up_gpios &=3D ~gpio_bit;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (cpu_is_omap44xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->level_mask =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base =
+ OMAP4_GPIO_LEVELDETECT0) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base =
+ OMAP4_GPIO_LEVELDETECT1);
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->level_mask =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base =
+ OMAP24XX_GPIO_LEVELDETECT0) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base =
+ OMAP24XX_GPIO_LEVELDETECT1);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 bank->level_mask =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base + bank->regs->le=
veldetect0) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base + bank->regs->le=
veldetect1);
> =A0}
> =A0#endif
>
> @@ -609,29 +603,13 @@ static void omap_gpio_free(struct gpio_chip *ch=
ip, unsigned offset)
> =A0{
> =A0 =A0 =A0 =A0struct gpio_bank *bank =3D container_of(chip, struct g=
pio_bank, chip);
> =A0 =A0 =A0 =A0unsigned long flags;
> + =A0 =A0 =A0 void __iomem *reg;
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
> -#ifdef CONFIG_ARCH_OMAP16XX
> - =A0 =A0 =A0 if (bank->method =3D=3D METHOD_GPIO_1610) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable wake-up during idle for dyna=
mic tick */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + OMAP=
1610_GPIO_CLEAR_WAKEUPENA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << offset, reg);
> - =A0 =A0 =A0 }
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> - =A0 =A0 =A0 if (bank->method =3D=3D METHOD_GPIO_24XX) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable wake-up during idle for dyna=
mic tick */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + OMAP=
24XX_GPIO_CLEARWKUENA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << offset, reg);
> - =A0 =A0 =A0 }
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> - =A0 =A0 =A0 if (bank->method =3D=3D METHOD_GPIO_44XX) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable wake-up during idle for dyna=
mic tick */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + OMAP=
4_GPIO_IRQWAKEN0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << offset, reg);
> - =A0 =A0 =A0 }
> -#endif
> + =A0 =A0 =A0 /* Disable wake-up during idle for dynamic tick */
> + =A0 =A0 =A0 reg =3D bank->base + bank->regs->wkupclear;

Consider using bank->wake_clear instead of extracting reg here.

> +
> + =A0 =A0 =A0 __raw_writel(1 << offset, reg);

This is wrong on OMAP15xx & OMAP7xx as wkupclear is NULL.

-V Charulatha

> =A0 =A0 =A0 =A0bank->mod_usage &=3D ~(1 << offset);
>
> =A0 =A0 =A0 =A0if ((bank->regs->ctrl !=3D USHRT_MAX) && (!bank->mod_u=
sage)) {
> --
> 1.6.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
