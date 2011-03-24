From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] usb: otg: OMAP4430: Fix omap4430_phy_init function
Date: Thu, 24 Mar 2011 13:08:25 +0200
Message-ID: <20110324110824.GH14602@legolas.emea.dhcp.ti.com>
References: <1300964764-6794-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42205 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751365Ab1CXLIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 07:08:31 -0400
Content-Disposition: inline
In-Reply-To: <1300964764-6794-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Mar 24, 2011 at 04:36:04PM +0530, Hema HK wrote:
> omap4430_phy_init() function can be called with no device pointer
> to powerdown the UTMI PHY during board init when USB is disabled.
> Fix the function accordingly.
> 
> Signed-off-by: Hema HK <hemahk@ti.com>
> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |   44 ++++++++++++++++--------------
>  1 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
> index e2e605f..a959e2f 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -50,34 +50,36 @@ int omap4430_phy_init(struct device *dev)
>  {
>  	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>  	if (!ctrl_base) {
> -		dev_err(dev, "control module ioremap failed\n");
> +		printk(KERN_ERR "control module ioremap failed\n");

use pr_err()

>  		return -ENOMEM;
>  	}
>  	/* Power down the phy */
>  	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> -	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
>  
> -	if (IS_ERR(phyclk)) {
> -		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
> -		iounmap(ctrl_base);
> -		return PTR_ERR(phyclk);
> -	}
> +	if (dev) {

you can avoid this nesting level:

if (!dev)
	return;

-- 
balbi
