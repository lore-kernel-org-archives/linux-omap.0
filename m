From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH linux-omap-pm/pm-wip/cpufreq] OMAP2PLUS: cpufreq: Fix
 typo when attempting to set mpu_clk for OMAP4
Date: Thu, 14 Apr 2011 20:32:50 +0530
Message-ID: <4DA70C9A.7080805@ti.com>
References: <1302787318-6650-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38252 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758719Ab1DNPDM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Apr 2011 11:03:12 -0400
Received: by mail-gx0-f172.google.com with SMTP id 19so1033442gxk.17
        for <linux-omap@vger.kernel.org>; Thu, 14 Apr 2011 08:03:11 -0700 (PDT)
In-Reply-To: <1302787318-6650-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

On 4/14/2011 6:51 PM, Jarkko Nikula wrote:
> Fix this typo as there is no dpll_mpu_ck for OMAP3 and code flow is clearly
> trying to set mpu_clk for OMAP4 for which this dpll_mpu_ck is available.
>
> Signed-off-by: Jarkko Nikula<jhnikula@gmail.com>
> ---
>   arch/arm/mach-omap2/omap2plus-cpufreq.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 8d472f6..d53ce23 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -161,7 +161,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>   		mpu_clk = clk_get(NULL, "virt_prcm_set");
>   	else if (cpu_is_omap34xx())
>   		mpu_clk = clk_get(NULL, "dpll1_ck");
> -	else if (cpu_is_omap34xx())
> +	else if (cpu_is_omap44xx())
My Bad :(
Thanks Jarkko for finding this.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


