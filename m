From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v10 13/14] usb: gadget: udc: adapt to OTG core
Date: Mon, 13 Jun 2016 10:14:31 +0300
Message-ID: <575E5D57.7010700@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-14-git-send-email-rogerq@ti.com>
 <20160612113655.GC32615@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160612113655.GC32615@shlinux2>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 12/06/16 14:36, Peter Chen wrote:
> On Fri, Jun 10, 2016 at 04:07:22PM +0300, Roger Quadros wrote:
>>  
>> +/**
>> + * usb_otg_add_gadget_udc - adds a new gadget to the udc class driver list
>> + * @parent: the parent device to this udc. Usually the controller
>> + * driver's device.
> 
> It seems it should be udc device

Parent and udc->dev are not the same right?

I guess i'll omit the second statement to avoid confusion. So.

@parent: the parent device to this udc.

> 
>> +/* udc_lock must be held */
>>  static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
>>  {
>>  	int ret;
>> @@ -1282,17 +1449,26 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
>>  	ret = driver->bind(udc->gadget, driver);
>>  	if (ret)
>>  		goto err1;
>> -	ret = usb_gadget_udc_start(udc);
>> -	if (ret) {
>> -		driver->unbind(udc->gadget);
>> -		goto err1;
>> +
>> +	/* If OTG/dual-role, the otg core manages UDC start/stop */
>> +	if (udc->gadget->otg_dev) {
>> +		mutex_unlock(&udc_lock);
>> +		usb_otg_gadget_ready(udc->gadget, true);
>> +		mutex_lock(&udc_lock);
>> +	} else {
>> +		ret = usb_gadget_udc_start(udc);
>> +		if (ret) {
>> +			mutex_unlock(&udc_lock);
>> +			driver->unbind(udc->gadget);
>> +			goto err1;
>> +		}
>> +		usb_udc_connect_control(udc);
>>  	}
>> -	usb_udc_connect_control(udc);
>>  
>>  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>>  	return 0;
>>  err1:
>> -	if (ret != -EISNAM)
>> +	if ((ret != -EISNAM) && (ret != -EPROBE_DEFER))
> 
> It seems it will not introduce -EPROBE_DEFER with your changes
> in udc_bind_to_driver
> 

Good catch. Left over bit when I moved defer probing out of here.

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
