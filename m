From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH] ARM : omap3 : fix wrong container_of in clock36xx.c
Date: Wed, 29 May 2013 16:05:16 -0700
Message-ID: <20130529230516.6058.74417@quantum>
References: <CAGGh5h3BNV7fE3jC0KSmA+2K6zKwVyHdeo8AW0gvmhgQsy8ZEg@mail.gmail.com>
 <1368805886-26085-1-git-send-email-jp.francois@cynove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:62464 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966322Ab3E2XFW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 19:05:22 -0400
Received: by mail-pd0-f174.google.com with SMTP id 3so7791006pdj.33
        for <linux-omap@vger.kernel.org>; Wed, 29 May 2013 16:05:21 -0700 (PDT)
In-Reply-To: <1368805886-26085-1-git-send-email-jp.francois@cynove.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?utf-8?q?Jean-Philippe_Fran=C3=A7ois?= <jp.francois@cynove.com>

Quoting Jean-Philippe Francois (2013-05-17 08:51:26)
> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of=
 the clock
> to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all conce=
rned clock
> have parent defined as clk_divider.
> Fix the function to use clk_divider.=20
> Tested with  3.9 on dm3730.
>=20
> Signed-off-by: Jean-Philippe Fran=EF=BF=BD=EF=BF=BDois <jp.francois@c=
ynove.com>
>=20
> Index: b/arch/arm/mach-omap2/clock36xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/arm/mach-omap2/clock36xx.c
> +++ b/arch/arm/mach-omap2/clock36xx.c
> @@ -20,11 +20,12 @@
> =20
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/io.h>
> =20
>  #include "clock.h"
>  #include "clock36xx.h"
> -
> +#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw=
)
> =20
>  /**
>   * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suff=
ering
> @@ -39,29 +40,28 @@
>   */
>  int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
>  {
> -       struct clk_hw_omap *parent;
> +       struct clk_divider *parent;
>         struct clk_hw *parent_hw;
> -       u32 dummy_v, orig_v, clksel_shift;
> +       u32 dummy_v, orig_v;
>         int ret;
> =20
>         /* Clear PWRDN bit of HSDIVIDER */
>         ret =3D omap2_dflt_clk_enable(clk);
> =20
>         parent_hw =3D __clk_get_hw(__clk_get_parent(clk->clk));
> -       parent =3D to_clk_hw_omap(parent_hw);
> +       parent =3D to_clk_divider(parent_hw);

Peaking inside of clock structures was OK back in the legacy clock days=
,
and even if the clocks are the same type (clk_hw_omap), but having omap
code dig into clk-divider structures is pretty gross.

How about reentrantly calling clk_set_rate here to achieve the same
effect?

	/* kick parent's clksel register after toggling PWRDN bit */
	struct clk *parent =3D clk_get_parent(clk->clk);
	unsigned long parent_rate =3D clk_get_rate(parent);
	clk_set_rate(parent, parent_rate/2);
	clk_set_rate(parent, parent_rate);

Regards,
Mike

> =20
>         /* Restore the dividers */
>         if (!ret) {
> -               clksel_shift =3D __ffs(parent->clksel_mask);
> -               orig_v =3D __raw_readl(parent->clksel_reg);
> +               orig_v =3D __raw_readl(parent->reg);
>                 dummy_v =3D orig_v;
> =20
>                 /* Write any other value different from the Read valu=
e */
> -               dummy_v ^=3D (1 << clksel_shift);
> -               __raw_writel(dummy_v, parent->clksel_reg);
> +               dummy_v ^=3D (1 << parent->shift);
> +               __raw_writel(dummy_v, parent->reg);
> =20
>                 /* Write the original divider */
> -               __raw_writel(orig_v, parent->clksel_reg);
> +               __raw_writel(orig_v, parent->reg);
>         }
> =20
>         return ret;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
