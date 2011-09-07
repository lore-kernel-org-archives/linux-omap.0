From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 22/25] gpio/omap: save and restore debounce registers
Date: Wed, 7 Sep 2011 11:46:43 +0530
Message-ID: <CAC83ZvKQ_Nrekoet6gnPuHTQ9pXSFpZaYAxJ5O8nsYetBxd6dw@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-23-git-send-email-tarun.kanti@ti.com>
	<877h5lw75t.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:39467 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755523Ab1IGGQo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Sep 2011 02:16:44 -0400
Received: by mail-bw0-f44.google.com with SMTP id c12so193024bkb.17
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 23:16:43 -0700 (PDT)
In-Reply-To: <877h5lw75t.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Nishant Menon <nm@ti.com>

On Wed, Sep 7, 2011 at 5:33 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Nishant Menon <nm@ti.com>
>
> Check spelling of first name (I believe version in signed-off-by belo=
w
> is the correct one.)
Yes, it should haven been "Nishanth".

>
>> GPIO debounce registers need to be saved and restored for proper fun=
ctioning
>> of driver. To save the registers, we cannot cut the clock before the=
 save,
>> hence move the clk disable after the save.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 22 +++++++++++++++++++---
>> =A01 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index dc382f6..67e08e9 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -41,6 +41,8 @@ struct gpio_regs {
>> =A0 =A0 =A0 u32 risingdetect;
>> =A0 =A0 =A0 u32 fallingdetect;
>> =A0 =A0 =A0 u32 dataout;
>> + =A0 =A0 u32 debounce;
>> + =A0 =A0 u32 debounce_en;
>> =A0};
>>
>> =A0struct gpio_bank {
>> @@ -1158,9 +1160,6 @@ static int omap_gpio_runtime_suspend(struct de=
vice *dev)
>> =A0 =A0 =A0 u32 l1 =3D 0, l2 =3D 0;
>> =A0 =A0 =A0 int j;
>>
>> - =A0 =A0 for (j =3D 0; j < hweight_long(bank->dbck_enable_mask); j+=
+)
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(bank->dbck);
>> -
>> =A0 =A0 =A0 if (!bank->mod_usage)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> @@ -1192,6 +1191,16 @@ update_gpio_context_count:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context_loss_count =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->ge=
t_context_loss_count(bank->dev);
>>
>> + =A0 =A0 if (bank->dbck_enable_mask) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 bank->context.debounce =3D __raw_readl(ban=
k->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 bank->regs->debounce);
>> + =A0 =A0 =A0 =A0 =A0 =A0 bank->context.debounce_en =3D __raw_readl(=
bank->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 bank->regs->debounce_en);
>
> Here you're taking a step backwards from the goal of not having to re=
ad
> registers in the runtime suspend callback.
>
> Rather than reading the registers here, the values should be saved in=
to
> bank->context when they are initially written (_set_gpio_debounce()),=
 so
> you don't have the overhead of reading the registers in ->runtime_sus=
pend.
Good catch! Thanks.
--
Tarun
>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for (j =3D 0; j < hweight_long(bank->dbck_enable_mask); j+=
+)
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(bank->dbck);
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> @@ -1331,6 +1340,13 @@ static void omap_gpio_restore_context(struct =
gpio_bank *bank)
>> =A0 =A0 =A0 __raw_writel(bank->context.fallingdetect,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->ba=
se + bank->regs->fallingdetect);
>> =A0 =A0 =A0 __raw_writel(bank->context.dataout, bank->base + bank->r=
egs->dataout);
>> +
>> + =A0 =A0 if (bank->dbck_enable_mask) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.debounce, bank-=
>base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->regs->debounce);
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.debounce_en,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->base + bank->regs->debounce_en);
>> + =A0 =A0 }
>> =A0}
>> =A0#else
>> =A0#define omap_gpio_runtime_suspend NULL
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
