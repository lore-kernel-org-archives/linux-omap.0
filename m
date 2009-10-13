From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: add CompuLab CM-T35 module
Date: Tue, 13 Oct 2009 10:08:42 -0700
Message-ID: <20091013170841.GR12700@atomide.com>
References: <cover.1255449748.git.mike@compulab.co.il> <067ddfa70bce94aed929176616bab1ac449c8765.1255449748.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50008 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760356AbZJMRJ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 13:09:26 -0400
Content-Disposition: inline
In-Reply-To: <067ddfa70bce94aed929176616bab1ac449c8765.1255449748.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org

* Mike Rapoport <mike@compulab.co.il> [091013 10:00]:
> This patch adds basic support for CompuLab CM-T35 module.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---

<snip>

> +static struct ehci_hcd_omap_platform_data ehci_pdata = {
> +
> +	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> +
> +	.phy_reset  = true,
> +	.reset_gpio_port[0]  = -EINVAL,
> +	.reset_gpio_port[1]  = -EINVAL,
> +	.reset_gpio_port[2]  = -EINVAL
> +};

This ehci stuff should be done in a separate patch, it's not in
the mainline tree yet.

Can you please check that your patch will compile OK with the
mainline tree?

Regards,

Tony
