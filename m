From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 09/15] OMAP: GPIO: cleanup suspend and resume functions
Date: Thu, 26 May 2011 15:32:34 +0530
Message-ID: <BANLkTi=eSS-faFd=zYnriUe6qRPTZ76yyQ@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-10-git-send-email-tarun.kanti@ti.com> <87d3j6o0ca.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52246 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753446Ab1EZKDQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 06:03:16 -0400
Received: by pwi15 with SMTP id 15so347021pwi.33
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 03:03:14 -0700 (PDT)
In-Reply-To: <87d3j6o0ca.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Kevin,

On Thu, May 26, 2011 at 04:27, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Since wake_status, wake_clear, wake_set is common for all banks on a=
 given
>> OMAP version it is enough to get their values once during probe().
>> Also, register offsets are already initialzed according to OMAP vers=
ions
>> during device registration. We no longer need these explicit checks.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> ---
>> =A0arch/arm/mach-omap1/gpio15xx.c =A0 =A0 =A0 =A0 | =A0 =A06 ++
>> =A0arch/arm/mach-omap1/gpio16xx.c =A0 =A0 =A0 =A0 | =A0 =A06 ++
>> =A0arch/arm/mach-omap1/gpio7xx.c =A0 =A0 =A0 =A0 =A0| =A0 =A06 ++
>> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 ++
>> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 =A03 +
>> =A0drivers/gpio/gpio_omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0102 +++=
++++-------------------------
>> =A06 files changed, 49 insertions(+), 80 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gp=
io15xx.c
>> index f18a4a9..b0bd21e 100644
>> --- a/arch/arm/mach-omap1/gpio15xx.c
>> +++ b/arch/arm/mach-omap1/gpio15xx.c
>> @@ -43,6 +43,9 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_re=
gs =3D {
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_MASKIT,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> =A0 =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> =A0};
>
> Same comment as earlier about USHRT_MAX.
>
> Just use zero to indicate no register present.
>
>> =A0static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpi=
o_config =3D {
>> @@ -85,6 +88,9 @@ static struct omap_gpio_reg_offs omap15xx_gpio_reg=
s =3D {
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP1510_GPIO_INT_MASK,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> =A0 =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap15xx_gpio_co=
nfig =3D {
>> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gp=
io16xx.c
>> index d886b88..403437b 100644
>> --- a/arch/arm/mach-omap1/gpio16xx.c
>> +++ b/arch/arm/mach-omap1/gpio16xx.c
>> @@ -46,6 +46,9 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_re=
gs =3D {
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_MASKIT,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> =A0 =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpi=
o_config =3D {
>> @@ -91,6 +94,9 @@ static struct omap_gpio_reg_offs omap16xx_gpio_reg=
s =3D {
>> =A0 =A0 =A0 .set_irqenable =A0=3D OMAP1610_GPIO_SET_IRQENABLE1,
>> =A0 =A0 =A0 .clr_irqenable =A0=3D OMAP1610_GPIO_CLEAR_IRQENABLE1,
>> =A0 =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupstatus =A0 =A0 =3D OMAP1610_GPIO_WAKEUPENABLE,
>> + =A0 =A0 .wkupclear =A0 =A0 =A0=3D OMAP1610_GPIO_CLEAR_WAKEUPENA,
>> + =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D OMAP1610_GPIO_SET_WAKEUPENA,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap16xx_gpio1_c=
onfig =3D {
>> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpi=
o7xx.c
>> index c7684ce..d5a4aaf 100644
>> --- a/arch/arm/mach-omap1/gpio7xx.c
>> +++ b/arch/arm/mach-omap1/gpio7xx.c
>> @@ -48,6 +48,9 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_reg=
s =3D {
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_MASKIT / 2,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> =A0 =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio=
_config =3D {
>> @@ -90,6 +93,9 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs=
 =3D {
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP7XX_GPIO_INT_MASK,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> =A0 =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupstatus =A0 =A0 =3D USHRT_MAX,
>> + =A0 =A0 .wkupclear =A0 =A0 =A0=3D USHRT_MAX,
>> + =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap7xx_gpio1_co=
nfig =3D {
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index 0782e06..7e79999 100644
>> --- a/arch/arm/mach-omap2/gpio.c
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -111,6 +111,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod=
 *oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->debounce =3D OMAP24XX_GPIO_=
DEBOUNCE_VAL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->debounce_en =3D OMAP24XX_GP=
IO_DEBOUNCE_EN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->ctrl =3D OMAP24XX_GPIO_CTRL=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupstatus =3D OMAP24XX_GPIO_=
WAKE_EN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupclear =3D OMAP24XX_GPIO_C=
LEARWKUENA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupset =3D OMAP24XX_GPIO_SET=
WKUENA;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 3:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->bank_type =3D METHOD_GPIO_44XX;
>> @@ -128,6 +131,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod=
 *oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->debounce =3D OMAP4_GPIO_DEB=
OUNCINGTIME;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->debounce_en =3D OMAP4_GPIO_=
DEBOUNCENABLE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->ctrl =3D OMAP4_GPIO_CTRL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupstatus =3D OMAP4_GPIO_IRQ=
WAKEN0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupclear =3D OMAP4_GPIO_IRQW=
AKEN0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupset =3D OMAP4_GPIO_IRQWAK=
EN0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "Invalid gpio bank_type\n");
>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-=
omap/include/plat/gpio.h
>> index 5718a45..2d1a5d6 100644
>> --- a/arch/arm/plat-omap/include/plat/gpio.h
>> +++ b/arch/arm/plat-omap/include/plat/gpio.h
>> @@ -189,6 +189,9 @@ struct omap_gpio_reg_offs {
>> =A0 =A0 =A0 u16 debounce;
>> =A0 =A0 =A0 u16 debounce_en;
>> =A0 =A0 =A0 u16 ctrl;
>> + =A0 =A0 u16 wkupstatus;
>> + =A0 =A0 u16 wkupclear;
>> + =A0 =A0 u16 wkupset;
>
> s/wkup/wkup_/

Okay.

>
>> =A0 =A0 =A0 bool irqenable_inv;
>> =A0};
>> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
>> index fcc60be..c189416 100644
>> --- a/drivers/gpio/gpio_omap.c
>> +++ b/drivers/gpio/gpio_omap.c
>> @@ -77,6 +77,9 @@ struct gpio_bank {
>> =A0 =A0 =A0 u32 width;
>> =A0 =A0 =A0 u32 ctx_lost_cnt_before;
>> =A0 =A0 =A0 u16 id;
>> + =A0 =A0 void __iomem *wake_status;
>> + =A0 =A0 void __iomem *wake_clear;
>> + =A0 =A0 void __iomem *wake_set;
>>
>> =A0 =A0 =A0 void (*set_dataout)(struct gpio_bank *bank, int gpio, in=
t enable);
>>
>> @@ -606,27 +609,11 @@ static void omap_gpio_free(struct gpio_chip *c=
hip, unsigned offset)
>> =A0 =A0 =A0 unsigned long flags;
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> -#ifdef CONFIG_ARCH_OMAP16XX
>> - =A0 =A0 if (bank->method =3D=3D METHOD_GPIO_1610) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Disable wake-up during idle for dynamic=
 tick */
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + OMAP161=
0_GPIO_CLEAR_WAKEUPENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << offset, reg);
>> - =A0 =A0 }
>> -#endif
>> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>> - =A0 =A0 if (bank->method =3D=3D METHOD_GPIO_24XX) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Disable wake-up during idle for dynamic=
 tick */
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + OMAP24X=
X_GPIO_CLEARWKUENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << offset, reg);
>> - =A0 =A0 }
>> -#endif
>> -#ifdef CONFIG_ARCH_OMAP4
>> - =A0 =A0 if (bank->method =3D=3D METHOD_GPIO_44XX) {
>> +
>> + =A0 =A0 if (bank->regs->wkupclear !=3D USHRT_MAX)
>
> Here you check the 'regs' version...
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable wake-up during idle for dynam=
ic tick */
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + OMAP4_G=
PIO_IRQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << offset, reg);
>> - =A0 =A0 }
>> -#endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << offset, bank->wake_clear=
);
>> +
>
> ...and here you write using the copy. =A0Not good for readability. =A0=
More
> on this below.

Agreed. Will do the needful.

>
>> =A0 =A0 =A0 bank->mod_usage &=3D ~(1 << offset);
>>
>> =A0 =A0 =A0 if ((bank->regs->ctrl !=3D USHRT_MAX) && (!bank->mod_usa=
ge)) {
>> @@ -1189,6 +1176,15 @@ static int __devinit omap_gpio_probe(struct p=
latform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Storing these addresses avoids redundant computation =
of these
>> + =A0 =A0 =A0* values every time in suspend/resume functions and for=
 all the
>> + =A0 =A0 =A0* gpio banks.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 bank->wake_status =3D bank->base + bank->regs->wkupstatus;
>> + =A0 =A0 bank->wake_clear =3D bank->base + bank->regs->wkupclear;
>> + =A0 =A0 bank->wake_set =3D bank->base + bank->regs->wkupset;
>
> Well, it's not really redundant since these are only used in the susp=
end
> and resume functions. =A0I'd rather have an extra add in the
> suspend/resume functions than have 3 extra words in every struct gpio=
_bank.
>
> Also, Using 'bank + reg offset' in the functions that use them is
> consistent with the pattern of all the other changes in the cleanup
> series, so lets not start something new.

Agreed.

>
>> =A0 =A0 =A0 pm_runtime_enable(bank->dev);
>> =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
>>
>> @@ -1207,7 +1203,7 @@ err_exit:
>> =A0}
>>
>> =A0#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLU=
S)
>> -static int omap_gpio_suspend(struct sys_device *dev, pm_message_t m=
esg)
>> +static int omap_gpio_suspend(struct sys_device *dev, pm_message_t u=
nused)
>
> change not related to $SUBJECT patch
>
>> =A0{
>> =A0 =A0 =A0 struct gpio_bank *bank;
>>
>> @@ -1215,41 +1211,12 @@ static int omap_gpio_suspend(struct sys_devi=
ce *dev, pm_message_t mesg)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> =A0 =A0 =A0 list_for_each_entry(bank, &omap_gpio_list, node) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *wake_status;
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *wake_clear;
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *wake_set;
>
> IMO, these should stay here and should just be assigned 'bank->base +
> bank->regs->...'

Okay.

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flags;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 switch (bank->method) {
>> -#ifdef CONFIG_ARCH_OMAP16XX
>> - =A0 =A0 =A0 =A0 =A0 =A0 case METHOD_GPIO_1610:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_status =3D bank->base=
 + OMAP1610_GPIO_WAKEUPENABLE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base =
+ OMAP1610_GPIO_CLEAR_WAKEUPENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + =
OMAP1610_GPIO_SET_WAKEUPENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>> - =A0 =A0 =A0 =A0 =A0 =A0 case METHOD_GPIO_24XX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_status =3D bank->base=
 + OMAP24XX_GPIO_WAKE_EN;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base =
+ OMAP24XX_GPIO_CLEARWKUENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + =
OMAP24XX_GPIO_SETWKUENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#ifdef CONFIG_ARCH_OMAP4
>> - =A0 =A0 =A0 =A0 =A0 =A0 case METHOD_GPIO_44XX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_status =3D bank->base=
 + OMAP4_GPIO_IRQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base =
+ OMAP4_GPIO_IRQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + =
OMAP4_GPIO_IRQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> - =A0 =A0 =A0 =A0 =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->saved_wakeup =3D __raw_readl(wake_st=
atus);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, wake_clear);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->suspend_wakeup, wake_se=
t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 bank->saved_wakeup =3D __raw_readl(bank->w=
ake_status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, bank->wake_clear)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->suspend_wakeup, bank->w=
ake_set);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flag=
s);
>> =A0 =A0 =A0 }
>
>> @@ -1264,36 +1231,11 @@ static int omap_gpio_resume(struct sys_devic=
e *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> =A0 =A0 =A0 list_for_each_entry(bank, &omap_gpio_list, node) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *wake_clear;
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *wake_set;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flags;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 switch (bank->method) {
>> -#ifdef CONFIG_ARCH_OMAP16XX
>> - =A0 =A0 =A0 =A0 =A0 =A0 case METHOD_GPIO_1610:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base =
+ OMAP1610_GPIO_CLEAR_WAKEUPENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + =
OMAP1610_GPIO_SET_WAKEUPENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>> - =A0 =A0 =A0 =A0 =A0 =A0 case METHOD_GPIO_24XX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base =
+ OMAP24XX_GPIO_CLEARWKUENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + =
OMAP24XX_GPIO_SETWKUENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#ifdef CONFIG_ARCH_OMAP4
>> - =A0 =A0 =A0 =A0 =A0 =A0 case METHOD_GPIO_44XX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base =
+ OMAP4_GPIO_IRQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + =
OMAP4_GPIO_IRQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> - =A0 =A0 =A0 =A0 =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, wake_clear);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->saved_wakeup, wake_set)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, bank->wake_clear)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->saved_wakeup, bank->wak=
e_set);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flag=
s);
>> =A0 =A0 =A0 }
>
> In addition, the cpu_is_* checks in the suspend/resume functions coul=
d
> be replaced by checking for non-zero values in bank->regs->wkup*

This is taken care in a later patch. In our next series, we will take c=
are
about the patch order too with cleanup taken care in a separately and
later any functionality change/fixes.

-V Charulatha

>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
