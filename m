From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v8 REPOST 17/24] gpio/omap: fix debounce clock handling
Date: Mon, 7 Nov 2011 19:19:28 +0530
Message-ID: <CAC83ZvK48SQj=GTHcASQ5uFZBXffYZmxUN49qo35MFdJNZj97g@mail.gmail.com>
References: <1318422697-22247-1-git-send-email-tarun.kanti@ti.com>
	<87hb2jdeof.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54043 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754597Ab1KGNta convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Nov 2011 08:49:30 -0500
Received: by mail-qw0-f48.google.com with SMTP id g24so674784qab.35
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 05:49:29 -0800 (PST)
In-Reply-To: <87hb2jdeof.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Fri, Nov 4, 2011 at 10:10 PM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Currently debounce clock state is not tracked in the system.
>
> ??
>
> bank->dbck_enable_mask ?
As I understand, this only tells which all GPIOs have debounce timeout =
enabled.
But, during system operation as debounce clocks are enabled and disable=
d I need
additional flag to keep track of current state (enabled/disabled).
This is what I meant.

>
>> The bank->dbck
>> is enabled/disabled in suspend/idle paths irrespective of whether de=
bounce
>> interval has been set or not.
>
> No. =A0It's conditional based on bank->dbck_enable_mask, which is bas=
ed on
> whether or not debounce has been enabled.
You are right. I need to rephrase my description.

>
>> Ideally, it should be handled only for those
>> gpio banks where the debounce is enabled.
>
> AFAICT, it is. =A0Please explain more what is actually happening in t=
he
> patch, and why.
Yes, as I explained above, it is more about the tracking the debounce c=
lock
enabled/disabled state for those GPIOs whose debounce timeouts are enab=
led.
I will modify the patch description.

>
>> In _set_gpio_debounce, enable debounce clock before accessing
>> registers.
>
> This is a separate issue/bug and wants its own patch with descriptive
> changelog.
OK.

>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> During further internal testing it was found that image was crashing=
 within
