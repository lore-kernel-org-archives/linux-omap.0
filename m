From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 02/15] OMAP: GPIO: remove MPUIO handling from _clear_gpio_irqbank()
Date: Mon, 25 Apr 2011 19:18:49 +0530
Message-ID: <BANLkTinmf5EWwbWrYJHz=Z19v1EkG-MPvg@mail.gmail.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com> <1303513327-14532-3-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47275 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752139Ab1DYNta convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Apr 2011 09:49:30 -0400
Received: by iwn36 with SMTP id 36so2322804iwn.36
        for <linux-omap@vger.kernel.org>; Mon, 25 Apr 2011 06:49:29 -0700 (PDT)
In-Reply-To: <1303513327-14532-3-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin,

On Sat, Apr 23, 2011 at 04:31, Kevin Hilman <khilman@ti.com> wrote:
> Remove the OMAP1 #ifdef and MPUIO special case for _clear_gpio_irqban=
k()
>
> The MPUIOs do not need a register access to ack/clear the IRQ status,
> since reading the IRQ status clears it. =A0In addition, the MPUIO
> irq_chip has an empty ack method, so _clear_gpio_irqbank() is never
> used for MPUIOs.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/plat-omap/gpio.c | =A0 =A06 ------
> =A01 files changed, 0 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index fe6971a..8b5ca6e 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -770,12 +770,6 @@ static void _clear_gpio_irqbank(struct gpio_bank=
 *bank, int gpio_mask)
> =A0 =A0 =A0 =A0void __iomem *reg =3D bank->base;
>
> =A0 =A0 =A0 =A0switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP1
> - =A0 =A0 =A0 case METHOD_MPUIO:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MPUIO irqstatus is reset by reading =
the status register,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* so do nothing here */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -#endif

The default case has a "WARN_ON(1)". I guess WARN_ON()
is not required for METHOD_MPUIO.

-V Charulatha

> =A0#ifdef CONFIG_ARCH_OMAP15XX
> =A0 =A0 =A0 =A0case METHOD_GPIO_1510:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg +=3D OMAP1510_GPIO_INT_STATUS;
> --
> 1.7.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
