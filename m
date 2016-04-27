From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
Date: Wed, 27 Apr 2016 14:22:46 +0300
Message-ID: <5720A106.1030702@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-10-git-send-email-rogerq@ti.com>
 <AM4PR04MB2130ACE0588E64EA723987E3896E0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <571E23D7.5070501@ti.com>
 <AM4PR04MB2130B0F024C0B275514020DE89630@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM4PR04MB2130B0F024C0B275514020DE89630-WOempg8NbQQzjTQnahXoOs9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 26/04/16 03:07, Jun Li wrote:
> Hi
> 
>> -----Original Message-----
>> From: Roger Quadros [mailto:rogerq-l0cyMroinI0@public.gmane.org]
>> Sent: Monday, April 25, 2016 10:04 PM
>> To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>; stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org; balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
>> gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
>> Cc: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org;
>> mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org;
>> abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org; r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: Re: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
>>
>> Hi,
>>
>> On 21/04/16 09:38, Jun Li wrote:
>>> Hi,
>>>
>>> ...
>>>>
>>>>  /**
>>>> + * usb_gadget_start - start the usb gadget controller and connect to
>>>> +bus
>>>> + * @gadget: the gadget device to start
>>>> + *
>>>> + * This is external API for use by OTG core.
>>>> + *
>>>> + * Start the usb device controller and connect to bus (enable pull).
>>>> + */
>>>> +static int usb_gadget_start(struct usb_gadget *gadget) {
>>>> +	int ret;
>>>> +	struct usb_udc *udc = NULL;
>>>> +
>>>> +	dev_dbg(&gadget->dev, "%s\n", __func__);
>>>> +	mutex_lock(&udc_lock);
>>>> +	list_for_each_entry(udc, &udc_list, list)
>>>> +		if (udc->gadget == gadget)
>>>> +			goto found;
>>>> +
>>>> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
>>>> +		__func__);
>>>> +	mutex_unlock(&udc_lock);
>>>> +	return -EINVAL;
>>>> +
>>>> +found:
>>>> +	ret = usb_gadget_udc_start(udc);
>>>> +	if (ret)
>>>> +		dev_err(&udc->dev, "USB Device Controller didn't start: %d\n",
>>>> +			ret);
>>>> +	else
>>>> +		usb_udc_connect_control(udc);
>>>
>>> For drd, it's fine, but for real otg, gadget connect should be done by
>>> loc_conn() instead of gadget start.
>>
>> It is upto the OTG state machine to call gadget_start() when it needs to
>> connect to the bus (i.e. loc_conn()). I see no point in calling gadget
>> start before.
>>
>> Do you see any issue in doing so?
> 
> This is what OTG state machine does:
> case OTG_STATE_B_PERIPHERAL:
>      otg_chrg_vbus(otg, 0);
>      otg_loc_sof(otg, 0);
>      otg_set_protocol(fsm, PROTO_GADGET);
>      otg_loc_conn(otg, 1);
>      break;
> 
> You intend to abstract something common in this api when start gadget,
> which should be called by otg_set_protocol(fsm, PROTO_GADGET); and
> drd_set_protocol(fsm, PROTO_GADGET); right?
> 
> So you may move usb_udc_connect_control(IMO usb_gadget_connect()
> is better)out of usb_gadget_start(), then for drd:
> 
> case OTG_STATE_B_PERIPHERAL:
>      drd_set_protocol(fsm, PROTO_GADGET);
>      otg_drv_vbus(otg, 0);
>      usb_gadget_connect();

OK. I understand now. I'll implement your suggestion. Thanks.

cheers,
-roger

>>>
>>>> +
>>>> +	mutex_unlock(&udc_lock);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +/**
>>>> + * usb_gadget_stop - disconnect from bus and stop the usb gadget
>>>> + * @gadget: The gadget device we want to stop
>>>> + *
>>>> + * This is external API for use by OTG core.
>>>> + *
>>>> + * Disconnect from the bus (disable pull) and stop the
>>>> + * gadget controller.
>>>> + */
>>>> +static int usb_gadget_stop(struct usb_gadget *gadget) {
>>>> +	struct usb_udc *udc = NULL;
>>>> +
>>>> +	dev_dbg(&gadget->dev, "%s\n", __func__);
>>>> +	mutex_lock(&udc_lock);
>>>> +	list_for_each_entry(udc, &udc_list, list)
>>>> +		if (udc->gadget == gadget)
>>>> +			goto found;
>>>> +
>>>> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
>>>> +		__func__);
>>>> +	mutex_unlock(&udc_lock);
>>>> +	return -EINVAL;
>>>> +
>>>> +found:
>>>> +	usb_gadget_disconnect(udc->gadget);
>>>
>>> Likewise, gadget disconnect also should be done by loc_conn() instead
>>> of gadget stop.
>>>
>>>> +	udc->driver->disconnect(udc->gadget);
>>>> +	usb_gadget_udc_stop(udc);
>>>> +	mutex_unlock(&udc_lock);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>
>>> Li Jun
>>>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
