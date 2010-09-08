From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] OMAP1: PM: add simple runtime PM layer to manage
 clocks
Date: Wed, 8 Sep 2010 10:22:37 -0600
Message-ID: <20100908162237.GE3686@angua.secretlab.ca>
References: <1283907282-986-1-git-send-email-khilman@deeprootsystems.com>
 <1283907282-986-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48007 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab0IHQWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 12:22:41 -0400
Received: by pwi3 with SMTP id 3so122095pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Sep 2010 09:22:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283907282-986-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Manjunatha GK <manjugk@ti.com>

On Tue, Sep 07, 2010 at 05:54:42PM -0700, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
> 
> On OMAP1, we do not have omap_device + omap_hwmod to manage the
> device-specific idle, enable and shutdown.  Instead, just
> enable/disable device clocks automatically at the runtime PM level.
> 
> This allows drivers to not have any OMAP1 specific clock management
> and allows them to simply use the runtime PM API to manage clocks.
> 
> OMAP1 compile fixes Manjunatha GK <manjugk@ti.com>
> 
> Cc: Manjunatha GK <manjugk@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Also should go via Greg's tree.

g.

> ---
>  arch/arm/mach-omap1/Makefile |    2 +-
>  arch/arm/mach-omap1/pm_bus.c |   98 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/pm_bus.c
> 
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index facfaeb..9a304d8 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
>  obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
>  
>  # Power Management
> -obj-$(CONFIG_PM) += pm.o sleep.o
> +obj-$(CONFIG_PM) += pm.o sleep.o pm_bus.o
>  
>  # DSP
>  obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
> diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
> new file mode 100644
> index 0000000..c831348
> --- /dev/null
> +++ b/arch/arm/mach-omap1/pm_bus.c
> @@ -0,0 +1,98 @@
> +/*
> + * Runtime PM support code for OMAP1
> + *
> + * Author: Kevin Hilman, Deep Root Systems, LLC
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> +#include <linux/mutex.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +
> +#include <plat/omap_device.h>
> +#include <plat/omap-pm.h>
> +
> +#ifdef CONFIG_PM_RUNTIME
> +static int omap1_pm_runtime_suspend(struct device *dev)
> +{
> +	struct clk *iclk, *fclk;
> +	int ret = 0;
> +
> +	dev_dbg(dev, "%s\n", __func__);
> +
> +	ret = pm_generic_runtime_suspend(dev);
> +
> +	fclk = clk_get(dev, "fck");
> +	if (!IS_ERR(fclk)) {
> +		clk_disable(fclk);
> +		clk_put(fclk);
> +	}
> +
> +	iclk = clk_get(dev, "ick");
> +	if (!IS_ERR(iclk)) {
> +		clk_disable(iclk);
> +		clk_put(iclk);
> +	}
> +
> +	return 0;
> +};
> +
> +static int omap1_pm_runtime_resume(struct device *dev)
> +{
> +	int ret = 0;
> +	struct clk *iclk, *fclk;
> +
> +	dev_dbg(dev, "%s\n", __func__);
> +
> +	iclk = clk_get(dev, "ick");
> +	if (!IS_ERR(iclk)) {
> +		clk_enable(iclk);
> +		clk_put(iclk);
> +	}
> +
> +	fclk = clk_get(dev, "fck");
> +	if (!IS_ERR(fclk)) {
> +		clk_enable(fclk);
> +		clk_put(fclk);
> +	}
> +
> +	return pm_generic_runtime_resume(dev);
> +};
> +
> +static int __init omap1_pm_runtime_init(void)
> +{
> +	const struct dev_pm_ops *pm;
> +	struct dev_pm_ops *omap_pm;
> +
> +	pm = platform_bus_get_pm_ops();
> +	if (!pm) {
> +		pr_err("%s: unable to get dev_pm_ops from platform_bus\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	omap_pm = kmemdup(pm, sizeof(struct dev_pm_ops), GFP_KERNEL);
> +	if (!omap_pm) {
> +		pr_err("%s: unable to alloc memory for new dev_pm_ops\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +		
> +	omap_pm->runtime_suspend = omap1_pm_runtime_suspend;
> +	omap_pm->runtime_resume = omap1_pm_runtime_resume;
> +
> +	platform_bus_set_pm_ops(omap_pm);
> +
> +	return 0;
> +}
> +core_initcall(omap1_pm_runtime_init);
> +#endif /* CONFIG_PM_RUNTIME */
> -- 
> 1.7.2.1
> 
