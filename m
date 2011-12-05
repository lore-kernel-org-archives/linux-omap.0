From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v8 REPOST 17/24] gpio/omap: fix debounce clock handling
Date: Mon, 5 Dec 2011 19:27:09 +0530
Message-ID: <CAC83ZvLc+gOXp6wD1iXb5juSHyOXbFPCE3cucgq5=R8AYVhXbg@mail.gmail.com>
References: <1318422697-22247-1-git-send-email-tarun.kanti@ti.com>
	<87hb2jdeof.fsf@ti.com>
	<CAC83ZvK48SQj=GTHcASQ5uFZBXffYZmxUN49qo35MFdJNZj97g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53662 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932151Ab1LEN5L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Dec 2011 08:57:11 -0500
Received: by mail-qw0-f41.google.com with SMTP id c12so568915qad.14
        for <linux-omap@vger.kernel.org>; Mon, 05 Dec 2011 05:57:09 -0800 (PST)
In-Reply-To: <CAC83ZvK48SQj=GTHcASQ5uFZBXffYZmxUN49qo35MFdJNZj97g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Mon, Nov 7, 2011 at 7:19 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Fri, Nov 4, 2011 at 10:10 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> Currently debounce clock state is not tracked in the system.
>>
>> ??
>>
>> bank->dbck_enable_mask ?
> As I understand, this only tells which all GPIOs have debounce timeou=
t enabled.
> But, during system operation as debounce clocks are enabled and disab=
led I need
> additional flag to keep track of current state (enabled/disabled).
> This is what I meant.
>
>>
>>> The bank->dbck
>>> is enabled/disabled in suspend/idle paths irrespective of whether d=
ebounce
>>> interval has been set or not.
>>
>> No. =A0It's conditional based on bank->dbck_enable_mask, which is ba=
sed on
>> whether or not debounce has been enabled.
> You are right. I need to rephrase my description.
>
>>
>>> Ideally, it should be handled only for those
>>> gpio banks where the debounce is enabled.
>>
>> AFAICT, it is. =A0Please explain more what is actually happening in =
the
>> patch, and why.
> Yes, as I explained above, it is more about the tracking the debounce=
 clock
> enabled/disabled state for those GPIOs whose debounce timeouts are en=
abled.
> I will modify the patch description.
>
>>
>>> In _set_gpio_debounce, enable debounce clock before accessing
>>> registers.
>>
>> This is a separate issue/bug and wants its own patch with descriptiv=
e
>> changelog.
> OK.
>
>>
>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>> ---
>>> During further internal testing it was found that image was crashin=
g within
>>> _set_gpio_debounce(). It is observed that we are trying to access r=
egisters
>>> without enabling debounce clock. This patch incorporates the change=
 whereby
