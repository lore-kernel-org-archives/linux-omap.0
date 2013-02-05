From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 09/13] mfd: omap-usb-host: Add device tree support and
 binding information
Date: Tue, 5 Feb 2013 16:42:09 +0200
Message-ID: <51111A41.4050607@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-10-git-send-email-rogerq@ti.com> <20130205142049.GC26842@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50237 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab3BEOm1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 09:42:27 -0500
In-Reply-To: <20130205142049.GC26842@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/05/2013 04:20 PM, Mark Rutland wrote:
> Hi,
> 
> I have a few comments on the binding and the way it's parsed.
> 
> On Mon, Feb 04, 2013 at 03:58:56PM +0000, Roger Quadros wrote:
>> Allows the OMAP HS USB host controller to be specified
>> via device tree.
>>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  .../devicetree/bindings/mfd/omap-usb-host.txt      |   68 ++++++++++++++++
>>  drivers/mfd/omap-usb-host.c                        |   83 ++++++++++++++++++--
>>  2 files changed, 145 insertions(+), 6 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>> new file mode 100644
>> index 0000000..2196893
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>> @@ -0,0 +1,68 @@
>> +OMAP HS USB Host
>> +
>> +Required properties:
>> +
>> +- compatible: should be "ti,usbhs-host"
>> +- reg: should contain one register range i.e. start and length
>> +- ti,hwmods: must contain "usb_host_hs"
>> +
>> +Optional properties:
>> +
>> +- nports: number of USB ports. Usually this is automatically detected
>> +  from the IP's revision register but can be overridden by specifying
>> +  this property.
> 
> It would be nice if this were "num-ports", as atmel-usb is already using that,
> and it's clear that it's a number of ports rather than some other meaning of
> 'n'.
> 
> From a quick grep of binding documents, out of "nTHING(s)", "nr-THINGs", and
> num-THINGs, num-THINGs seems to be the most common. It would be nice if new
> bindings could standardise this.

Agreed.
> 
>> +
>> +- portN_mode: Integer specifying the port mode for port N, where N can be
>> +  from 1 to nports. The port mode must be as per enum usbhs_omap_port_mode
>> +  in include/linux/platform_data/usb-omap.h
>> +  If the port mode is not specified, that port is treated as unused.
> 
> I'm against devicetree bindings refering to Linux internals. It makes a poorly
> documented ABI that someone might change in future without realising the
> implications, and it makes it stupidly difficult to read a dts.
> 
> Everything required should be specified in the binding document (or another
> linked binding document). It might be better to describe this with a string
> property that gets mapped by your dt parsing code to whatever internal
> representation you need. That way it's far easier for a human to verify the dts
> is correct, and you know by construction that the parsed value is something you
> can handle in the driver.

As string makes it self documenting, I'll convert it to a string and update the
binding document.

> 
> It would be nicer is you used '-' rather than '_' for consistency with
> devicetree bindings in general.

OK.

> 
>> +
>> +- single_ulpi_bypass: Must be present if the controller contains a single
>> +  ULPI bypass control bit. e.g. OMAP3 silicon <= ES2.1
> 
> Again it would be nicer to have '-' rather than '_' here. It might be worth
> prefixing this "ti,".

Is prefixing with "ti" really required? how does it better?

