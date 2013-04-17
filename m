From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 2/2] USB: ehci-omap: Improve PHY error handling
Date: Wed, 17 Apr 2013 10:15:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1304171014540.1623-100000@iolanthe.rowland.org>
References: <1366187065-10795-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366187065-10795-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, holler@ahsoftware.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 17 Apr 2013, Roger Quadros wrote:

> As the USB PHY layer never returns NULL we don't need
> to check for that condition.
> 
> CC: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/host/ehci-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 5de3e43..3d1491b 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -175,12 +175,12 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  			phy = devm_usb_get_phy_by_phandle(dev, "phys", i);
>  		else
>  			phy = devm_usb_get_phy_dev(dev, i);
> -		if (IS_ERR(phy) || !phy) {
> +		if (IS_ERR(phy)) {
>  			/* Don't bail out if PHY is not absolutely necessary */
>  			if (pdata->port_mode[i] != OMAP_EHCI_PORT_MODE_PHY)
>  				continue;
>  
> -			ret = IS_ERR(phy) ? PTR_ERR(phy) : -ENODEV;
> +			ret = PTR_ERR(phy);
>  			dev_err(dev, "Can't get PHY device for port %d: %d\n",
>  					i, ret);
>  			goto err_phy;

Acked-by: Alan Stern <stern@rowland.harvard.edu>
