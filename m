From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/7] usb: dwc3: adapt dwc3 core to use Generic PHY Framework
Date: Fri, 11 Oct 2013 18:09:29 +0300
Message-ID: <525814A9.7060106@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com> <1378136591-7463-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1378136591-7463-3-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 09/02/2013 06:43 PM, Kishon Vijay Abraham I wrote:
> Adapted dwc3 core to use the Generic PHY Framework. So for init, exit,
> power_on and power_off the following APIs are used phy_init(), phy_exit(),
> phy_power_on() and phy_power_off().
> 
> However using the old USB phy library wont be removed till the PHYs of all
> other SoC's using dwc3 core is adapted to the Generic PHY Framework.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt |    6 ++-
>  drivers/usb/dwc3/Kconfig                       |    1 +
>  drivers/usb/dwc3/core.c                        |   49 ++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h                        |    7 ++++
>  4 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index e807635..471366d 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -6,11 +6,13 @@ Required properties:
>   - compatible: must be "snps,dwc3"
>   - reg : Address and length of the register set for the device
>   - interrupts: Interrupts used by the dwc3 controller.
> +
> +Optional properties:
>   - usb-phy : array of phandle for the PHY device.  The first element
>     in the array is expected to be a handle to the USB2/HS PHY and
>     the second element is expected to be a handle to the USB3/SS PHY
> -
> -Optional properties:
> + - phys: from the *Generic PHY* bindings
> + - phy-names: from the *Generic PHY* bindings
>   - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
>  
>  This is usually a subnode to DWC3 glue to which it is connected.
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index cfc16dd..ad7ce83 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -3,6 +3,7 @@ config USB_DWC3
>  	depends on (USB || USB_GADGET) && GENERIC_HARDIRQS && HAS_DMA
>  	depends on EXTCON
>  	select USB_PHY
> +	select GENERIC_PHY
>  	select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
>  	help
>  	  Say Y or M here if your system has a Dual Role SuperSpeed
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 428c29e..485d365 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -82,6 +82,12 @@ static void dwc3_core_soft_reset(struct dwc3 *dwc)
>  
>  	usb_phy_init(dwc->usb2_phy);
>  	usb_phy_init(dwc->usb3_phy);

How about adding
+	if (dwc->usb2_phy)
+		usb_phy_init(dwc->usb2_phy);
+	if (dwc->usb3_phy)
+		usb_phy_init(dwc->usb3_phy);

both usb phy and generic phy shouldn't be present together.

> +
> +	if (dwc->usb2_generic_phy)
> +		phy_init(dwc->usb2_generic_phy);
> +	if (dwc->usb3_generic_phy)
> +		phy_init(dwc->usb3_generic_phy);
> +
>  	mdelay(100);
>  
>  	/* Clear USB3 PHY reset */
> @@ -343,6 +349,11 @@ static void dwc3_core_exit(struct dwc3 *dwc)
>  {
>  	usb_phy_shutdown(dwc->usb2_phy);
>  	usb_phy_shutdown(dwc->usb3_phy);

here as well

> +
> +	if (dwc->usb2_generic_phy)
> +		phy_power_off(dwc->usb2_generic_phy);
> +	if (dwc->usb3_generic_phy)
> +		phy_power_off(dwc->usb3_generic_phy);
>  }
>  
>  #define DWC3_ALIGN_MASK		(16 - 1)
> @@ -427,6 +438,23 @@ static int dwc3_probe(struct platform_device *pdev)
>  		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
>  	}
>  
> +	if (of_property_read_bool(node, "phys") || pdata->has_phy) {
> +		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> +		if (IS_ERR(dwc->usb2_generic_phy)) {
> +			dev_err(dev, "no usb2 phy configured yet");
> +			return PTR_ERR(dwc->usb2_generic_phy);
> +		}
> +
> +		dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> +		if (IS_ERR(dwc->usb3_generic_phy)) {
> +			dev_err(dev, "no usb3 phy configured yet");
> +			return PTR_ERR(dwc->usb3_generic_phy);
> +		}

better to add
+		/* Don't use USB PHY if generic PHY was found */
+		dwc->usb2_phy = dwc->usb3_phy = NULL;

> +	} else {

not required as we've used kzalloc for dwc.

> +		dwc->usb2_generic_phy = NULL;
> +		dwc->usb3_generic_phy = NULL;
> +	}
> +
>  	/* default to superspeed if no maximum_speed passed */
>  	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
>  		dwc->maximum_speed = USB_SPEED_SUPER;
> @@ -450,6 +478,11 @@ static int dwc3_probe(struct platform_device *pdev)

