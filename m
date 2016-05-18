From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Wed, 18 May 2016 16:43:59 +0300
Message-ID: <573C719F.5010107@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-14-git-send-email-rogerq@ti.com>
 <20160516070249.GB24609@shlinux2.ap.freescale.net> <57398451.2060103@ti.com>
 <20160516092323.GD24609@shlinux2.ap.freescale.net> <57399839.90706@ti.com>
 <AM4PR04MB2130E149700361CBA3F6863389480@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573AD198.6030307@ti.com>
 <AM4PR04MB2130EF68F7ADD64607C6CD4389480@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573C6347.6080705@ti.com>
 <AM4PR04MB2130145869480748D06FE6E589490@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR04MB2130145869480748D06FE6E589490@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>, Peter Chen <hzpeterchen@gmail.com>
Cc: "peter.chen@freescale.com" <peter.chen@freescale.com>, "balbi@kernel.org" <balbi@kernel.org>, "tony@atomide.com" <tony@atomide.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "robh@kernel.org" <robh@kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>, "b-liu@ti.com" <b-liu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vg>
List-Id: linux-omap@vger.kernel.org

On 18/05/16 16:12, Jun Li wrote:
> Hi
> 
>> -----Original Message-----
>> From: Roger Quadros [mailto:rogerq@ti.com]
>> Sent: Wednesday, May 18, 2016 8:43 PM
>> To: Jun Li <jun.li@nxp.com>; Peter Chen <hzpeterchen@gmail.com>
>> Cc: peter.chen@freescale.com; balbi@kernel.org; tony@atomide.com;
>> gregkh@linuxfoundation.org; dan.j.williams@intel.com;
>> mathias.nyman@linux.intel.com; Joao.Pinto@synopsys.com;
>> sergei.shtylyov@cogentembedded.com; jun.li@freescale.com;
>> grygorii.strashko@ti.com; yoshihiro.shimoda.uh@renesas.com;
>> robh@kernel.org; nsekhar@ti.com; b-liu@ti.com; linux-usb@vger.kernel.org;
>> linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org
>> Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
>>
>> On 17/05/16 11:28, Jun Li wrote:
>>> Hi Roger,
>>>
>>>> -----Original Message-----
>>>> From: Roger Quadros [mailto:rogerq@ti.com]
>>>> Sent: Tuesday, May 17, 2016 4:09 PM
>>>> To: Jun Li <jun.li@nxp.com>; Peter Chen <hzpeterchen@gmail.com>
>>>> Cc: peter.chen@freescale.com; balbi@kernel.org; tony@atomide.com;
>>>> gregkh@linuxfoundation.org; dan.j.williams@intel.com;
>>>> mathias.nyman@linux.intel.com; Joao.Pinto@synopsys.com;
>>>> sergei.shtylyov@cogentembedded.com; jun.li@freescale.com;
>>>> grygorii.strashko@ti.com; yoshihiro.shimoda.uh@renesas.com;
>>>> robh@kernel.org; nsekhar@ti.com; b-liu@ti.com;
>>>> linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>>>> Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
>>>>
>>>> On 17/05/16 10:38, Jun Li wrote:
>>>>> Hi
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Roger Quadros [mailto:rogerq@ti.com]
>>>>>> Sent: Monday, May 16, 2016 5:52 PM
>>>>>> To: Peter Chen <hzpeterchen@gmail.com>
>>>>>> Cc: peter.chen@freescale.com; balbi@kernel.org; tony@atomide.com;
>>>>>> gregkh@linuxfoundation.org; dan.j.williams@intel.com;
>>>>>> mathias.nyman@linux.intel.com; Joao.Pinto@synopsys.com;
>>>>>> sergei.shtylyov@cogentembedded.com; jun.li@freescale.com;
>>>>>> grygorii.strashko@ti.com; yoshihiro.shimoda.uh@renesas.com;
>>>>>> robh@kernel.org; nsekhar@ti.com; b-liu@ti.com;
>>>>>> linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
>>>>>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>>>>>> Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
>>>>>>
>>>>>> On 16/05/16 12:23, Peter Chen wrote:
>>>>>>> On Mon, May 16, 2016 at 11:26:57AM +0300, Roger Quadros wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 16/05/16 10:02, Peter Chen wrote:
>>>>>>>>> On Fri, May 13, 2016 at 01:03:27PM +0300, Roger Quadros wrote:
>>>>>>>>>> +
>>>>>>>>>> +static int usb_gadget_connect_control(struct usb_gadget
>>>>>>>>>> +*gadget, bool connect) {
>>>>>>>>>> +	struct usb_udc *udc;
>>>>>>>>>> +
>>>>>>>>>> +	mutex_lock(&udc_lock);
>>>>>>>>>> +	udc = usb_gadget_to_udc(gadget);
>>>>>>>>>> +	if (!udc) {
>>>>>>>>>> +		dev_err(gadget->dev.parent, "%s: gadget not
>>>>>> registered.\n",
>>>>>>>>>> +			__func__);
>>>>>>>>>> +		mutex_unlock(&udc_lock);
>>>>>>>>>> +		return -EINVAL;
>>>>>>>>>> +	}
>>>>>>>>>> +
>>>>>>>>>> +	if (connect) {
>>>>>>>>>> +		if (!gadget->connected)
>>>>>>>>>> +			usb_gadget_connect(udc->gadget);
>>>>>>>>>> +	} else {
>>>>>>>>>> +		if (gadget->connected) {
>>>>>>>>>> +			usb_gadget_disconnect(udc->gadget);
>>>>>>>>>> +			udc->driver->disconnect(udc->gadget);
>>>>>>>>>> +		}
>>>>>>>>>> +	}
>>>>>>>>>> +
>>>>>>>>>> +	mutex_unlock(&udc_lock);
>>>>>>>>>> +
>>>>>>>>>> +	return 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> Since this is called for vbus interrupt, why not using
>>>>>>>>> usb_udc_vbus_handler directly, and call udc->driver->disconnect
>>>>>>>>> at usb_gadget_stop.
>>>>>>>>
>>>>>>>> We can't assume that this is always called for vbus interrupt so
>>>>>>>> I decided not to call usb_udc_vbus_handler.
>>>>>>>>
>>>>>>>> udc->vbus is really pointless for us. We keep vbus states in our
>>>>>>>> state machine and leave udc->vbus as ture always.
>>>>>>>>
>>>>>>>> Why do you want to move udc->driver->disconnect() to stop?
>>>>>>>> If USB controller disconnected from bus then the gadget driver
>>>>>>>> must be notified about the disconnect immediately. The controller
>>>>>>>> may or may not be stopped by the core.
>>>>>>>>
>>>>>>>
>>>>>>> Then, would you give some comments when this API will be used?
>>>>>>> I was assumed it is only used for drd state machine.
>>>>>>
>>>>>> drd_state machine didn't even need this API in the first place :).
>>>>>> You guys wanted me to separate out start/stop and
>>>>>> connect/disconnect for full OTG case.
>>>>>> Won't full OTG state machine want to use this API? If not what
>>>>>> would it use?
>>>>>
>>>>> Instead create those new interfaces/symbol here and there just aim
>>>>> to address build problems in diff configures, Could we only allow
>>>>> meaningful combination of those 3 drivers configures?
>>>>>
>>>>> Hcd=y, gadget=y, otg=y or
>>>>> Hcd=m, gadget=m, otg=m
>>>>
>>>> This is still a limitation.
>>>>
>>>> It is perfectly fine to have
>>>> hcd=m, gadget=y
>>>> or
>>>> hcd=y, gadget=m
>>>
>>> I agree it makes sense to have above configs in non-otg case, that is,
>>> the 'y' driver can work without 'm' driver loaded.
>>>
>>> But,
>>> in otg enabled(y/m) case, the otherwise config of my list can't make
>>> any sense from my point view. That is: some driver is built-in, but it
>>> can't work at all if another 'm' driver is not loaded,
>>>
>>> in another words, the otg driver has to be 'm' if its dependent driver
>>> is 'm', correct?
>>
>> If both host and gadget are 'm' then otg can be 'm', but if either host or
>> gadget is built in then we have no choice but to make otg as built-in.
>>
>> I didn't want to have complex Kconfig so decided to have otg as built-in
>> only.
>> What do you want me to change in existing code? and why?
> 
> Remove those stuff which only for pass diff driver config
> Like every controller driver need a duplicated
> 
> static struct otg_hcd_ops ci_hcd_ops = {
>     ...
> }

This is an exception only. Every controller driver doesn't need to implement
hcd_ops. It is implemented in the hcd core.

> 
> And here is another example, for gadget connect, otg driver can
> directly call to usb_udc_vbus_handler() in drd state machine,
> but you create another interface:
> 
> .connect_control = usb_gadget_connect_control,
> 
> If the symbol is defined in one driver which is 'm', another driver
> reference it should be 'm' as well, then there is no this kind of problem
> as my understanding.

That is fine as long as all are 'm'. but how do you solve the case
when Gadget is built in and host is 'm'? OTG has to be built-in and
you will need an hcd to gadget interface.

Do you have any ideas to solve that case?

cheers,
-roger

>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>>>  	return 0;
>>>>>>>>>> @@ -660,9 +830,15 @@ static ssize_t
>>>>>>>>>> usb_udc_softconn_store(struct
>>>>>> device *dev,
>>>>>>>>>>  		return -EOPNOTSUPP;
>>>>>>>>>>  	}
>>>>>>>>>>
>>>>>>>>>> +	/* In OTG mode we don't support softconnect, but b_bus_req */
>>>>>>>>>> +	if (udc->gadget->otg_dev) {
>>>>>>>>>> +		dev_err(dev, "soft-connect not supported in OTG mode\n");
>>>>>>>>>> +		return -EOPNOTSUPP;
>>>>>>>>>> +	}
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> The soft-connect can be supported at dual-role mode currently,
>>>>>>>>> we can use b_bus_req entry once it is implemented later.
>>>>>>>>
>>>>>>>> Soft-connect should be done via sysfs handling within the OTG core.
>>>>>>>> This can be added later. I don't want anything outside the OTG
>>>>>>>> core to handle soft-connect behaviour as it will be hard to keep
>>>>>>>> things in sync.
>>>>>>>>
>>>>>>>> I can update the comment to something like this.
>>>>>>>>
>>>>>>>> /* In OTG/dual-role mode, soft-connect should be handled by OTG
>>>>>>>> core */
>>>>>>>
>>>>>>> Ok, let's Felipe decide it.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>  	if (sysfs_streq(buf, "connect")) {
>>>>>>>>>>  		usb_gadget_udc_start(udc);
>>>>>>>>>> -		usb_gadget_connect(udc->gadget);
>>>>>>>>>> +		usb_udc_connect_control(udc);
>>>>>>>>>
>>>>>>>>> This line seems to be not related with this patch.
>>>>>>>>>
>>>>>>>> Right. I'll remove it.
>>>>>>>>
>>>>>>>> cheers,
>>>>>>>> -roger
>>>>>>>
