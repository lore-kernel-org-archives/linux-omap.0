From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Cpufreq: Clean up to support multi omap builds
Date: Thu, 6 Jan 2011 18:06:03 -0800
Message-ID: <20110107020602.GE7771@atomide.com>
References: <1294244613-25798-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34694 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262Ab1AGCGL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 21:06:11 -0500
Content-Disposition: inline
In-Reply-To: <1294244613-25798-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, khilman@ti.com

* Thara Gopinath <thara@ti.com> [110105 08:23]:
> +#define OMAP1_MPU_CLK		"mpu"
> +#define OMAP2_MPU_CLK		"virt_prcm_set"
> +#define OMAP3_MPU_CLK		"dpll1_ck"
...
  
>  static int __init omap_cpufreq_init(void)
>  {
> +	if (cpu_class_is_omap1()) {
> +		mpu_clk_name = OMAP1_MPU_CLK;
> +		arch_cpu_init = omap1_cpu_init;
> +		arch_cpu_target = omap1_cpu_target;
> +	} else if (cpu_is_omap24xx()) {
> +		mpu_clk_name = OMAP2_MPU_CLK;
> +		arch_cpu_init = omap1_cpu_init;
> +		arch_cpu_target = omap2plus_cpu_target;
> +	} else if (cpu_is_omap34xx()) {
> +		mpu_clk_name = OMAP3_MPU_CLK;
> +		arch_cpu_init = omap3_cpu_init;
> +		arch_cpu_target = omap2plus_cpu_target;
> +	} else {
> +		pr_warning("%s: cpufreq support not yet added\n", __func__);
> +		return -EINVAL;
> +	}
> +

To me it seems that you should be able to now remove these
just by adding the mpu clock alias to the struct omap_clk
tables?

Tony
