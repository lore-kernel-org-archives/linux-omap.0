From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
Date: Fri, 31 May 2013 12:32:11 -0700
Message-ID: <20130531193211.21525.68958@quantum>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:49214 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab3EaTcW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 15:32:22 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so2697323pbb.24
        for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 12:32:21 -0700 (PDT)
In-Reply-To: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?utf-8?q?Jean-Philippe_Fran=C3=A7ois?= <jp.francois@cynove.com>

Quoting Jean-Philippe Francois (2013-05-30 01:50:27)
> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of=
 the clock
> to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all conce=
rned clock
> have parent defined as clk_divider. Instead of using container_of to =
eventually get
> to the register and directly mess with the divider, change freq via c=
lk_set_rate,=20
> and let the clock framework toggle the divider value.
> Tested with  3.9 on dm3730.
>=20
> Signed-off-by: Jean-Philippe Fran=EF=BF=BD=EF=BF=BDois <jp.francois@c=
ynove.com>

Did you use git-format-patch to create this patch?  Its a bit nicer to
use that or if you just use diff then use "diff -up" or "diff -uprN"
(taken from Documentation/SubmittingPatches.txt).

Also did you test this to make sure it works?  I don't mean a boot test=
,
but actually disabling/re-enabling an HSDIVIDER on 3630?  The previous
code just programmed the clksel field to 1, and this code divides the
rate by 2, then restores it.  I just used that as an example in my
previous email and it needs to be verified that it works (though it
should if I remember this errata correctly).

If that testing is done and everything looks good then please add:

Acked-by: Mike Turquette <mturquette@linaro.org>

>=20
> Index: b/arch/arm/mach-omap2/clock36xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/arm/mach-omap2/clock36xx.c
> +++ b/arch/arm/mach-omap2/clock36xx.c
> @@ -39,30 +39,25 @@
>   */
>  int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
>  {
> -       struct clk_hw_omap *parent;
> -       struct clk_hw *parent_hw;
> -       u32 dummy_v, orig_v, clksel_shift;
>         int ret;
> =20
>         /* Clear PWRDN bit of HSDIVIDER */
>         ret =3D omap2_dflt_clk_enable(clk);
> =20
> -       parent_hw =3D __clk_get_hw(__clk_get_parent(clk->clk));
> -       parent =3D to_clk_hw_omap(parent_hw);
> -
> -       /* Restore the dividers */
> +       /* kick parent's clksel register after toggling PWRDN bit */
>         if (!ret) {
> -               clksel_shift =3D __ffs(parent->clksel_mask);
> -               orig_v =3D __raw_readl(parent->clksel_reg);
> -               dummy_v =3D orig_v;
> -
> -               /* Write any other value different from the Read valu=
e */
> -               dummy_v ^=3D (1 << clksel_shift);
> -               __raw_writel(dummy_v, parent->clksel_reg);
> -
> -               /* Write the original divider */
> -               __raw_writel(orig_v, parent->clksel_reg);
> +               struct clk *parent =3D clk_get_parent(clk->clk);
> +               unsigned long parent_rate =3D clk_get_rate(parent);
> +               ret =3D clk_set_rate(parent, parent_rate/2);
> +               if(ret)
> +                       goto badfreq;
> +               ret =3D clk_set_rate(parent, parent_rate);
> +               if(ret)
> +                       goto badfreq;
>         }
> +       return ret;
> =20
> + badfreq :
> +       omap2_dflt_clk_disable(clk);
>         return ret;
>  }
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
