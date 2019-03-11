From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] gpio: omap: avoid clang warning
Date: Mon, 11 Mar 2019 10:39:48 +0100
Message-ID: <CAMpxmJXpYtJp5eZfz1uCQfE8yg_uLzQxWNt9wKZ4uMzfckU2TQ@mail.gmail.com>
References: <20190307103348.1591457-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307103348.1591457-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Nick Desaulniers <ndesaulniers@google.com>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

czw., 7 mar 2019 o 11:39 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> clang warns about a tentative array definition in the gpio-omap driver:
>
> drivers/gpio/gpio-omap.c:1282:34: error: tentative array definition assum=
ed to have one element [-Werror]
> static const struct of_device_id omap_gpio_match[];
>
> It's best to just reorder the entire file to avoid forward declarations,
> which lets us use the regular declaration. To do this, the unnecessary
> CONFIG_OF check must also be removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpio/gpio-omap.c | 549 +++++++++++++++++++--------------------
>  1 file changed, 267 insertions(+), 282 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index f4e9921fa966..9d743563f4c1 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1249,196 +1249,63 @@ static int omap_gpio_chip_init(struct gpio_bank =
*bank, struct irq_chip *irqc)
>         return ret;
>  }
>
> -static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context=
);
> -static void omap_gpio_unidle(struct gpio_bank *bank);
> -
> -static int gpio_omap_cpu_notifier(struct notifier_block *nb,
> -                                 unsigned long cmd, void *v)
> +static void omap_gpio_init_context(struct gpio_bank *p)
>  {
> -       struct gpio_bank *bank;
> -       unsigned long flags;
> +       struct omap_gpio_reg_offs *regs =3D p->regs;
> +       void __iomem *base =3D p->base;
>
> -       bank =3D container_of(nb, struct gpio_bank, nb);
> +       p->context.ctrl         =3D readl_relaxed(base + regs->ctrl);
> +       p->context.oe           =3D readl_relaxed(base + regs->direction)=
;
> +       p->context.wake_en      =3D readl_relaxed(base + regs->wkup_en);
> +       p->context.leveldetect0 =3D readl_relaxed(base + regs->leveldetec=
t0);
> +       p->context.leveldetect1 =3D readl_relaxed(base + regs->leveldetec=
t1);
> +       p->context.risingdetect =3D readl_relaxed(base + regs->risingdete=
ct);
> +       p->context.fallingdetect =3D readl_relaxed(base + regs->fallingde=
tect);
> +       p->context.irqenable1   =3D readl_relaxed(base + regs->irqenable)=
;
> +       p->context.irqenable2   =3D readl_relaxed(base + regs->irqenable2=
);
>
> -       raw_spin_lock_irqsave(&bank->lock, flags);
> -       switch (cmd) {
> -       case CPU_CLUSTER_PM_ENTER:
> -               if (bank->is_suspended)
> -                       break;
> -               omap_gpio_idle(bank, true);
> -               break;
> -       case CPU_CLUSTER_PM_ENTER_FAILED:
> -       case CPU_CLUSTER_PM_EXIT:
> -               if (bank->is_suspended)
> -                       break;
> -               omap_gpio_unidle(bank);
> -               break;
> -       }
> -       raw_spin_unlock_irqrestore(&bank->lock, flags);
> +       if (regs->set_dataout && p->regs->clr_dataout)
> +               p->context.dataout =3D readl_relaxed(base + regs->set_dat=
aout);
> +       else
> +               p->context.dataout =3D readl_relaxed(base + regs->dataout=
);
>
> -       return NOTIFY_OK;
> +       p->context_valid =3D true;
>  }
>
> -static const struct of_device_id omap_gpio_match[];
> -
> -static int omap_gpio_probe(struct platform_device *pdev)
> +static void omap_gpio_restore_context(struct gpio_bank *bank)
>  {
> -       struct device *dev =3D &pdev->dev;
> -       struct device_node *node =3D dev->of_node;
> -       const struct of_device_id *match;
> -       const struct omap_gpio_platform_data *pdata;
> -       struct resource *res;
> -       struct gpio_bank *bank;
> -       struct irq_chip *irqc;
> -       int ret;
> -
> -       match =3D of_match_device(of_match_ptr(omap_gpio_match), dev);
> -
> -       pdata =3D match ? match->data : dev_get_platdata(dev);
> -       if (!pdata)
> -               return -EINVAL;
> -
> -       bank =3D devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
> -       if (!bank)
> -               return -ENOMEM;
> -
> -       irqc =3D devm_kzalloc(dev, sizeof(*irqc), GFP_KERNEL);
> -       if (!irqc)
> -               return -ENOMEM;
> -
> -       irqc->irq_startup =3D omap_gpio_irq_startup,
> -       irqc->irq_shutdown =3D omap_gpio_irq_shutdown,
> -       irqc->irq_ack =3D omap_gpio_ack_irq,
> -       irqc->irq_mask =3D omap_gpio_mask_irq,
> -       irqc->irq_unmask =3D omap_gpio_unmask_irq,
> -       irqc->irq_set_type =3D omap_gpio_irq_type,
> -       irqc->irq_set_wake =3D omap_gpio_wake_enable,
> -       irqc->irq_bus_lock =3D omap_gpio_irq_bus_lock,
> -       irqc->irq_bus_sync_unlock =3D gpio_irq_bus_sync_unlock,
> -       irqc->name =3D dev_name(&pdev->dev);
> -       irqc->flags =3D IRQCHIP_MASK_ON_SUSPEND;
> -       irqc->parent_device =3D dev;
> -
> -       bank->irq =3D platform_get_irq(pdev, 0);
> -       if (bank->irq <=3D 0) {
> -               if (!bank->irq)
> -                       bank->irq =3D -ENXIO;
> -               if (bank->irq !=3D -EPROBE_DEFER)
> -                       dev_err(dev,
> -                               "can't get irq resource ret=3D%d\n", bank=
->irq);
> -               return bank->irq;
> -       }
> -
> -       bank->chip.parent =3D dev;
> -       bank->chip.owner =3D THIS_MODULE;
> -       bank->dbck_flag =3D pdata->dbck_flag;
> -       bank->quirks =3D pdata->quirks;
> -       bank->stride =3D pdata->bank_stride;
> -       bank->width =3D pdata->bank_width;
> -       bank->is_mpuio =3D pdata->is_mpuio;
> -       bank->non_wakeup_gpios =3D pdata->non_wakeup_gpios;
> -       bank->regs =3D pdata->regs;
> -#ifdef CONFIG_OF_GPIO
> -       bank->chip.of_node =3D of_node_get(node);
> -#endif
> -
> -       if (node) {
> -               if (!of_property_read_bool(node, "ti,gpio-always-on"))
> -                       bank->loses_context =3D true;
> -       } else {
> -               bank->loses_context =3D pdata->loses_context;
> -
> -               if (bank->loses_context)
> -                       bank->get_context_loss_count =3D
> -                               pdata->get_context_loss_count;
> -       }
> -
> -       if (bank->regs->set_dataout && bank->regs->clr_dataout) {
> -               bank->set_dataout =3D omap_set_gpio_dataout_reg;
> -               bank->set_dataout_multiple =3D omap_set_gpio_dataout_reg_=
multiple;
> -       } else {
> -               bank->set_dataout =3D omap_set_gpio_dataout_mask;
> -               bank->set_dataout_multiple =3D
> -                               omap_set_gpio_dataout_mask_multiple;
> -       }
> -
> -       if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
> -               bank->funcs.idle_enable_level_quirk =3D
> -                       omap2_gpio_enable_level_quirk;
> -               bank->funcs.idle_disable_level_quirk =3D
> -                       omap2_gpio_disable_level_quirk;
> -       }
> -
> -       raw_spin_lock_init(&bank->lock);
> -       raw_spin_lock_init(&bank->wa_lock);
> -
> -       /* Static mapping, never released */
> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       bank->base =3D devm_ioremap_resource(dev, res);
> -       if (IS_ERR(bank->base)) {
> -               return PTR_ERR(bank->base);
> -       }
> -
> -       if (bank->dbck_flag) {
> -               bank->dbck =3D devm_clk_get(dev, "dbclk");
> -               if (IS_ERR(bank->dbck)) {
> -                       dev_err(dev,
> -                               "Could not get gpio dbck. Disable debounc=
e\n");
> -                       bank->dbck_flag =3D false;
> -               } else {
> -                       clk_prepare(bank->dbck);
> -               }
> -       }
> -
> -       platform_set_drvdata(pdev, bank);
> -
> -       pm_runtime_enable(dev);
> -       pm_runtime_get_sync(dev);
> -
> -       if (bank->is_mpuio)
> -               omap_mpuio_init(bank);
> -
> -       omap_gpio_mod_init(bank);
> -
> -       ret =3D omap_gpio_chip_init(bank, irqc);
> -       if (ret) {
> -               pm_runtime_put_sync(dev);
> -               pm_runtime_disable(dev);
> -               if (bank->dbck_flag)
> -                       clk_unprepare(bank->dbck);
> -               return ret;
> -       }
> -
> -       omap_gpio_show_rev(bank);
> +       writel_relaxed(bank->context.wake_en,
> +                               bank->base + bank->regs->wkup_en);
> +       writel_relaxed(bank->context.ctrl, bank->base + bank->regs->ctrl)=
;
> +       writel_relaxed(bank->context.leveldetect0,
> +                               bank->base + bank->regs->leveldetect0);
> +       writel_relaxed(bank->context.leveldetect1,
> +                               bank->base + bank->regs->leveldetect1);
> +       writel_relaxed(bank->context.risingdetect,
> +                               bank->base + bank->regs->risingdetect);
> +       writel_relaxed(bank->context.fallingdetect,
> +                               bank->base + bank->regs->fallingdetect);
> +       if (bank->regs->set_dataout && bank->regs->clr_dataout)
> +               writel_relaxed(bank->context.dataout,
> +                               bank->base + bank->regs->set_dataout);
> +       else
> +               writel_relaxed(bank->context.dataout,
> +                               bank->base + bank->regs->dataout);
> +       writel_relaxed(bank->context.oe, bank->base + bank->regs->directi=
on);
>
> -       if (bank->funcs.idle_enable_level_quirk &&
> -           bank->funcs.idle_disable_level_quirk) {
> -               bank->nb.notifier_call =3D gpio_omap_cpu_notifier;
> -               cpu_pm_register_notifier(&bank->nb);
> +       if (bank->dbck_enable_mask) {
> +               writel_relaxed(bank->context.debounce, bank->base +
> +                                       bank->regs->debounce);
> +               writel_relaxed(bank->context.debounce_en,
> +                                       bank->base + bank->regs->debounce=
_en);
>         }
>
> -       pm_runtime_put(dev);
> -
> -       return 0;
> -}
> -
> -static int omap_gpio_remove(struct platform_device *pdev)
> -{
> -       struct gpio_bank *bank =3D platform_get_drvdata(pdev);
> -
> -       if (bank->nb.notifier_call)
> -               cpu_pm_unregister_notifier(&bank->nb);
> -       list_del(&bank->node);
> -       gpiochip_remove(&bank->chip);
> -       pm_runtime_disable(&pdev->dev);
> -       if (bank->dbck_flag)
> -               clk_unprepare(bank->dbck);
> -
> -       return 0;
> +       writel_relaxed(bank->context.irqenable1,
> +                               bank->base + bank->regs->irqenable);
> +       writel_relaxed(bank->context.irqenable2,
> +                               bank->base + bank->regs->irqenable2);
>  }
>
> -static void omap_gpio_restore_context(struct gpio_bank *bank);
> -
>  static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context=
)
>  {
>         struct device *dev =3D bank->chip.parent;
> @@ -1479,8 +1346,6 @@ static void omap_gpio_idle(struct gpio_bank *bank, =
bool may_lose_context)
>         omap_gpio_dbck_disable(bank);
>  }
>
> -static void omap_gpio_init_context(struct gpio_bank *p);
> -
>  static void omap_gpio_unidle(struct gpio_bank *bank)
>  {
>         struct device *dev =3D bank->chip.parent;
> @@ -1574,113 +1439,33 @@ static void omap_gpio_unidle(struct gpio_bank *b=
ank)
>         bank->workaround_enabled =3D false;
>  }
>
> -static void omap_gpio_init_context(struct gpio_bank *p)
> +static int gpio_omap_cpu_notifier(struct notifier_block *nb,
> +                                 unsigned long cmd, void *v)
>  {
> -       struct omap_gpio_reg_offs *regs =3D p->regs;
> -       void __iomem *base =3D p->base;
> +       struct gpio_bank *bank;
> +       unsigned long flags;
>
> -       p->context.ctrl         =3D readl_relaxed(base + regs->ctrl);
> -       p->context.oe           =3D readl_relaxed(base + regs->direction)=
;
> -       p->context.wake_en      =3D readl_relaxed(base + regs->wkup_en);
> -       p->context.leveldetect0 =3D readl_relaxed(base + regs->leveldetec=
t0);
> -       p->context.leveldetect1 =3D readl_relaxed(base + regs->leveldetec=
t1);
> -       p->context.risingdetect =3D readl_relaxed(base + regs->risingdete=
ct);
> -       p->context.fallingdetect =3D readl_relaxed(base + regs->fallingde=
tect);
> -       p->context.irqenable1   =3D readl_relaxed(base + regs->irqenable)=
;
> -       p->context.irqenable2   =3D readl_relaxed(base + regs->irqenable2=
);
> +       bank =3D container_of(nb, struct gpio_bank, nb);
>
> -       if (regs->set_dataout && p->regs->clr_dataout)
> -               p->context.dataout =3D readl_relaxed(base + regs->set_dat=
aout);
> -       else
> -               p->context.dataout =3D readl_relaxed(base + regs->dataout=
);
> +       raw_spin_lock_irqsave(&bank->lock, flags);
> +       switch (cmd) {
> +       case CPU_CLUSTER_PM_ENTER:
> +               if (bank->is_suspended)
> +                       break;
> +               omap_gpio_idle(bank, true);
> +               break;
> +       case CPU_CLUSTER_PM_ENTER_FAILED:
> +       case CPU_CLUSTER_PM_EXIT:
> +               if (bank->is_suspended)
> +                       break;
> +               omap_gpio_unidle(bank);
> +               break;
> +       }
> +       raw_spin_unlock_irqrestore(&bank->lock, flags);
>
> -       p->context_valid =3D true;
> -}
> -
> -static void omap_gpio_restore_context(struct gpio_bank *bank)
> -{
> -       writel_relaxed(bank->context.wake_en,
> -                               bank->base + bank->regs->wkup_en);
> -       writel_relaxed(bank->context.ctrl, bank->base + bank->regs->ctrl)=
;
> -       writel_relaxed(bank->context.leveldetect0,
> -                               bank->base + bank->regs->leveldetect0);
> -       writel_relaxed(bank->context.leveldetect1,
> -                               bank->base + bank->regs->leveldetect1);
> -       writel_relaxed(bank->context.risingdetect,
> -                               bank->base + bank->regs->risingdetect);
> -       writel_relaxed(bank->context.fallingdetect,
> -                               bank->base + bank->regs->fallingdetect);
> -       if (bank->regs->set_dataout && bank->regs->clr_dataout)
> -               writel_relaxed(bank->context.dataout,
> -                               bank->base + bank->regs->set_dataout);
> -       else
> -               writel_relaxed(bank->context.dataout,
> -                               bank->base + bank->regs->dataout);
> -       writel_relaxed(bank->context.oe, bank->base + bank->regs->directi=
on);
> -
> -       if (bank->dbck_enable_mask) {
> -               writel_relaxed(bank->context.debounce, bank->base +
> -                                       bank->regs->debounce);
> -               writel_relaxed(bank->context.debounce_en,
> -                                       bank->base + bank->regs->debounce=
_en);
> -       }
> -
> -       writel_relaxed(bank->context.irqenable1,
> -                               bank->base + bank->regs->irqenable);
> -       writel_relaxed(bank->context.irqenable2,
> -                               bank->base + bank->regs->irqenable2);
> -}
> -
> -static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
> -{
> -       struct gpio_bank *bank =3D dev_get_drvdata(dev);
> -       unsigned long flags;
> -       int error =3D 0;
> -
> -       raw_spin_lock_irqsave(&bank->lock, flags);
> -       /* Must be idled only by CPU_CLUSTER_PM_ENTER? */
> -       if (bank->irq_usage) {
> -               error =3D -EBUSY;
> -               goto unlock;
> -       }
> -       omap_gpio_idle(bank, true);
> -       bank->is_suspended =3D true;
> -unlock:
> -       raw_spin_unlock_irqrestore(&bank->lock, flags);
> -
> -       return error;
> -}
> -
> -static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
> -{
> -       struct gpio_bank *bank =3D dev_get_drvdata(dev);
> -       unsigned long flags;
> -       int error =3D 0;
> -
> -       raw_spin_lock_irqsave(&bank->lock, flags);
> -       /* Must be unidled only by CPU_CLUSTER_PM_ENTER? */
> -       if (bank->irq_usage) {
> -               error =3D -EBUSY;
> -               goto unlock;
> -       }
> -       omap_gpio_unidle(bank);
> -       bank->is_suspended =3D false;
> -unlock:
> -       raw_spin_unlock_irqrestore(&bank->lock, flags);
> -
> -       return error;
> +       return NOTIFY_OK;
>  }
>
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -static const struct dev_pm_ops gpio_pm_ops =3D {
> -       SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_r=
esume,
> -                                                                       N=
ULL)
> -};
> -#else
> -static const struct dev_pm_ops gpio_pm_ops;
> -#endif /* CONFIG_ARCH_OMAP2PLUS */
> -
> -#if defined(CONFIG_OF)
>  static struct omap_gpio_reg_offs omap2_gpio_regs =3D {
>         .revision =3D             OMAP24XX_GPIO_REVISION,
>         .direction =3D            OMAP24XX_GPIO_OE,
> @@ -1768,15 +1553,215 @@ static const struct of_device_id omap_gpio_match=
[] =3D {
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, omap_gpio_match);
> +
> +static int omap_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *node =3D dev->of_node;
> +       const struct of_device_id *match;
> +       const struct omap_gpio_platform_data *pdata;
> +       struct resource *res;
> +       struct gpio_bank *bank;
> +       struct irq_chip *irqc;
> +       int ret;
> +
> +       match =3D of_match_device(of_match_ptr(omap_gpio_match), dev);
> +
> +       pdata =3D match ? match->data : dev_get_platdata(dev);
> +       if (!pdata)
> +               return -EINVAL;
> +
> +       bank =3D devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
> +       if (!bank)
> +               return -ENOMEM;
> +
> +       irqc =3D devm_kzalloc(dev, sizeof(*irqc), GFP_KERNEL);
> +       if (!irqc)
> +               return -ENOMEM;
> +
> +       irqc->irq_startup =3D omap_gpio_irq_startup,
> +       irqc->irq_shutdown =3D omap_gpio_irq_shutdown,
> +       irqc->irq_ack =3D omap_gpio_ack_irq,
> +       irqc->irq_mask =3D omap_gpio_mask_irq,
> +       irqc->irq_unmask =3D omap_gpio_unmask_irq,
> +       irqc->irq_set_type =3D omap_gpio_irq_type,
> +       irqc->irq_set_wake =3D omap_gpio_wake_enable,
> +       irqc->irq_bus_lock =3D omap_gpio_irq_bus_lock,
> +       irqc->irq_bus_sync_unlock =3D gpio_irq_bus_sync_unlock,
> +       irqc->name =3D dev_name(&pdev->dev);
> +       irqc->flags =3D IRQCHIP_MASK_ON_SUSPEND;
> +       irqc->parent_device =3D dev;
> +
> +       bank->irq =3D platform_get_irq(pdev, 0);
> +       if (bank->irq <=3D 0) {
> +               if (!bank->irq)
> +                       bank->irq =3D -ENXIO;
> +               if (bank->irq !=3D -EPROBE_DEFER)
> +                       dev_err(dev,
> +                               "can't get irq resource ret=3D%d\n", bank=
->irq);
> +               return bank->irq;
> +       }
> +
> +       bank->chip.parent =3D dev;
> +       bank->chip.owner =3D THIS_MODULE;
> +       bank->dbck_flag =3D pdata->dbck_flag;
> +       bank->quirks =3D pdata->quirks;
> +       bank->stride =3D pdata->bank_stride;
> +       bank->width =3D pdata->bank_width;
> +       bank->is_mpuio =3D pdata->is_mpuio;
> +       bank->non_wakeup_gpios =3D pdata->non_wakeup_gpios;
> +       bank->regs =3D pdata->regs;
> +#ifdef CONFIG_OF_GPIO
> +       bank->chip.of_node =3D of_node_get(node);
>  #endif
>
> +       if (node) {
> +               if (!of_property_read_bool(node, "ti,gpio-always-on"))
> +                       bank->loses_context =3D true;
> +       } else {
> +               bank->loses_context =3D pdata->loses_context;
> +
> +               if (bank->loses_context)
> +                       bank->get_context_loss_count =3D
> +                               pdata->get_context_loss_count;
> +       }
> +
> +       if (bank->regs->set_dataout && bank->regs->clr_dataout) {
> +               bank->set_dataout =3D omap_set_gpio_dataout_reg;
> +               bank->set_dataout_multiple =3D omap_set_gpio_dataout_reg_=
multiple;
> +       } else {
> +               bank->set_dataout =3D omap_set_gpio_dataout_mask;
> +               bank->set_dataout_multiple =3D
> +                               omap_set_gpio_dataout_mask_multiple;
> +       }
> +
> +       if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
> +               bank->funcs.idle_enable_level_quirk =3D
> +                       omap2_gpio_enable_level_quirk;
> +               bank->funcs.idle_disable_level_quirk =3D
> +                       omap2_gpio_disable_level_quirk;
> +       }
> +
> +       raw_spin_lock_init(&bank->lock);
> +       raw_spin_lock_init(&bank->wa_lock);
> +
> +       /* Static mapping, never released */
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       bank->base =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(bank->base)) {
> +               return PTR_ERR(bank->base);
> +       }
> +
> +       if (bank->dbck_flag) {
> +               bank->dbck =3D devm_clk_get(dev, "dbclk");
> +               if (IS_ERR(bank->dbck)) {
> +                       dev_err(dev,
> +                               "Could not get gpio dbck. Disable debounc=
e\n");
> +                       bank->dbck_flag =3D false;
> +               } else {
> +                       clk_prepare(bank->dbck);
> +               }
> +       }
> +
> +       platform_set_drvdata(pdev, bank);
> +
> +       pm_runtime_enable(dev);
> +       pm_runtime_get_sync(dev);
> +
> +       if (bank->is_mpuio)
> +               omap_mpuio_init(bank);
> +
> +       omap_gpio_mod_init(bank);
> +
> +       ret =3D omap_gpio_chip_init(bank, irqc);
> +       if (ret) {
> +               pm_runtime_put_sync(dev);
> +               pm_runtime_disable(dev);
> +               if (bank->dbck_flag)
> +                       clk_unprepare(bank->dbck);
> +               return ret;
> +       }
> +
> +       omap_gpio_show_rev(bank);
> +
> +       if (bank->funcs.idle_enable_level_quirk &&
> +           bank->funcs.idle_disable_level_quirk) {
> +               bank->nb.notifier_call =3D gpio_omap_cpu_notifier;
> +               cpu_pm_register_notifier(&bank->nb);
> +       }
> +
> +       pm_runtime_put(dev);
> +
> +       return 0;
> +}
> +
> +static int omap_gpio_remove(struct platform_device *pdev)
> +{
> +       struct gpio_bank *bank =3D platform_get_drvdata(pdev);
> +
> +       if (bank->nb.notifier_call)
> +               cpu_pm_unregister_notifier(&bank->nb);
> +       list_del(&bank->node);
> +       gpiochip_remove(&bank->chip);
> +       pm_runtime_disable(&pdev->dev);
> +       if (bank->dbck_flag)
> +               clk_unprepare(bank->dbck);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
> +{
> +       struct gpio_bank *bank =3D dev_get_drvdata(dev);
> +       unsigned long flags;
> +       int error =3D 0;
> +
> +       raw_spin_lock_irqsave(&bank->lock, flags);
> +       /* Must be idled only by CPU_CLUSTER_PM_ENTER? */
> +       if (bank->irq_usage) {
> +               error =3D -EBUSY;
> +               goto unlock;
> +       }
> +       omap_gpio_idle(bank, true);
> +       bank->is_suspended =3D true;
> +unlock:
> +       raw_spin_unlock_irqrestore(&bank->lock, flags);
> +
> +       return error;
> +}
> +
> +static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
> +{
> +       struct gpio_bank *bank =3D dev_get_drvdata(dev);
> +       unsigned long flags;
> +       int error =3D 0;
> +
> +       raw_spin_lock_irqsave(&bank->lock, flags);
> +       /* Must be unidled only by CPU_CLUSTER_PM_ENTER? */
> +       if (bank->irq_usage) {
> +               error =3D -EBUSY;
> +               goto unlock;
> +       }
> +       omap_gpio_unidle(bank);
> +       bank->is_suspended =3D false;
> +unlock:
> +       raw_spin_unlock_irqrestore(&bank->lock, flags);
> +
> +       return error;
> +}
> +
> +static const struct dev_pm_ops gpio_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_r=
esume,
> +                                                                       N=
ULL)
> +};
> +
>  static struct platform_driver omap_gpio_driver =3D {
>         .probe          =3D omap_gpio_probe,
>         .remove         =3D omap_gpio_remove,
>         .driver         =3D {
>                 .name   =3D "omap_gpio",
>                 .pm     =3D &gpio_pm_ops,
> -               .of_match_table =3D of_match_ptr(omap_gpio_match),
> +               .of_match_table =3D omap_gpio_match,

This doesn't seem like a logical part of this commit. Can you send a
separate patch?

Other than that, looks good to me.

Bart

>         },
>  };
>
> --
> 2.20.0
>
