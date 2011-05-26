From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 12/15] OMAP: GPIO: Fix: use wake set/clear regs
Date: Thu, 26 May 2011 15:06:47 +0530
Message-ID: <BANLkTikbUDJ1MY+eGODZm2QM-_GM1v2X6Q@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-13-git-send-email-tarun.kanti@ti.com> <87zkmal6f5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46510 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757207Ab1EZJh2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 05:37:28 -0400
Received: by mail-pz0-f48.google.com with SMTP id 10so288449pzk.21
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 02:37:27 -0700 (PDT)
In-Reply-To: <87zkmal6f5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thu, May 26, 2011 at 04:44, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> In set_24xx_gpio_triggering(), for OMAP4, GPIO wakeup request
>> is set for all type of GPIO triggers whereas as per TRM the GPIO
>> wakeup request can only be generated on edge transitions. Fix this.
>
> OK. =A0Please make a dedicated patch for this part.

Okay.

>
> Subject: GPIO: OMAP: IRQ triggering: use wake set/clear regs

Okay.

>
>> In set_24xx_gpio_triggering(), OMAP4_GPIO_IRQWAKEN0 register
>> is used for wakeup request and the GPIO set/clear wakeup registers
>> are not used in OMAP4 but is handled without retaining it's old
>> value. This would corrupt the contents of OMAP4_GPIO_IRQWAKEN0
>> register by writing the value of the last requested GPIO pin in
>> a given bank. This can be avoided by making use of GPIO set/clear
>> wakeup registers.
>
> And this should be a separate patch too, or probably folded into PATC=
H
> 09/15 with an updated changelog of course.

Okay.

>
> Kevin
>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/gpio.c | =A0 =A04 ++--
>> =A0drivers/gpio/gpio_omap.c =A0 | =A0 32 ++++++++++-----------------=
-----
>> =A02 files changed, 12 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index 5c888dd..fbedbbb 100644
>> --- a/arch/arm/mach-omap2/gpio.c
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -142,8 +142,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod=
 *oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->risingdetect =3D OMAP4_GPIO=
_RISINGDETECT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->fallingdetect =3D OMAP4_GPI=
O_FALLINGDETECT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupstatus =3D OMAP4_GPIO_I=
RQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupclear =3D OMAP4_GPIO_IRQW=
AKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupset =3D OMAP4_GPIO_IRQWAK=
EN0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupclear =3D OMAP4_GPIO_CLEA=
RWKUENA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs->wkupset =3D OMAP4_GPIO_SETWKU=
ENA;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "Invalid gpio bank_type\n");
>> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
>> index 05c2857..762d73c 100644
>> --- a/drivers/gpio/gpio_omap.c
>> +++ b/drivers/gpio/gpio_omap.c
>> @@ -229,30 +229,18 @@ static inline void set_24xx_gpio_triggering(st=
ruct gpio_bank *bank, int gpio,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT,=
 gpio_bit,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trigger & IRQ_TYPE_EDGE_=
=46ALLING);
>> =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx()) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (trigger !=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writ=
el(1 << gpio, bank->base+
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP4_GPIO_IRQWAKEN0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D __=
raw_readl(bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_GPIO_IRQWAKEN0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writ=
el(val & (~(1 << gpio)), bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_GPIO_IRQWAKEN0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* GPIO wakeup request c=
an only be generated on edge
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* transitions
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (trigger & IRQ_TYPE_EDG=
E_BOTH)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writ=
el(1 << gpio, bank->base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 + OMAP24XX_GPIO_SETWKUENA);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writ=
el(1 << gpio, bank->base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 + OMAP24XX_GPIO_CLEARWKUENA);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* GPIO wakeup request can only be gener=
ated on edge
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* transitions
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (trigger & IRQ_TYPE_EDGE_BOTH)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << gpio, ba=
nk->wake_set);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << gpio, ba=
nk->wake_clear);
>> =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 /* This part needs to be executed always for OMAP34xx */
>> =A0 =A0 =A0 if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_=
bit)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
