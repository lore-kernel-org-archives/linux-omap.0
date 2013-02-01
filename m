From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH] ARM: OMAP2+: dpll: Add missing soc_is_am33xx() check
Date: Fri, 01 Feb 2013 09:54:27 -0800
Message-ID: <20130201175427.16898.39901@quantum>
References: <1359714424-21167-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59458 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046Ab3BARyo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 12:54:44 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so2365700pab.5
        for <linux-omap@vger.kernel.org>; Fri, 01 Feb 2013 09:54:44 -0800 (PST)
In-Reply-To: <1359714424-21167-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

Quoting AnilKumar Ch (2013-02-01 02:27:04)
> Add missing soc_is_am33xx() check in noncore DPLL set rate function.
> Without this, dpll set_rate function throughs warnings for am33xx
> family of devices.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

I think that only 3430 needs the freqsel calculation.  If this is true,
then I think it would be better to just have a check for cpu_is_3430()
instead of appending new SoCs to the list that do not care about the
freqsel calculation.

Regards,
Mike

> ---
>  arch/arm/mach-omap2/dpll3xxx.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index 0a02aab5..4bb3f78 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -501,7 +501,8 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
>                         return -EINVAL;
>  
>                 /* No freqsel on OMAP4 and OMAP3630 */
> -               if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
> +               if (!cpu_is_omap44xx() && !cpu_is_omap3630() &&
> +                                       !soc_is_am33xx()) {
>                         freqsel = _omap3_dpll_compute_freqsel(clk,
>                                                 dd->last_rounded_n);
>                         WARN_ON(!freqsel);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
