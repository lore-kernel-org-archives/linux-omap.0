From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Tue, 10 Jan 2017 15:08:40 +0100
Message-ID: <CAMuHMdVLbNXx23-wgLHcvktyHxWf6t75ggU3rM5A-DhtU9hn5w@mail.gmail.com>
References: <20161227172003.6517-1-tony@atomide.com> <20161227172003.6517-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161227172003.6517-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tue, Dec 27, 2016 at 6:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> Having the pin control framework call pin controller functions
> before it's probe has finished is not nice as the pin controller
> device driver does not yet have struct pinctrl_dev handle.
>
> Let's fix this issue by adding deferred work for late init. This is
> needed to be able to add pinctrl generic helper functions that expect
> to know struct pinctrl_dev handle. Note that we now need to call
> create_pinctrl() directly as we don't want to add the pin controller
> to the list of controllers until the hogs are claimed. We also need
> to pass the pinctrl_dev to the device tree parser functions as they
> otherwise won't find the right controller at this point.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

I believe this patch causes a regression on r8a7740/armadillo, where the
pin controller is also a GPIO controller, and lcd0 needs a hog
(cfr. arch/arm/boot/dts/r8a7740-armadillo800eva.dts):

-GPIO line 176 (lcd0) hogged as output/high
-sh-pfc e6050000.pfc: r8a7740_pfc handling gpio 0 -> 211
+gpiochip_add_data: GPIOs 0..211 (r8a7740_pfc) failed to register
+sh-pfc e6050000.pfc: failed to init GPIO chip, ignoring...
 sh-pfc e6050000.pfc: r8a7740_pfc support registered

Hence all drivers using GPIOs fail to initialize because their GPIOs never
become available.

Adding debug prints to the failure paths shows that the call to
of_pinctrl_get() in of_gpiochip_add_pin_range() fails with -EPROBE_DEFER.
Adding a debug print to the top of gpiochip_add_data() makes the problem go
away, presumably because it introduces a delay that allows the delayed work
to kick in...

Jon's fix ("pinctrl: core: Fix panic when pinctrl devices with hogs are
unregistered") doesn't help, as it affects unregistration only.

> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c

> @@ -1800,32 +1847,10 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
>                 goto out_err;
>         }
>
> -       mutex_lock(&pinctrldev_list_mutex);
> -       list_add_tail(&pctldev->node, &pinctrldev_list);
> -       mutex_unlock(&pinctrldev_list_mutex);
> -
> -       pctldev->p = pinctrl_get(pctldev->dev);
> -
> -       if (!IS_ERR(pctldev->p)) {
> -               pctldev->hog_default =
> -                       pinctrl_lookup_state(pctldev->p, PINCTRL_STATE_DEFAULT);
> -               if (IS_ERR(pctldev->hog_default)) {
> -                       dev_dbg(dev, "failed to lookup the default state\n");
> -               } else {
> -                       if (pinctrl_select_state(pctldev->p,
> -                                               pctldev->hog_default))
> -                               dev_err(dev,
> -                                       "failed to select default state\n");
> -               }
> -
> -               pctldev->hog_sleep =
> -                       pinctrl_lookup_state(pctldev->p,
> -                                                   PINCTRL_STATE_SLEEP);
> -               if (IS_ERR(pctldev->hog_sleep))
> -                       dev_dbg(dev, "failed to lookup the sleep state\n");
> -       }
> -
> -       pinctrl_init_device_debugfs(pctldev);
> +       if (pinctrl_dt_has_hogs(pctldev))

Changing the above line to "if (0 && pinctrl_dt_has_hogs(pctldev))"
fixes the issue for me.

> +               schedule_delayed_work(&pctldev->late_init, 0);
> +       else
> +               pinctrl_late_init(&pctldev->late_init.work);
>
>         return pctldev;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
