From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
Date: Thu, 26 May 2011 15:08:06 +0530
Message-ID: <BANLkTik2=da94cZh23gwx1hzZQK6H_hy2Q@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-3-git-send-email-tarun.kanti@ti.com> <87sjs2sbvy.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51153 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756902Ab1EZJir convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 05:38:47 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so253890pzk.15
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 02:38:46 -0700 (PDT)
In-Reply-To: <87sjs2sbvy.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Thu, May 26, 2011 at 03:04, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> Non-wakeup GPIOs are available only in OMAP2420 and OMAP3430. But
>> the GPIO driver initializes the non-wakeup GPIO bits for OMAP24xx
>> (bothe OMAP 2420 and 2430) & not for OMAP3 which is incorrect.
>
> Can you cite the documentation you're using for the OMAP3 non-wakeup
> GPIOs?

I am referring to Table 25-5. GPIO Channel Description at page no 3354
OMAP3430 public TRM Version P.

>
> This is a change of functionality from current code, where all OMAP3
> GPIOs are considered wakeup capable.
>
> I'd like this to be tackled in two patches. =A0One for the
> cleanup/consolidation, and one for change in behavior.

Okay.

>
> For this cleanup/consolidation (this series), please keep existing
> functionality and focus on the cleanup. =A0Then, in an additional pat=
ch
> (on top of the cleanup/conslidation), change the functionality with a
> detailed changelog.

Okay.

