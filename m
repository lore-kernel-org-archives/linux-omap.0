From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/5] MFD: OMAP3EVM: USB: cosmetic fix to failed parent
 clk set
Date: Mon, 11 Jun 2012 10:03:33 -0500
Message-ID: <4FD608C5.9000900@ti.com>
References: <zumeng.chen@gmail.com> <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com> <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab2FKPDj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 11:03:39 -0400
In-Reply-To: <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, ajay.gupta@ti.com, khasim@ti.com, hvaibhav@ti.com


On 06/11/2012 09:00 AM, Zumeng Chen wrote:
> A typo fix for this cosmetic change and mute a failed message from
> a unnecessary setting of some parent clk for usbhs_omap on OMAP3EVM.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
>  drivers/mfd/omap-usb-host.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 7e96bb2..9aaaf3c 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -698,8 +698,9 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>  		goto err_usbtll_p2_fck;
>  	}
>  
> +#ifndef CONFIG_MACH_OMAP3EVM
> +	/* for OMAP3 , the clk set parent fails */
>  	if (is_ehci_phy_mode(pdata->port_mode[0])) {
> -		/* for OMAP3 , the clk set paretn fails */
>  		ret = clk_set_parent(omap->utmi_p1_fck,
>  					omap->xclk60mhsp1_ck);
>  		if (ret != 0)

This begs the question, why is port_mode[0] set to ehci phy mode if this
is failing? Something does not seem right here but this does not look
like the right fix.

Cheers
Jon
