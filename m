From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/4] gpio: lp873x: Add support for General Purpose Outputs
Date: Thu, 11 Aug 2016 15:30:54 +0200
Message-ID: <CACRpkdbFHbxcKHC827A1v8q1JPFk8jZsbJEHFpXi1Ddz054Xdw@mail.gmail.com>
References: <1470635218-15951-1-git-send-email-j-keerthy@ti.com> <1470635218-15951-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470635218-15951-4-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 8, 2016 at 7:46 AM, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> wrote:

> Add driver for lp873x PMIC family GPOs. Two GPOs are supported
> and can be configured in Open-drain output or Push-pull output.
>
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

Still looks pretty nice, just thought of some things if
you're anyway working on the code:

> +       return regmap_update_bits(gpio->lp873->regmap, LP873X_REG_GPO_CTRL,
> +                                 BIT(offset * 4), value ? BIT(offset * 4) : 0);
(...)
(...)
> +       return val & BIT(offset * 4);
(...)
> +       regmap_update_bits(gpio->lp873->regmap, LP873X_REG_GPO_CTRL,
> +                          BIT(offset * 4), value ? BIT(offset * 4) : 0);
(...)
> +               return regmap_update_bits(gpio->lp873->regmap,
> +                                         LP873X_REG_GPO_CTRL,
> +                                         BIT(offset * 4 + 2),
> +                                         BIT(offset * 4 + 2));
> +       case LINE_MODE_PUSH_PULL:
> +               return regmap_update_bits(gpio->lp873->regmap,
> +                                         LP873X_REG_GPO_CTRL,
> +                                         BIT(offset * 4 + 2), 0);

This 4 +2 etc business is a bit hard to understand, could you create
a macro with a clever name that makes it more understandable?

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
