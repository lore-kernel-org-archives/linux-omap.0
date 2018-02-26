From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH usb-next v10 2/8] usb: add a flag to skip PHY
 initialization to struct usb_hcd
Date: Mon, 26 Feb 2018 11:26:59 +0800
Message-ID: <20180226032659.GC22100@b29397-desktop>
References: <20180218184504.3331-1-martin.blumenstingl@googlemail.com>
 <20180218184504.3331-3-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180218184504.3331-3-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, yixun.lan@amlogic.com, arnd@arndb.de, felipe.balbi@linux.intel.com, Peter.Chen@nxp.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, narmstrong@baylibre.com, robh+dt@kernel.org, jonathanh@nvidia.com, mathias.nyman@intel.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, linux-mediatek@lists.infradead.org, linux@prisktech.co.nz, linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org, stern@rowland.harvard.edu, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, Feb 18, 2018 at 07:44:58PM +0100, Martin Blumenstingl wrote:
> The USB HCD core driver parses the device-tree node for "phys" and
> "usb-phys" properties. It also manages the power state of these PHYs
> automatically.
> However, drivers may opt-out of this behavior by setting "phy" or
> "usb_phy" in struct usb_hcd to a non-null value. An example where this
> is required is the "Qualcomm USB2 controller", implemented by the
> chipidea driver. The hardware requires that the PHY is only powered on
> after the "reset completed" event from the controller is received.
> 
> A follow-up patch will allow the USB HCD core driver to manage more than
> one PHY. Add a new "skip_phy_initialization" bitflag to struct usb_hcd
> so drivers can opt-out of any PHY management provided by the USB HCD
> core driver.
> 
> This also updates the existing drivers so they use the new flag if they
> want to opt out of the PHY management provided by the USB HCD core
> driver. This means that for these drivers the new "multiple PHY"
> handling (which will be added in a follow-up patch) will be disabled as
> well.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/usb/chipidea/host.c      | 6 ++----
>  drivers/usb/core/hcd.c           | 4 ++--
>  drivers/usb/host/ehci-fsl.c      | 2 ++
>  drivers/usb/host/ehci-platform.c | 4 ++--
>  drivers/usb/host/ehci-tegra.c    | 1 +
>  drivers/usb/host/ohci-omap.c     | 1 +
>  drivers/usb/host/ohci-platform.c | 4 ++--
>  drivers/usb/host/xhci-plat.c     | 1 +
>  include/linux/usb/hcd.h          | 6 ++++++
>  9 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index 19d60ed7e41f..af45aa3222b5 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -124,10 +124,8 @@ static int host_start(struct ci_hdrc *ci)
>  
>  	hcd->power_budget = ci->platdata->power_budget;
>  	hcd->tpl_support = ci->platdata->tpl_support;
> -	if (ci->phy)
> -		hcd->phy = ci->phy;
> -	else
> -		hcd->usb_phy = ci->usb_phy;
> +	if (ci->phy || ci->usb_phy)
> +		hcd->skip_phy_initialization = 1;
>  
>  	ehci = hcd_to_ehci(hcd);
>  	ehci->caps = ci->hw_bank.cap;
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index fc32391a34d5..f2307470a31e 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2727,7 +2727,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  	int retval;
>  	struct usb_device *rhdev;
>  
> -	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->usb_phy) {
> +	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->skip_phy_initialization) {
>  		struct usb_phy *phy = usb_get_phy_dev(hcd->self.sysdev, 0);
>  
>  		if (IS_ERR(phy)) {
> @@ -2745,7 +2745,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  		}
>  	}
>  
> -	if (IS_ENABLED(CONFIG_GENERIC_PHY) && !hcd->phy) {
> +	if (IS_ENABLED(CONFIG_GENERIC_PHY) && !hcd->skip_phy_initialization) {
>  		struct phy *phy = phy_get(hcd->self.sysdev, "usb");
>  
>  		if (IS_ERR(phy)) {
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index c5094cb88cd5..0a9fd2022acf 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -155,6 +155,8 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
>  			retval = -ENODEV;
>  			goto err2;
>  		}
> +
> +		hcd->skip_phy_initialization = 1;
>  	}
>  #endif
>  	return retval;
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index b065a960adc2..b91eea8c73ae 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -219,9 +219,9 @@ static int ehci_platform_probe(struct platform_device *dev)
>  			if (IS_ERR(priv->phys[phy_num])) {
>  				err = PTR_ERR(priv->phys[phy_num]);
>  					goto err_put_hcd;
> -			} else if (!hcd->phy) {
> +			} else {
>  				/* Avoiding phy_get() in usb_add_hcd() */
> -				hcd->phy = priv->phys[phy_num];
> +				hcd->skip_phy_initialization = 1;
>  			}
>  		}
>  
> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> index c809f7d2f08f..a6f4389f7e88 100644
> --- a/drivers/usb/host/ehci-tegra.c
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -461,6 +461,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
>  		goto cleanup_clk_en;
>  	}
>  	hcd->usb_phy = u_phy;
> +	hcd->skip_phy_initialization = 1;
>  
>  	tegra->needs_double_reset = of_property_read_bool(pdev->dev.of_node,
>  		"nvidia,needs-double-reset");
> diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> index 0201c49bc4fc..d8d35d456456 100644
> --- a/drivers/usb/host/ohci-omap.c
> +++ b/drivers/usb/host/ohci-omap.c
> @@ -230,6 +230,7 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
>  		} else {
>  			return -EPROBE_DEFER;
>  		}
> +		hcd->skip_phy_initialization = 1;
>  		ohci->start_hnp = start_hnp;
>  	}
>  #endif
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 1e6c954f4b3f..62ef36a9333f 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -186,9 +186,9 @@ static int ohci_platform_probe(struct platform_device *dev)
>  			if (IS_ERR(priv->phys[phy_num])) {
>  				err = PTR_ERR(priv->phys[phy_num]);
>  				goto err_put_hcd;
> -			} else if (!hcd->phy) {
> +			} else {
>  				/* Avoiding phy_get() in usb_add_hcd() */
> -				hcd->phy = priv->phys[phy_num];
> +				hcd->skip_phy_initialization = 1;
>  			}
>  		}
>  
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 6f038306c14d..6700e5ee82ad 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -284,6 +284,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  		ret = usb_phy_init(hcd->usb_phy);
>  		if (ret)
>  			goto put_usb3_hcd;
> +		hcd->skip_phy_initialization = 1;
>  	}
>  
>  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 176900528822..693502c84c04 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -151,6 +151,12 @@ struct usb_hcd {
>  	unsigned		msix_enabled:1;	/* driver has MSI-X enabled? */
>  	unsigned		msi_enabled:1;	/* driver has MSI enabled? */
>  	unsigned		remove_phy:1;	/* auto-remove USB phy */
> +	/*
> +	 * do not manage the PHY state in the HCD core, instead let the driver
> +	 * handle this (for example if the PHY can only be turned on after a
> +	 * specific event)
> +	 */
> +	unsigned		skip_phy_initialization:1;
>  
>  	/* The next flag is a stopgap, to be removed when all the HCDs
>  	 * support the new root-hub polling mechanism. */
> -- 

For chipidea part:

Acked-by: Peter Chen <peter.chen@nxp.com>

-- 

Best Regards,
Peter Chen
