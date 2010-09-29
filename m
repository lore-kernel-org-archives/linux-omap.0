From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP: PM: CPUFREQ: Fix conditional compilation
Date: Wed, 29 Sep 2010 15:28:28 -0700
Message-ID: <87mxr0rxpv.fsf@deeprootsystems.com>
References: <1285752174-11394-1-git-send-email-silesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:59636 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab0I2W2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 18:28:31 -0400
Received: by pxi10 with SMTP id 10so308900pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 15:28:30 -0700 (PDT)
In-Reply-To: <1285752174-11394-1-git-send-email-silesh@ti.com> (Silesh C. V.'s
	message of "Wed, 29 Sep 2010 14:52:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Silesh C V <silesh@ti.com>
Cc: linux-omap@vger.kernel.org

Silesh C V <silesh@ti.com> writes:

> Fix conditional compilation. A conditional expresiion
> should follow "#elif", in this case #elif clause should
> check whether CONFIG_ARCH_OMAP3 is defined or not
> (ie. defined(CONFIG_ARCH_OMAP3)) rather than checking for
> the value of the macro.
>
> Signed-off-by: Silesh C V <silesh@ti.com>

OK, applied to the pm-cpufreq sub-branch of the PM branch.

Kevin

> ---
>  arch/arm/plat-omap/cpu-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index df08829..02e4865 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -41,7 +41,7 @@ static struct cpufreq_frequency_table *freq_table;
>  
>  #ifdef CONFIG_ARCH_OMAP1
>  #define MPU_CLK		"mpu"
> -#elif CONFIG_ARCH_OMAP3
> +#elif defined(CONFIG_ARCH_OMAP3)
>  #define MPU_CLK		"arm_fck"
>  #else
>  #define MPU_CLK		"virt_prcm_set"
