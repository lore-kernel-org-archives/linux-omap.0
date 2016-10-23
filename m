From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] drivers: gpio: Add support for multiple IPs
Date: Sun, 23 Oct 2016 12:32:21 +0200
Message-ID: <CACRpkdbsgM-yiWpiA5G35jQR8v3FO=Me+4rhe6TzE0qsWOJ8Ew@mail.gmail.com>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com> <1476855239-32730-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476855239-32730-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 19, 2016 at 7:33 AM, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> wrote:

> From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
>
> Update GPIO driver to support Multiple GPIO IPs.
>
> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

This commit message is not at all describing what the patch is doing.

What it does is bumping the GPIO pin offset in the Linux global
GPIO number space with 32 for each new controller.

> +       static int bank_base;
>
>         pdata = davinci_gpio_get_pdata(pdev);
>         if (!pdata) {
> @@ -226,7 +227,8 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>                 chips[i].chip.direction_output = davinci_direction_out;
>                 chips[i].chip.set = davinci_gpio_set;
>
> -               chips[i].chip.base = base;
> +               chips[i].chip.base = bank_base;
> +               bank_base += 32;

Why can you not rewrite the driver to pass -1 as base and
get a dynamic allocation of GPIO numbers instead? Then
you won't have this hairy problem.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
