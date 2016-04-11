From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Mon, 11 Apr 2016 13:54:32 +0300
Message-ID: <570B8268.6090700@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <SG2PR06MB091922CDE73AE061A79E90E4D8900@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <57064850.3060405@ti.com>
 <SG2PR06MB09197595F9D810CF8A22D860D8910@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB09197595F9D810CF8A22D860D8910@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 08/04/16 14:22, Yoshihiro Shimoda wrote:
> Hi,
> 
>> From: Roger Quadros
>> Sent: Thursday, April 07, 2016 8:45 PM
>>
>> Hi,
>>
>> On 07/04/16 11:52, Yoshihiro Shimoda wrote:
>>> Hi,
>>>
>>>> From: Roger Quadros
>>>> Sent: Tuesday, April 05, 2016 11:05 PM
> < snip >
>>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>>> index 41e762a..4d7f043 100644
>>> --- a/drivers/usb/common/usb-otg.c
>>> +++ b/drivers/usb/common/usb-otg.c
>>> @@ -825,11 +825,16 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>>  	if (otg->primary_hcd.hcd) {
>>>  		/* probably a shared HCD ? */
>>>  		if (usb_otg_hcd_is_primary_hcd(hcd)) {
>>> +			if (hcd->driver->flags & HCD_USB11) {
>>> +				dev_info(otg_dev, "this assumes usb 1.1 hc is as shared_hcd\n");
>>> +				goto check_shared_hcd;
>>> +			}
>>>  			dev_err(otg_dev, "otg: primary host already registered\n");
>>>  			goto err;
>>>  		}
>>>
>>>  		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
>>> +check_shared_hcd:
>>>  			if (otg->shared_hcd.hcd) {
>>>  				dev_err(otg_dev, "otg: shared host already registered\n");
>>>  				goto err;
>>>
>>> What do you think this local hack?
>>
>> Is it guaranteed that EHCI hcd registers before OHCI hcd?
> 
> Thank you for the comment. No, it is not guaranteed.
> 
>> If not we need to improve the code still.
>> We will also need to remove the constraint that primary_hcd must be registered
>> first in usb_otg_register_hcd(). I think that constraint is no longer
>> needed anyways.
> 
> I got it.
> So, I made a patch to avoid the constraint using an additional property "otg-hcds".
> The patch is in this end of email. What do you think about the patch?

This might only solve the issue for device tree but what about non-device tree?
We need to deal with both cases.

> 
>> If EHCI & OHCI HCDs register before OTG driver then things will break unless
>> we fix usb_otg_hcd_wait_add(). We need to add this HCD_USB11 check there to
>> populate wait->shared_hcd.
> 
> I see. In my environment, since EHCI & OHCI HCDs need phy driver and phy driver
> will calls usb_otg_register(), the order is right. In other words,
> EHCI & OHCI HCDs never register before OTG driver because even if EHCI driver
> is probed first, the driver will be deferred (EHCI driver needs the phy driver).

But still we cannot assume this is true for all platforms. OTG driver can also
be a separate entity than PHY driver.

> 
>>> I also wonder if array of hcd may be good for both xHCI and EHCI/OHCI.
>>> For example of xHCI:
>>>  - otg->hcds[0] = primary_hcd
>>>  - otg->hcds[1] = shared_hcd
>>>
>>> For example of EHCI/OHCI:
>>>  - otg->hcds[0] = primary_hcd of EHCI
>>>  - otg->hcds[1] = primary_hcd of OHCI
>>
>> The bigger problem is that how do we know in the OHCI/EHCI case that we need to wait
>> for both of them before starting the OTG FSM?
>> Some systems might use just OHCI or just EHCI.
>>
>> There is no guarantee that OTG driver registers before the HCDs so this piece
>> of information must come from the HCD itself. i.e. whether it needs a companion or not.
> 
> I understood these problems. I wonder if my patch can resolve these problems.
> 
> Best regards,
> Yoshihiro Shimoda
> ---
> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> index f6866c1..518b9eb 100644
> --- a/Documentation/devicetree/bindings/usb/generic.txt
> +++ b/Documentation/devicetree/bindings/usb/generic.txt
> @@ -27,6 +27,12 @@ Optional properties:
>   - otg-controller: phandle to otg controller. Host or gadget controllers can
>  			contain this property to link it to a particular OTG
>  			controller.
> + - otg-hcds: phandle to host controller(s). An OTG controller can contain this
> +	     property. The first one is as "primary", and (optional) the second
> +	     one is as "shared".
> +	     - For example for xHCI:		otg-hcds = <&xhci>, <&xhci>;
> +	     - For example for EHCI/OHCI:	otg-hcds = <&ehci>, <&ohci>;
> +	     - For example for just EHCI:	otg-hcds = <&ehci>;
>  

This is kind of duplicating the information. We are already specifying in the
hcd nodes as to which otg controller it is linked to.

Instead, how about just adding a boolean property in the otg node saying that
HCD needs companion. e.g.
	hcd-needs-compainion: must be present if otg controller is dealing with
			EHCI host controller that needs a companion OHCI host controller.

This can also be added in struct usb_otg_config so that it can deal with non-DT cases.

So if this property is true, the OTG core will wait for 2 primary HCDs to be registered.

cheers,
-roger

>  This is an attribute to a USB controller such as:
>  
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 741d9d2..9dcf76ac 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -1253,6 +1253,7 @@
>  			compatible = "renesas,usb2-phy-r8a7795";
>  			reg = <0 0xee080200 0 0x700>;
>  			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			otg-hcds = <&ehci0>, <&ohci0>;
>  			clocks = <&cpg CPG_MOD 703>;
>  			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
>  			#phy-cells = <0>;
> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
> index 41e762a..9a78482 100644
> --- a/drivers/usb/common/usb-otg.c
> +++ b/drivers/usb/common/usb-otg.c
> @@ -258,7 +258,8 @@ static void usb_otg_flush_wait(struct device *otg_dev)
>  
>  	dev_dbg(otg_dev, "otg: registering pending host/gadget\n");
>  	gadget = &wait->gcd;
> -	if (gadget)
> +	/* I'm not sure but gadget->gadget is possible to be NULL */
> +	if (gadget && gadget->gadget)
>  		usb_otg_register_gadget(gadget->gadget, gadget->ops);
>  
>  	host = &wait->primary_hcd;
> @@ -567,6 +568,8 @@ struct usb_otg *usb_otg_register(struct device *dev,
>  {
>  	struct usb_otg *otg;
>  	struct otg_wait_data *wait;
> +	struct device_node *np;
> +	struct platform_device *pdev;
>  	int ret = 0;
>  
>  	if (!dev || !config || !config->fsm_ops)
> @@ -616,6 +619,40 @@ struct usb_otg *usb_otg_register(struct device *dev,
>  	list_add_tail(&otg->list, &otg_list);
>  	mutex_unlock(&otg_list_mutex);
>  
> +	/* Get primary hcd device (mandatory) */
> +	np = of_parse_phandle(dev->of_node, "otg-hcds", 0);
> +	if (!np) {
> +		dev_err(dev, "no otg-hcds\n");
> +		ret = -EINVAL;
> +		goto err_dt;
> +	}
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev) {
> +		dev_err(dev, "coulnd't get primary hcd device\n");
> +		ret = -ENODEV;
> +		goto err_dt;
> +	}
> +	otg->primary_dev = &pdev->dev;
> +
> +	/* Get shared hcd device (optional) */
> +	np = of_parse_phandle(dev->of_node, "otg-hcds", 1);
> +	if (np) {
> +		pdev = of_find_device_by_node(np);
> +		of_node_put(np);
> +		if (!pdev) {
> +			dev_err(dev, "coulnd't get shared hcd device\n");
> +			ret = -ENODEV;
> +			goto err_dt;
> +		}
> +		otg->shared_dev = &pdev->dev;
> +	} else {
> +		dev_dbg(dev, "no shared hcd\n");
> +	}
> +
> +	if (otg->primary_dev != otg->shared_dev)
> +		otg->flags |= OTG_FLAG_SHARED_IS_2ND_PRIMARY;
> +
>  	/* were we in wait list? */
>  	mutex_lock(&wait_list_mutex);
>  	wait = usb_otg_get_wait(dev);
> @@ -627,6 +664,8 @@ struct usb_otg *usb_otg_register(struct device *dev,
>  
>  	return otg;
>  
> +err_dt:
> +	destroy_workqueue(otg->wq);
>  err_wq:
>  	kfree(otg);
>  unlock:
> @@ -822,50 +861,42 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>  
>  	/* HCD will be started by OTG fsm when needed */
>  	mutex_lock(&otg->fsm.lock);
> -	if (otg->primary_hcd.hcd) {
> -		/* probably a shared HCD ? */
> -		if (usb_otg_hcd_is_primary_hcd(hcd)) {
> -			dev_err(otg_dev, "otg: primary host already registered\n");
> -			goto err;
> +	if (!otg->primary_hcd.hcd) {
> +		dev_info(hcd_dev, "%s: primary %s, now %s\n", __func__,
> +			dev_name(otg->primary_dev),
> +			dev_name(hcd->self.controller));
> +		if (otg->primary_dev == hcd->self.controller) {
> +			otg->primary_hcd.hcd = hcd;
> +			otg->primary_hcd.irqnum = irqnum;
> +			otg->primary_hcd.irqflags = irqflags;
> +			otg->primary_hcd.ops = ops;
> +			otg->hcd_ops = ops;
> +			dev_info(otg_dev, "otg: primary host %s registered\n",
> +				 dev_name(hcd->self.controller));
>  		}
> +	}
>  
> -		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
> -			if (otg->shared_hcd.hcd) {
> -				dev_err(otg_dev, "otg: shared host already registered\n");
> -				goto err;
> -			}
> -
> +	if (!otg->shared_hcd.hcd && (!usb_otg_hcd_is_primary_hcd(hcd) ||
> +			otg->flags & OTG_FLAG_SHARED_IS_2ND_PRIMARY)) {
> +		dev_info(hcd_dev, "%s: shared %s, now %s\n", __func__,
> +			dev_name(otg->shared_dev),
> +			dev_name(hcd->self.controller));
> +		if (otg->shared_dev == hcd->self.controller) {
>  			otg->shared_hcd.hcd = hcd;
>  			otg->shared_hcd.irqnum = irqnum;
>  			otg->shared_hcd.irqflags = irqflags;
>  			otg->shared_hcd.ops = ops;
>  			dev_info(otg_dev, "otg: shared host %s registered\n",
>  				 dev_name(hcd->self.controller));
> -		} else {
> -			dev_err(otg_dev, "otg: invalid shared host %s\n",
> -				dev_name(hcd->self.controller));
> -			goto err;
> -		}
> -	} else {
> -		if (!usb_otg_hcd_is_primary_hcd(hcd)) {
> -			dev_err(otg_dev, "otg: primary host must be registered first\n");
> -			goto err;
>  		}
> -
> -		otg->primary_hcd.hcd = hcd;
> -		otg->primary_hcd.irqnum = irqnum;
> -		otg->primary_hcd.irqflags = irqflags;
> -		otg->primary_hcd.ops = ops;
> -		otg->hcd_ops = ops;
> -		dev_info(otg_dev, "otg: primary host %s registered\n",
> -			 dev_name(hcd->self.controller));
>  	}
>  
>  	/*
>  	 * we're ready only if we have shared HCD
>  	 * or we don't need shared HCD.
>  	 */
> -	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
> +	if (otg->primary_hcd.hcd && (!otg->shared_dev ||
> +	    (otg->shared_dev && otg->shared_hcd.hcd))) {
>  		otg->host = hcd_to_bus(hcd);
>  		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
>  
> @@ -878,10 +909,6 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>  	mutex_unlock(&otg->fsm.lock);
>  
>  	return 0;
> -
> -err:
> -	mutex_unlock(&otg->fsm.lock);
> -	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(usb_otg_register_hcd);
>  
> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> index b094352..ed08865 100644
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -51,6 +51,8 @@ struct otg_hcd {
>   * @fsm: otg finite state machine
>   * @hcd_ops: host controller interface
>   * ------- internal use only -------
> + * @primary_dev: primary host device for matching
> + * @shared_dev: (optional) shared or other primary host device for matching
>   * @primary_hcd: primary host state and interface
>   * @shared_hcd: shared host state and interface
>   * @gadget_ops: gadget controller interface
> @@ -75,6 +77,8 @@ struct usb_otg {
>  	struct otg_hcd_ops	*hcd_ops;
>  
>  	/* internal use only */
> +	struct device *primary_dev;
> +	struct device *shared_dev;
>  	struct otg_hcd primary_hcd;
>  	struct otg_hcd shared_hcd;
>  	struct otg_gadget_ops *gadget_ops;
> @@ -84,6 +88,7 @@ struct usb_otg {
>  	u32 flags;
>  #define OTG_FLAG_GADGET_RUNNING (1 << 0)
>  #define OTG_FLAG_HOST_RUNNING (1 << 1)
> +#define OTG_FLAG_SHARED_IS_2ND_PRIMARY (1 << 2)
>  	/* use otg->fsm.lock for serializing access */
>  
>  /*------------- deprecated interface -----------------------------*/
> 
> 
