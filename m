From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 24/25] gpio/omap: restore OE only after setting the
 output level
Date: Wed, 7 Sep 2011 11:48:49 +0530
Message-ID: <CAC83ZvLgUp0-mjuNcEx3+JaX2-6-5t72CCZo93FiUssdE8m_Ag@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-25-git-send-email-tarun.kanti@ti.com>
	<87ty8pusfq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47426 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754196Ab1IGGSv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Sep 2011 02:18:51 -0400
Received: by bkbzt12 with SMTP id zt12so260010bkb.0
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 23:18:49 -0700 (PDT)
In-Reply-To: <87ty8pusfq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On Wed, Sep 7, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Nishanth Menon <nm@ti.com>
>>
>> Setup the dataout register before setting the GPIO to output mode
>> in restore path.
>
> Please summarize why. =A0(again, it may seem obvious now, but may not=
 be for
> those not familiar with the driver or when coming back to it after a =
few
> months looking at other code.
Ok.

>
> Kevin
>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index db22df8..a629498 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1326,7 +1326,6 @@ static void omap_gpio_restore_context(struct g=
pio_bank *bank)
>> =A0 =A0 =A0 __raw_writel(bank->context.wake_en,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->ba=
se + bank->regs->wkup_en);
>> =A0 =A0 =A0 __raw_writel(bank->context.ctrl, bank->base + bank->regs=
->ctrl);
>> - =A0 =A0 __raw_writel(bank->context.oe, bank->base + bank->regs->di=
rection);
>> =A0 =A0 =A0 __raw_writel(bank->context.leveldetect0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->ba=
se + bank->regs->leveldetect0);
>> =A0 =A0 =A0 __raw_writel(bank->context.leveldetect1,
>> @@ -1336,6 +1335,7 @@ static void omap_gpio_restore_context(struct g=
pio_bank *bank)
>> =A0 =A0 =A0 __raw_writel(bank->context.fallingdetect,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->ba=
se + bank->regs->fallingdetect);
>> =A0 =A0 =A0 __raw_writel(bank->context.dataout, bank->base + bank->r=
egs->dataout);
>> + =A0 =A0 __raw_writel(bank->context.oe, bank->base + bank->regs->di=
rection);
>>
>> =A0 =A0 =A0 if (bank->dbck_enable_mask) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->context.debounce, ban=
k->base +
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
