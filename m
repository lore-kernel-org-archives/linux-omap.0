From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v6 0/3] mfd: tps65217: Add power-button and IRQ support
Date: Wed, 14 Sep 2016 10:37:37 +0200
Message-ID: <CAMuHMdV+bVCQ0_YUp1v3yVgjp3EpNgVGnHYpnESszexGnby8Ug@mail.gmail.com>
References: <20160909084204.26226-1-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160909084204.26226-1-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 9, 2016 at 10:42 AM, Marcin Niestroj
<m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> wrote:
> The following patches add tps65217 power button support and make it usable
> with am335x boards. It was developed and rebased on v4.8-rc5.
>
> Changes v5 -> v6 (suggested by Dmitry):
>  * Use dev_get_regmap() instead of fragile pointer calculations
>  * Keep old formatting for flags as single function argument
>
> Changes v4 -> v5:
>  * Dropped two patches (they were already dropped in v4 resend):
>    * "power_supply: tps65217-charger: Fix NULL deref during property export"
>      (already in mainline)
>    * "power_supply: tps65217-charger: Add support for IRQs" (queued into
>      power-supply's -next branch)
>  * Combine tps65217 and tps65218 power button drivers (as suggested by Dmitry)
>  * Combine device-tree documentation for tps65217 and tps65218 power buttons
>
> Changes v3 -> v4:
>  * Add irq_set_parent() during irq init (suggested by Grygorii)

irq_set_parent() is not exported to modules

ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!

See e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/12801307/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
