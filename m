From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5] usb: dwc3: use extcon fwrk to receive connect/disconnect
Date: Mon, 24 Jun 2013 20:12:45 +0900
Message-ID: <51C829AD.4010208@samsung.com>
References: <1371215425-1979-1-git-send-email-kishon@ti.com>
 <1371815921-28303-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1371815921-28303-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/21/2013 08:58 PM, Kishon Vijay Abraham I wrote:
> Modified dwc3-omap to receive connect and disconnect notification using
> extcon framework. Also did the necessary cleanups required after
> adapting to extcon framework.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> This patch should be applied after all of the extcon patchset will be applied
> because this patch has dependency of extcon patch related to DT.
> http://goo.gl/Tu3qW
> 
> Changes from v4:
> * checked the return values of extcon_register_interest and print an error
> message. Note that I dint do return since there might be cases where
> one of USB (device mode) or USB-HOST (host mode) might succeed.
> * Added depends on of EXTCON in usb_dwc3. Only some platforms might
> be using EXTCON, but inorder to avoid compilation errors, added
> depends on
> Changes from v3:
> * did #include of of_extcon.h after Chanwoo resent the patch separating
> extcon-class.c from of_extcon.c
> Changes from v2:
> * updated the Documentation with dwc3 dt binding information.
> * used of_extcon_get_extcon_dev to get extcon device from device tree data.
> Changes from v1:
> * regulator enable/disable is now done here instead of palmas-usb as some users
> of palmas-usb wont need regulator.
> 
>  Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +
>  drivers/usb/dwc3/Kconfig                           |    1 +
>  drivers/usb/dwc3/dwc3-omap.c                       |  125 +++++++++++++++++---
>  include/linux/usb/dwc3-omap.h                      |   30 -----
>  4 files changed, 112 insertions(+), 49 deletions(-)
>  delete mode 100644 include/linux/usb/dwc3-omap.h
> 
> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
> index d4769f3..f1c15f3 100644
> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> @@ -53,6 +53,11 @@ OMAP DWC3 GLUE
>     It should be set to "1" for HW mode and "2" for SW mode.
>   - ranges: the child address space are mapped 1:1 onto the parent address space
>  
> +Optional Properties:
> + - extcon : phandle for the extcon device omap dwc3 uses to detect
> +   connect/disconnect events.
> + - vbus-supply : phandle to the regulator device tree node if needed.
> +
>  Sub-nodes:
>  The dwc3 core should be added as subnode to omap dwc3 glue.
>  - dwc3 :
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 757aa18..08a9fab 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -1,6 +1,7 @@
>  config USB_DWC3
>  	tristate "DesignWare USB3 DRD Core Support"
>  	depends on (USB || USB_GADGET) && GENERIC_HARDIRQS
> +	depends on EXTCON
>  	select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
>  	help
>  	  Say Y or M here if your system has a Dual Role SuperSpeed
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index f8f76e6..80b5780 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -43,13 +43,15 @@
>  #include <linux/spinlock.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/dwc3-omap.h>
> -#include <linux/usb/dwc3-omap.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/ioport.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/extcon.h>
> +#include <linux/extcon/of_extcon.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/usb/otg.h>
>  
> @@ -124,9 +126,21 @@ struct dwc3_omap {
>  	u32			utmi_otg_status;
>  
>  	u32			dma_status:1;
> +
> +	struct extcon_specific_cable_nb extcon_vbus_dev;
> +	struct extcon_specific_cable_nb extcon_id_dev;
> +	struct notifier_block	vbus_nb;
> +	struct notifier_block	id_nb;
> +
> +	struct regulator	*vbus_reg;
>  };
>  
> -static struct dwc3_omap		*_omap;
> +enum omap_dwc3_vbus_id_status {
> +	OMAP_DWC3_ID_FLOAT,
> +	OMAP_DWC3_ID_GROUND,
> +	OMAP_DWC3_VBUS_OFF,
> +	OMAP_DWC3_VBUS_VALID,
> +};
>  
>  static inline u32 dwc3_omap_readl(void __iomem *base, u32 offset)
>  {
> @@ -138,18 +152,23 @@ static inline void dwc3_omap_writel(void __iomem *base, u32 offset, u32 value)
>  	writel(value, base + offset);
>  }
>  
> -int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
> +static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
> +	enum omap_dwc3_vbus_id_status status)
>  {
> -	u32			val;
> -	struct dwc3_omap	*omap = _omap;
> -
> -	if (!omap)
> -		return -EPROBE_DEFER;
> +	int	ret;
> +	u32	val;
>  
>  	switch (status) {
>  	case OMAP_DWC3_ID_GROUND:
>  		dev_dbg(omap->dev, "ID GND\n");
>  
> +		if (omap->vbus_reg) {
> +			ret = regulator_enable(omap->vbus_reg);
> +			if (ret) {
> +				dev_dbg(omap->dev, "regulator enable failed\n");
> +				return;
> +			}
> +		}
>  		val = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
>  		val &= ~(USBOTGSS_UTMI_OTG_STATUS_IDDIG
>  				| USBOTGSS_UTMI_OTG_STATUS_VBUSVALID
> @@ -172,6 +191,9 @@ int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>  		break;
>  
>  	case OMAP_DWC3_ID_FLOAT:
> +		if (omap->vbus_reg)
> +			regulator_disable(omap->vbus_reg);
> +
>  	case OMAP_DWC3_VBUS_OFF:
>  		dev_dbg(omap->dev, "VBUS Disconnect\n");
>  
> @@ -185,12 +207,9 @@ int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>  		break;
>  
>  	default:
> -		dev_dbg(omap->dev, "ID float\n");
> +		dev_dbg(omap->dev, "invalid state\n");
>  	}
> -
> -	return 0;
>  }
> -EXPORT_SYMBOL_GPL(dwc3_omap_mailbox);
>  
>  static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
>  {
> @@ -282,6 +301,32 @@ static void dwc3_omap_disable_irqs(struct dwc3_omap *omap)
>  
>  static u64 dwc3_omap_dma_mask = DMA_BIT_MASK(32);
>  
> +static int dwc3_omap_id_notifier(struct notifier_block *nb,
> +	unsigned long event, void *ptr)
> +{
> +	struct dwc3_omap *omap = container_of(nb, struct dwc3_omap, id_nb);
> +
> +	if (event)
> +		dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_GROUND);
> +	else
> +		dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_FLOAT);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int dwc3_omap_vbus_notifier(struct notifier_block *nb,
> +	unsigned long event, void *ptr)
> +{
> +	struct dwc3_omap *omap = container_of(nb, struct dwc3_omap, vbus_nb);
> +
> +	if (event)
> +		dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_VALID);
> +	else
> +		dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_OFF);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static int dwc3_omap_probe(struct platform_device *pdev)
>  {
>  	struct device_node	*node = pdev->dev.of_node;
> @@ -289,6 +334,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>  	struct dwc3_omap	*omap;
>  	struct resource		*res;
>  	struct device		*dev = &pdev->dev;
> +	struct extcon_dev	*edev;
> +	struct regulator	*vbus_reg = NULL;
>  
>  	int			ret = -ENOMEM;
>  	int			irq;
> @@ -330,19 +377,22 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	if (of_property_read_bool(node, "vbus-supply")) {
> +		vbus_reg = devm_regulator_get(dev, "vbus");
> +		if (IS_ERR(vbus_reg)) {
> +			dev_err(dev, "vbus init failed\n");
> +			return PTR_ERR(vbus_reg);
> +		}
> +	}
> +
>  	spin_lock_init(&omap->lock);
>  
>  	omap->dev	= dev;
>  	omap->irq	= irq;
>  	omap->base	= base;
> +	omap->vbus_reg	= vbus_reg;
>  	dev->dma_mask	= &dwc3_omap_dma_mask;
>  
> -	/*
> -	 * REVISIT if we ever have two instances of the wrapper, we will be
> -	 * in big trouble
> -	 */
> -	_omap	= omap;
> -
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
> @@ -381,14 +431,47 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>  
>  	dwc3_omap_enable_irqs(omap);
>  
> +	if (of_property_read_bool(node, "extcon")) {
> +		edev = of_extcon_get_extcon_dev(dev, 0);
> +		if (IS_ERR(edev)) {
> +			dev_vdbg(dev, "couldn't get extcon device\n");
> +			ret = PTR_ERR(edev);
> +			goto err2;
> +		}
> +
> +		omap->vbus_nb.notifier_call = dwc3_omap_vbus_notifier;
> +		ret = extcon_register_interest(&omap->extcon_vbus_dev,
> +			edev->name, "USB", &omap->vbus_nb);
> +		if (ret < 0)
> +			dev_vdbg(dev,
> +			"extcon register interest of *USB* failed\n");
> +		omap->id_nb.notifier_call = dwc3_omap_id_notifier;
> +		ret = extcon_register_interest(&omap->extcon_id_dev, edev->name,
> +					 "USB-HOST", &omap->id_nb);
> +		if (ret < 0)
> +			dev_vdbg(dev,
> +			"extcon register interest of *USB-HOST* failed\n");
> +
> +		if (extcon_get_cable_state(edev, "USB") == true)
> +			dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_VALID);
> +		if (extcon_get_cable_state(edev, "USB-HOST") == true)
> +			dwc3_omap_set_mailbox(omap, OMAP_DWC3_ID_GROUND);
> +	}
> +
>  	ret = of_platform_populate(node, NULL, NULL, dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to create dwc3 core\n");
> -		goto err2;
> +		goto err3;
>  	}
>  
>  	return 0;
>  
> +err3:
> +	if (omap->extcon_vbus_dev.edev)
> +		extcon_unregister_interest(&omap->extcon_vbus_dev);
> +	if (omap->extcon_id_dev.edev)
> +		extcon_unregister_interest(&omap->extcon_id_dev);
> +
>  err2:
>  	dwc3_omap_disable_irqs(omap);
>  
> @@ -405,6 +488,10 @@ static int dwc3_omap_remove(struct platform_device *pdev)
>  {
>  	struct dwc3_omap	*omap = platform_get_drvdata(pdev);
>  
> +	if (omap->extcon_vbus_dev.edev)
> +		extcon_unregister_interest(&omap->extcon_vbus_dev);
> +	if (omap->extcon_id_dev.edev)
> +		extcon_unregister_interest(&omap->extcon_id_dev);
>  	dwc3_omap_disable_irqs(omap);
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> diff --git a/include/linux/usb/dwc3-omap.h b/include/linux/usb/dwc3-omap.h
> deleted file mode 100644
> index 5615f4d..0000000
> 

I have below some fixes for indentation and applied it (extcon-for-palmas branch).
-                       dev_vdbg(dev,
-                       "extcon register interest of *USB* failed\n");
+                       dev_vdbg(dev, "failed to register notifier for USB\n");
                omap->id_nb.notifier_call = dwc3_omap_id_notifier;
                ret = extcon_register_interest(&omap->extcon_id_dev, edev->name,
                                         "USB-HOST", &omap->id_nb);
                if (ret < 0)
                        dev_vdbg(dev,
-                       "extcon register interest of *USB-HOST* failed\n");
+                               "failed to register notifier for USB-HOST\n");
 
                if (extcon_get_cable_state(edev, "USB") == true)
                        dwc3_omap_set_mailbox(omap, OMAP_DWC3_VBUS_VALID);

You can check it on following git repository.
- http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-for-palmas&id=bd84f70d42b867dfce61f961fb1c50d22e3ab4a8

And, I have plan to move your patch from extcon-for-palmas to extcon-next branch
after below patch on usb.git is applied on v3.11

usb: dwc3: omap: improve error handling of dwc3_omap_probe
- https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=next&id=594daba1bcb0510cdc9dccfbab9e6fd5d9cc94e6
- git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git (next branch)


Thanks,
Chanwoo Choi














--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