>
> Thanks,
>
> Kevin
>
>> Fix the above by providing non-wakeup GPIO information through pdata
>> specific to the SoC.
>>
>> The GPIO rev id provided in the hwmod database is the same for OMAP2=
420
>> and OMAP2430. Change the GPIO rev ids in hwmod database as given bel=
ow
>> so that it can be used to identify OMAP2420 and OMAP2430.
>> OMAP2420 - 0
>> OMAP2430 - 1
>> OMAP3 =A0 =A0- 2
>> OMAP4 =A0 =A0- 3
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> ---
>> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
26 ++++++++++++++++++++++++--
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 =A02 +-
>> =A0arch/arm/plat-omap/include/plat/gpio.h =A0 =A0 | =A0 =A01 +
>> =A0drivers/gpio/gpio_omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 11 +++--------
>> =A06 files changed, 31 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index 0446bd1..6cd26b4 100644
>> --- a/arch/arm/mach-omap2/gpio.c
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -56,6 +56,28 @@ static int omap2_gpio_dev_init(struct omap_hwmod =
*oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 switch (oh->class->rev) {
>> + =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (id =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non-wakeup GPIO pins fo=
r OMAP2420 Bank1 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->non_wakeup_gpios =3D=
 0xe203ffc0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (id =3D=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non-wakeup GPIO pins fo=
r OMAP2420 Bank2 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->non_wakeup_gpios =3D=
 0x08700040;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (id =3D=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non-wakeup GPIO pins fo=
r OMAP3 Bank2 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->non_wakeup_gpios =3D=
 0x00000001;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (id =3D=3D 6)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non-wakeup GPIO pins fo=
r OMAP3 Bank6 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->non_wakeup_gpios =3D=
 0x08000000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* No non-wakeup GPIO pins for other SoCs =
*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 dev_attr =3D (struct omap_gpio_dev_attr *)oh->dev_attr;
>> =A0 =A0 =A0 pdata->bank_width =3D dev_attr->bank_width;
>> =A0 =A0 =A0 pdata->dbck_flag =3D dev_attr->dbck_flag;
>> @@ -70,6 +92,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *=
oh, void *unused)
>> =A0 =A0 =A0 switch (oh->class->rev) {
>> =A0 =A0 =A0 case 0:
>> =A0 =A0 =A0 case 1:
>> + =A0 =A0 case 2:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->bank_type =3D METHOD_GPIO_24XX;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->revision =3D OMAP24XX_GPIO_=
REVISION;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->direction =3D OMAP24XX_GPIO=
_OE;
>> @@ -86,7 +109,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod =
*oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->debounce_en =3D OMAP24XX_GP=
IO_DEBOUNCE_EN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->ctrl =3D OMAP24XX_GPIO_CTRL=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 case 2:
>> + =A0 =A0 case 3:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->bank_type =3D METHOD_GPIO_44XX;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->revision =3D OMAP4_GPIO_REV=
ISION;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->direction =3D OMAP4_GPIO_OE=
;
>> @@ -108,7 +131,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod=
 *oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pdata);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 od =3D omap_device_build(name, id - 1, oh, pdata,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*=
pdata), omap_gpio_latency,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SI=
ZE(omap_gpio_latency),
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_2430_data.c
>> index 9682dd5..ae702b5 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> @@ -1728,7 +1728,7 @@ static struct omap_hwmod_class_sysconfig omap2=
43x_gpio_sysc =3D {
>> =A0static struct omap_hwmod_class omap243x_gpio_hwmod_class =3D {
>> =A0 =A0 =A0 .name =3D "gpio",
>> =A0 =A0 =A0 .sysc =3D &omap243x_gpio_sysc,
>> - =A0 =A0 .rev =3D 0,
>> + =A0 =A0 .rev =3D 1,
>> =A0};
>>
>> =A0/* gpio1 */
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_3xxx_data.c
>> index 909a84d..05e7005 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -2117,7 +2117,7 @@ static struct omap_hwmod_class_sysconfig omap3=
xxx_gpio_sysc =3D {
>> =A0static struct omap_hwmod_class omap3xxx_gpio_hwmod_class =3D {
>> =A0 =A0 =A0 .name =3D "gpio",
>> =A0 =A0 =A0 .sysc =3D &omap3xxx_gpio_sysc,
>> - =A0 =A0 .rev =3D 1,
>> + =A0 =A0 .rev =3D 2,
>> =A0};
>>
>> =A0/* gpio_dev_attr*/
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index abc548a..ea30752 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -1703,7 +1703,7 @@ static struct omap_hwmod_class_sysconfig omap4=
4xx_gpio_sysc =3D {
>> =A0static struct omap_hwmod_class omap44xx_gpio_hwmod_class =3D {
>> =A0 =A0 =A0 .name =A0 =3D "gpio",
>> =A0 =A0 =A0 .sysc =A0 =3D &omap44xx_gpio_sysc,
>> - =A0 =A0 .rev =A0 =A0=3D 2,
>> + =A0 =A0 .rev =A0 =A0=3D 3,
>> =A0};
>>
>> =A0/* gpio dev_attr */
>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-=
omap/include/plat/gpio.h
>> index caf432c..8014a8a 100644
>> --- a/arch/arm/plat-omap/include/plat/gpio.h
>> +++ b/arch/arm/plat-omap/include/plat/gpio.h
>> @@ -199,6 +199,7 @@ struct omap_gpio_platform_data {
>> =A0 =A0 =A0 int bank_width; =A0 =A0 =A0 =A0 /* GPIO bank width */
>> =A0 =A0 =A0 int bank_stride; =A0 =A0 =A0 =A0/* Only needed for omap1=
 MPUIO */
>> =A0 =A0 =A0 bool dbck_flag; =A0 =A0 =A0 =A0 /* dbck required or not =
- True for OMAP3&4 */
>> + =A0 =A0 u32 non_wakeup_gpios;
>>
>> =A0 =A0 =A0 struct omap_gpio_reg_offs *regs;
>> =A0};
>> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
>> index dfdc45e..0ba4cdb 100644
>> --- a/drivers/gpio/gpio_omap.c
>> +++ b/drivers/gpio/gpio_omap.c
>> @@ -1008,7 +1008,7 @@ static inline int init_gpio_info(struct platfo=
rm_device *pdev)
>> =A0}
>>
>> =A0/* TODO: Cleanup cpu_is_* checks */
>> -static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
>> +static void omap_gpio_mod_init(struct gpio_bank *bank)
>> =A0{
>> =A0 =A0 =A0 if (cpu_class_is_omap2()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx()) {
>> @@ -1028,12 +1028,6 @@ static void omap_gpio_mod_init(struct gpio_ba=
nk *bank, int id)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize interface =
clk ungated, module enabled */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, bank->ba=
se + OMAP24XX_GPIO_CTRL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else if (cpu_is_omap24xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 static const u32 non_wakeu=
p_gpios[] =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xe203ffc0=
, 0x08700040
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (id < ARRAY_SIZE(non_wa=
keup_gpios))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->non_=
wakeup_gpios =3D non_wakeup_gpios[id];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 } else if (cpu_class_is_omap1()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bank_is_mpuio(bank))
>> @@ -1179,6 +1173,7 @@ static int __devinit omap_gpio_probe(struct pl=
atform_device *pdev)
>> =A0 =A0 =A0 bank->dbck_flag =3D pdata->dbck_flag;
>> =A0 =A0 =A0 bank->stride =3D pdata->bank_stride;
>> =A0 =A0 =A0 bank->width =3D pdata->bank_width;
>> + =A0 =A0 bank->non_wakeup_gpios =3D pdata->non_wakeup_gpios;
>>
>> =A0 =A0 =A0 bank->regs =3D pdata->regs;
>>
>> @@ -1205,7 +1200,7 @@ static int __devinit omap_gpio_probe(struct pl=
atform_device *pdev)
>> =A0 =A0 =A0 pm_runtime_enable(bank->dev);
>> =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
>>
>> - =A0 =A0 omap_gpio_mod_init(bank, id);
>> + =A0 =A0 omap_gpio_mod_init(bank);
>> =A0 =A0 =A0 omap_gpio_chip_init(bank);
>> =A0 =A0 =A0 omap_gpio_show_rev(bank);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
