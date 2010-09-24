From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: CPUFREQ: Fix conditional compilation
Date: Fri, 24 Sep 2010 08:06:01 -0700
Message-ID: <87pqw3ji5i.fsf@deeprootsystems.com>
References: <1285318494-22092-1-git-send-email-silesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49447 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0IXPGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 11:06:03 -0400
Received: by pvg2 with SMTP id 2so683710pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 08:06:03 -0700 (PDT)
In-Reply-To: <1285318494-22092-1-git-send-email-silesh@ti.com> (Silesh C. V.'s
	message of "Fri, 24 Sep 2010 14:24:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Silesh C V <silesh@ti.com>
Cc: linux-omap@vger.kernel.org

Silesh C V <silesh@ti.com> writes:

> Fix conditional compilation.
 
What excatly was the compile error?  and with which compiler?

The current pm branch  seems to compile fine for me.

Kevin

> Signed-off-by: Silesh C V <silesh@ti.com>
> ---
>
> Applies on top of the latest pm branch.
>
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
