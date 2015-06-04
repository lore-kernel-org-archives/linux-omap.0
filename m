From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/12] ARM: OMAP2+: Add support for initializing dm814x
 clocks
Date: Thu, 4 Jun 2015 11:42:54 -0700
Message-ID: <20150604184254.GJ490@codeaurora.org>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
 <1433348601-8966-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49509 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbFDSm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2015 14:42:56 -0400
Content-Disposition: inline
In-Reply-To: <1433348601-8966-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

On 06/03, Tony Lindgren wrote:
> diff --git a/drivers/clk/ti/clk-814x.c b/drivers/clk/ti/clk-814x.c
> new file mode 100644
> index 0000000..bd2353c
> --- /dev/null
> +++ b/drivers/clk/ti/clk-814x.c
> @@ -0,0 +1,36 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/list.h>

Is list.h used?

> +#include <linux/clk-provider.h>
> +#include <linux/clk/ti.h>
> +
> +static struct ti_dt_clk dm814_clks[] = {
> +	DT_CLK(NULL, "devosc_ck", "devosc_ck"),
> +	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
> +	DT_CLK(NULL, "sysclk4_ck", "sysclk4_ck"),
> +	DT_CLK(NULL, "sysclk6_ck", "sysclk6_ck"),
> +	DT_CLK(NULL, "sysclk10_ck", "sysclk10_ck"),
> +	DT_CLK(NULL, "sysclk18_ck", "sysclk18_ck"),
> +	DT_CLK(NULL, "timer_sys_ck", "devosc_ck"),
> +	DT_CLK(NULL, "cpsw_125mhz_gclk", "cpsw_125mhz_gclk"),
> +	DT_CLK(NULL, "cpsw_cpts_rft_clk", "cpsw_cpts_rft_clk"),
> +	{ .node_name = NULL },
> +};
> +
> +static const char *enable_init_clks[] = {
> +};

delete?

> +
> +int __init dm814x_dt_clk_init(void)
> +{
> +	ti_dt_clocks_register(dm814_clks);
> +	omap2_clk_disable_autoidle_all();
> +	omap2_clk_enable_init_clocks(enable_init_clks,
> +				     ARRAY_SIZE(enable_init_clks));

And pass NULL and 0 here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
