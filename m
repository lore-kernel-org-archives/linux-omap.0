From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP3xxx: clockdomain: fix software supervised wakeup/sleep
Date: Fri, 27 Jul 2012 06:38:53 -0700
Message-ID: <87y5m5l3wy.fsf@ti.com>
References: <alpine.DEB.2.00.1207261503290.14468@utopia.booyaka.com>
	<CACYZBRHmO3a3oBwbFP8GqDQj3xB7nB59TkzxAbFrZ2=h0VX3-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:51074 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053Ab2G0Njn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 09:39:43 -0400
Received: by yhpp61 with SMTP id p61so3170348yhp.11
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 06:38:54 -0700 (PDT)
In-Reply-To: <CACYZBRHmO3a3oBwbFP8GqDQj3xB7nB59TkzxAbFrZ2=h0VX3-g@mail.gmail.com>
	(Rajendra Nayak's message of "Fri, 27 Jul 2012 13:28:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jon-hunter@ti.com

"Nayak, Rajendra" <rnayak@ti.com> writes:

> Paul,
>
> On Fri, Jul 27, 2012 at 2:34 AM, Paul Walmsley <paul@pwsan.com> wrote:
>>
>> Commit 4da71ae6 ("OMAP: clockdomain: Arch specific funcs for
>> clkdm_clk_enable/disable") called the OMAP2xxx-specific functions for
>> clockdomain wakeup and sleep.  This would probably have broken
>> software-supervised clockdomain wakeup and sleep on OMAP3.
>
> Would something like this be better than duplicating most of
> omap2_clkdm_clk_enable/disable?

Not when using cpu_is* checks at runtime.  Maybe if you setup function
pointers at init time?

Kevin

> ---
>  arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> Index: linux-2.6/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> 2012-07-27 13:15:49.238134472 +0530
> +++ linux-2.6/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> 2012-07-27 13:22:01.607380032 +0530
> @@ -162,6 +162,27 @@
>                                                 clkdm->clktrctrl_mask);
>  }
>
> +static void _clkdm_sleep(struct clockdomain *clkdm)
> +{
> +       if (cpu_is_omap24xx())
> +               omap2_cm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
> +                                       clkdm->pwrdm.ptr->prcm_offs,
> +                                       OMAP2_PM_PWSTCTRL);
> +       else if (cpu_is_omap34xx())
> +               omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
> +                                       clkdm->clktrctrl_mask);
> +}
> +
> +static void _clkdm_wakeup(struct clockdomain *clkdm)
> +{
> +       if (cpu_is_omap24xx())
> +               omap2_cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
> +                                       clkdm->pwrdm.ptr->prcm_offs,
> +                                       OMAP2_PM_PWSTCTRL);
> +       else if (cpu_is_omap34xx())
> +               omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
> +                                       clkdm->clktrctrl_mask);
> +}
>
>  static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
>  {
> @@ -180,7 +201,7 @@
>                 _enable_hwsup(clkdm);
>         } else {
>                 if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
> -                       omap2_clkdm_wakeup(clkdm);
> +                       _clkdm_wakeup(clkdm);
>         }
>
>         return 0;
> @@ -203,7 +224,7 @@
>                 _enable_hwsup(clkdm);
>         } else {
>                 if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
> -                       omap2_clkdm_sleep(clkdm);
> +                       _clkdm_sleep(clkdm);
>         }
>
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Jon Hunter <jon-hunter@ti.com>
>> ---
>>  arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   50 ++++++++++++++++++++++++++--
>>  1 file changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
>> index a0d68db..f99e65c 100644
>> --- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
>> +++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
>> @@ -241,6 +241,52 @@ static void omap3_clkdm_deny_idle(struct clockdomain *clkdm)
>>                 _clkdm_del_autodeps(clkdm);
>>  }
>>
>> +static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
>> +{
>> +       bool hwsup = false;
>> +
>> +       if (!clkdm->clktrctrl_mask)
>> +               return 0;
>> +
>> +       hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
>> +                               clkdm->clktrctrl_mask);
>> +
>> +       if (hwsup) {
>> +               /* Disable HW transitions when we are changing deps */
>> +               _disable_hwsup(clkdm);
>> +               _clkdm_add_autodeps(clkdm);
>> +               _enable_hwsup(clkdm);
>> +       } else {
>> +               if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
>> +                       omap3_clkdm_wakeup(clkdm);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int omap3xxx_clkdm_clk_disable(struct clockdomain *clkdm)
>> +{
>> +       bool hwsup = false;
>> +
>> +       if (!clkdm->clktrctrl_mask)
>> +               return 0;
>> +
>> +       hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
>> +                               clkdm->clktrctrl_mask);
>> +
>> +       if (hwsup) {
>> +               /* Disable HW transitions when we are changing deps */
>> +               _disable_hwsup(clkdm);
>> +               _clkdm_del_autodeps(clkdm);
>> +               _enable_hwsup(clkdm);
>> +       } else {
>> +               if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
>> +                       omap3_clkdm_sleep(clkdm);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  struct clkdm_ops omap2_clkdm_operations = {
>>         .clkdm_add_wkdep        = omap2_clkdm_add_wkdep,
>>         .clkdm_del_wkdep        = omap2_clkdm_del_wkdep,
>> @@ -267,6 +313,6 @@ struct clkdm_ops omap3_clkdm_operations = {
>>         .clkdm_wakeup           = omap3_clkdm_wakeup,
>>         .clkdm_allow_idle       = omap3_clkdm_allow_idle,
>>         .clkdm_deny_idle        = omap3_clkdm_deny_idle,
>> -       .clkdm_clk_enable       = omap2_clkdm_clk_enable,
>> -       .clkdm_clk_disable      = omap2_clkdm_clk_disable,
>> +       .clkdm_clk_enable       = omap3xxx_clkdm_clk_enable,
>> +       .clkdm_clk_disable      = omap3xxx_clkdm_clk_disable,
>>  };
>> --
>> 1.7.10.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
