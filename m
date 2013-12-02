From: Chao Xu <caesarxuchao@gmail.com>
Subject: Re: [PATCH V2] gpio: omap: refresh patch "be more aggressive with
 pm_runtime" against v3.12-rc5
Date: Mon, 2 Dec 2013 17:00:56 -0600
Message-ID: <CAKZq+rd2yVOzRhcf2_dGudaYR7EqZ4vk7nv-GX2OKKxwdWKjUg@mail.gmail.com>
References: <1385506004-14943-1-git-send-email-caesarxuchao@gmail.com>
	<5298C932.60709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5298C932.60709@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, balbi@ti.com, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

Sorry for the late reply.

On Fri, Nov 29, 2013 at 11:04 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Adding Kevin's Linaro id, + Nishant,
>
> On Tuesday 26 November 2013 05:46 PM, Chao Xu wrote:
>> From: Felipe Balbi <balbi@ti.com>
>>
>> try to keep gpio block suspended as much as possible.
>>
>> Tested with pandaboard and a sysfs exported gpio.
>>
>> Signed-off-by: Felipe Balbi <balbi at ti.com>
>>
>> [caesarxuchao@gmail.com : Refreshed against v3.12-rc5, and added rev=
ision check to enable aggressive pm_runtime on OMAP4-only. Because am33=
xx_gpio_sysc.idlemodes seems to be wrongly marked as SIDLE_SMART_WKUP, =
which might cause missed interrupts with this patch. Tested on Pandaboa=
rd rev A2.]
>>
> Please format the text and limit it to 80 char rule.
>
Sorry. It's my first time submitting a patch. I will fix it and resubmi=
t.
>> Signed-off-by: Chao Xu <caesarxuchao@gmail.com>
>> ---
>> According to Mr. Felipe Balbi, the original patch was not accepted b=
ecause interrupts would be missed when GPIO was used as IRQ source. But=
 in my tests with pandaboard, interrupts were not missed. This is becau=
se _idle_sysc() sets the idlemode of gpio module to smart-idle-wakeup, =
and according to OMAP4430 TRM, under this idlemode, the gpio can genera=
te an asynchronous wakeup request to the PRCM. And after GPIO is awake,=
 the wake-up request is reflected into the interrupt status registers.
>>
>> A change made on the original patch is only applying the aggressive =
runtime pm scheme on OMAP4, because I don=92t have HW to test OMAP3 or =
am33xx devices. According to the respective TRMs, their GPIO modules al=
so can generate wake-up request if the idlemode is set to smart-idle or=
 smart-idle-wakeup. So the patch should work for them, too. But I suspe=
ct a potential SW bug may cause missed interrupts: the am33xx_gpio_sysc=
=2Eidlemodes is marked as capable of SIDLE_SMART_WKUP in omap_hwmod_33x=
x.c. But according to AM335x TRM, _only_ gpio0 is capable of this mode.=
 This may make GPIO stuck in force-idle mode and unable to generate wak=
eup request. And thus interrupt will be missed. Again, I don=92t have t=
he HW to verify whether this is a bug or not :(
>>
> In general I am not against this idea but patch has many assumptions =
which
> are not entirely correct.
>
> - SMART_WAKEUP will take care of waking IP etc not always true to pow=
er
> domain getting into idle.
>
I agree that if the power domain goes to idle, SMART_WAKEUP
won't be effective. But, correct me if i'm wrong, even if we don't call
runtime_put(), the power domain can still go to idle. Because the
modulemode of GPIO is set to HW_AUTO in this case, which won't
prevent the power domain goes to retention. So this patch doesn't
make the situation worse.
> - If we want to go on this path then I would like to see we address
> omap2_gpio_[prepare/resumne]_for_idle()
>
I did a quick google search but didn't find the problem with the two
functions. Could you give me a pointer here?
> - GPIO though sound simple is one of the most notorious IP block
> on PM front so this needs lot of testing. This patch not seems be
> tested at all so I would have much liked it to be in RFC/RFT
> state.
I tested using a gpio pin as interrupt source after applying the patch.
What are the other tests that I should do? Is there a formal way of
reporting test results here?
>
>>  drivers/gpio/gpio-omap.c                |  103 ++++++++++++++++++++=
++++++-----
>>  include/linux/platform_data/gpio-omap.h |    1 +
>>  2 files changed, 87 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 89675f8..90661f2 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -76,6 +76,7 @@ struct gpio_bank {
>>       int context_loss_count;
>>       int power_mode;
>>       bool workaround_enabled;
>> +     bool is_aggressive_pm;
>>
>>       void (*set_dataout)(struct gpio_bank *bank, int gpio, int enab=
le);
>>       int (*get_context_loss_count)(struct device *dev);
>> @@ -473,8 +474,15 @@ static void _disable_gpio_module(struct gpio_ba=
nk *bank, unsigned offset)
>>  static int gpio_is_input(struct gpio_bank *bank, int mask)
>>  {
>>       void __iomem *reg =3D bank->base + bank->regs->direction;
>> +     u32 val;
>>
>> -     return __raw_readl(reg) & mask;
>> +     if (bank->is_aggressive_pm)
>> +             pm_runtime_get_sync(bank->dev);
>> +     val =3D __raw_readl(reg) & mask;
>> +     if (bank->is_aggressive_pm)
>> +             pm_runtime_put(bank->dev);
>> +
> Move above in some wrapper instead of sprinkling the
> 'is_aggressive_pm' check everywhere.
>
Will do.
>> @@ -1585,18 +1651,21 @@ static const struct omap_gpio_platform_data =
omap2_pdata =3D {
>>       .regs =3D &omap2_gpio_regs,
>>       .bank_width =3D 32,
>>       .dbck_flag =3D false,
>> +     .is_aggressive_pm =3D false,
>>  };
>>
>>  static const struct omap_gpio_platform_data omap3_pdata =3D {
>>       .regs =3D &omap2_gpio_regs,
>>       .bank_width =3D 32,
>>       .dbck_flag =3D true,
>> +     .is_aggressive_pm =3D false,
>>  };
>>
>>  static const struct omap_gpio_platform_data omap4_pdata =3D {
>>       .regs =3D &omap4_gpio_regs,
>>       .bank_width =3D 32,
>>       .dbck_flag =3D true,
>> +     .is_aggressive_pm =3D true,
>>  };
>>
> Well OMAP IP shouldn't have different behavior on OMAP3 and
> OMAP4 at least so something you can enable for OMAP4, you
> should be able to do it for OMAP3 as well.
>
the am33xx_gpio_sysc.idlemodes is marked as capable of
SMART_WKUP in omap_hwmod_33xx.c. But according to TRM,
only gpio0 is capable of this. So i suspect the patch won't work
for omap3. I don't have the hardware to verify this. Could someone
verify it? Thank you.
> Kevin might have some more concerns to add.
>
> Regards,
> Santosh
>



--=20
Regards,
Chao Xu
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
