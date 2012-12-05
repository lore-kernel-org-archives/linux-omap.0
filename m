From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v3 23/23] mfd: omap-usb-host: Don't spam console on clk_set_parent
 failure
Date: Wed, 05 Dec 2012 17:42:08 +0400
Message-ID: <50BF4F30.4030903@mvista.com>
References: <1354631514-24815-1-git-send-email-rogerq@ti.com> <1354631514-24815-8-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:49185 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab2LENng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 08:43:36 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so4293205lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Dec 2012 05:43:35 -0800 (PST)
In-Reply-To: <1354631514-24815-8-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, bjorn@mork.no, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hello.

On 04-12-2012 18:31, Roger Quadros wrote:

> clk_set_parent is expected to fail on OMAP3 platforms. We don't
> consider that as fatal so don't spam console.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/mfd/omap-usb-host.c |   18 +++++++++---------
>   1 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 0bb54393..e5257dc 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -657,32 +657,32 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>   	}
>
>   	if (is_ehci_phy_mode(pdata->port_mode[0])) {
> -		/* for OMAP3 , the clk set paretn fails */
> +		/* for OMAP3, clk_set_parent fails */
>   		ret = clk_set_parent(omap->utmi_clk[0],
>   					omap->xclk60mhsp1_ck);
>   		if (ret != 0)
> -			dev_err(dev, "xclk60mhsp1_ck set parent"
> -				"failed error:%d\n", ret);
> +			dev_dbg(dev, "xclk60mhsp1_ck set parent failed : %d\n",
> +					ret);
>   	} else if (is_ehci_tll_mode(pdata->port_mode[0])) {
>   		ret = clk_set_parent(omap->utmi_clk[0],
>   					omap->init_60m_fclk);
>   		if (ret != 0)
> -			dev_err(dev, "init_60m_fclk set parent"
> -				"failed error:%d\n", ret);
> +			dev_dbg(dev, "P0 init_60m_fclk set parent failed: %d\n",
> +					ret);
>   	}
>
>   	if (is_ehci_phy_mode(pdata->port_mode[1])) {
>   		ret = clk_set_parent(omap->utmi_clk[1],
>   					omap->xclk60mhsp2_ck);
>   		if (ret != 0)
> -			dev_err(dev, "xclk60mhsp2_ck set parent"
> -					"failed error:%d\n", ret);
> +			dev_dbg(dev, "xclk60mhsp2_ck set parent failed : %d\n",
> +					ret);
>   	} else if (is_ehci_tll_mode(pdata->port_mode[1])) {
>   		ret = clk_set_parent(omap->utmi_clk[1],
>   						omap->init_60m_fclk);
>   		if (ret != 0)
> -			dev_err(dev, "init_60m_fclk set parent"
> -				"failed error:%d\n", ret);
> +			dev_dbg(dev, "P1 init_60m_fclk set parent failed: %d\n",
> +					ret);

    Hm, you sometimes put a space before colon in the error message and 
sometimes not. Inconsistent. :-)

WBR, Sergei

