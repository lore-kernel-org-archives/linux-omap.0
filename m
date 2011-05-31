From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Add missing iounmap in omap4430_phy_init
Date: Tue, 31 May 2011 04:55:35 -0700
Message-ID: <20110531115535.GB11352@atomide.com>
References: <20110526192553.GA21534@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65206 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753238Ab1EaLzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 07:55:37 -0400
Content-Disposition: inline
In-Reply-To: <20110526192553.GA21534@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>

* Todd Poynor <toddpoynor@google.com> [110526 12:22]:
> !dev case needs iounmap before return.

Adding to fixes thanks.

Tony
 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
> index ae97336..bd563cf 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -56,8 +56,10 @@ int omap4430_phy_init(struct device *dev)
>  	/* Power down the phy */
>  	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>  
> -	if (!dev)
> +	if (!dev) {
> +		iounmap(ctrl_base);
>  		return 0;
> +	}
>  
>  	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
>  	if (IS_ERR(phyclk)) {
> -- 
> 1.7.3.1
> 
