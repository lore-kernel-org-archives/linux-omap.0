From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH linux-omap-pm/pm-wip/cpufreq] OMAP2PLUS: cpufreq: Fix typo when attempting to set mpu_clk for OMAP4
Date: Tue, 19 Apr 2011 15:50:46 -0700
Message-ID: <87aaflam9l.fsf@ti.com>
References: <1302787318-6650-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:33262 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751626Ab1DSWuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 18:50:51 -0400
Received: by pwj7 with SMTP id 7so141098pwj.40
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 15:50:48 -0700 (PDT)
In-Reply-To: <1302787318-6650-1-git-send-email-jhnikula@gmail.com> (Jarkko
	Nikula's message of "Thu, 14 Apr 2011 16:21:58 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

Jarkko Nikula <jhnikula@gmail.com> writes:

> Fix this typo as there is no dpll_mpu_ck for OMAP3 and code flow is clearly
> trying to set mpu_clk for OMAP4 for which this dpll_mpu_ck is available.
>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Thanks, applied to pm-wip/cpufreq branch.

Kevin

> ---
>  arch/arm/mach-omap2/omap2plus-cpufreq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 8d472f6..d53ce23 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -161,7 +161,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  		mpu_clk = clk_get(NULL, "virt_prcm_set");
>  	else if (cpu_is_omap34xx())
>  		mpu_clk = clk_get(NULL, "dpll1_ck");
> -	else if (cpu_is_omap34xx())
> +	else if (cpu_is_omap44xx())
>  		mpu_clk = clk_get(NULL, "dpll_mpu_ck");
>  
>  	if (IS_ERR(mpu_clk))
