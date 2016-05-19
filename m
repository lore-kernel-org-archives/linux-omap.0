From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Thu, 19 May 2016 10:32:44 +0300
Message-ID: <573D6C1C.4090600@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-14-git-send-email-rogerq@ti.com>
 <20160516070249.GB24609@shlinux2.ap.freescale.net> <57398451.2060103@ti.com>
 <20160516092323.GD24609@shlinux2.ap.freescale.net> <57399839.90706@ti.com>
 <AM4PR04MB2130E149700361CBA3F6863389480@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573AD198.6030307@ti.com>
 <AM4PR04MB2130EF68F7ADD64607C6CD4389480@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573C6347.6080705@ti.com>
 <AM4PR04MB2130145869480748D06FE6E589490@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573C719F.5010107@ti.com>
 <AM4PR04MB2130926F9AE8EBFC0D19447689490@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM4PR04MB2130926F9AE8EBFC0D19447689490-WOempg8NbQQzjTQnahXoOs9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>, "b-liu-l0cyMroinI0@public.gmane.org" <b-liu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel@vg>
List-Id: linux-omap@vger.kernel.org

On 18/05/16 17:46, Jun Li wrote:
> 
> 
>>>>
>>>> I didn't want to have complex Kconfig so decided to have otg as
>>>> built-in only.
>>>> What do you want me to change in existing code? and why?
>>>
>>> Remove those stuff which only for pass diff driver config Like every
>>> controller driver need a duplicated
>>>
>>> static struct otg_hcd_ops ci_hcd_ops = {
>>>     ...
>>> }
>>
>> This is an exception only. Every controller driver doesn't need to
>> implement hcd_ops. It is implemented in the hcd core.
>>
>>>
>>> And here is another example, for gadget connect, otg driver can
>>> directly call to usb_udc_vbus_handler() in drd state machine, but you
>>> create another interface:
>>>
>>> .connect_control = usb_gadget_connect_control,
>>>
>>> If the symbol is defined in one driver which is 'm', another driver
>>> reference it should be 'm' as well, then there is no this kind of
>>> problem as my understanding.
>>
>> That is fine as long as all are 'm'. but how do you solve the case when
>> Gadget is built in and host is 'm'? OTG has to be built-in and you will
>> need an hcd to gadget interface.
> 
> Hcd to gadget interface? Or you want to say otg to host interface?

Sorry, I meant to say host to otg interface.

> 
> I think hcd and gadget are independent each other, now
> 
> Hcd --> otg; and gadget --> otg, (hcd and gadget use otg's symbol)

It is actually a circular dependency for both.
 hcd <--> otg and gadget <--> otg

hcd -> otg for usb_otg_register/unregister_hcd
otg -> hcd for usb_add/remove_hcd, usb_bus_start_enum, usb_control_msg, usb_hub_find_child

gadget -> otg for usb_otg_register/unregister_gadget
otg -> gadget for usb_gadget_start/stop, usb_udc_vbus_handler

Now consider what will happen if I get rid of the otg_hcd and otg_gadget interfaces.
'y' means built-in, 'm' means module.

1) hcd 'y', gadget 'y'
otg has to be 'y' for proper build.

2) hcd 'm', gadget 'm'
otg has to be 'm' for proper build.

3) hcd 'y', gadget 'm'
Build will fail always.
If otg is 'y', otg build will fail due to dependency on gadget.
If otg is 'm', hcd build will fail due to dependency on otg.

4) hcd 'm', gadget 'y'
Build will fail always.
If otg is 'y', otg build will fail due to dependency on hcd.
If otg is 'm', gadget build will fails due to dependency on otg.

So I solve this problem by adding the otg_hcd_ops and otg_gadget_ops
to remove otg->hcd and otg->gadget dependency.

Now we can address 3) and 4) like so

3) hcd 'y', gadget 'm'
otg has to be 'y' for proper build.

4) hcd 'm', gadget 'y'
otg has to be 'y' for proper build.

> 
> If you directly call to usb_udc_vbus_handler() in drd state machine
> 
> Then:
> 
> Hcd --> otg; and gadget <--> otg, (gadget and otg will refer to symbol of each other)

It's not so easy. We are again creating a circular dependency and all
build configurations don't work like I pointed above.

The only optimization I could do is make CONFIG_OTG tristate and
allow it to be built as 'm' if both hcd and gadget are 'm'.
i.e. case (2).

cheers,
-roger

>>
>> Do you have any ideas to solve that case?
>>
>> cheers,
>> -roger
>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>  	return 0;
>>>>>>>>>>>> @@ -660,9 +830,15 @@ static ssize_t
>>>>>>>>>>>> usb_udc_softconn_store(struct
>>>>>>>> device *dev,
>>>>>>>>>>>>  		return -EOPNOTSUPP;
>>>>>>>>>>>>  	}
>>>>>>>>>>>>
>>>>>>>>>>>> +	/* In OTG mode we don't support softconnect, but
>> b_bus_req */
>>>>>>>>>>>> +	if (udc->gadget->otg_dev) {
>>>>>>>>>>>> +		dev_err(dev, "soft-connect not supported in OTG
>> mode\n");
>>>>>>>>>>>> +		return -EOPNOTSUPP;
>>>>>>>>>>>> +	}
>>>>>>>>>>>> +
>>>>>>>>>>>
>>>>>>>>>>> The soft-connect can be supported at dual-role mode currently,
>>>>>>>>>>> we can use b_bus_req entry once it is implemented later.
>>>>>>>>>>
>>>>>>>>>> Soft-connect should be done via sysfs handling within the OTG
>> core.
>>>>>>>>>> This can be added later. I don't want anything outside the OTG
>>>>>>>>>> core to handle soft-connect behaviour as it will be hard to
>>>>>>>>>> keep things in sync.
>>>>>>>>>>
>>>>>>>>>> I can update the comment to something like this.
>>>>>>>>>>
>>>>>>>>>> /* In OTG/dual-role mode, soft-connect should be handled by OTG
>>>>>>>>>> core */
>>>>>>>>>
>>>>>>>>> Ok, let's Felipe decide it.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>  	if (sysfs_streq(buf, "connect")) {
>>>>>>>>>>>>  		usb_gadget_udc_start(udc);
>>>>>>>>>>>> -		usb_gadget_connect(udc->gadget);
>>>>>>>>>>>> +		usb_udc_connect_control(udc);
>>>>>>>>>>>
>>>>>>>>>>> This line seems to be not related with this patch.
>>>>>>>>>>>
>>>>>>>>>> Right. I'll remove it.
>>>>>>>>>>
>>>>>>>>>> cheers,
>>>>>>>>>> -roger
>>>>>>>>>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
