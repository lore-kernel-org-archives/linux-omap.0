From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 13/15] OMAP: GPIO: clean set_gpio_triggering function
Date: Thu, 26 May 2011 15:25:15 +0530
Message-ID: <BANLkTincMHY4dZ4eWspmxm4LqTgv2ZZZ-w@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-14-git-send-email-tarun.kanti@ti.com> <87fwo2l5s1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:47012 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752041Ab1EZJz4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 05:55:56 -0400
Received: by pxi6 with SMTP id 6so306600pxi.31
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 02:55:55 -0700 (PDT)
In-Reply-To: <87fwo2l5s1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Kevin,

On Thu, May 26, 2011 at 04:57, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> Getting rid of ifdefs within the function by adding register offset =
intctrl
>> and associating OMAPXXXX_GPIO_INT_CONTROL in respective SoC specific=
 files.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> =A0arch/arm/mach-omap1/gpio15xx.c =A0 =A0 =A0 =A0 | =A0 14 ++++
>> =A0arch/arm/mach-omap1/gpio16xx.c =A0 =A0 =A0 =A0 | =A0 14 ++++
>> =A0arch/arm/mach-omap1/gpio7xx.c =A0 =A0 =A0 =A0 =A0| =A0 14 ++++
>> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +
>> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 =A03 +
>> =A0drivers/gpio/gpio_omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0125 +++=
++++-------------------------
>> =A06 files changed, 77 insertions(+), 97 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gp=
io15xx.c
>> index b0bd21e..ceee046 100644
>> --- a/arch/arm/mach-omap1/gpio15xx.c
>> +++ b/arch/arm/mach-omap1/gpio15xx.c
>> @@ -46,6 +46,13 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_r=
egs =3D {
>> =A0 =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .irqctrl =A0 =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_INT_EDGE,
>> + =A0 =A0 .edgectrl1 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .edgectrl2 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .leveldetect0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .leveldetect1 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .risingdetect =A0 =3D USHRT_MAX,
>> + =A0 =A0 .fallingdetect =A0=3D USHRT_MAX,
>> =A0};
>
> As before, drop the USHRT_MAX and just use non-zer value to determine=
 if
