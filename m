From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 09/10] [PM-WIP-MMC] OMAP MMC : Fix crash with  CONFIG_PM_RUNTIME
Date: Thu, 26 Aug 2010 16:23:15 -0700
Message-ID: <87vd6xuffg.fsf@deeprootsystems.com>
References: <16171.10.24.255.18.1282335076.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51958 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab0HZXXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:23:17 -0400
Received: by pvg2 with SMTP id 2so840704pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:23:17 -0700 (PDT)
In-Reply-To: <16171.10.24.255.18.1282335076.squirrel@dbdmail.itg.ti.com>
	(kishore kadiyala's message of "Sat, 21 Aug 2010 01:41:16 +0530
	(IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com

"kishore kadiyala" <kishore.kadiyala@ti.com> writes:

> Crash if enabled CONFIG_PM_RUNTIME and power_saving set.
>
> Use get_sync/put_sync properly so that host->nesting_cnt gets
> updated properly.

<blush>This one is my fault for not really understanding the MMC driver.

Go ahead and just fold this into the original patch when you incorporate
it.

Kevin

> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index c113bfd..90a69c3 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2036,7 +2036,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>  	host->dpm_state = DISABLED;
>
>  	pm_runtime_enable(host->dev);
> -	pm_runtime_get_sync(host->dev);
> +	if (mmc_host_enable(host->mmc) != 0)
> +		goto err1;
>
>  	if (cpu_is_omap2430()) {
>  		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
> @@ -2139,8 +2140,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>
>  	mmc_add_host(mmc);
>
> -	pm_runtime_put(host->dev);
> -
>  	if (mmc_slot(host).name != NULL) {
>  		ret = device_create_file(&mmc->class_dev, &dev_attr_slot_name);
>  		if (ret < 0)
