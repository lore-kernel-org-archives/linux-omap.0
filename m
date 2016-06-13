From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v10 09/14] usb: of: add an API to get OTG device from USB
 controller node
Date: Mon, 13 Jun 2016 11:16:38 +0300
Message-ID: <575E6BE6.7020800@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-10-git-send-email-rogerq@ti.com>
 <AM4PR04MB213007B012120B6FF67F869689530@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM4PR04MB213007B012120B6FF67F869689530-WOempg8NbQQzjTQnahXoOs9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>, "b-liu-l0cyMroinI0@public.gmane.org" <b-liu-l0cyMroinI0@public.gmane.org>, "joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org" <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 13/06/16 11:13, Jun Li wrote:
> Hi
> 
>> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
>> index e3d0161..d7ec471 100644
>> --- a/drivers/usb/common/common.c
>> +++ b/drivers/usb/common/common.c
>> @@ -238,6 +238,33 @@ int of_usb_update_otg_caps(struct device_node *np,  }
>> EXPORT_SYMBOL_GPL(of_usb_update_otg_caps);
>>
>> +#ifdef CONFIG_USB_OTG
>> +/**
>> + * of_usb_get_otg - get the OTG controller linked to the USB controller
>> + * @np: Pointer to the device_node of the USB controller
>> + * @otg_caps: Pointer to the target usb_otg_caps to be set
> 
> Remove otg_caps.

Sure.

> 
>> + *
>> + * Returns the OTG controller device or NULL on error.
>> + */
>> +struct device *of_usb_get_otg(struct device_node *np) {
>> +	struct device_node *otg_np;
>> +	struct platform_device *pdev;
>> +
>> +	otg_np = of_parse_phandle(np, "otg-controller", 0);
>> +	if (!otg_np)
>> +		return NULL;
>> +
>> +	pdev = of_find_device_by_node(otg_np);
>> +	of_node_put(otg_np);
>> +	if (!pdev)
>> +		return NULL;
>> +
>> +	return &pdev->dev;
>> +}
>> +EXPORT_SYMBOL_GPL(of_usb_get_otg);
>> +#endif
>> +
>>  #endif
>>
>>  MODULE_LICENSE("GPL");
>> diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h index
>> de3237f..499a4e8 100644
>> --- a/include/linux/usb/of.h
>> +++ b/include/linux/usb/of.h
>> @@ -40,6 +40,15 @@ static inline struct device_node
>> *usb_of_get_child_node  }  #endif
>>
>> +#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_OTG) struct device
>> +*of_usb_get_otg(struct device_node *np); #else static inline struct
>> +device *of_usb_get_otg(struct device_node *np) {
>> +	return NULL;
>> +}
>> +#endif
>> +
>>  #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_SUPPORT)  enum
>> usb_phy_interface of_usb_get_phy_mode(struct device_node *np);  #else
>> --
>> 2.7.4
> 

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