> register exists.
>
>> =A0static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpi=
o_config =3D {
>> @@ -91,6 +98,13 @@ static struct omap_gpio_reg_offs omap15xx_gpio_re=
gs =3D {
>> =A0 =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .irqctrl =A0 =A0 =A0 =A0=3D OMAP1510_GPIO_INT_CONTROL,
>> + =A0 =A0 .edgectrl1 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .edgectrl2 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .leveldetect0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .leveldetect1 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .risingdetect =A0 =3D USHRT_MAX,
>> + =A0 =A0 .fallingdetect =A0=3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap15xx_gpio_co=
nfig =3D {
>> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gp=
io16xx.c
>> index 403437b..b2479c5 100644
>> --- a/arch/arm/mach-omap1/gpio16xx.c
>> +++ b/arch/arm/mach-omap1/gpio16xx.c
>> @@ -49,6 +49,13 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_r=
egs =3D {
>> =A0 =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .irqctrl =A0 =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_INT_EDGE,
>> + =A0 =A0 .edgectrl1 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .edgectrl2 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .leveldetect0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .leveldetect1 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .risingdetect =A0 =3D USHRT_MAX,
>> + =A0 =A0 .fallingdetect =A0=3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpi=
o_config =3D {
>> @@ -97,6 +104,13 @@ static struct omap_gpio_reg_offs omap16xx_gpio_r=
egs =3D {
>> =A0 =A0 =A0 .wkupstatus =A0 =A0 =3D OMAP1610_GPIO_WAKEUPENABLE,
>> =A0 =A0 =A0 .wkupclear =A0 =A0 =A0=3D OMAP1610_GPIO_CLEAR_WAKEUPENA,
>> =A0 =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D OMAP1610_GPIO_SET_WAKEUPENA,
>> + =A0 =A0 .irqctrl =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .edgectrl1 =A0 =A0 =A0=3D OMAP1610_GPIO_EDGE_CTRL1,
>> + =A0 =A0 .edgectrl2 =A0 =A0 =A0=3D OMAP1610_GPIO_EDGE_CTRL2,
>> + =A0 =A0 .leveldetect0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .leveldetect1 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .risingdetect =A0 =3D USHRT_MAX,
>> + =A0 =A0 .fallingdetect =A0=3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap16xx_gpio1_c=
onfig =3D {
>> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpi=
o7xx.c
>> index d5a4aaf..ceac936 100644
>> --- a/arch/arm/mach-omap1/gpio7xx.c
>> +++ b/arch/arm/mach-omap1/gpio7xx.c
>> @@ -51,6 +51,13 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_re=
gs =3D {
>> =A0 =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .irqctrl =A0 =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_INT_EDGE / 2,
>> + =A0 =A0 .edgectrl1 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .edgectrl2 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .leveldetect0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .leveldetect1 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .risingdetect =A0 =3D USHRT_MAX,
>> + =A0 =A0 .fallingdetect =A0=3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio=
_config =3D {
>> @@ -96,6 +103,13 @@ static struct omap_gpio_reg_offs omap7xx_gpio_re=
gs =3D {
>> =A0 =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> =A0 =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .irqctrl =A0 =A0 =A0 =A0=3D OMAP7XX_GPIO_INT_CONTROL,
>> + =A0 =A0 .edgectrl1 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .edgectrl2 =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .leveldetect0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .leveldetect1 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .risingdetect =A0 =3D USHRT_MAX,
>> + =A0 =A0 .fallingdetect =A0=3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap7xx_gpio1_co=
nfig =3D {
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index fbedbbb..eda1846 100644
>> --- a/arch/arm/mach-omap2/gpio.c
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -92,6 +92,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod =
*oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 pdata->regs->irqctrl =3D USHRT_MAX;
>> + =A0 =A0 pdata->regs->edgectrl1 =3D USHRT_MAX;
>> + =A0 =A0 pdata->regs->edgectrl2 =3D USHRT_MAX;
>> +
>> =A0 =A0 =A0 switch (oh->class->rev) {
>> =A0 =A0 =A0 case 0:
>> =A0 =A0 =A0 case 1:
>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-=
omap/include/plat/gpio.h
>> index a341790..f82881c 100644
>> --- a/arch/arm/plat-omap/include/plat/gpio.h
>> +++ b/arch/arm/plat-omap/include/plat/gpio.h
>> @@ -197,6 +197,9 @@ struct omap_gpio_reg_offs {
>> =A0 =A0 =A0 u16 wkupstatus;
>> =A0 =A0 =A0 u16 wkupclear;
>> =A0 =A0 =A0 u16 wkupset;
>> + =A0 =A0 u16 irqctrl;
>> + =A0 =A0 u16 edgectrl1;
>> + =A0 =A0 u16 edgectrl2;
>>
>> =A0 =A0 =A0 bool irqenable_inv;
>> =A0};
>> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
>> index 762d73c..ebeb16e 100644
>> --- a/drivers/gpio/gpio_omap.c
>> +++ b/drivers/gpio/gpio_omap.c
>> @@ -202,33 +202,20 @@ static void _set_gpio_debounce(struct gpio_ban=
k *bank, unsigned gpio,
>> =A0 =A0 =A0 __raw_writel(val, reg);
>> =A0}
>>
>> -#ifdef CONFIG_ARCH_OMAP2PLUS
>> -static inline void set_24xx_gpio_triggering(struct gpio_bank *bank,=
 int gpio,
>> +static inline void set_gpio_trigger(struct gpio_bank *bank, int gpi=
o,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 int trigger)
>> =A0{
>> =A0 =A0 =A0 void __iomem *base =3D bank->base;
>> =A0 =A0 =A0 u32 gpio_bit =3D 1 << gpio;
>> - =A0 =A0 u32 val;
>>
>> - =A0 =A0 if (cpu_is_omap44xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT0, gpio_=
bit,
>> + =A0 =A0 MOD_REG_BIT(bank->regs->leveldetect0, gpio_bit,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger & IRQ_TYPE_LEVEL=
_LOW);
>> - =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT1, gpio_=
bit,
>> + =A0 =A0 MOD_REG_BIT(bank->regs->leveldetect1, gpio_bit,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger & IRQ_TYPE_LEVEL=
_HIGH);
>> - =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(OMAP4_GPIO_RISINGDETECT, gpio_=
bit,
>> + =A0 =A0 MOD_REG_BIT(bank->regs->risingdetect, gpio_bit,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger & IRQ_TYPE_EDGE_=
RISING);
>> - =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(OMAP4_GPIO_FALLINGDETECT, gpio=
_bit,
>> + =A0 =A0 MOD_REG_BIT(bank->regs->fallingdetect, gpio_bit,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger & IRQ_TYPE_EDGE_=
=46ALLING);
>> - =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT0, gp=
io_bit,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger & IRQ_TYPE_LEVEL_L=
OW);
>> - =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gp=
io_bit,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger & IRQ_TYPE_LEVEL_H=
IGH);
>> - =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gp=
io_bit,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger & IRQ_TYPE_EDGE_RI=
SING);
>> - =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, g=
pio_bit,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger & IRQ_TYPE_EDGE_FA=
LLING);
>> - =A0 =A0 }
>>
>> =A0 =A0 =A0 if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> @@ -259,36 +246,16 @@ static inline void set_24xx_gpio_triggering(st=
ruct gpio_bank *bank, int gpio,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base + bank->regs->lev=
eldetect0) |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base + bank->regs->lev=
eldetect1);
>> =A0}
>> -#endif
>>
>> -#ifdef CONFIG_ARCH_OMAP1
>> =A0/*
>> =A0 * This only applies to chips that can't do both rising and falli=
ng edge
>> =A0 * detection at once. =A0For all other chips, this function is a =
noop.
>> =A0 */
>> =A0static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, =
int gpio)
>> =A0{
>> - =A0 =A0 void __iomem *reg =3D bank->base;
>> + =A0 =A0 void __iomem *reg =3D bank->base + bank->regs->irqctrl;
>> =A0 =A0 =A0 u32 l =3D 0;
>
> Need to check for valid regs->irqctrl here.

Okay. I will move the check to this place.

>
>> - =A0 =A0 switch (bank->method) {
>> - =A0 =A0 case METHOD_MPUIO:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP_MPUIO_GPIO_INT_EDGE / bank->=
stride;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#ifdef CONFIG_ARCH_OMAP15XX
>> - =A0 =A0 case METHOD_GPIO_1510:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP1510_GPIO_INT_CONTROL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
>> - =A0 =A0 case METHOD_GPIO_7XX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP7XX_GPIO_INT_CONTROL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> - =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 }
>> -
>> =A0 =A0 =A0 l =3D __raw_readl(reg);
>> =A0 =A0 =A0 if ((l >> gpio) & 1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(1 << gpio);
>> @@ -297,31 +264,18 @@ static void _toggle_gpio_edge_triggering(struc=
t gpio_bank *bank, int gpio)
>>
>> =A0 =A0 =A0 __raw_writel(l, reg);
>> =A0}
>> -#endif
>>
>> =A0static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,=
 int trigger)
>> =A0{
>> =A0 =A0 =A0 void __iomem *reg =3D bank->base;
>> =A0 =A0 =A0 u32 l =3D 0;
>>
>> - =A0 =A0 switch (bank->method) {
>> -#ifdef CONFIG_ARCH_OMAP1
>> - =A0 =A0 case METHOD_MPUIO:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP_MPUIO_GPIO_INT_EDGE / bank->=
stride;
>> - =A0 =A0 =A0 =A0 =A0 =A0 l =3D __raw_readl(reg);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((trigger & IRQ_TYPE_SENSE_MASK) =3D=3D=
 IRQ_TYPE_EDGE_BOTH)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->toggle_mask |=3D 1 <=
< gpio;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (trigger & IRQ_TYPE_EDGE_RISING)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D 1 << gpio;
>> - =A0 =A0 =A0 =A0 =A0 =A0 else if (trigger & IRQ_TYPE_EDGE_FALLING)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(1 << gpio);
>> - =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#ifdef CONFIG_ARCH_OMAP15XX
>> - =A0 =A0 case METHOD_GPIO_1510:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP1510_GPIO_INT_CONTROL;
>> + =A0 =A0 if ((bank->regs->leveldetect0 !=3D USHRT_MAX) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (bank->regs->wkupstatus !=3D=
 USHRT_MAX)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_gpio_trigger(bank, gpio, trigger);
>> + =A0 =A0 } else if (bank->regs->irqctrl !=3D USHRT_MAX) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->irqctrl;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D __raw_readl(reg);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((trigger & IRQ_TYPE_SENSE_MASK) =3D=3D=
 IRQ_TYPE_EDGE_BOTH)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->toggle_mask |=3D 1=
 << gpio;
>> @@ -330,15 +284,16 @@ static int _set_gpio_triggering(struct gpio_ba=
nk *bank, int gpio, int trigger)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (trigger & IRQ_TYPE_EDGE_FALLING=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(1 << gpio);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#ifdef CONFIG_ARCH_OMAP16XX
>> - =A0 =A0 case METHOD_GPIO_1610:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(l, reg);
>> +
>> + =A0 =A0 } else if (bank->regs->edgectrl1 !=3D USHRT_MAX) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio & 0x08)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP1610_GPIO_EDG=
E_CTRL2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->edgec=
trl2;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP1610_GPIO_EDG=
E_CTRL1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D bank->regs->edgec=
trl1;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio &=3D 0x07;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D __raw_readl(reg);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(3 << (gpio << 1));
>> @@ -346,40 +301,17 @@ static int _set_gpio_triggering(struct gpio_ba=
nk *bank, int gpio, int trigger)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D 2 << (gpio << 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (trigger & IRQ_TYPE_EDGE_FALLING)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D 1 << (gpio << 1);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (trigger)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable wake-up during=
 idle for dynamic tick */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << gpio, ba=
nk->base + OMAP1610_GPIO_SET_WAKEUPENA);
>> - =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << gpio, ba=
nk->base + OMAP1610_GPIO_CLEAR_WAKEUPENA);
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
>> - =A0 =A0 case METHOD_GPIO_7XX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP7XX_GPIO_INT_CONTROL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 l =3D __raw_readl(reg);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ((trigger & IRQ_TYPE_SENSE_MASK) =3D=3D=
 IRQ_TYPE_EDGE_BOTH)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->toggle_mask |=3D 1 <=
< gpio;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (trigger & IRQ_TYPE_EDGE_RISING)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D 1 << gpio;
>> - =A0 =A0 =A0 =A0 =A0 =A0 else if (trigger & IRQ_TYPE_EDGE_FALLING)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~(1 << gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << gpio, ba=
nk->wake_set);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad;
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#ifdef CONFIG_ARCH_OMAP2PLUS
>> - =A0 =A0 case METHOD_GPIO_24XX:
>> - =A0 =A0 case METHOD_GPIO_44XX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 set_24xx_gpio_triggering(bank, gpio, trigg=
er);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> -#endif
>> - =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto bad;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << gpio, ba=
nk->wake_clear);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(l, reg);
>> =A0 =A0 =A0 }
>> - =A0 =A0 __raw_writel(l, reg);
>> +
>> =A0 =A0 =A0 return 0;
>> -bad:
>> - =A0 =A0 return -EINVAL;
>> =A0}
>>
>> =A0static int gpio_irq_type(struct irq_data *d, unsigned type)
>> @@ -678,7 +610,6 @@ static void gpio_irq_handler(unsigned int irq, s=
truct irq_desc *desc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(isr & 1))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue=
;
>>
>> -#ifdef CONFIG_ARCH_OMAP1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Some chips can't re=
spond to both rising and falling
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* at the same time. =A0=
If this irq was requested with
>> @@ -686,9 +617,9 @@ static void gpio_irq_handler(unsigned int irq, s=
truct irq_desc *desc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to respond to the I=
RQ for the opposite direction.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This will be indica=
ted in the bank toggle_mask.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bank->toggle_mask & (1=
 << gpio_index))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((bank->regs->irqctrl !=
=3D USHRT_MAX) &&
>
> The valid register check belongs in function, not here.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (bank->toggle_mask & (1 << gpio_index)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _toggle_=
gpio_edge_triggering(bank, gpio_index);
>> -#endif
>
> This change isn't quite right, as we don't want (or need) do do this =
on
> OMAP2+. =A0This really is an OMAP1-specific hack.
>
> For the purposes of this patch, leave the OMAP1 #ifdef. =A0Then, in a
> subsequent patch, add another per-bank flag (passed in from pdata) th=
at
> indicates whether we want to use this hack, and enable it for
> OMAP1-based platforms.

Agreed.

-V Charulatha

>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
