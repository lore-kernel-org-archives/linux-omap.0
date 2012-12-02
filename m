From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 22/22] mfd: omap-usb-host: Don't spam console on clk_set_parent
 failure
Date: Sun, 02 Dec 2012 21:10:16 +0400
Message-ID: <50BB8B78.9010207@mvista.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com> <1354114150-11941-23-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:63038 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab2LBRLv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Dec 2012 12:11:51 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1647527lag.19
        for <linux-omap@vger.kernel.org>; Sun, 02 Dec 2012 09:11:49 -0800 (PST)
In-Reply-To: <1354114150-11941-23-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hello.

On 28-11-2012 18:49, Roger Quadros wrote:

> clk_set_parent is expected to fail on OMAP3 platforms. We don't
> consider that as fatal so don't spam console.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/mfd/omap-usb-host.c |   10 +++++-----
>   1 files changed, 5 insertions(+), 5 deletions(-)

> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 6ede319..493e010 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -653,17 +653,17 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>   	}
>
>   	if (is_ehci_phy_mode(pdata->port_mode[0])) {
> -		/* for OMAP3 , the clk set paretn fails */
> +		/* for OMAP3 , the clk set parent fails */

    Worth removing spave before comma too.

>   		ret = clk_set_parent(omap->utmi_clk[0],
>   					omap->xclk60mhsp1_ck);
>   		if (ret != 0)
> -			dev_err(dev, "xclk60mhsp1_ck set parent"
> +			dev_dbg(dev, "xclk60mhsp1_ck set parent"

    Need space at the end of this substring, else you get "parentfailed"

>   				"failed error:%d\n", ret);
>   	} else if (is_ehci_tll_mode(pdata->port_mode[0])) {
>   		ret = clk_set_parent(omap->utmi_clk[0],
>   					omap->init_60m_fclk);
>   		if (ret != 0)
> -			dev_err(dev, "init_60m_fclk set parent"
> +			dev_dbg(dev, "init_60m_fclk set parent"

    Same here.

>   				"failed error:%d\n", ret);
>   	}
>
> @@ -671,13 +671,13 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>   		ret = clk_set_parent(omap->utmi_clk[1],
>   					omap->xclk60mhsp2_ck);
>   		if (ret != 0)
> -			dev_err(dev, "xclk60mhsp2_ck set parent"
> +			dev_dbg(dev, "xclk60mhsp2_ck set parent"

    Same here.

>   					"failed error:%d\n", ret);
>   	} else if (is_ehci_tll_mode(pdata->port_mode[1])) {
>   		ret = clk_set_parent(omap->utmi_clk[1],
>   						omap->init_60m_fclk);
>   		if (ret != 0)
> -			dev_err(dev, "init_60m_fclk set parent"
> +			dev_dbg(dev, "init_60m_fclk set parent"

    And here.

>   				"failed error:%d\n", ret);

WBR, Sergei


