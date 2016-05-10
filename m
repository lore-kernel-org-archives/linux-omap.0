From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Tue, 10 May 2016 12:20:28 +0300
Message-ID: <5731A7DC.7060502@ti.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-4-git-send-email-rogerq@ti.com>
 <20160506094103.GF32359@shlinux2.ap.freescale.net> <57305C42.90300@ti.com>
 <20160510031401.GA3748@shlinux2.ap.freescale.net> <57318F19.7000506@ti.com>
 <AM4PR04MB2130A378F6E7A103FAF3486989710@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR04MB2130A378F6E7A103FAF3486989710@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>, Peter Chen <hzpeterchen@gmail.com>
Cc: "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10/05/16 11:03, Jun Li wrote:
> Hi
> 
>> -----Original Message-----
>> From: Roger Quadros [mailto:rogerq@ti.com]
>> Sent: Tuesday, May 10, 2016 3:35 PM
>> To: Peter Chen <hzpeterchen@gmail.com>
>> Cc: peter.chen@freescale.com; stern@rowland.harvard.edu; balbi@kernel.org;
>> gregkh@linuxfoundation.org; dan.j.williams@intel.com; jun.li@freescale.com;
>> mathias.nyman@linux.intel.com; tony@atomide.com; Joao.Pinto@synopsys.com;
>> abrestic@chromium.org; yoshihiro.shimoda.uh@renesas.com; linux-
>> usb@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> omap@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH v7 03/14] usb: hcd.h: Add OTG to HCD interface
>>
>> On 10/05/16 06:14, Peter Chen wrote:
>>> On Mon, May 09, 2016 at 12:45:38PM +0300, Roger Quadros wrote:
>>>> On 06/05/16 12:41, Peter Chen wrote:
>>>>> On Mon, May 02, 2016 at 03:18:46PM +0300, Roger Quadros wrote:
>>>>>> The OTG core will use struct otg_hcd_ops to interface with the HCD
>>>>>> controller.
>>>>>>
>>>>>> The main purpose of this interface is to avoid directly calling HCD
>>>>>> APIs from the OTG core as they wouldn't be defined in the built-in
>>>>>> symbol table if CONFIG_USB is m.
>>>>>>
>>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>>> Acked-by: Peter Chen <peter.chen@nxp.com>
>>>>>
>>>>> Roger, after thinking more, I still think current dependency between
>>>>> OTG, HCD and gadget are too complicated. Since the OTG can't work if
>>>>> it is built as module, I suggest letting OTG depends on HCD &&
>>>>> USB_GADGET, and it is a boolean, in that case, we don't need to
>>>>> export any HCD and gadget ops, things will be much simpler.
>>>>> What's your opinion?
>>>>
>>>> How will it work if HCD and USB_GADGET are modules and OTG is built-in?
>>>>
>>>
>>> The OTG will not be compiled at this situation, since it is boolean.
>>> In fact, like I mentioned at above, OTG or USB function can't work if
>>> it is built as module.
>>
>> Isn't this a limitation?
>> As per the current implementation dual role works fine even with both
>> USB_GADGET and HCD as module.
> 
> My understand: only make sense for pass build, host can't work before
> gadget modules loaded; gadget can't work before hcd loaded, nothing
> can work before all drivers are loaded.

I can make OTG depend on GADGET and HCD, no issue with that.
But we can't get rid of the OTG to HCD/Gadged interfaces as we want things
to work with GADGET and HCD as modules.

> 
>>
>> In the real world it is unlikely that GADGET and HCD will be built-in.
> 
> Why? User enable USB_OTG means both drivers should be enabled anyway.

Enabled, but not necessarily built-in. Most distributions don't have them
as built-in.

But let's not argue in that direction. Let's say that they can be either
built-in or modules.

> Even in non-OTG case, both may be built-in for machine with 2 ports
> (one port is host only, the other one is peripheral only).

Sure. Every system designer is free to select the configuration.

> 
> A general question, 2 drivers depends on each other, allowable?

I don't thing that's possible. Kconfig will complain.
http://lxr.free-electrons.com/source/Documentation/kbuild/kconfig-language.txt#L397

cheers,
-roger

>>>>>
>>>>>> ---
>>>>>>  include/linux/usb/hcd.h | 24 ++++++++++++++++++++++++
>>>>>>  1 file changed, 24 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
>>>>>> index b98f831..861ccaa 100644
>>>>>> --- a/include/linux/usb/hcd.h
>>>>>> +++ b/include/linux/usb/hcd.h
>>>>>> @@ -399,6 +399,30 @@ struct hc_driver {
>>>>>>
>>>>>>  };
>>>>>>
>>>>>> +/**
>>>>>> + * struct otg_hcd_ops - Interface between OTG core and HCD
>>>>>> + *
>>>>>> + * Provided by the HCD core to allow the OTG core to interface
>>>>>> +with the HCD
>>>>>> + *
>>>>>> + * @add: function to add the HCD
>>>>>> + * @remove: function to remove the HCD
>>>>>> + * @usb_bus_start_enum: function to immediately start bus
>>>>>> +enumeration
>>>>>> + * @usb_control_msg: function to build and send of a control urb
>>>>>> + * @usb_hub_find_child: function to get pointer to the child
>>>>>> +device  */ struct otg_hcd_ops {
>>>>>> +	int (*add)(struct usb_hcd *hcd,
>>>>>> +		   unsigned int irqnum, unsigned long irqflags);
>>>>>> +	void (*remove)(struct usb_hcd *hcd);
>>>>>> +	int (*usb_bus_start_enum)(struct usb_bus *bus, unsigned int
>> port_num);
>>>>>> +	int (*usb_control_msg)(struct usb_device *dev, unsigned int
>> pipe,
>>>>>> +			       __u8 request, __u8 requesttype, __u16 value,
>>>>>> +			       __u16 index, void *data, __u16 size,
>>>>>> +			       int timeout);
>>>>>> +	struct usb_device * (*usb_hub_find_child)(struct usb_device
>> *hdev,
>>>>>> +						  int port1);
>>>>>> +};
>>>>>> +
>>>>>>  static inline int hcd_giveback_urb_in_bh(struct usb_hcd *hcd)  {
>>>>>>  	return hcd->driver->flags & HCD_BH;
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> linux-usb" in the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>
