From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
Date: Wed, 7 Sep 2011 10:34:43 +0530
Message-ID: <CAC83Zv+sX1G4saFsU=bOUYjedcM6eYEOCVMKqMZ-5pxkBc6x2A@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87ehztxmcg.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

[...]
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If this is the first gpio_request for the bank,
>> + =A0 =A0 =A0* enable the bank module.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (!bank->mod_usage)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev=
) < 0)) {
>
> All of the IS_ERR_VALUE() usage is wrong here. =A0You're checking if the
> result of IS_ERR_VALUE() is < 0 which will never happen.
No.
IS_ERR_VALUE is applied on the return value of pm_runtime_get_sync
which is <  0.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "%s: GPIO b=
ank %d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "pm_runtime_get_sync failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __func__, bank->id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->=
lock, flags);
>
> Rather than take the lock and have to unlock it here, just move the
> get_sync before the spinlock. =A0There's no reason to hold the spinlock
> across the get_sync.
>
> In fact, holding the spinlock across a get sync means that the
> ->runtime_resume callback does not have proper locking around register
> access, which is also probably wrong.
>
> The locking in this driver is only around device register accesses, and
> should be kept minimal and to very small critical sections.
You are right! I will move *_get_sync() outside spinlock.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 /* Set trigger to none. You need to enable the desired trigg=
er with
>> =A0 =A0 =A0 =A0* request_irq() or set_irq_type().
>> =A0 =A0 =A0 =A0*/
>> @@ -530,6 +545,19 @@ static void omap_gpio_free(struct gpio_chip *chip, =
unsigned offset)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 _reset_gpio(bank, bank->chip.base + offset);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If this is the last gpio to be freed in the bank,
>> + =A0 =A0 =A0* disable the bank module.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (!bank->mod_usage) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev=
) < 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev, "%s: GPIO b=
ank %d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "pm_runtime_put_sync failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 __func__, bank->id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>
> same here, this should be after unlocking the spinlock, and register
> accesses inside the ->runtime_resume() callback need their own
> protection.
Ok.

>
>> =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags);
>> =A0}
>>
>> @@ -556,6 +584,7 @@ static void gpio_irq_handler(unsigned int irq, struc=
t irq_desc *desc)
>>
>> =A0 =A0 =A0 bank =3D irq_get_handler_data(irq);
>> =A0 =A0 =A0 isr_reg =3D bank->base + bank->regs->irqstatus;
>> + =A0 =A0 pm_runtime_get_sync(bank->dev);
>>
>> =A0 =A0 =A0 if (WARN_ON(!isr_reg))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
>> @@ -617,6 +646,7 @@ static void gpio_irq_handler(unsigned int irq, struc=
t irq_desc *desc)
>> =A0exit:
>> =A0 =A0 =A0 if (!unmasked)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 chained_irq_exit(chip, desc);
>> + =A0 =A0 pm_runtime_put_sync_suspend(bank->dev);
>
> Why use _put_sync_suspend()?
>
> Why does this need to be synchronous? =A0I think it should use the
> asynchronous pm_runtime_put().
I will change it to pm_runtime_put().

>
[...]
>>
>> @@ -1258,10 +1310,16 @@ static void omap_gpio_restore_context(struct gpi=
o_bank *bank)
>> =A0}
>> =A0#endif
>>
>> +static const struct dev_pm_ops gpio_pm_ops =3D {
>> + =A0 =A0 .suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D omap_gpio_suspend,
>> + =A0 =A0 .resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D omap_gpio_resume,
>> +};
>
> Please use SET_SYSTEM_SLEEP_PM_OPS(). =A0See <linux/pm.h>
Ok.

>
>> =A0static struct platform_driver omap_gpio_driver =3D {
>> =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_gpio_probe,
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap_gpio",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &gpio_pm_ops,
>> =A0 =A0 =A0 },
>> =A0};
>>
>> @@ -1275,16 +1333,3 @@ static int __init omap_gpio_drv_reg(void)
>> =A0 =A0 =A0 return platform_driver_register(&omap_gpio_driver);
>> =A0}
>> =A0postcore_initcall(omap_gpio_drv_reg);
>> -
>> -static int __init omap_gpio_sysinit(void)
>> -{
>> -
>> -#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
>> - =A0 =A0 if (cpu_is_omap16xx() || cpu_class_is_omap2())
>> - =A0 =A0 =A0 =A0 =A0 =A0 register_syscore_ops(&omap_gpio_syscore_ops);
>> -#endif
>> -
>> - =A0 =A0 return 0;
>> -}
>> -
>> -arch_initcall(omap_gpio_sysinit);
>
> Kevin
>
