From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: cpuidle - check the powerdomain lookup
Date: Fri, 04 May 2012 14:23:21 -0700
Message-ID: <87k40r8wty.fsf@ti.com>
References: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org>
	<1336151921-9485-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:41569 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132Ab2EDVXV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 17:23:21 -0400
Received: by pbbrr4 with SMTP id rr4so4674724pbb.23
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 14:23:16 -0700 (PDT)
In-Reply-To: <1336151921-9485-2-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Fri, 4 May 2012 19:18:40 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> At init time, check the powerdomains lookup is successful otherwise
> exit the cpuidle driver init function with -ENODEV like what is done for the
> omap3 cpuidle driver.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>

Thanks, applying to my for_3.5/cleanup/omap-cpuidle branch.

Kevin

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index f682e17..207bc1c 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -363,6 +363,9 @@ int __init omap3_idle_init(void)
>  	per_pd = pwrdm_lookup("per_pwrdm");
>  	cam_pd = pwrdm_lookup("cam_pwrdm");
>  
> +	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
> +		return -ENODEV;
> +
>  	cpuidle_register_driver(&omap3_idle_driver);
>  
>  	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
