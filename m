From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/2] usb: otg: OMAP4430: Fix omap4430_phy_init function
Date: Thu, 24 Mar 2011 16:17:54 +0300
Message-ID: <4D8B4482.4040506@ru.mvista.com>
References: <1300964764-6794-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52284 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575Ab1CXNTY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Mar 2011 09:19:24 -0400
In-Reply-To: <1300964764-6794-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hello.

On 24-03-2011 14:06, Hema HK wrote:

> omap4430_phy_init() function can be called with no device pointer
> to powerdown the UTMI PHY during board init when USB is disabled.
> Fix the function accordingly.

> Signed-off-by: Hema HK<hemahk@ti.com>
> ---
>   arch/arm/mach-omap2/omap_phy_internal.c |   44 ++++++++++++++++--------------
>   1 files changed, 23 insertions(+), 21 deletions(-)

> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
> index e2e605f..a959e2f 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -50,34 +50,36 @@ int omap4430_phy_init(struct device *dev)
>   {
>   	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>   	if (!ctrl_base) {
> -		dev_err(dev, "control module ioremap failed\n");
> +		printk(KERN_ERR "control module ioremap failed\n");

    Use pr_err().

>   		return -ENOMEM;
>   	}
>   	/* Power down the phy */
>   	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> -	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
>
> -	if (IS_ERR(phyclk)) {
> -		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
> -		iounmap(ctrl_base);
> -		return PTR_ERR(phyclk);
> -	}
> +	if (dev) {
> +		phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");

    Couldn't clk_get() be called with NULL device ptr?

WBR, Sergei
