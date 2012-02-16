From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Split omap2_hsmmc_init() to properly
 support I2C GPIO pins
Date: Thu, 16 Feb 2012 08:45:05 -0800
Message-ID: <20120216164504.GD15692@atomide.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <20120215182825.18884.40972.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56167 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab2BPQpK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 11:45:10 -0500
Content-Disposition: inline
In-Reply-To: <20120215182825.18884.40972.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120215 09:57]:
>  
> +void omap_hsmmc_late_init(struct omap2_hsmmc_info *controllers)
> +{
> +	struct platform_device *pdev;
> +	int res;
> +
> +	for (; controllers->mmc; controllers++) {
> +		if (!controllers->deferred)
> +			continue;
> +
> +		pdev = controllers->pdev;
> +		if (!pdev)
> +			continue;
> +
> +		res = omap_device_register(pdev);
> +		if (res) {
> +			pr_err("Could not late init MMC %s\n",
> +			       controllers->name);
> +			continue;
> +		}
> +	}
> +}

Most likely there's no need to pass struct omap2_hsmmc_info *controllers
to omap_hsmmc_late_init() here. And I'll also take a look at making
it a completion to make it more generic across various PMICs.

Tony
