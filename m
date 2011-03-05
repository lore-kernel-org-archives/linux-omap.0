From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 5/5] OMAP: GPIO: use PM runtime framework
Date: Sat, 5 Mar 2011 09:40:12 +0430
Message-ID: <AANLkTi=Sd0zJwnx1DHCCOr9ncHv1ZP1EworoJex7NLEK@mail.gmail.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
 <1298890670-5481-6-git-send-email-charu@ti.com> <87mxlabih5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35937 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751323Ab1CEFKz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Mar 2011 00:10:55 -0500
Received: by fxm8 with SMTP id 8so3412590fxm.34
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 21:10:52 -0800 (PST)
In-Reply-To: <87mxlabih5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Hi Kevin,

Thanks for the detailed review.

On Sat, Mar 5, 2011 at 03:29, Kevin Hilman <khilman@ti.com> wrote:
> Charulatha V <charu@ti.com> writes:
>
>> Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get()
>
> Minor: I think you mean _get_sync() and _put()

Yes, thanks for catching it. It was a typo  :-(

>
>> for enabling/disabling the clocks, sysconfig settings instead of usi=
ng
>> clock FW APIs.
>> Note: OMAP16xx & OMAP2 has interface and functional clocks whereas
>> OMAP3&4 has interface and debounce clocks.
>>
>> GPIO driver is modified to use dev_pm_ops instead of sysdev_class.
>> With this approach, gpio_bank_suspend() & gpio_bank_resume()
>> are not part of sys_dev_class.
>>
>> Usage of PM runtime get/put APIs in GPIO driver is as given below:
>> pm_runtime_get_sync():
>> * In the probe before accessing the GPIO registers
>> * at the beginning of omap_gpio_request()
>> =A0 =A0 =A0 -only when one of the gpios is requested on a bank, in w=
hich,
>> =A0 =A0 =A0 =A0no other gpio is being used (when mod_usage becomes n=
on-zero).
>
> When using runtime PM, bank->mod_usage acutally becomes redundant wit=
h
> usage counting already done at the runtime PM level. =A0IOW, checking
> bank->mod_usage is he equivalent of checking pm_runtime_suspended(), =
so
> I think you can totally get rid of bank->mod_usage.

I wish to differ here. bank->mod_usage is filled for each GPIO pin in a=
 bank.
Hence during request/free if pm_runtime_get_sync() is called for each G=
PIO
pin, then the count gets increased for each GPIO pin in a bank. But
gpio_prepare_for_idle/suspend calls pm_runtime_put() only once for
each bank. Hence there will be a count mismatch and hence this will lea=
d
to problems and never a bank will get suspended.

IMO it is required to have bank->mod_usage checks. Please correct
me if I am wrong.

>
> pm_runtime_get* on an already active device is harmless and will just
> increment the runtime PM internal use counting. =A0It does however ha=
ve
> the additional benefit of taking advantage of the runtime PM statisti=
cs
> so using tools like powertop, we will be able to see stats for *all*
> GPIO users, not just the first (and last) ones to use a given bank.
> IMO, This is a big win for PM debug.
>
> More on the implementation of this below...
>
>> * at the beginning of gpio_resume_after_idle()
>> =A0 =A0 =A0 - only if the GPIO bank is under use
>> =A0 =A0 =A0 (and)
>> =A0 =A0 =A0 - if the bank is in non-wkup power domain
>> * at the beginning of gpio_irq_handler()
>> =A0 =A0 =A0 - only if the specific GPIO bank is pm_runtime_suspended=
()
>> * at the beginning of omap_gpio_resume()
>> =A0 =A0 =A0 - only if the GPIO bank is under use
>>
>> pm_runtime_put():
>> * In the probe after completing GPIO register access
>> * at the end of omap_gpio_free()
>> =A0 =A0 =A0 - only when the last used gpio in the gpio bank is
>> =A0 =A0 =A0 =A0 freed (when mod_usage becomes 0).
>> * at the end of gpio_prepare_for_idle()
>> =A0 =A0 =A0 - only if the GPIO bank is under use
>> =A0 =A0 =A0 (and)
>> =A0 =A0 =A0 - if the bank is in non-wkup power domain
>> * at the end of gpio_irq_handler()
>> =A0 =A0 =A0 - only if a corresponding pm_runtime_get_sync() was done
>> =A0 =A0 =A0 =A0 in gpio_irq_handler()
>> * at the end of omap_gpio_suspend()
>> =A0 =A0 =A0 - only if the GPIO bank is under use
>>
>> OMAP GPIO Request/ Free:
>> *During a gpio_request when mod_usage becomes non-zero, the bank
>> =A0registers are configured with init time configurations inorder to
>> =A0make sure that the GPIO init time configurations are not lost if
>> =A0the context was earlier lost when the GPIO bank was not in use.
>>
>> =A0TODO:
>> =A0Cleanup GPIO driver to avoid usage of gpio_bank_count &
>> =A0cpu_is_* checks
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> =A0arch/arm/plat-omap/gpio.c | =A0305 +++++++++++++++++++++++++-----=
---------------
>> =A01 files changed, 167 insertions(+), 138 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>> index 10792b6..908bad2 100644
>> --- a/arch/arm/plat-omap/gpio.c
>> +++ b/arch/arm/plat-omap/gpio.c
>> @@ -177,6 +177,7 @@ struct gpio_bank {
>>
>> =A0static void omap_gpio_save_context(struct gpio_bank *bank);
>> =A0static void omap_gpio_restore_context(struct gpio_bank *bank);
>> +static void omap_gpio_mod_init(struct gpio_bank *bank, int id);
>>
>> =A0/*
>> =A0 * TODO: Cleanup gpio_bank usage as it is having information
>> @@ -1042,8 +1043,28 @@ static int omap_gpio_request(struct gpio_chip=
 *chip, unsigned offset)
>> =A0 =A0 =A0 struct gpio_bank *bank =3D container_of(chip, struct gpi=
o_bank, chip);
>> =A0 =A0 =A0 unsigned long flags;
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If this is the first gpio_request for the bank,
>> + =A0 =A0 =A0* enable the bank module
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (!bank->mod_usage) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct platform_device *pdev =3D to_platfo=
rm_device(bank->dev);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(pm_runtime_get_sync(bank->dev=
) < 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "%s: GP=
IO bank %d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "pm_runtime_get_sync failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __func__, pdev->id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize the gpio bank registers to i=
nit time value */
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_gpio_mod_init(bank, pdev->id);
>> + =A0 =A0 }
>> +
>
> This could all be replaced by:
> =A0 =A0 =A0 =A0if (!pm_runtime_get_sync(bank->dev))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_gpio_mod_init(bank, pdev->id);
>
> since the first 'get' that actually resumes the device will return ze=
ro,
> all the others will return 1.
>
> Actually, even better (and my prefernce) would be to just do the
> _get_sync() for every request as above, but put the omap_gpio_mod_ini=
t()
> in the ->runtime_resume() hook so it gets called whenever the first G=
PIO
> in the bank is activated.

The problem is only about the count mismatch I mentioned above.

>
>
>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>>
>> + =A0 =A0 bank->mod_usage |=3D 1 << offset;
>> +
>
>> =A0 =A0 =A0 /* Set trigger to none. You need to enable the desired t=
rigger with
>> =A0 =A0 =A0 =A0* request_irq() or set_irq_type().
>> =A0 =A0 =A0 =A0*/
>> @@ -1058,22 +1079,7 @@ static int omap_gpio_request(struct gpio_chip=
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
>> - =A0 =A0 }
>
> Where did this code go? =A0I expected it to be moved, but not removed=
 completely.

It is only moved and not removed.
bank->mod_usage |=3D 1 << offset; is done above and the rest is done be=
low.

> This code also belongs in the ->runtime_resume() method so it happens
> when the first GPIO in a bank is activated.

Okay.

>
>> +
>> =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -1106,24 +1112,39 @@ static void omap_gpio_free(struct gpio_chip =
*chip, unsigned offset)
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
>> + =A0 =A0 if (!bank->mod_usage) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D bank->base;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 ctrl;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bank->method =3D=3D METHOD_GPIO_24XX)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP24XX_GPIO_CTR=
L;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (bank->method =3D=3D METHOD_GPIO_4=
4XX)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D OMAP4_GPIO_CTRL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto reset_gpio;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D __raw_readl(reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Module is disabled, clocks are gated */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(ctrl, reg);
>
> And here, rather than updating bank->mod_usage, just move this code
> into a ->runtime_suspend hook which will then be called whenever the
> bank is actually suspended.

Pls see above explanation for bank->mod_usage.

>
>> =A0 =A0 =A0 }
>> +reset_gpio:
>> =A0 =A0 =A0 _reset_gpio(bank, bank->chip.base + offset);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If this is the last gpio to be freed in the bank,
>> + =A0 =A0 =A0* disable the bank module
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (!bank->mod_usage) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(pm_runtime_put(bank->dev) < 0=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct platform_device *pd=
ev =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 to_platform_device(bank->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "%s: GP=
IO bank %d pm_runtime_put "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "failed\n", __func__, pdev->id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> and this can just be a pm_runtime_put(bank->dev)

ditto.

>
>> =A0}
>>
>> =A0/*
>> @@ -1143,10 +1164,17 @@ static void gpio_irq_handler(unsigned int ir=
q, struct irq_desc *desc)
>> =A0 =A0 =A0 struct gpio_bank *bank;
>> =A0 =A0 =A0 u32 retrigger =3D 0;
>> =A0 =A0 =A0 int unmasked =3D 0;
>> + =A0 =A0 int enable_gpio =3D 0;
>>
>> =A0 =A0 =A0 desc->irq_data.chip->irq_ack(&desc->irq_data);
>>
>> =A0 =A0 =A0 bank =3D get_irq_data(irq);
>> +
>> + =A0 =A0 if (pm_runtime_suspended(bank->dev)) {
>
> Why do you need the check here?
>
> If the device is already suspended, and you call _get_sync(), it
> just increments the usecount, and returns.

Yes, you are right. I will remove pm_runtime_suspended() checks
and also the enable_gpio flag.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(pm_runtime_get_sync(bank->dev=
) =3D=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_gpio =3D 1;
>> + =A0 =A0 }
>> +
>> =A0#ifdef CONFIG_ARCH_OMAP1
>> =A0 =A0 =A0 if (bank->method =3D=3D METHOD_MPUIO)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 isr_reg =3D bank->base +
>> @@ -1238,6 +1266,9 @@ static void gpio_irq_handler(unsigned int irq,=
 struct irq_desc *desc)
>> =A0exit:
>> =A0 =A0 =A0 if (!unmasked)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->irq_data.chip->irq_unmask(&desc->i=
rq_data);
>> +
>> + =A0 =A0 if (enable_gpio)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(bank->dev);
>
> Likewise, I think you could just always do a 'put' here without havin=
g
> to have a flag.

Sure, will change this.

>
>> =A0}
>>
>> =A0static void gpio_irq_shutdown(struct irq_data *d)
>> @@ -1742,126 +1773,121 @@ static int __devinit omap_gpio_probe(struc=
t platform_device *pdev)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 pm_runtime_enable(bank->dev);
>> - =A0 =A0 pm_runtime_get_sync(bank->dev);
>> + =A0 =A0 pm_runtime_irq_safe(bank->dev);
>> +
>> + =A0 =A0 if (unlikely(pm_runtime_get_sync(bank->dev) < 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "%s: GPIO bank %d pm_ru=
ntime_get_sync "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed\n"=
, __func__, id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iounmap(bank->base);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>>
>> - =A0 =A0 omap_gpio_mod_init(bank, id);
>> =A0 =A0 =A0 omap_gpio_chip_init(bank);
>> =A0 =A0 =A0 omap_gpio_show_rev(bank);
>>
>> + =A0 =A0 if (unlikely(pm_runtime_put(bank->dev) < 0)) {
>
> use IS_ERR_VALUE() instead of '< 0'

Okay.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "%s: GPIO bank %d pm_ru=
ntime_put "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed\n"=
, __func__, id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iounmap(bank->base);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (!gpio_init_done)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_init_done =3D 1;
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
>> -static int omap_gpio_suspend(struct sys_device *dev, pm_message_t m=
esg)
>> +static int omap_gpio_suspend(struct device *dev)
>> =A0{
>> - =A0 =A0 int i;
>> + =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev);
>> + =A0 =A0 void __iomem *wake_status;
>> + =A0 =A0 void __iomem *wake_clear;
>> + =A0 =A0 void __iomem *wake_set;
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 struct gpio_bank *bank =3D &gpio_bank[pdev->id];
>>
>> - =A0 =A0 if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
>> + =A0 =A0 /* If the gpio bank is not used, do nothing */
>> + =A0 =A0 if (!bank->mod_usage)
>
> =A0 =A0 =A0 =A0if (pm_runtime_suspended(bank-dev))
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> - =A0 =A0 for (i =3D 0; i < gpio_bank_count; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_bank *bank =3D &gpio_bank[i];
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *wake_status;
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *wake_clear;
>> - =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *wake_set;
>> - =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flags;
>> + =A0 =A0 switch (bank->method) {
>> + =A0 =A0 case METHOD_GPIO_1610:
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_status =3D bank->base + OMAP1610_GPIO=
_WAKEUPENABLE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base + OMAP1610_GPIO_=
CLEAR_WAKEUPENA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + OMAP1610_GPIO_SE=
T_WAKEUPENA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case METHOD_GPIO_24XX:
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_status =3D bank->base + OMAP24XX_GPIO=
_WAKE_EN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base + OMAP24XX_GPIO_=
CLEARWKUENA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + OMAP24XX_GPIO_SE=
TWKUENA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case METHOD_GPIO_44XX:
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_status =3D bank->base + OMAP4_GPIO_IR=
QWAKEN0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base + OMAP4_GPIO_IRQ=
WAKEN0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + OMAP4_GPIO_IRQWA=
KEN0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 switch (bank->method) {
>> -#ifdef CONFIG_ARCH_OMAP16XX
>> - =A0 =A0 =A0 =A0 =A0 =A0 case METHOD_GPIO_1610:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_status =3D bank->base=
 + OMAP1610_GPIO_WAKEUPENABLE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base =
+ OMAP1610_GPIO_CLEAR_WAKEUPENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + =
OMAP1610_GPIO_SET_WAKEUPENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>> - =A0 =A0 =A0 =A0 =A0 =A0 case METHOD_GPIO_24XX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_status =3D bank->base=
 + OMAP24XX_GPIO_WAKE_EN;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base =
+ OMAP24XX_GPIO_CLEARWKUENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + =
OMAP24XX_GPIO_SETWKUENA;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> -#ifdef CONFIG_ARCH_OMAP4
>> - =A0 =A0 =A0 =A0 =A0 =A0 case METHOD_GPIO_44XX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_status =3D bank->base=
 + OMAP4_GPIO_IRQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_clear =3D bank->base =
+ OMAP4_GPIO_IRQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_set =3D bank->base + =
OMAP4_GPIO_IRQWAKEN0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> -#endif
>> - =A0 =A0 =A0 =A0 =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 if (strcmp(bank->pwrdm_name, "wkup_pwrdm"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_gpio_save_context(bank);
>
> see comments on patch 2.

I agree.

>
>> - =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->saved_wakeup =3D __raw_readl(wake_st=
atus);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0xffffffff, wake_clear);
>> - =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(bank->suspend_wakeup, wake_se=
t);
>> - =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags)=
;
>> - =A0 =A0 }
>> + =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>> + =A0 =A0 bank->saved_wakeup =3D __raw_readl(wake_status);
>> + =A0 =A0 __raw_writel(0xffffffff, wake_clear);
>> + =A0 =A0 __raw_writel(bank->suspend_wakeup, wake_set);
>> + =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>> +
>> + =A0 =A0 if (unlikely(pm_runtime_put(bank->dev) < 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>>

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
