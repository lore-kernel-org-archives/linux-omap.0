From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 15/15] OMAP: GPIO: clean omap_gpio_mod_init function
Date: Fri, 3 Jun 2011 16:50:02 +0530
Message-ID: <BANLkTi=e1PowoD7er46g1q+8EOqLfJNGTQ@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-16-git-send-email-tarun.kanti@ti.com> <87r57mjq9d.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41437 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751515Ab1FCLUn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Jun 2011 07:20:43 -0400
Received: by mail-pw0-f52.google.com with SMTP id 4so1381671pwi.39
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 04:20:42 -0700 (PDT)
In-Reply-To: <87r57mjq9d.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Kevin,

On Thu, May 26, 2011 at 05:18, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> With register offsets now defined for respective OMAP versions
>> we can get rid of cpu_class_* checks. In addition, organized
>> common initialization for the different OMAP silicon versions.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>
> The sysconfig stuff in this patch should be removed. =A0In fact, now =
that
> hwmod is used to manage all the GPIO IP blocks, the driver should not=
 be
> touching sysconfig at all.

The sysconfig stuff in this patch is for OMAP16XX.

>
> The hwmod defaults should be enough, and for enabling wake-ups, the
> device-specific code should be calling omap_hwmod_enable_wakeup() (wh=
ich
> will also enable smart-idle if the IP supports it.)
>
>
>> ---
>> =A0arch/arm/mach-omap1/gpio16xx.c =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 =A01 +
>> =A0drivers/gpio/gpio_omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 74 +++=
++++++++++-------------------
>> =A03 files changed, 32 insertions(+), 44 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gp=
io16xx.c
>> index 24f6cfa..e9f8abd 100644
>> --- a/arch/arm/mach-omap1/gpio16xx.c
>> +++ b/arch/arm/mach-omap1/gpio16xx.c
>> @@ -227,6 +227,7 @@ static int __init omap16xx_gpio_init(void)
>> =A0 =A0 =A0 omap16xx_gpio_regs.wkupset =3D OMAP1610_GPIO_SET_WAKEUPE=
NA;
>> =A0 =A0 =A0 omap16xx_gpio_regs.edgectrl1 =3D OMAP1610_GPIO_EDGE_CTRL=
1;
>> =A0 =A0 =A0 omap16xx_gpio_regs.edgectrl2 =3D OMAP1610_GPIO_EDGE_CTRL=
2;
>> + =A0 =A0 omap16xx_gpio_regs.sysconfig =3D OMAP1610_GPIO_SYSCONFIG;
>>
>> =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_device_register(omap16xx_gpio_d=
ev[i]);
>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-=
omap/include/plat/gpio.h
>> index f82881c..ac45191 100644
>> --- a/arch/arm/plat-omap/include/plat/gpio.h
>> +++ b/arch/arm/plat-omap/include/plat/gpio.h
>> @@ -176,6 +176,7 @@ struct omap_gpio_dev_attr {
>>
>> =A0struct omap_gpio_reg_offs {
>> =A0 =A0 =A0 u16 revision;
>> + =A0 =A0 u16 sysconfig;
>> =A0 =A0 =A0 u16 direction;
>> =A0 =A0 =A0 u16 datain;
>> =A0 =A0 =A0 u16 dataout;
>> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
>> index ebeb16e..3649c74 100644
>> --- a/drivers/gpio/gpio_omap.c
>> +++ b/drivers/gpio/gpio_omap.c
>> @@ -885,65 +885,51 @@ static void __init omap_gpio_show_rev(struct g=
pio_bank *bank)
>> =A0 =A0 =A0 called =3D true;
>> =A0}
>>
>> -/* This lock class tells lockdep that GPIO irqs are in a different
>> +/*
>> + * This lock class tells lockdep that GPIO irqs are in a different
>> =A0 * category than their parents, so it won't report false recursio=
n.
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
>> + =A0 =A0 if (bank->width =3D=3D 32) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 l =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bank->regs->irqenable_inv)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D ~l;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(l, bank->base + bank->regs->i=
rqstatus);
>
> The ->irqenable_inv flag doesn't affect ->irqstatus.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(l, bank->base + bank->regs->i=
rqenable);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bank->regs->debounce_en !=3D USHRT_MAX=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(l, bank->base=
 + bank->regs->debounce_en);
>
> If ->irqenable_inv =3D true, debounce was just enabled for all GPIOs =
in
> the bank.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bank->regs->ctrl !=3D USHRT_MAX)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize interface =
clk ungated, module enabled */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, bank->base=
 + OMAP24XX_GPIO_CTRL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 } else if (cpu_class_is_omap1()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (bank_is_mpuio(bank)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writew(0xffff, bank-=
>base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MPUIO=
_GPIO_MASKIT / bank->stride);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_writel(l, bank->b=
ase + bank->regs->ctrl);
>
> If ->irqenable_env =3D true, all the clocks were just gated.

Okay. Will do the needful.

>
> Similar problems below.
>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