if (dwc->usb2_phy)

>  	usb_phy_set_suspend(dwc->usb2_phy, 0);

if (dwc->usb3_phy)

>  	usb_phy_set_suspend(dwc->usb3_phy, 0);
>  
> +	if (dwc->usb2_generic_phy)
> +		phy_power_on(dwc->usb2_generic_phy);
> +	if (dwc->usb3_generic_phy)
> +		phy_power_on(dwc->usb3_generic_phy);
> +
>  	spin_lock_init(&dwc->lock);
>  	platform_set_drvdata(pdev, dwc);
>  
> @@ -576,6 +609,11 @@ static int dwc3_remove(struct platform_device *pdev)

if (dwc->usb2_phy)
>  	usb_phy_set_suspend(dwc->usb2_phy, 1);

if (dwc->usb3_phy)
>  	usb_phy_set_suspend(dwc->usb3_phy, 1);
>  
> +	if (dwc->usb2_generic_phy)
> +		phy_power_off(dwc->usb2_generic_phy);
> +	if (dwc->usb3_generic_phy)
> +		phy_power_off(dwc->usb3_generic_phy);
> +
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> @@ -673,6 +711,11 @@ static int dwc3_suspend(struct device *dev)

if (dwc->usb3_phy)
>  	usb_phy_shutdown(dwc->usb3_phy);

if (dwc->usb2_phy)
>  	usb_phy_shutdown(dwc->usb2_phy);
>  
> +	if (dwc->usb2_generic_phy)
> +		phy_exit(dwc->usb2_generic_phy);
> +	if (dwc->usb3_generic_phy)
> +		phy_exit(dwc->usb3_generic_phy);
> +
>  	return 0;
>  }
>  
> @@ -683,6 +726,12 @@ static int dwc3_resume(struct device *dev)
>  

if (dwc->usb3_phy)
>  	usb_phy_init(dwc->usb3_phy);

if (dwc->usb2_phy)
>  	usb_phy_init(dwc->usb2_phy);
> +
> +	if (dwc->usb2_generic_phy)
> +		phy_init(dwc->usb2_generic_phy);
> +	if (dwc->usb3_generic_phy)
> +		phy_init(dwc->usb3_generic_phy);
> +
>  	msleep(100);
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index f8af8d4..01ec7d7 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -31,6 +31,8 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg.h>
>  
> +#include <linux/phy/phy.h>
> +
>  /* Global constants */
>  #define DWC3_EP0_BOUNCE_SIZE	512
>  #define DWC3_ENDPOINTS_NUM	32
> @@ -613,6 +615,8 @@ struct dwc3_scratchpad_array {
>   * @dr_mode: requested mode of operation
>   * @usb2_phy: pointer to USB2 PHY
>   * @usb3_phy: pointer to USB3 PHY
> + * @usb2_generic_phy: pointer to USB2 PHY
> + * @usb3_generic_phy: pointer to USB3 PHY
>   * @dcfg: saved contents of DCFG register
>   * @gctl: saved contents of GCTL register
>   * @is_selfpowered: true when we are selfpowered
> @@ -665,6 +669,9 @@ struct dwc3 {
>  	struct usb_phy		*usb2_phy;
>  	struct usb_phy		*usb3_phy;
>  
> +	struct phy		*usb2_generic_phy;
> +	struct phy		*usb3_generic_phy;
> +
>  	void __iomem		*regs;
>  	size_t			regs_size;
>  
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