> 
>> +
>> +Required properties if child node exists:
>> +
>> +- #address-cells: Must be 1
>> +- #size-cells: Must be 1
>> +- ranges: must be present
>> +
>> +Properties for children:
>> +
>> +The OMAP HS USB Host subsystem contains EHCI and OHCI controllers.
>> +See Documentation/devicetree/bindings/usb/omap-ehci.txt and
>> +omap3-ohci.txt
>> +
>> +Example for OMAP4:
>> +
>> +usbhshost: usbhshost@0x4a064000 {
>> +	compatible = "ti,usbhs-host";
>> +	reg = <0x4a064000 0x800>;
>> +	ti,hwmods = "usb_host_hs";
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	ranges;
>> +
>> +	usbhsohci: ohci@0x4a064800 {
>> +		compatible = "ti,omap3-ohci", "usb-ohci";
>> +		reg = <0x4a064800 0x400>;
>> +		interrupt-parent = <&gic>;
>> +		interrupts = <0 76 0x4>;
>> +	};
>> +
>> +	usbhsehci: ehci@0x4a064c00 {
>> +		compatible = "ti,omap-ehci", "usb-ehci";
>> +		reg = <0x4a064c00 0x400>;
>> +		interrupt-parent = <&gic>;
>> +		interrupts = <0 77 0x4>;
>> +	};
>> +};
>> +
>> +&usbhshost {
>> +	port1_mode = <1>; /* OMAP_EHCI_PORT_MODE_PHY */
>> +	port2_mode = <2>; /* OMAP_EHCI_PORT_MODE_TLL */
>> +	port3_mode = <1>; /* OMAP_EHCI_PORT_MODE_PHY */
> 
> With a string property, these values would be self-documenting.
> 
>> +};
>> +
>> +&usbhsehci {
>> +	phy = <&hsusb1_phy 0 &hsusb3_phy>;
>> +};
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index f8ed08e..0f67856 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -1,8 +1,9 @@
>>  /**
>>   * omap-usb-host.c - The USBHS core driver for OMAP EHCI & OHCI
>>   *
>> - * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
>> + * Copyright (C) 2011-2013 Texas Instruments Incorporated - http://www.ti.com
>>   * Author: Keshava Munegowda <keshava_mgowda@ti.com>
>> + * Author: Roger Quadros <rogerq@ti.com>
>>   *
>>   * This program is free software: you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License version 2  of
>> @@ -27,6 +28,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/platform_data/usb-omap.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>>  
>>  #include "omap-usb.h"
>>  
>> @@ -464,6 +467,37 @@ static void omap_usbhs_init(struct device *dev)
>>  	pm_runtime_put_sync(dev);
>>  }
>>  
>> +static int usbhs_omap_get_dt_pdata(struct device_node *node,
>> +					struct usbhs_omap_platform_data *pdata)
>> +{
>> +	int ret, i;
>> +
>> +	ret = of_property_read_u32(node, "nports", &pdata->nports);
>> +	if (ret)
>> +		pdata->nports = 0;
> 
> Is there no upper bound on how many ports the controller can have lower than
> 4294967295?
> 
> I see there are several places in the driver that assume you can only have at
> most OMAP3_HS_USB_PORTS (i.e. 3) ports. Is this expected to grow, or is the
> hardware design capped at 3?

AFAIK it is capped at 3.
> 
> I don't seem to have usbhs_omap_platform_data::nports in my tree, and I
> couldn't see it addded in any of this series so far. Where can I find a tree
> with it present? 

It should be in linux-next. Alternatively you can pull the patchset from 
	git://github.com/rogerq/linux.git linux-usbhost14-part

> 
> Is it a u32? If not, you'll need to use a temporary when reading the dt.

nports is int.
> 
>> +
>> +	/* get port modes */
>> +	for (i = 0; i < OMAP3_HS_USB_PORTS; i++) {
>> +		char prop[11];
>> +
>> +		snprintf(prop, sizeof(prop), "port%d_mode", i + 1);
>> +		ret = of_property_read_u32(node, prop, &pdata->port_mode[i]);
>> +		if (ret)
>> +			pdata->port_mode[i] = OMAP_USBHS_PORT_MODE_UNUSED;
> 
> What if the port has an invalid mode value? What if something needs to be added
> to or removed from the enum in future?

Right. I'll add checks for invalid modes and print a warning.

> 
> In my tree, pdata->port_mode[i] is an enum usbhs_omap_port_mode, not a u32.
> Assuming it's the same in your tree. depending on what size the compiler
> allocates the enum, you may clobber the other entries in the array (or data
> immediately beyond it).

it pdata->port_mod[i] is still enum usbhs_omap_port_mode. So i'll have to fix this.

> 
> It'd at least be worth warning the user if there's a value the driver doesn't
> understand.
> 
>> +	}
>> +
>> +	/* get flags */
>> +	pdata->single_ulpi_bypass = of_property_read_bool(node,
>> +						"single_ulpi_bypass");
>> +	return 0;
>> +}
>> +
>> +static struct of_device_id usbhs_child_match_table[] __initdata = {
>> +	{ .compatible = "ti,omap-ehci", },
>> +	{ .compatible = "ti,omap-ohci", },
>> +	{ }
>> +};
>> +
>>  /**
>>   * usbhs_omap_probe - initialize TI-based HCDs
>>   *
>> @@ -479,6 +513,21 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>  	int				i;
>>  	bool				need_logic_fck;
>>  
>> +	if (dev->of_node) {
>> +		/* For DT boot we populate platform data from OF node */
>> +		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +		if (!pdata)
>> +			return -ENOMEM;
>> +
>> +		if (usbhs_omap_get_dt_pdata(dev->of_node, pdata)) {
>> +			dev_err(dev,
>> +				"Error getting platform data from DT node\n");
>> +			return -ENODEV;
> 
> This is currently unnecessary, as usbhs_omap_get_dt_pdata always returns 0.
> 
> It would be nicer if it error'd out on an invalid dt.

yes.

> 
>> +		}
>> +
>> +		dev->platform_data = pdata;
>> +	}
>> +
>>  	if (!pdata) {
>>  		dev_err(dev, "Missing platform data\n");
>>  		return -ENODEV;
> 

Thanks for the in-depth review :).

cheers,
-roger

