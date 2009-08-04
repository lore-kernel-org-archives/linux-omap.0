From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v1 1/3] ARM:OMAP4 iommu:changes in iommu for OMAP4
Date: Tue, 4 Aug 2009 23:45:04 +0100
Message-ID: <20090804224504.GB17716@n2100.arm.linux.org.uk>
References: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBABD@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38095 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933370AbZHDWpN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 18:45:13 -0400
Content-Disposition: inline
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBABD@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Tue, Aug 04, 2009 at 05:30:23PM -0500, Kanigeri, Hari wrote:
> -	obj->clk = clk_get(&pdev->dev, pdata->clk_name);
> -	if (IS_ERR(obj->clk))
> -		goto err_clk;
> +	/*
> +	 * FIX-ME: Replace with correct clk node when clk
> +	 * framework is available
> +	 */
> +	if (!cpu_is_omap44xx())	{
> +		obj->clk = clk_get(&pdev->dev, pdata->clk_name);
> +		if (IS_ERR(obj->clk))
> +			goto err_clk;
> +	}

I've no visibility on when these are going to get resolved, and it's
starting to concern me that there appears to be no progress on it,
especially as we have more and more code being merged with these
workarounds.  It's getting towards the point where enough is enough
and we need OMAP4 clk support in place, even if it is just a simple
stop-gap implementation rather than all these horrible hacks spread
through the code which one day will need to be found and removed.

