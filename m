From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 11/15] OMAP: GPIO: Remove hardcoded offsets in ctxt save/restore
Date: Thu, 26 May 2011 15:18:28 +0530
Message-ID: <BANLkTikA63fLpGFspPg3h3fx3juUy7X60w@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-12-git-send-email-tarun.kanti@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D177FF4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35559 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290Ab1EZJtJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 05:49:09 -0400
Received: by pxi19 with SMTP id 19so309505pxi.15
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 02:49:08 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D177FF4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Sanjeev,

On Thu, May 26, 2011 at 15:12, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> DebBarma, Tarun Kanti
>> Sent: Tuesday, May 24, 2011 7:55 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Hilman, Kevin; Shilimkar, Santosh; tony@atomide.com;
>> linux-arm-kernel@lists.infradead.org; DebBarma, Tarun Kanti;
>> Varadarajan, Charulatha
>> Subject: [PATCH 11/15] OMAP: GPIO: Remove hardcoded offsets
>> in ctxt save/restore
>>
>> It is not required to use hard-coded offsets any more in context
>> save and restore functions and instead use the generic offsets
>> which have been correctly initialized during device registration.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
>> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 =A01 +
>> =A0drivers/gpio/gpio_omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0123
>> ++++++++++----------------------
>> =A03 files changed, 40 insertions(+), 86 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index 0f8782f..5c888dd 100644
>
> [snip]...[snip]
>> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
>> index 28390a9..05c2857 100644
>> --- a/drivers/gpio/gpio_omap.c
>> +++ b/drivers/gpio/gpio_omap.c
>> @@ -1395,96 +1395,47 @@ restore_gpio_ctx:
>>
>> =A0void omap_gpio_save_context(struct gpio_bank *bank)
>> =A0{
>
> [sp] The [PATCH 06/15] OMAP4: GPIO: Save/restore context
> =A0 =A0 seems to be doing exactly opposite:
> =A0 =A0 It introduces the checks for
> [quote]
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (bank->method =3D=3D METHOD_GPIO_2=
4XX) {
> ...
> ...
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (bank->method =3D=3D METHOD=
_GPIO_44XX) {
> [/quote]
>
> and this patch removes the same checks.
>
> Am I missing something?

Patch 6 introduces the save/restore context code for OMAP4 and this pat=
ch
tries to replace all the macro usage with the reg offset values which i=
s nothing
but cleanup.

Based on your comments and Kevin's I understand that I should make clea=
nups
first and then any fixes/functionality changes to avoid confusions.
Will do that and send a revised series next week.

-V Charulatha

>
> ~sanjeev
>
>
>> - =A0 =A0 if (bank->method =3D=3D METHOD_GPIO_24XX) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.irqenable1 =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base +
>> OMAP24XX_GPIO_IRQENABLE1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.irqenable2 =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base +
>> OMAP24XX_GPIO_IRQENABLE2);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.wake_en =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base +
>> OMAP24XX_GPIO_WAKE_EN);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.ctrl =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base +
>> OMAP24XX_GPIO_CTRL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.oe =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base + OMAP24XX_GPIO_OE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.leveldetect0 =3D __raw_readl=
(bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_LEVELDETECT0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.leveldetect1 =3D __raw_readl=
(bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_LEVELDETECT1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.risingdetect =3D __raw_readl=
(bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_RISINGDETECT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.fallingdetect =3D __raw_read=
l(bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP24XX_GPIO_FALLINGDETECT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.dataout =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base +
>> OMAP24XX_GPIO_DATAOUT);
>> - =A0 =A0 } else if (bank->method =3D=3D METHOD_GPIO_44XX) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.irqenable1 =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base +
>> OMAP4_GPIO_IRQSTATUSSET0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.irqenable2 =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base +
>> OMAP4_GPIO_IRQSTATUSSET1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.wake_en =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base +
>> OMAP4_GPIO_IRQWAKEN0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.ctrl =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base + OMAP4_GPIO_CTRL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.oe =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base + OMAP24XX_GPIO_OE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.leveldetect0 =3D __raw_readl=
(bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP4_GPIO_LEVELDETECT0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.leveldetect1 =3D __raw_readl=
(bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP4_GPIO_LEVELDETECT1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.risingdetect =3D __raw_readl=
(bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP4_GPIO_RISINGDETECT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.fallingdetect =3D __raw_read=
l(bank->base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP4_GPIO_FALLINGDETECT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->context.dataout =3D __raw_readl(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base +
>> OMAP4_GPIO_DATAOUT);
>> - =A0 =A0 }
>> + =A0 =A0 bank->context.irqenable1 =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base + b=
ank->regs->irqenable);
>> + =A0 =A0 bank->context.irqenable2 =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base +
>> bank->regs->irqenable2);
>> + =A0 =A0 bank->context.wake_en =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base +
>> bank->regs->wkupstatus);
>> + =A0 =A0 bank->context.ctrl =3D __raw_readl(bank->base + bank->regs=
->ctrl);
>> + =A0 =A0 bank->context.oe =3D __raw_readl(bank->base +
>> bank->regs->direction);
>> + =A0 =A0 bank->context.leveldetect0 =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base +
>> bank->regs->leveldetect0);
>> + =A0 =A0 bank->context.leveldetect1 =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base +
>> bank->regs->leveldetect1);
>> + =A0 =A0 bank->context.risingdetect =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base +
>> bank->regs->risingdetect);
>> + =A0 =A0 bank->context.fallingdetect =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(bank->base +
>> bank->regs->fallingdetect);
>> + =A0 =A0 bank->context.dataout =3D __raw_readl(bank->base +
>> bank->regs->dataout);
>> =A0}
>>
>> =A0void omap_gpio_restore_context(struct gpio_bank *bank)
>> =A0{
>> - =A0 =A0 if (bank->method =3D=3D METHOD_GPIO_24XX) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.irqenable1, ban=
k->base +
>> -
>> OMAP24XX_GPIO_IRQENABLE1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.irqenable2, ban=
k->base +
>> -
>> OMAP24XX_GPIO_IRQENABLE2);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.wake_en, bank->=
base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP24XX_GPIO_WAKE_EN);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.ctrl, bank->bas=
e +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP24XX_GPIO_CTRL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.oe, bank->base =
+
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP24XX_GPIO_OE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.leveldetect0, b=
ank->base +
>> -
>> OMAP24XX_GPIO_LEVELDETECT0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.leveldetect1, b=
ank->base +
>> -
>> OMAP24XX_GPIO_LEVELDETECT1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.risingdetect, b=
ank->base +
>> -
>> OMAP24XX_GPIO_RISINGDETECT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.fallingdetect, =
bank->base +
>> -
>> OMAP24XX_GPIO_FALLINGDETECT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.dataout, bank->=
base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP24XX_GPIO_DATAOUT);
>> - =A0 =A0 } else if (bank->method =3D=3D METHOD_GPIO_44XX) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.irqenable1, ban=
k->base +
>> -
>> OMAP4_GPIO_IRQSTATUSSET0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.irqenable2, ban=
k->base +
>> -
>> OMAP4_GPIO_IRQSTATUSSET1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.wake_en, bank->=
base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP4_GPIO_IRQWAKEN0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.ctrl, bank->bas=
e +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP4_GPIO_CTRL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.oe, bank->base =
+
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP24XX_GPIO_OE);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.leveldetect0, b=
ank->base +
>> -
>> OMAP4_GPIO_LEVELDETECT0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.leveldetect1, b=
ank->base +
>> -
>> OMAP4_GPIO_LEVELDETECT1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.risingdetect, b=
ank->base +
>> -
>> OMAP4_GPIO_RISINGDETECT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.fallingdetect, =
bank->base +
>> -
>> OMAP4_GPIO_FALLINGDETECT);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.dataout, bank->=
base +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP4_GPIO_DATAOUT);
>> - =A0 =A0 }
>> + =A0 =A0 __raw_writel(bank->context.irqenable1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->irqenable);
>> + =A0 =A0 __raw_writel(bank->context.irqenable2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->irqenable2);
>> + =A0 =A0 __raw_writel(bank->context.wake_en,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->wkupstatus);
>> + =A0 =A0 __raw_writel(bank->context.ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->ctrl);
>> + =A0 =A0 __raw_writel(bank->context.oe,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->direction);
>> + =A0 =A0 __raw_writel(bank->context.leveldetect0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->leveldetect0);
>> + =A0 =A0 __raw_writel(bank->context.leveldetect1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->leveldetect1);
>> + =A0 =A0 __raw_writel(bank->context.risingdetect,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->risingdetect);
>> + =A0 =A0 __raw_writel(bank->context.fallingdetect,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->fallingdetect);
>> + =A0 =A0 __raw_writel(bank->context.dataout,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base=
 + bank->regs->dataout);
>> =A0}
>>
>> =A0#endif
>> --
>> 1.6.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
