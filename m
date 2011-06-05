From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
Date: Sat, 4 Jun 2011 19:37:54 -0700
Message-ID: <BANLkTingmUNvZO_szivRkmn7LRO4L5A+5Q@mail.gmail.com>
References: <1307214239-16316-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:5836 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab1FECh7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Jun 2011 22:37:59 -0400
Received: from kpbe19.cbf.corp.google.com (kpbe19.cbf.corp.google.com [172.25.105.83])
	by smtp-out.google.com with ESMTP id p552buSG030505
	for <linux-omap@vger.kernel.org>; Sat, 4 Jun 2011 19:37:56 -0700
Received: from yib18 (yib18.prod.google.com [10.243.65.82])
	by kpbe19.cbf.corp.google.com with ESMTP id p552bsIJ008809
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Sat, 4 Jun 2011 19:37:54 -0700
Received: by yib18 with SMTP id 18so324250yib.31
        for <linux-omap@vger.kernel.org>; Sat, 04 Jun 2011 19:37:54 -0700 (PDT)
In-Reply-To: <1307214239-16316-1-git-send-email-ccross@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Colin Cross <ccross@android.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>

On Sat, Jun 4, 2011 at 12:03 PM, Colin Cross <ccross@android.com> wrote=
:
> Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
> causing only the last bit set to take effect, resulting in lost
> wakeups when the GPIO controller is in idle.
>
> Replace direct writes to IRQWAKEN with writes to SETWKUENA and
> CLEARWKUEN.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
> =A0arch/arm/plat-omap/gpio.c | =A0 14 +++++---------
> =A01 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index c985652..23ac7b6 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -539,7 +539,6 @@ static inline void set_24xx_gpio_triggering(struc=
t gpio_bank *bank, int gpio,
> =A0{
> =A0 =A0 =A0 =A0void __iomem *base =3D bank->base;
> =A0 =A0 =A0 =A0u32 gpio_bit =3D 1 << gpio;
> - =A0 =A0 =A0 u32 val;
>
> =A0 =A0 =A0 =A0if (cpu_is_omap44xx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT0, g=
pio_bit,
> @@ -563,14 +562,11 @@ static inline void set_24xx_gpio_triggering(str=
uct gpio_bank *bank, int gpio,
> =A0 =A0 =A0 =A0if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap44xx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (trigger !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_w=
ritel(1 << gpio, bank->base+
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_GPIO_IRQWAKEN0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D=
 __raw_readl(bank->base +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_GPIO_IRQWAKEN0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_w=
ritel(val & (~(1 << gpio)), bank->base +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_GPIO_IRQWAKEN0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_w=
ritel(gpio_bit,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 bank->base + OMAP4_GPIO_SETWKUENA);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_w=
ritel(gpio_bit,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 bank->base + OMAP4_GPIO_CLEARWKUENA);

Todd pointed out that the OMAP4 TRM says not to use SETWKUENA and
CLEARWKUENA.  I'll send another patch that applies to v3.0-rc1 that
uses MOD_REG_BIT on IRQWAKEN_0, and another patch that adds the
necessary locking around the read-modify-writes in
_set_gpio_triggering.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * GPIO wakeup request=
 can only be generated on edge
> --
> 1.7.4.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
