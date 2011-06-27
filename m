From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 2/7] OMAP: omap_device: Create clkdev entry for hwmod
 main_clk
Date: Mon, 27 Jun 2011 11:56:04 -0700
Message-ID: <20110627185604.GB6187@google.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
 <1309192391-12410-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:1298 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab1F0S4J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 14:56:09 -0400
Content-Disposition: inline
In-Reply-To: <1309192391-12410-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

On Mon, Jun 27, 2011 at 06:33:06PM +0200, Benoit Cousson wrote:
...
> +	r = clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
> +	if (!IS_ERR(r)) {
> +		pr_warning("omap_device: %s: %s already exist\n",
> +			   dev_name(&od->pdev.dev), clk_alias);

I believe a clk_put(r) is appropriate here.

> +		return;
> +	}
> +
> +	r = omap_clk_get_by_name(clk_name);
> +	if (IS_ERR(r)) {
> +		pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
> +		       dev_name(&od->pdev.dev), clk_name);
> +		return;
> +	}
> +
> +	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
> +	if (!l) {
> +		pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
> +		       dev_name(&od->pdev.dev), clk_alias);

And here.

> +		return;
> +	}
> +
> +	clkdev_add(l);

And here.


Todd
