From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v10 13/14] usb: gadget: udc: adapt to OTG core
Date: Mon, 13 Jun 2016 10:37:59 +0300
Message-ID: <575E62D7.8010409@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-14-git-send-email-rogerq@ti.com>
 <20160612113655.GC32615@shlinux2> <575E5D57.7010700@ti.com>
 <20160613072019.GB19728@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160613072019.GB19728@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 13/06/16 10:20, Peter Chen wrote:
> On Mon, Jun 13, 2016 at 10:14:31AM +0300, Roger Quadros wrote:
>> On 12/06/16 14:36, Peter Chen wrote:
>>> On Fri, Jun 10, 2016 at 04:07:22PM +0300, Roger Quadros wrote:
>>>>  
>>>> +/**
>>>> + * usb_otg_add_gadget_udc - adds a new gadget to the udc class driver list
>>>> + * @parent: the parent device to this udc. Usually the controller
>>>> + * driver's device.
>>>
>>> It seems it should be udc device
>>
>> Parent and udc->dev are not the same right?
> 
> Sure, udc's parent is otg device.
> 
>>
>> I guess i'll omit the second statement to avoid confusion. So.
>>
>> @parent: the parent device to this udc.
> 
> Where you call below APIs? It seems to be a udc driver, right?
> So, when you try to get "otg-controller" from the node, this node
> should be udc.

@parent is actually the device that represents the USB Device controller
in the device tree. When you call usb_add_gadget_udc_release() a new
udc->dev device is created as it's child.

See explanation for the @parent argument in usb_add_gadget_udc_release().
As we want to keep the parent argument identical to that I will not make
any changes then.

> 
> /**
>  * usb_otg_add_gadget_udc - adds a new gadget to the udc class driver list
>  * @parent: the parent device to this udc. Usually the controller
>  * driver's device.
>  * @gadget: the gadget to be added to the list
>  * @otg_dev: the OTG controller device
>  *
>  * If otg_dev is NULL then device tree node is checked
>  * for OTG controller via the otg-controller property.
>  * Returns zero on success, negative errno otherwise.
>  */
> int usb_otg_add_gadget_udc(struct device *parent, struct usb_gadget *gadget,
> 			   struct device *otg_dev)
> {
> 	if (!otg_dev) {
> 		gadget->otg_dev = of_usb_get_otg(parent->of_node);
> 		if (!gadget->otg_dev)
> 			return -ENODEV;
> 	} else {
> 		gadget->otg_dev = otg_dev;
> 	}
> 
> 	return usb_add_gadget_udc_release(parent, gadget, NULL);
> }
> EXPORT_SYMBOL_GPL(usb_otg_add_gadget_udc);
> 

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
