From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v10 08/14] usb: otg: add OTG/dual-role core
Date: Mon, 13 Jun 2016 10:42:48 +0300
Message-ID: <575E63F8.8050309@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com>
 <20160612112105.GB32615@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160612112105.GB32615@shlinux2>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 12/06/16 14:21, Peter Chen wrote:
> On Fri, Jun 10, 2016 at 04:07:17PM +0300, Roger Quadros wrote:
>> index dca7856..03f7204 100644
>> --- a/drivers/usb/Makefile
>> +++ b/drivers/usb/Makefile
>> @@ -59,5 +59,6 @@ obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
>>  obj-$(CONFIG_USB_GADGET)	+= gadget/
>>  
>>  obj-$(CONFIG_USB_COMMON)	+= common/
>> +obj-$(CONFIG_USB_OTG_CORE)	+= common/
> 
> I don't think you need to make above change, why you do it?

You are right. I no longer get undefined symbol errors during build.
I'll remove this change.
> 
>> +
>> +/**
>> + * usb_otg_get_data() - get usb_otg data structa
> 
> %s/structa/structure

OK.
> 
>> +
>> +/**
>> + * usb_otg_kick_fsm() - Kick the OTG state machine
>> + * @otg_dev:	OTG controller device
>> + *
>> + * Used by USB host/gadget stack to sync OTG related
>> + * events to the OTG state machine.
>> + * e.g. change in host_bus->b_hnp_enable, gadget->b_hnp_enable
>> + *
>> + * Return: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_kick_fsm(struct device *otg_dev)
>> +{
>> +	struct usb_otg *otg;
>> +
>> +	mutex_lock(&otg_list_mutex);
>> +	otg = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otg) {
>> +		dev_dbg(otg_dev, "otg: %s: invalid otg device\n",
>> +			__func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	usb_otg_sync_inputs(otg);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_kick_fsm);
> 
> Do you have any users for this API? If no, please delete it in this
> version.

I'll remove it.
> 
>> +
>> +/**
>> + * usb_otg_register_hcd() - Register the host controller to OTG core
>> + * @hcd:	host controller
>> + * @irqnum:	interrupt number
>> + * @irqflags:	interrupt flags
>> + * @ops:	HCD ops to interface with the HCD
>> + *
>> + * This is used by the USB Host stack to register the host controller
>> + * to the OTG core. Host controller must not be started by the
>> + * caller as it is left upto the OTG state machine to do so.
> 
> %s/upto/up to
> 
>> +
>> +/**
>> + * usb_otg_register_gadget() - Register the gadget controller to OTG core
>> + * @gadget:	gadget controller instance
>> + * @ops:	gadget interface ops
>> + *
>> + * This is used by the USB gadget stack to register the gadget controller
>> + * to the OTG core. Gadget controller must not be started by the
>> + * caller as it is left upto the OTG state machine to do so.
>> + *
> 
> %s/upto/up to
> 

OK for both.

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