>> _set_gpio_debounce(). It is observed that we are trying to access re=
gisters
>> without enabling debounce clock. This patch incorporates the change =
whereby
>> the debounce clock is enabled before accessing registers and disable=
d at the
>> end of the function.
>>
>> =A0drivers/gpio/gpio-omap.c | =A0 60 +++++++++++++++++++++++++++++++=
+-------------
>> =A01 files changed, 42 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index fa6c9c5..85e9c2a 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -65,6 +65,7 @@ struct gpio_bank {
>> =A0 =A0 =A0 struct clk *dbck;
>> =A0 =A0 =A0 u32 mod_usage;
>> =A0 =A0 =A0 u32 dbck_enable_mask;
>> + =A0 =A0 bool dbck_enabled;
>> =A0 =A0 =A0 struct device *dev;
>> =A0 =A0 =A0 bool is_mpuio;
>> =A0 =A0 =A0 bool dbck_flag;
>> @@ -156,6 +157,22 @@ static inline void _gpio_rmw(void __iomem *base=
, u32 reg, u32 mask, bool set)
>> =A0 =A0 =A0 __raw_writel(l, base + reg);
>> =A0}
>>
>> +static inline void _gpio_dbck_enable(struct gpio_bank *bank)
>> +{
>> + =A0 =A0 if (bank->dbck_enable_mask && !bank->dbck_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(bank->dbck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 bank->dbck_enabled =3D true;
>> + =A0 =A0 }
>> +}
>> +
>> +static inline void _gpio_dbck_disable(struct gpio_bank *bank)
>> +{
>> + =A0 =A0 if (bank->dbck_enable_mask && bank->dbck_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(bank->dbck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 bank->dbck_enabled =3D false;
>> + =A0 =A0 }
>> +}
>> +
>> =A0/**
>> =A0 * _set_gpio_debounce - low level gpio debounce time
>> =A0 * @bank: the gpio bank we're acting upon
>> @@ -184,22 +201,22 @@ static void _set_gpio_debounce(struct gpio_ban=
k *bank, unsigned gpio,
>>
>> =A0 =A0 =A0 l =3D GPIO_BIT(bank, gpio);
>>
>> + =A0 =A0 clk_enable(bank->dbck);
>> =A0 =A0 =A0 reg =3D bank->base + bank->regs->debounce;
>> =A0 =A0 =A0 __raw_writel(debounce, reg);
>>
>> =A0 =A0 =A0 reg =3D bank->base + bank->regs->debounce_en;
>> =A0 =A0 =A0 val =3D __raw_readl(reg);
>>
>> - =A0 =A0 if (debounce) {
>> + =A0 =A0 if (debounce)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D l;
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(bank->dbck);
>> - =A0 =A0 } else {
>> + =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~l;
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(bank->dbck);
>> - =A0 =A0 }
>> +
>> =A0 =A0 =A0 bank->dbck_enable_mask =3D val;
>>
>> =A0 =A0 =A0 __raw_writel(val, reg);
>> + =A0 =A0 clk_disable(bank->dbck);
>> =A0}
>>
>> =A0static inline void set_gpio_trigger(struct gpio_bank *bank, int g=
pio,
>> @@ -485,8 +502,10 @@ static int omap_gpio_request(struct gpio_chip *=
chip, unsigned offset)
>> =A0 =A0 =A0 =A0* If this is the first gpio_request for the bank,
>> =A0 =A0 =A0 =A0* enable the bank module.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if (!bank->mod_usage)
>> + =A0 =A0 if (!bank->mod_usage) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_enable(bank);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> =A0 =A0 =A0 /* Set trigger to none. You need to enable the desired t=
rigger with
>> @@ -549,8 +568,10 @@ static void omap_gpio_free(struct gpio_chip *ch=
ip, unsigned offset)
>> =A0 =A0 =A0 =A0* If this is the last gpio to be freed in the bank,
>> =A0 =A0 =A0 =A0* disable the bank module.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if (!bank->mod_usage)
>> + =A0 =A0 if (!bank->mod_usage) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(bank->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_disable(bank);
>
> Why not add this to the ->runtime_suspend() callback?
Yes, I can move there and test.

>
>> + =A0 =A0 }
>> =A0}
>>
>> =A0/*
>> @@ -829,8 +850,10 @@ static int gpio_debounce(struct gpio_chip *chip=
, unsigned offset,
>>
>> =A0 =A0 =A0 if (!bank->dbck) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->dbck =3D clk_get(bank->dev, "dbclk=
");
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(bank->dbck))
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(bank->dbck)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "Coul=
d not get gpio dbck\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> @@ -1086,6 +1109,8 @@ static int omap_gpio_suspend(struct device *de=
v)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->saved_wakeup =3D __raw_readl(wake_=
status);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->wkup_en, ban=
k->suspend_wakeup, 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flag=
s);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_disable(bank);
>
> If this call was in the ->runtime_suspend() callback, you wouldn't ne=
ed
> it here.
Yes.

>
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return 0;
>> @@ -1102,6 +1127,8 @@ static int omap_gpio_resume(struct device *dev=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bank->regs->wkup_en)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_enable(bank);
>
> Similarily, this call should be in the ->runtime_resume() callback an=
d
> it wouldn't be needed here.
Right.

>
> Using the runtime PM callbacks, all the _gpio_dbck_* calls below woul=
d
> not be needed.
Yes.
--
Tarun
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->wkup_en, ban=
k->saved_wakeup, 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flag=
s);
>> @@ -1120,16 +1147,14 @@ void omap2_gpio_prepare_for_idle(int off_mod=
e)
>>
>> =A0 =A0 =A0 list_for_each_entry(bank, &omap_gpio_list, node) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 l1 =3D 0, l2 =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 int j;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bank->loses_context)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < hweight_long(bank->dbck_=
enable_mask); j++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(bank->dbck);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!off_mode)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!off_mode) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_disable(bank);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If going to OFF, remove triggering fo=
r all
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* non-wakeup GPIOs. =A0Otherwise spur=
ious IRQs will be
>> @@ -1151,15 +1176,16 @@ void omap2_gpio_prepare_for_idle(int off_mod=
e)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(l2, bank->base + bank->regs=
->risingdetect);
>>
>> =A0save_gpio_context:
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bank->get_context_loss_count)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context_loss_count=
 =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->ge=
t_context_loss_count(bank->dev);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_gpio_save_context(bank);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_runtime_suspended(bank->dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_runtime_suspended(bank->dev)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(bank=
->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_disable(bank);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -1170,13 +1196,11 @@ void omap2_gpio_resume_after_idle(void)
>> =A0 =A0 =A0 list_for_each_entry(bank, &omap_gpio_list, node) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 context_lost_cnt_after;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 l =3D 0, gen, gen0, gen1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 int j;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bank->loses_context)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < hweight_long(bank->dbck_=
enable_mask); j++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(bank->dbck);
>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_enable(bank);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pm_runtime_suspended(bank->dev))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(bank=
->dev);
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
