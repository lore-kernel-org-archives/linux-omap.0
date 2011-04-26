From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 13/15] OMAP: GPIO: cleanup _set_gpio_wakeup(), remove ifdefs
Date: Tue, 26 Apr 2011 20:14:05 +0530
Message-ID: <BANLkTi=z3zk2E5Big5Ot-QXP86gBr=D53w@mail.gmail.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com> <1303513327-14532-14-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48497 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752223Ab1DZOou convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 10:44:50 -0400
Received: by mail-iy0-f175.google.com with SMTP id 7so679991iye.20
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 07:44:46 -0700 (PDT)
In-Reply-To: <1303513327-14532-14-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
> Make _set_gpio_wakeup() generic by removing ifdefs. =A0Code for the
> various SoCs/bank-methods was already the same, except for the
> non-wakeup GPIO checking. =A0But that flag is set on a per-SoC basis,=
 so
> can be used for all SoCs.
>
> While here, use pr_err() and remove GPIO bank calculation assumption
> based on subtracting bank pointers.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/plat-omap/gpio.c | =A0 49 +++++++++++++------------------=
-------------
> =A01 files changed, 15 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index a025b7a..82afed8 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -535,42 +535,23 @@ static inline void _set_gpio_irqenable(struct g=
pio_bank *bank, int gpio, int ena
> =A0*/
> =A0static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int =
enable)
> =A0{
> - =A0 =A0 =A0 unsigned long uninitialized_var(flags);
> + =A0 =A0 =A0 u32 gpio_bit =3D GPIO_BIT(bank, gpio);
> + =A0 =A0 =A0 unsigned long flags;
>
> - =A0 =A0 =A0 switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP16XX
> - =A0 =A0 =A0 case METHOD_MPUIO:
> - =A0 =A0 =A0 case METHOD_GPIO_1610:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->suspend_wakeup |=3D=
 (1 << gpio);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->suspend_wakeup &=3D=
 ~(1 << gpio);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, fla=
gs);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> - =A0 =A0 =A0 case METHOD_GPIO_24XX:
> - =A0 =A0 =A0 case METHOD_GPIO_44XX:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bank->non_wakeup_gpios & (1 << gpio=
)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable=
 to modify wakeup on "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "non-wakeup GPIO%d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(bank - =
gpio_bank) * bank->width + gpio);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->suspend_wakeup |=3D=
 (1 << gpio);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->suspend_wakeup &=3D=
 ~(1 << gpio);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, fla=
gs);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -#endif
> - =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Can't enable GPIO wake=
up for method %i\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->method);
> + =A0 =A0 =A0 if (bank->non_wakeup_gpios & gpio_bit) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Unable to modify wakeup on non-=
wakeup GPIO%d\n", gpio);

use dev_err instead.

-V Charulatha

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
