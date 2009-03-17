From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP3: PM: Remove double assignments of mpu_pd, core_pd
Date: Tue, 17 Mar 2009 07:53:35 -0700
Message-ID: <87zlfkfbf4.fsf@deeprootsystems.com>
References: <4d34a0a70903170025y9256732xff9b811fa803f2b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:24240 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbZCQOxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 10:53:41 -0400
Received: by yw-out-2324.google.com with SMTP id 3so19716ywj.1
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 07:53:38 -0700 (PDT)
In-Reply-To: <4d34a0a70903170025y9256732xff9b811fa803f2b0@mail.gmail.com> (Kim Kyuwon's message of "Tue\, 17 Mar 2009 16\:25\:44 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, q1.kim@samsung.com, Jouni Hogander <jouni.hogander@nokia.com>, kyungmin.park@samsung.com

Kim Kyuwon <chammoru@gmail.com> writes:

> mpu_pd, core_pd is already assigned at the beginning of the
> omap3_idle_init() function.
>
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index 5e50c46..630108c 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -272,8 +272,6 @@ int omap3_idle_init(void)
>  		       __func__);
>  		return -EIO;
>  	}
> -	mpu_pd = pwrdm_lookup("mpu_pwrdm");
> -	core_pd = pwrdm_lookup("core_pwrdm");
>  	return 0;
>  }
>  #endif /* CONFIG_CPU_IDLE */
> -- 
> 1.5.2.5
>
>
> -- 
> Kyuwon
