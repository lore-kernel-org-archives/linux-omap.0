From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 01/15] OMAP: GPIO: Avoid cpu_is checks during module ena/disable
Date: Thu, 26 May 2011 15:08:28 +0530
Message-ID: <BANLkTi=4_Zu28DH8h0wSn=XrJFCd7Bg80A@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-2-git-send-email-tarun.kanti@ti.com> <8762oytr43.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40719 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756902Ab1EZJjJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 05:39:09 -0400
Received: by pzk9 with SMTP id 9so289933pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 02:39:08 -0700 (PDT)
In-Reply-To: <8762oytr43.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thu, May 26, 2011 at 02:49, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> Remove cpu-is checks while enabling/disabling OMAP GPIO module
>> during a gpio request/free.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>
> This looks mostly OK, but one nitpick about the usage of USHRT_MAX.
>
> For most registers, you should just test for a non-zero register offs=
et
> to determine if it's present or not instead of USHRT_MAX.

Is it safe to assume that zero offset is always for revision register o=
nly?
IMHO I feel that it is safe to assume an offset of 0xFFFF as invalid.
Pls add your thoughts on this.

>
> I used USHRT_MAX for the revision register because it is at offset ze=
ro
> on most SoCs, so testing for non-zero wouldn't work there.
>
> Other than that, the approach looks fine.
>
> Thanks,
>
> Kevin
>
>> ---
>> =A0arch/arm/mach-omap1/gpio15xx.c =A0 =A0 =A0 =A0 | =A0 =A02 +
>> =A0arch/arm/mach-omap1/gpio16xx.c =A0 =A0 =A0 =A0 | =A0 =A02 +
>> =A0arch/arm/mach-omap1/gpio7xx.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
>> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
>> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 =A01 +
>> =A0drivers/gpio/gpio_omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 53 +++=
+++++++++++------------------
>> =A06 files changed, 32 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gp=
io15xx.c
>> index f79c6ae..6d83e0a 100644
>> --- a/arch/arm/mach-omap1/gpio15xx.c
>> +++ b/arch/arm/mach-omap1/gpio15xx.c
>> @@ -42,6 +42,7 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_re=
gs =3D {
>> =A0 =A0 =A0 .irqstatus =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_INT,
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_MASKIT,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> + =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpi=
o_config =3D {
>> @@ -83,6 +84,7 @@ static struct omap_gpio_reg_offs omap15xx_gpio_reg=
s =3D {
>> =A0 =A0 =A0 .irqstatus =A0 =A0 =A0=3D OMAP1510_GPIO_INT_STATUS,
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP1510_GPIO_INT_MASK,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> + =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap15xx_gpio_co=
nfig =3D {
>> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gp=
io16xx.c
>> index c69b3b1..6bba196 100644
>> --- a/arch/arm/mach-omap1/gpio16xx.c
>> +++ b/arch/arm/mach-omap1/gpio16xx.c
>> @@ -45,6 +45,7 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_re=
gs =3D {
>> =A0 =A0 =A0 .irqstatus =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_INT,
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_MASKIT,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> + =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpi=
o_config =3D {
>> @@ -89,6 +90,7 @@ static struct omap_gpio_reg_offs omap16xx_gpio_reg=
s =3D {
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP1610_GPIO_IRQENABLE1,
>> =A0 =A0 =A0 .set_irqenable =A0=3D OMAP1610_GPIO_SET_IRQENABLE1,
>> =A0 =A0 =A0 .clr_irqenable =A0=3D OMAP1610_GPIO_CLEAR_IRQENABLE1,
>> + =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap16xx_gpio1_c=
onfig =3D {
>> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpi=
o7xx.c
>> index d7f2ad3..0fc2557 100644
>> --- a/arch/arm/mach-omap1/gpio7xx.c
>> +++ b/arch/arm/mach-omap1/gpio7xx.c
>> @@ -47,6 +47,7 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_reg=
s =3D {
>> =A0 =A0 =A0 .irqstatus =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_INT / 2,
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_MASKIT / 2,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> + =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio=
_config =3D {
>> @@ -88,6 +89,7 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs=
 =3D {
>> =A0 =A0 =A0 .irqstatus =A0 =A0 =A0=3D OMAP7XX_GPIO_INT_STATUS,
>> =A0 =A0 =A0 .irqenable =A0 =A0 =A0=3D OMAP7XX_GPIO_INT_MASK,
>> =A0 =A0 =A0 .irqenable_inv =A0=3D true,
>> + =A0 =A0 .ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
>> =A0};
>>
>> =A0static struct __initdata omap_gpio_platform_data omap7xx_gpio1_co=
nfig =3D {
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index 9a46d77..0446bd1 100644
>> --- a/arch/arm/mach-omap2/gpio.c
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -84,6 +84,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *=
oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->clr_irqenable =3D OMAP24XX_=
GPIO_CLEARIRQENABLE1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->debounce =3D OMAP24XX_GPIO_=
DEBOUNCE_VAL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->debounce_en =3D OMAP24XX_GP=
IO_DEBOUNCE_EN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->ctrl =3D OMAP24XX_GPIO_CTRL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 2:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->bank_type =3D METHOD_GPIO_44XX;
>> @@ -100,6 +101,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod=
 *oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->clr_irqenable =3D OMAP4_GPI=
O_IRQSTATUSCLR0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->debounce =3D OMAP4_GPIO_DEB=
OUNCINGTIME;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->debounce_en =3D OMAP4_GPIO_=
DEBOUNCENABLE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->ctrl =3D OMAP4_GPIO_CTRL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "Invalid gpio bank_type\n");
>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-=
omap/include/plat/gpio.h
>> index 91e8de3..caf432c 100644
>> --- a/arch/arm/plat-omap/include/plat/gpio.h
>> +++ b/arch/arm/plat-omap/include/plat/gpio.h
>> @@ -188,6 +188,7 @@ struct omap_gpio_reg_offs {
>> =A0 =A0 =A0 u16 clr_irqenable;
>> =A0 =A0 =A0 u16 debounce;
>> =A0 =A0 =A0 u16 debounce_en;
>> + =A0 =A0 u16 ctrl;
>>
>> =A0 =A0 =A0 bool irqenable_inv;
>> =A0};
>> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
>> index a490cb1..dfdc45e 100644
>> --- a/drivers/gpio/gpio_omap.c
>> +++ b/drivers/gpio/gpio_omap.c
>> @@ -89,6 +89,7 @@ int gpio_bank_count;
>>
>> =A0#define GPIO_INDEX(bank, gpio) (gpio % bank->width)
>> =A0#define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
>> +#define GPIO_MOD_CTRL_BIT =A0 =A0BIT(0)
>>
>> =A0static void _set_gpio_direction(struct gpio_bank *bank, int gpio,=
 int is_input)
>> =A0{
>> @@ -586,22 +587,18 @@ static int omap_gpio_request(struct gpio_chip =
*chip, unsigned offset)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(__raw_readl(reg) | (1 << of=
fset), reg);
>> =A0 =A0 =A0 }
>> =A0#endif
>> - =A0 =A0 if (!cpu_class_is_omap1()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!bank->mod_usage) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank=
->base;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ctrl;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap24xx() || c=
pu_is_omap34xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D O=
MAP24XX_GPIO_CTRL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (cpu_is_omap44xx()=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D O=
MAP4_GPIO_CTRL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D __raw_readl(reg);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Module is enabled, cloc=
ks are not gated */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D 0xFFFFFFFE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(ctrl, reg);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->mod_usage |=3D 1 << offset;
>> + =A0 =A0 if ((bank->regs->ctrl !=3D USHRT_MAX) && (!bank->mod_usage=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + bank->r=
egs->ctrl;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 ctrl;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D __raw_readl(reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Module is enabled, clocks are not gated=
 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~GPIO_MOD_CTRL_BIT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(ctrl, reg);
>> =A0 =A0 =A0 }
>> +
>> + =A0 =A0 bank->mod_usage |=3D 1 << offset;
>> +
>> =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -634,22 +631,18 @@ static void omap_gpio_free(struct gpio_chip *c=
hip, unsigned offset)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << offset, reg);
>> =A0 =A0 =A0 }
>> =A0#endif
>> - =A0 =A0 if (!cpu_class_is_omap1()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->mod_usage &=3D ~(1 << offset);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!bank->mod_usage) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank=
->base;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ctrl;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap24xx() || c=
pu_is_omap34xx())
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D O=
MAP24XX_GPIO_CTRL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (cpu_is_omap44xx()=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D O=
MAP4_GPIO_CTRL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D __raw_readl(reg);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Module is disabled, clo=
cks are gated */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(ctrl, reg);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 bank->mod_usage &=3D ~(1 << offset);
>> +
>> + =A0 =A0 if ((bank->regs->ctrl !=3D USHRT_MAX) && (!bank->mod_usage=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base + bank->r=
egs->ctrl;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 ctrl;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D __raw_readl(reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Module is disabled, clocks are gated */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D GPIO_MOD_CTRL_BIT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(ctrl, reg);
>> =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 _reset_gpio(bank, bank->chip.base + offset);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>> =A0}
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
