From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 09/13] mfd: omap-usb-host: Add device tree support and
 binding information
Date: Tue, 5 Feb 2013 17:41:02 +0530
Message-ID: <5110F6D6.8020900@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-10-git-send-email-rogerq@ti.com> <5110A3C6.6040808@ti.com> <5110E5C4.1000501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5110E5C4.1000501-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 05 February 2013 04:28 PM, Roger Quadros wrote:
> On 02/05/2013 08:16 AM, kishon wrote:
>> On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
>>> Allows the OMAP HS USB host controller to be specified
>>> via device tree.
>>>
>>> CC: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>> ---
>>>    .../devicetree/bindings/mfd/omap-usb-host.txt      |   68 ++++++++++++++++
>>>    drivers/mfd/omap-usb-host.c                        |   83 ++++++++++++++++++--
>>>    2 files changed, 145 insertions(+), 6 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>>> new file mode 100644
>>> index 0000000..2196893
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>>> @@ -0,0 +1,68 @@
>>> +OMAP HS USB Host
>>> +
>>> +Required properties:
>>> +
>>> +- compatible: should be "ti,usbhs-host"
>>> +- reg: should contain one register range i.e. start and length
>>> +- ti,hwmods: must contain "usb_host_hs"
>>> +
>>> +Optional properties:
>>> +
>>> +- nports: number of USB ports. Usually this is automatically detected
>>> +  from the IP's revision register but can be overridden by specifying
>>> +  this property.
>>> +
>>> +- portN_mode: Integer specifying the port mode for port N, where N can be
>>> +  from 1 to nports. The port mode must be as per enum usbhs_omap_port_mode
>>> +  in include/linux/platform_data/usb-omap.h
>>> +  If the port mode is not specified, that port is treated as unused.
>>> +
>>> +- single_ulpi_bypass: Must be present if the controller contains a single
>>> +  ULPI bypass control bit. e.g. OMAP3 silicon <= ES2.1
>>> +
>>> +Required properties if child node exists:
>>> +
>>> +- #address-cells: Must be 1
>>> +- #size-cells: Must be 1
>>> +- ranges: must be present
>>> +
>>> +Properties for children:
>>> +
>>> +The OMAP HS USB Host subsystem contains EHCI and OHCI controllers.
>>> +See Documentation/devicetree/bindings/usb/omap-ehci.txt and
>>> +omap3-ohci.txt
>>> +
>>> +Example for OMAP4:
>>> +
>>> +usbhshost: usbhshost@0x4a064000 {
>>> +    compatible = "ti,usbhs-host";
>>> +    reg = <0x4a064000 0x800>;
>>> +    ti,hwmods = "usb_host_hs";
>>> +    #address-cells = <1>;
>>> +    #size-cells = <1>;
>>> +    ranges;
>>> +
>>> +    usbhsohci: ohci@0x4a064800 {
>>> +        compatible = "ti,omap3-ohci", "usb-ohci";
>>> +        reg = <0x4a064800 0x400>;
>>> +        interrupt-parent = <&gic>;
>>> +        interrupts = <0 76 0x4>;
>>> +    };
>>> +
>>> +    usbhsehci: ehci@0x4a064c00 {
>>> +        compatible = "ti,omap-ehci", "usb-ehci";
>>> +        reg = <0x4a064c00 0x400>;
>>> +        interrupt-parent = <&gic>;
>>> +        interrupts = <0 77 0x4>;
>>> +    };
>>> +};
>>> +
>>> +&usbhshost {
>>> +    port1_mode = <1>; /* OMAP_EHCI_PORT_MODE_PHY */
>>> +    port2_mode = <2>; /* OMAP_EHCI_PORT_MODE_TLL */
>>> +    port3_mode = <1>; /* OMAP_EHCI_PORT_MODE_PHY */
>>> +};
>>> +
>>> +&usbhsehci {
>>> +    phy = <&hsusb1_phy 0 &hsusb3_phy>;
>>> +};
>>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>>> index f8ed08e..0f67856 100644
>>> --- a/drivers/mfd/omap-usb-host.c
>>> +++ b/drivers/mfd/omap-usb-host.c
>>> @@ -1,8 +1,9 @@
>>>    /**
>>>     * omap-usb-host.c - The USBHS core driver for OMAP EHCI & OHCI
>>>     *
>>> - * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
>>> + * Copyright (C) 2011-2013 Texas Instruments Incorporated - http://www.ti.com
>>>     * Author: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>> + * Author: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>     *
>>>     * This program is free software: you can redistribute it and/or modify
>>>     * it under the terms of the GNU General Public License version 2  of
>>> @@ -27,6 +28,8 @@
>>>    #include <linux/platform_device.h>
>>>    #include <linux/platform_data/usb-omap.h>
>>>    #include <linux/pm_runtime.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_platform.h>
>>>
>>>    #include "omap-usb.h"
>>>
>>> @@ -464,6 +467,37 @@ static void omap_usbhs_init(struct device *dev)
>>>        pm_runtime_put_sync(dev);
>>>    }
>>>
>>> +static int usbhs_omap_get_dt_pdata(struct device_node *node,
>>> +                    struct usbhs_omap_platform_data *pdata)
>>> +{
>>> +    int ret, i;
>>> +
>>> +    ret = of_property_read_u32(node, "nports", &pdata->nports);
>>> +    if (ret)
>>> +        pdata->nports = 0;
>>> +
>>> +    /* get port modes */
>>> +    for (i = 0; i < OMAP3_HS_USB_PORTS; i++) {
>>> +        char prop[11];
>>> +
>>> +        snprintf(prop, sizeof(prop), "port%d_mode", i + 1);
>>> +        ret = of_property_read_u32(node, prop, &pdata->port_mode[i]);
>>> +        if (ret)
>>> +            pdata->port_mode[i] = OMAP_USBHS_PORT_MODE_UNUSED;
>>> +    }
>>> +
>>> +    /* get flags */
>>> +    pdata->single_ulpi_bypass = of_property_read_bool(node,
>>> +                        "single_ulpi_bypass");
>>> +    return 0;
>>> +}
>>> +
>>> +static struct of_device_id usbhs_child_match_table[] __initdata = {
>>> +    { .compatible = "ti,omap-ehci", },
>>> +    { .compatible = "ti,omap-ohci", },
>>> +    { }
>>> +};
>>> +
>>>    /**
>>>     * usbhs_omap_probe - initialize TI-based HCDs
>>>     *
>>> @@ -479,6 +513,21 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>>        int                i;
>>>        bool                need_logic_fck;
>>>
>>> +    if (dev->of_node) {
>>> +        /* For DT boot we populate platform data from OF node */
>>> +        pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>> +        if (!pdata)
>>> +            return -ENOMEM;
>>> +
>>> +        if (usbhs_omap_get_dt_pdata(dev->of_node, pdata)) {
>>> +            dev_err(dev,
>>> +                "Error getting platform data from DT node\n");
>>> +            return -ENODEV;
>>> +        }
>>> +
>>> +        dev->platform_data = pdata;
>>> +    }
>>> +
>>>        if (!pdata) {
>>>            dev_err(dev, "Missing platform data\n");
>>>            return -ENODEV;
>>> @@ -490,7 +539,7 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>>            return -ENOMEM;
>>>        }
>>>
>>> -    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>        omap->uhh_base = devm_request_and_ioremap(dev, res);
>>>        if (!omap->uhh_base) {
>>>            dev_err(dev, "Resource request/ioremap failed\n");
>>> @@ -661,10 +710,23 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>>        }
>>>
>>>        omap_usbhs_init(dev);
>>> -    ret = omap_usbhs_alloc_children(pdev);
>>> -    if (ret) {
>>> -        dev_err(dev, "omap_usbhs_alloc_children failed\n");
>>> -        goto err_alloc;
>>> +
>>> +    if (dev->of_node) {
>>> +        ret = of_platform_populate(dev->of_node,
>>> +                usbhs_child_match_table, NULL, dev);
>>> +
>>> +        if (ret) {
>>> +            dev_err(dev, "Failed to create DT children: %d\n", ret);
>>> +            goto err_alloc;
>>> +        }
>>> +
>>> +    } else {
>>> +        ret = omap_usbhs_alloc_children(pdev);
>>> +        if (ret) {
>>> +            dev_err(dev, "omap_usbhs_alloc_children failed: %d\n",
>>> +                        ret);
>>> +            goto err_alloc;
>>> +        }
>> These child devices should be destroyed on driver remove..no?
>>
> I could not find a function that does the opposite of of_platform_populate() or
> of_platform_device_create_pdata(). It seems that platform devices created via
> device tree are never meant to be destroyed.

No. I've done it for dwc3 in usb/dwc3/dwc3-omap.c. (you can check usb-next)
>
> It kind of makes sense for EHCI/OHCI, cause the devices are always present
> on the SoC.
Not true for devices created in drivers/ IMHO. It makes sense only if 
you create the device in some platform specific initialization file.

> Also, this driver can't be built as a module so it can never be removed.
Why is this restriction btw?

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
