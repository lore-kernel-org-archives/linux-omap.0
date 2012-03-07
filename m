From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V2] OMAP3+: PM: VP: fix integer truncation error
Date: Tue, 06 Mar 2012 16:05:27 -0800
Message-ID: <87hay1b7i0.fsf@ti.com>
References: <1331059872-29011-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56394 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031620Ab2CGAFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 19:05:30 -0500
Received: by mail-iy0-f182.google.com with SMTP id k25so10515937iah.13
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 16:05:29 -0800 (PST)
In-Reply-To: <1331059872-29011-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Tue, 6 Mar 2012 12:51:12 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon <jon-hunter@ti.com>, Yuan Jiangli <jlyuan@motorola.com>

Nishanth Menon <nm@ti.com> writes:

> From: Yuan Jiangli <jlyuan@motorola.com>
>
> commit 2f34ce81b8c05c900e45bd88595cc154f7bb5957
> (OMAP3: PM: Adding voltage driver support.)
> introduced runtime computation of waittime to handle all potential
> sys clocks available.
>
> In the voltage processor, the SPMSUpdateWait is calculated based on
> the slew rate and the voltage step (SMPSUpdateWait = slew rate *
> Voltage Step). After the voltage processor receives the SMPS_Ack
> signal, the Voltage Controller will wait for SMPSUpdateWait clock
> cycles for the voltage to settle to the new value. For all
> practical purposes, the waittime parameter is the OMAP hardware
> translation of what the slew rate on the PMIC is.
>
> As an example, with TPS62361 on OMAP4460,
> step_size = 10000
> slew_rate = 32000
> sys_clk_rate = 38400
>
> Our current computation results in the following:
>  = ((step_size / slew_rate) * sys_clk_rate) / 1000
>  = ((10000 / 32000) * 38400 / 1000
>  = 0
>
> Fix the same using DIV_ROUND_UP as an extra wait clock cycle
> is better than lesser clock cycle. For the above example, this
> translates to:
>  = (10000 * 38400) / (1000 * 32000)
>  = 12
>
> Acked-by: Jon Hunter <jon-hunter@ti.com>
> [nm@ti.com: slightly better implementation]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Yuan Jiangli <jlyuan@motorola.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, I don't have any more PM fixes for this cycle, so feel free to add
this to fixes-non-critical-part2.

This is an important fix, but since we're not doing active voltage
scaling in mainline today, I don't think it's 3.3 material.

Kevin

> ---
>  arch/arm/mach-omap2/vp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 0df8882..f95c1ba 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -61,8 +61,8 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
>  	vddmin = voltdm->pmic->vp_vddmin;
>  	vddmax = voltdm->pmic->vp_vddmax;
>  
> -	waittime = ((voltdm->pmic->step_size / voltdm->pmic->slew_rate) *
> -		    sys_clk_rate) / 1000;
> +	waittime = DIV_ROUND_UP(voltdm->pmic->step_size * sys_clk_rate,
> +				1000 * voltdm->pmic->slew_rate);
>  	vstepmin = voltdm->pmic->vp_vstepmin;
>  	vstepmax = voltdm->pmic->vp_vstepmax;
