From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v9 11/25] gpio/omap: cleanup omap_gpio_mod_init function
Date: Tue, 24 Apr 2012 00:24:26 +0530
Message-ID: <CAC83ZvK630=6B-k2TfV3XBg8w7ZosLVDNE4ezjDYnn=hcXA48Q@mail.gmail.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
	<1328203851-20435-12-git-send-email-tarun.kanti@ti.com>
	<13629551.hP3ZV1ajDo@vclass>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:34933 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753174Ab2DWSyb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 14:54:31 -0400
Received: by qaea16 with SMTP id a16so1891029qae.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 11:54:26 -0700 (PDT)
In-Reply-To: <13629551.hP3ZV1ajDo@vclass>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, grant.likely@secretlab.ca, khilman@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Sat, Apr 21, 2012 at 7:33 PM, Janusz Krzysztofik
<jkrzyszt@tis.icnet.pl> wrote:
> On Thursday 02 of February 2012 23:00:37 Tarun Kanti DebBarma wrote:
>> With register offsets now defined for respective OMAP versions we ca=
n get rid
>> of cpu_class_* checks. This function now has common initialization c=
ode for
>> all OMAP versions...
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>
> Sorry for being so late with my comment for chanes already present in
> mainline, but this patch breaks GPIO on Amstrad Delta at least, and I
> have neither enough spare time nor enough experience with non OMAP1
> machines to provide a solution myself.
Yes, I looked at the omap_gpio_mod_init() and OMAP1 configurations are
overwritten.
Also looks like there is issue in making distinction between omap15xx
and omap16xx.
I will post a patch and you can help me testing it in OMAP1 platform.
Thanks for pointing this out.
--
Tarun
>
>> ---
>> =A0arch/arm/mach-omap1/gpio16xx.c | =A0 35 +++++++++++++++++-
>> =A0drivers/gpio/gpio-omap.c =A0 =A0 =A0 | =A0 77 ++++++++++++-------=
---------------------
>> =A02 files changed, 57 insertions(+), 55 deletions(-)
> ...
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index f39d9e4..a948351 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
> ...
>> @@ -898,62 +896,30 @@ static void __init omap_gpio_show_rev(struct g=
pio_bank *bank)
>> =A0 */
>> =A0static struct lock_class_key gpio_lock_class;
>>
>> -/* TODO: Cleanup cpu_is_* checks */
>> =A0static void omap_gpio_mod_init(struct gpio_bank *bank)
>> =A0{
>> - =A0 =A0 if (cpu_class_is_omap2()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, b=
ank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP4_GPIO_IRQSTATUSCLR0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x00000000, b=
ank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0OMAP4_GPIO_DEBOUNCENABLE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize interface cl=
k ungated, module enabled */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, bank->base=
 + OMAP4_GPIO_CTRL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else if (cpu_is_omap34xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x00000000, b=
ank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_IRQENABLE1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, b=
ank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_IRQSTATUS1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x00000000, b=
ank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_DEBOUNCE_EN);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize interface cl=
k ungated, module enabled */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, bank->base=
 + OMAP24XX_GPIO_CTRL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 } else if (cpu_class_is_omap1()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (bank_is_mpuio(bank)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writew(0xffff, bank-=
>base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MPUIO=
_GPIO_MASKIT / bank->stride);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpuio_init(bank);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap15xx() && bank->method =3D=3D=
 METHOD_GPIO_1510) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writew(0xffff, bank-=
>base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP1510_GPIO_INT_MASK);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writew(0x0000, bank-=
>base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP1510_GPIO_INT_STATUS);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap16xx() && bank->method =3D=3D=
 METHOD_GPIO_1610) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writew(0x0000, bank-=
>base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP1610_GPIO_IRQENABLE1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writew(0xffff, bank-=
>base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP1610_GPIO_IRQSTATUS1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writew(0x0014, bank-=
>base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP1610_GPIO_SYSCONFIG);
>> + =A0 =A0 void __iomem *base =3D bank->base;
>> + =A0 =A0 u32 l =3D 0xffffffff;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable system clock f=
or GPIO module.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The CAM_CLK_CTRL *is*=
 really the right place.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(omap_readl(ULP=
D_CAM_CLK_CTRL) | 0x04,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ULPD_CAM_CLK_CTRL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap7xx() && bank->method =3D=3D=
 METHOD_GPIO_7XX) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, b=
ank->base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP7XX_GPIO_INT_MASK);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0x00000000, b=
ank->base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP7XX_GPIO_INT_STATUS);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 if (bank->width =3D=3D 16)
>> + =A0 =A0 =A0 =A0 =A0 =A0 l =3D 0xffff;
>> +
>> + =A0 =A0 if (bank_is_mpuio(bank)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(l, bank->base + bank->regs->i=
rqenable);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>> +
>> + =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->irqe=
nable_inv);
>> + =A0 =A0 _gpio_rmw(base, bank->regs->irqstatus, l,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->regs->irqenable_inv =3D=3D false);
>> + =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->debo=
unce_en !=3D 0);
>> + =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->ctrl=
 !=3D 0);
>
> bank->regs->irqenable trgister is manipulated 3 times in a row, each
> time based on different criteria. This breaks GPIO on Amstrad Delta a=
t
> least, and generally looks wrong. I was only able to verify that
> commenting out the above two lines fixes the issue with Amstrad Delta=
 for
> me.
>
>> + =A0 =A0 if (bank->regs->debounce_en)
>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->debounce_en, 0=
, 1);
>
> This also looks suspicious, I guess the second line should rather be:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_gpio_rmw(base, bank->regs->debounce, =
0, 1);
>
>> +
>> + =A0 =A0 =A0/* Initialize interface clk ungated, module enabled */
>> + =A0 =A0 if (bank->regs->ctrl)
>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->ctrl, 0, 1);
>
> Is bank->regs->ctrl a flag, or a register offset? If the latter, is t=
hat
> offset guaranteed to never take a valid value of 0?
>
> Thanks,
> Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
