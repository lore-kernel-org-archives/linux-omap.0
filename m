From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3] clk: ti: omap36xx: Work around sprz319 advisory 2.1
Date: Fri, 02 Dec 2016 14:41:29 -0800
Message-ID: <148071848900.32158.18280759674771820548@resonance>
References: <1480713278-6884-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1480713278-6884-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-clk-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
Cc: linux-clk@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Richard Watts <rrw@kynesim.co.uk>, Tony Lindgren <tony@atomide.com>, Alexander Kinzer <a.kinzer@plusoptix.de>
List-Id: linux-omap@vger.kernel.org

Quoting Laurent Pinchart (2016-12-02 13:14:38)
> From: Richard Watts <rrw@kynesim.co.uk>
> =

> The OMAP36xx DPLL5, driving EHCI USB, can be subject to a long-term
> frequency drift. The frequency drift magnitude depends on the VCO update
> rate, which is inversely proportional to the PLL divider. The kernel
> DPLL configuration code results in a high value for the divider, leading
> to a long term drift high enough to cause USB transmission errors. In
> the worst case the USB PHY's ULPI interface can stop responding,
> breaking USB operation completely. This manifests itself on the
> Beagleboard xM by the LAN9514 reporting 'Cannot enable port 2. Maybe the
> cable is bad?' in the kernel log.
> =

> Errata sprz319 advisory 2.1 documents PLL values that minimize the
> drift. Use them automatically when DPLL5 is used for USB operation,
> which we detect based on the requested clock rate. The clock framework
> will still compute the PLL parameters and resulting rate as usual, but
> the PLL M and N values will then be overridden. This can result in the
> effective clock rate being slightly different than the rate cached by
> the clock framework, but won't cause any adverse effect to USB
> operation.
> =

> Signed-off-by: Richard Watts <rrw@kynesim.co.uk>
> [Upported from v3.2 to v4.9]
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v2:
> =

> - Added spaces around +
> ---
>  drivers/clk/ti/clk-3xxx.c | 20 +++++++-------
>  drivers/clk/ti/clock.h    |  9 +++++++
>  drivers/clk/ti/dpll.c     | 19 +++++++++++++-
>  drivers/clk/ti/dpll3xxx.c | 67 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 104 insertions(+), 11 deletions(-)
> =

> diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
> index 8831e1a05367..11d8aa3ec186 100644
> --- a/drivers/clk/ti/clk-3xxx.c
> +++ b/drivers/clk/ti/clk-3xxx.c
> @@ -22,13 +22,6 @@
>  =

>  #include "clock.h"
>  =

> -/*
> - * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
> - * that are sourced by DPLL5, and both of these require this clock
> - * to be at 120 MHz for proper operation.
> - */
> -#define DPLL5_FREQ_FOR_USBHOST         120000000
> -
>  #define OMAP3430ES2_ST_DSS_IDLE_SHIFT                  1
>  #define OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT             5
>  #define OMAP3430ES2_ST_SSI_IDLE_SHIFT                  8
> @@ -546,14 +539,21 @@ void __init omap3_clk_lock_dpll5(void)
>         struct clk *dpll5_clk;
>         struct clk *dpll5_m2_clk;
>  =

> +       /*
> +        * Errata sprz319f advisory 2.1 documents a USB host clock drift =
issue
> +        * that can be worked around using specially crafted dpll5 settin=
gs
> +        * with a dpll5_m2 divider set to 8. Set the dpll5 rate to 8x the=
 USB
> +        * host clock rate, its .set_rate handler() will detect that freq=
uency
> +        * and use the errata settings.
> +        */
>         dpll5_clk =3D clk_get(NULL, "dpll5_ck");
> -       clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
> +       clk_set_rate(dpll5_clk, OMAP3_DPLL5_FREQ_FOR_USBHOST * 8);
>         clk_prepare_enable(dpll5_clk);
>  =

> -       /* Program dpll5_m2_clk divider for no division */
> +       /* Program dpll5_m2_clk divider */
>         dpll5_m2_clk =3D clk_get(NULL, "dpll5_m2_ck");
>         clk_prepare_enable(dpll5_m2_clk);
> -       clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
> +       clk_set_rate(dpll5_m2_clk, OMAP3_DPLL5_FREQ_FOR_USBHOST);
>  =

>         clk_disable_unprepare(dpll5_m2_clk);
>         clk_disable_unprepare(dpll5_clk);
> diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
> index 90f3f472ae1c..13c37f48d9d6 100644
> --- a/drivers/clk/ti/clock.h
> +++ b/drivers/clk/ti/clock.h
> @@ -257,11 +257,20 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsig=
ned long target_rate,
>  unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
>                                     unsigned long parent_rate);
>  =

> +/*
> + * OMAP3_DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
> + * that are sourced by DPLL5, and both of these require this clock
> + * to be at 120 MHz for proper operation.
> + */
> +#define OMAP3_DPLL5_FREQ_FOR_USBHOST   120000000
> +
>  unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_=
rate);
>  int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
>                          unsigned long parent_rate);
>  int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rat=
e,
>                                     unsigned long parent_rate, u8 index);
> +int omap3_dpll5_set_rate(struct clk_hw *hw, unsigned long rate,
> +                        unsigned long parent_rate);
>  void omap3_clk_lock_dpll5(void);
>  =

