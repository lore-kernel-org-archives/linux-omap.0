From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v3 13/13] gpio/omap: fix incorrect update to context.irqenable1
Date: Tue, 13 Mar 2012 11:01:57 +0530
Message-ID: <CAC83Zv+_kOTe1rThNC2_KEqc+cMdt6YzEbCqyr9pnT8Z41u9Vw@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-14-git-send-email-tarun.kanti@ti.com>
	<87haxtwjwt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35572 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754697Ab2CMFb6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 01:31:58 -0400
Received: by mail-yw0-f41.google.com with SMTP id 47so189207yhr.0
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 22:31:57 -0700 (PDT)
In-Reply-To: <87haxtwjwt.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Tue, Mar 13, 2012 at 3:39 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
>> gpio_mask can be directly set by writing to set_irqenable register
>> without overwriting current value.
>
> Ouch. =A0Nice catch.
>
>> In order to ensure the same is
>> stored in context.irqenable1, we must read from regs->irqenable
>> instead of overwriting it with gpio_mask.
>> The overwriting makes sense only in the second case where irqenable
>> is explicitly read and updated with new gpio_mask before writing it
>> back. However, for consistency reading regs->irqenable into the
>> bank->context.irqenable1 takes care of both the scenarios.
>
> ...takes care of both scenarios, but adds and extra duplicate read fo=
r
> the second.
Right. I wanted to keep code change minimum.
>
> Instead, how about just move the context update into each side of the
> if/else? =A0untested patch below to show what I mean.
Yes, initially I thought of doing in this way as well. I will make the =
change.
--
Tarun
>
> Kevin
>
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 752ae9b..f8b7099 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -442,6 +442,7 @@ static void _enable_gpio_irqbank(struct gpio_bank=
 *bank, int gpio_mask)
> =A0 =A0 =A0 =A0if (bank->regs->set_irqenable) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg +=3D bank->regs->set_irqenable;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D gpio_mask;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context.irqenable1 |=3D gpio_mask=
;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg +=3D bank->regs->irqenable;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D __raw_readl(reg);
> @@ -449,10 +450,10 @@ static void _enable_gpio_irqbank(struct gpio_ba=
nk *bank, int gpio_mask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l &=3D ~gpio_mask;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D gpio_mask;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context.irqenable1 =3D l;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0__raw_writel(l, reg);
> - =A0 =A0 =A0 bank->context.irqenable1 =3D l;
> =A0}
>
> =A0static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio=
_mask)
> @@ -463,6 +464,7 @@ static void _disable_gpio_irqbank(struct gpio_ban=
k *bank, int gpio_mask)
> =A0 =A0 =A0 =A0if (bank->regs->clr_irqenable) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg +=3D bank->regs->clr_irqenable;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D gpio_mask;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context.irqenable1 &=3D ~gpio_mas=
k;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg +=3D bank->regs->irqenable;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l =3D __raw_readl(reg);
> @@ -470,10 +472,10 @@ static void _disable_gpio_irqbank(struct gpio_b=
ank *bank, int gpio_mask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D gpio_mask;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l &=3D ~gpio_mask;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context.irqenable1 =3D l;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0__raw_writel(l, reg);
> - =A0 =A0 =A0 bank->context.irqenable1 =3D l;
> =A0}
>
> =A0static inline void _set_gpio_irqenable(struct gpio_bank *bank, int=
 gpio, int enable)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
