From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC PATCH 04/10] OMAP: GPIO: Remove dependency on gpio_bank_count
Date: Fri, 20 May 2011 13:57:12 +0530
Message-ID: <BANLkTi=v+8-3QCfyF+DLoNhyU9=5-gyWzw@mail.gmail.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
 <1305546104-1511-5-git-send-email-tarun.kanti@ti.com> <87ipt68znp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60376 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934699Ab1ETI1x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 04:27:53 -0400
Received: by iyb14 with SMTP id 14so3970330iyb.33
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 01:27:52 -0700 (PDT)
In-Reply-To: <87ipt68znp.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Kevin,

On Thu, May 19, 2011 at 21:12, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> gpio_bank_count is the count of number of GPIO devices
>> in a SoC. Remove this dependency from the driver. Also remove
>> the dependency on array of pointers to gpio_bank struct of
>> all GPIO devices.
>>
>> The cpu_is*() checks used in omap2_gpio_prepare_for_idle() and
>> omap2_gpio_resume_after_idle() would be removed in one of the
>> patches in this series
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>
>
> Nice. =A0I like this direction.... Some minor comments below...
>
>> ---
>> =A0arch/arm/mach-omap1/gpio15xx.c =A0 =A0 =A0 =A0 | =A0 =A01 -
>> =A0arch/arm/mach-omap1/gpio16xx.c =A0 =A0 =A0 =A0 | =A0 =A02 -
>> =A0arch/arm/mach-omap1/gpio7xx.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 -
>> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
>> =A0arch/arm/plat-omap/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0157 +++=
+++++++++++++---------------
>> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 =A03 -
>> =A06 files changed, 81 insertions(+), 85 deletions(-)
>>

[...]

>>
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index 12deb1c..0b76475 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -30,7 +30,10 @@
>> =A0#include <mach/gpio.h>
>> =A0#include <asm/mach/irq.h>
>>
>> +static LIST_HEAD(omap_gpio_list);
>> +
>> =A0struct gpio_bank {
>> + =A0 =A0 struct list_head node;
>> =A0 =A0 =A0 unsigned long pbase;
>> =A0 =A0 =A0 void __iomem *base;
>> =A0 =A0 =A0 u16 irq;
>> @@ -57,6 +60,7 @@ struct gpio_bank {
>> =A0 =A0 =A0 bool dbck_flag;
>> =A0 =A0 =A0 int stride;
>> =A0 =A0 =A0 u32 width;
>> + =A0 =A0 u16 id;
>>
>> =A0 =A0 =A0 void (*set_dataout)(struct gpio_bank *bank, int gpio, in=
t enable);
>>
>> @@ -80,15 +84,6 @@ struct omap3_gpio_regs {
>> =A0static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
>> =A0#endif
>>
>> -/*
>> - * TODO: Cleanup gpio_bank usage as it is having information
>> - * related to all instances of the device
>> - */
>> -static struct gpio_bank *gpio_bank;
>> -
>> -/* TODO: Analyze removing gpio_bank_count usage from driver code */
>> -int gpio_bank_count;
>> -
>> =A0#define GPIO_INDEX(bank, gpio) (gpio % bank->width)
>> =A0#define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
>> =A0#define GPIO_MOD_CTRL_BIT =A0 =A0BIT(0)
>> @@ -859,23 +854,29 @@ static struct platform_device omap_mpuio_devic=
e =3D {
>> =A0 =A0 =A0 /* could list the /proc/iomem resources */
>> =A0};
>>
>> -static inline void mpuio_init(void)
>> +static inline void mpuio_init(struct gpio_bank *bank)
>> =A0{
>> - =A0 =A0 struct gpio_bank *bank =3D &gpio_bank[0];
>> + =A0 =A0 static int mpuio_init_done;
>
> Why is this flag needed? =A0 isn't the bank->method check enough?

Correct. This flag is not required.

>
>> + =A0 =A0 if (mpuio_init_done || (bank->method !=3D METHOD_MPUIO))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> =A0 =A0 =A0 platform_set_drvdata(&omap_mpuio_device, bank);
>>
>> =A0 =A0 =A0 if (platform_driver_register(&omap_mpuio_driver) =3D=3D =
0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) platform_device_register(&omap_mp=
uio_device);
>> +
>> + =A0 =A0 mpuio_init_done =3D 1;
>> =A0}
>>

[...]

>>
>> =A0 =A0 =A0 bank->base =3D ioremap(res->start, resource_size(res));
>> =A0 =A0 =A0 if (!bank->base) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Could not ioremap gpi=
o bank%i\n", id);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Could not ioremap gpi=
o bank%i\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 pm_runtime_enable(bank->dev);
>> =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
>>
>> + =A0 =A0 mpuio_init(bank);
>
> How about moving this call into _mod_init(), and call it only when
> ->method =3D MPUIO.

Sure. Will do that.

-V Charulatha

>
>> =A0 =A0 =A0 omap_gpio_mod_init(bank);
>> =A0 =A0 =A0 omap_gpio_chip_init(bank);
>> =A0 =A0 =A0 omap_gpio_show_rev(bank);
>
> [...]
>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