>>> the debounce clock is enabled before accessing registers and disabl=
ed at the
>>> end of the function.
>>>
>>> =A0drivers/gpio/gpio-omap.c | =A0 60 ++++++++++++++++++++++++++++++=
++-------------
>>> =A01 files changed, 42 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index fa6c9c5..85e9c2a 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -65,6 +65,7 @@ struct gpio_bank {
>>> =A0 =A0 =A0 struct clk *dbck;
>>> =A0 =A0 =A0 u32 mod_usage;
>>> =A0 =A0 =A0 u32 dbck_enable_mask;
>>> + =A0 =A0 bool dbck_enabled;
>>> =A0 =A0 =A0 struct device *dev;
>>> =A0 =A0 =A0 bool is_mpuio;
>>> =A0 =A0 =A0 bool dbck_flag;
>>> @@ -156,6 +157,22 @@ static inline void _gpio_rmw(void __iomem *bas=
e, u32 reg, u32 mask, bool set)
>>> =A0 =A0 =A0 __raw_writel(l, base + reg);
>>> =A0}
>>>
>>> +static inline void _gpio_dbck_enable(struct gpio_bank *bank)
>>> +{
>>> + =A0 =A0 if (bank->dbck_enable_mask && !bank->dbck_enabled) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(bank->dbck);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 bank->dbck_enabled =3D true;
>>> + =A0 =A0 }
>>> +}
>>> +
>>> +static inline void _gpio_dbck_disable(struct gpio_bank *bank)
>>> +{
>>> + =A0 =A0 if (bank->dbck_enable_mask && bank->dbck_enabled) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(bank->dbck);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 bank->dbck_enabled =3D false;
>>> + =A0 =A0 }
>>> +}
>>> +
>>> =A0/**
>>> =A0 * _set_gpio_debounce - low level gpio debounce time
>>> =A0 * @bank: the gpio bank we're acting upon
>>> @@ -184,22 +201,22 @@ static void _set_gpio_debounce(struct gpio_ba=
nk *bank, unsigned gpio,
>>>
>>> =A0 =A0 =A0 l =3D GPIO_BIT(bank, gpio);
>>>
>>> + =A0 =A0 clk_enable(bank->dbck);
>>> =A0 =A0 =A0 reg =3D bank->base + bank->regs->debounce;
>>> =A0 =A0 =A0 __raw_writel(debounce, reg);
>>>
>>> =A0 =A0 =A0 reg =3D bank->base + bank->regs->debounce_en;
>>> =A0 =A0 =A0 val =3D __raw_readl(reg);
>>>
>>> - =A0 =A0 if (debounce) {
>>> + =A0 =A0 if (debounce)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D l;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(bank->dbck);
>>> - =A0 =A0 } else {
>>> + =A0 =A0 else
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~l;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(bank->dbck);
>>> - =A0 =A0 }
>>> +
>>> =A0 =A0 =A0 bank->dbck_enable_mask =3D val;
>>>
>>> =A0 =A0 =A0 __raw_writel(val, reg);
>>> + =A0 =A0 clk_disable(bank->dbck);
>>> =A0}
>>>
>>> =A0static inline void set_gpio_trigger(struct gpio_bank *bank, int =
gpio,
>>> @@ -485,8 +502,10 @@ static int omap_gpio_request(struct gpio_chip =
*chip, unsigned offset)
>>> =A0 =A0 =A0 =A0* If this is the first gpio_request for the bank,
>>> =A0 =A0 =A0 =A0* enable the bank module.
>>> =A0 =A0 =A0 =A0*/
>>> - =A0 =A0 if (!bank->mod_usage)
>>> + =A0 =A0 if (!bank->mod_usage) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_enable(bank);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(bank->dev);
>>> + =A0 =A0 }
>>>
>>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>>> =A0 =A0 =A0 /* Set trigger to none. You need to enable the desired =
trigger with
>>> @@ -549,8 +568,10 @@ static void omap_gpio_free(struct gpio_chip *c=
hip, unsigned offset)
>>> =A0 =A0 =A0 =A0* If this is the last gpio to be freed in the bank,
>>> =A0 =A0 =A0 =A0* disable the bank module.
>>> =A0 =A0 =A0 =A0*/
>>> - =A0 =A0 if (!bank->mod_usage)
>>> + =A0 =A0 if (!bank->mod_usage) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(bank->dev);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_disable(bank);
>>
>> Why not add this to the ->runtime_suspend() callback?
> Yes, I can move there and test.
>
>>
>>> + =A0 =A0 }
>>> =A0}
>>>
>>> =A0/*
>>> @@ -829,8 +850,10 @@ static int gpio_debounce(struct gpio_chip *chi=
p, unsigned offset,
>>>
>>> =A0 =A0 =A0 if (!bank->dbck) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->dbck =3D clk_get(bank->dev, "dbcl=
k");
>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(bank->dbck))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(bank->dbck)) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "Cou=
ld not get gpio dbck\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>>> @@ -1086,6 +1109,8 @@ static int omap_gpio_suspend(struct device *d=
ev)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->saved_wakeup =3D __raw_readl(wake=
_status);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->wkup_en, ba=
nk->suspend_wakeup, 1);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, fla=
gs);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_disable(bank);
>>
>> If this call was in the ->runtime_suspend() callback, you wouldn't n=
eed
>> it here.
> Yes.
>
>>
>>> =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 return 0;
>>> @@ -1102,6 +1127,8 @@ static int omap_gpio_resume(struct device *de=
v)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bank->regs->wkup_en)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_enable(bank);
>>
>> Similarily, this call should be in the ->runtime_resume() callback a=
nd
>> it wouldn't be needed here.
> Right.
>
>>
>> Using the runtime PM callbacks, all the _gpio_dbck_* calls below wou=
ld
>> not be needed.
> Yes.
I removed the  _gpio_dbck_disable/enable calls are removed from
*_prepare_for_idle()
and *_resume_after_idle(). But I am not seeing runtime callbacks being
called and
hence the  _gpio_dbck_* calls are not getting called.

I have also tried making explicit pm_runtime_put() and pm_runtime_get_s=
ync() in
*_prepare_for_idle() and *_resume_after_idle(). Still, I do not see
the runtime callbacks
getting called.

Is there anything that I could be missing?
--
Tarun
>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->wkup_en, ba=
nk->saved_wakeup, 1);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, fla=
gs);
>>> @@ -1120,16 +1147,14 @@ void omap2_gpio_prepare_for_idle(int off_mo=
de)
>>>
>>> =A0 =A0 =A0 list_for_each_entry(bank, &omap_gpio_list, node) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 l1 =3D 0, l2 =3D 0;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 int j;
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bank->loses_context)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < hweight_long(bank->dbck=
_enable_mask); j++)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(bank->dbck);
>>> -
>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!off_mode)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!off_mode) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_disable(bank);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If going to OFF, remove triggering f=
or all
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* non-wakeup GPIOs. =A0Otherwise spu=
rious IRQs will be
>>> @@ -1151,15 +1176,16 @@ void omap2_gpio_prepare_for_idle(int off_mo=
de)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(l2, bank->base + bank->reg=
s->risingdetect);
>>>
>>> =A0save_gpio_context:
>>> -
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bank->get_context_loss_count)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->context_loss_coun=
t =3D
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->g=
et_context_loss_count(bank->dev);
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_gpio_save_context(bank);
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_runtime_suspended(bank->dev))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_runtime_suspended(bank->dev)) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(ban=
k->dev);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_disable(bank);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 }
>>> =A0}
>>>
>>> @@ -1170,13 +1196,11 @@ void omap2_gpio_resume_after_idle(void)
>>> =A0 =A0 =A0 list_for_each_entry(bank, &omap_gpio_list, node) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 context_lost_cnt_after;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 l =3D 0, gen, gen0, gen1;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 int j;
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bank->loses_context)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < hweight_long(bank->dbck=
_enable_mask); j++)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(bank->dbck);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_dbck_enable(bank);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pm_runtime_suspended(bank->dev))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(ban=
k->dev);
>>
>> Kevin
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