>  unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> index 9fc8754a6e61..4b9a419d8e14 100644
> --- a/drivers/clk/ti/dpll.c
> +++ b/drivers/clk/ti/dpll.c
> @@ -114,6 +114,18 @@ static const struct clk_ops omap3_dpll_ck_ops =3D {
>         .round_rate     =3D &omap2_dpll_round_rate,
>  };
>  =

> +static const struct clk_ops omap3_dpll5_ck_ops =3D {
> +       .enable         =3D &omap3_noncore_dpll_enable,
> +       .disable        =3D &omap3_noncore_dpll_disable,
> +       .get_parent     =3D &omap2_init_dpll_parent,
> +       .recalc_rate    =3D &omap3_dpll_recalc,
> +       .set_rate       =3D &omap3_dpll5_set_rate,
> +       .set_parent     =3D &omap3_noncore_dpll_set_parent,
> +       .set_rate_and_parent    =3D &omap3_noncore_dpll_set_rate_and_pare=
nt,
> +       .determine_rate =3D &omap3_noncore_dpll_determine_rate,
> +       .round_rate     =3D &omap2_dpll_round_rate,
> +};
> +
>  static const struct clk_ops omap3_dpll_per_ck_ops =3D {
>         .enable         =3D &omap3_noncore_dpll_enable,
>         .disable        =3D &omap3_noncore_dpll_disable,
> @@ -474,7 +486,12 @@ static void __init of_ti_omap3_dpll_setup(struct dev=
ice_node *node)
>                 .modes =3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCK=
ED),
>         };
>  =

> -       of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd);
> +       if ((of_machine_is_compatible("ti,omap3630") ||
> +            of_machine_is_compatible("ti,omap36xx")) &&
> +           !strcmp(node->name, "dpll5_ck"))
> +               of_ti_dpll_setup(node, &omap3_dpll5_ck_ops, &dd);
> +       else
> +               of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd);
>  }
>  CLK_OF_DECLARE(ti_omap3_dpll_clock, "ti,omap3-dpll-clock",
>                of_ti_omap3_dpll_setup);
> diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
> index 88f2ce81ba55..4cdd28a25584 100644
> --- a/drivers/clk/ti/dpll3xxx.c
> +++ b/drivers/clk/ti/dpll3xxx.c
> @@ -838,3 +838,70 @@ int omap3_dpll4_set_rate_and_parent(struct clk_hw *h=
w, unsigned long rate,
>         return omap3_noncore_dpll_set_rate_and_parent(hw, rate, parent_ra=
te,
>                                                       index);
>  }
> +
> +/* Apply DM3730 errata sprz319 advisory 2.1. */
> +static bool omap3_dpll5_apply_errata(struct clk_hw *hw,
> +                                    unsigned long parent_rate)
> +{
> +       struct omap3_dpll5_settings {
> +               unsigned int rate, m, n;
> +       };
> +
> +       static const struct omap3_dpll5_settings precomputed[] =3D {
> +               /*
> +                * From DM3730 errata advisory 2.1, table 35 and 36.
> +                * The N value is increased by 1 compared to the tables a=
s the
> +                * errata lists register values while last_rounded_field =
is the
> +                * real divider value.
> +                */
> +               { 12000000,  80,  0 + 1 },
> +               { 13000000, 443,  5 + 1 },
> +               { 19200000,  50,  0 + 1 },
> +               { 26000000, 443, 11 + 1 },
> +               { 38400000,  25,  0 + 1 }
> +       };
> +
> +       const struct omap3_dpll5_settings *d;
> +       struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
> +       struct dpll_data *dd;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(precomputed); ++i) {
> +               if (parent_rate =3D=3D precomputed[i].rate)
> +                       break;
> +       }
> +
> +       if (i =3D=3D ARRAY_SIZE(precomputed))
> +               return false;
> +
> +       d =3D &precomputed[i];
> +
> +       /* Update the M, N and rounded rate values and program the DPLL. =
*/
> +       dd =3D clk->dpll_data;
> +       dd->last_rounded_m =3D d->m;
> +       dd->last_rounded_n =3D d->n;
> +       dd->last_rounded_rate =3D div_u64((u64)parent_rate * d->m, d->n);
> +       omap3_noncore_dpll_program(clk, 0);
> +
> +       return true;
> +}
> +
> +/**
> + * omap3_dpll5_set_rate - set rate for omap3 dpll5
> + * @hw: clock to change
> + * @rate: target rate for clock
> + * @parent_rate: rate of the parent clock
> + *
> + * Set rate for the DPLL5 clock. Apply the sprz319 advisory 2.1 on OMAP3=
6xx if
> + * the DPLL is used for USB host (detected through the requested rate).
> + */
> +int omap3_dpll5_set_rate(struct clk_hw *hw, unsigned long rate,
> +                        unsigned long parent_rate)
> +{
> +       if (rate =3D=3D OMAP3_DPLL5_FREQ_FOR_USBHOST * 8) {
> +               if (omap3_dpll5_apply_errata(hw, parent_rate))
> +                       return 0;
> +       }
> +
> +       return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);

Looks OK to me. This part is a bit sketchy, relying on the requested
rate to determine whether or not to deal with the drift, but errata are
often a sketchy affair.

Regards,
Mike

> +}
> -- =

> Regards,
> =

> Laurent Pinchart
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
