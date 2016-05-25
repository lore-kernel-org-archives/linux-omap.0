From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 25 May 2016 15:26:12 +0300
Message-ID: <574599E4.3090302@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-9-git-send-email-rogerq@ti.com> <574422CA.8080002@ti.com>
 <20160525024427.GA31142@shlinux2>
 <AM4PR04MB21300F71EFFD3BF73871A85389400@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR04MB21300F71EFFD3BF73871A85389400@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>, Peter Chen <hzpeterchen@gmail.com>
Cc: "peter.chen@freescale.com" <peter.chen@freescale.com>, "balbi@kernel.org" <balbi@kernel.org>, "tony@atomide.com" <tony@atomide.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "robh@kernel.org" <robh@kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>, "b-liu@ti.com" <b-liu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vg>
List-Id: linux-omap@vger.kernel.org

On 25/05/16 06:19, Jun Li wrote:
> 
> 
>> -----Original Message-----
>> From: Peter Chen [mailto:hzpeterchen@gmail.com]
>> Sent: Wednesday, May 25, 2016 10:44 AM
>> To: Roger Quadros <rogerq@ti.com>
>> Cc: peter.chen@freescale.com; balbi@kernel.org; tony@atomide.com;
>> gregkh@linuxfoundation.org; dan.j.williams@intel.com;
>> mathias.nyman@linux.intel.com; Joao.Pinto@synopsys.com;
>> sergei.shtylyov@cogentembedded.com; jun.li@freescale.com;
>> grygorii.strashko@ti.com; yoshihiro.shimoda.uh@renesas.com;
>> robh@kernel.org; nsekhar@ti.com; b-liu@ti.com; linux-usb@vger.kernel.org;
>> linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org
>> Subject: Re: [PATCH v8 08/14] usb: otg: add OTG/dual-role core
>>
>> On Tue, May 24, 2016 at 12:45:46PM +0300, Roger Quadros wrote:
>>> Hi Peter,
>>>
>>> I have one question here. Please see below.
>>>
>>> On 13/05/16 13:03, Roger Quadros wrote:
>>>> It provides APIs for the following tasks
>>>>
>>>> - Registering an OTG/dual-role capable controller
>>>> - Registering Host and Gadget controllers to OTG core
>>>> - Providing inputs to and kicking the OTG state machine
>>>>
>>>> Provide a dual-role device (DRD) state machine.
>>>> DRD mode is a reduced functionality OTG mode. In this mode we don't
>>>> support SRP, HNP and dynamic role-swap.
>>>>
>>>> In DRD operation, the controller mode (Host or Peripheral) is
>>>> decided based on the ID pin status. Once a cable plug (Type-A or
>>>> Type-B) is attached the controller selects the state and doesn't
>>>> change till the cable in unplugged and a different cable type is
>>>> inserted.
>>>>
>>>> As we don't need most of the complex OTG states and OTG timers we
>>>> implement a lean DRD state machine in usb-otg.c.
>>>> The DRD state machine is only interested in 2 hardware inputs 'id'
>>>> and 'b_sess_vld'.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>>  drivers/usb/common/Makefile  |    2 +-
>>>>  drivers/usb/common/usb-otg.c | 1042
>> ++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/usb/core/Kconfig     |    4 +-
>>>>  include/linux/usb/gadget.h   |    2 +
>>>>  include/linux/usb/hcd.h      |    1 +
>>>>  include/linux/usb/otg-fsm.h  |    7 +
>>>>  include/linux/usb/otg.h      |  154 ++++++-
>>>>  7 files changed, 1206 insertions(+), 6 deletions(-)  create mode
>>>> 100644 drivers/usb/common/usb-otg.c
>>>>
>>>
>>> <snip>
>>>
>>>> +
>>>> +/**
>>>> + * usb_otg_register() - Register the OTG/dual-role device to OTG
>>>> +core
>>>> + * @dev: OTG/dual-role controller device.
>>>> + * @config: OTG configuration.
>>>> + *
>>>> + * Registers the OTG/dual-role controller device with the USB OTG
>> core.
>>>> + *
>>>> + * Return: struct usb_otg * if success, ERR_PTR() if error.
>>>> + */
>>>> +struct usb_otg *usb_otg_register(struct device *dev,
>>>> +				 struct usb_otg_config *config) {
>>>> +	struct usb_otg *otg;
>>>> +	struct otg_wait_data *wait;
>>>> +	int ret = 0;
>>>> +
>>>> +	if (!dev || !config || !config->fsm_ops)
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	/* already in list? */
>>>> +	mutex_lock(&otg_list_mutex);
>>>> +	if (usb_otg_get_data(dev)) {
>>>> +		dev_err(dev, "otg: %s: device already in otg list\n",
>>>> +			__func__);
>>>> +		ret = -EINVAL;
>>>> +		goto unlock;
>>>> +	}
>>>> +
>>>> +	/* allocate and add to list */
>>>> +	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
>>>> +	if (!otg) {
>>>> +		ret = -ENOMEM;
>>>> +		goto unlock;
>>>> +	}
>>>> +
>>>> +	otg->dev = dev;
>>>> +	otg->caps = config->otg_caps;
>>>
>>> Here, we should be checking if user needs to disable any OTG features.
>>> So,
>>>
>>> 	if (dev->of_node)
>>> 		of_usb_update_otg_caps(dev->of_node, &otg->caps);
>>>
>>> Do you agree?
>>> This means we need to change otg->caps from 'struct usb_otg_caps *caps;'
>>> to 'struct usb_otg_caps caps;' so that we can modify the local copy
>>> instead of the one passed by the OTG controller.
>>
>> Why can't modify the one from OTG controller directly?
> 
> Yes, if user wants to disable any OTG features, this should have been
> done in 'config->otg_caps', if not, 'config->otg_caps' from controller
> driver is invalid and making no sense.

I've tried to why to Peter's mail.

> 
>>
>>>
>>> We can also move of_usb_update_otg_caps() to otg.h.
>>>
>>> We will also need to modify the udc-core code so that it sets
>>> gadget->otg_caps to the modified otg_caps from the OTG core. This will
>>> ensure that the right OTG descriptors are sent.
>>>
>>> So we will have to introduce an API.
>>>
>>> struct usb_otg_caps *usb_otg_get_otg_caps(struct device *otg_dev)
>>>
>>> And in udc-core.c,
>>>
>>> static int udc_bind_to_driver(struct usb_udc *udc, struct
>>> usb_gadget_driver *driver) { ..
>>>         ret = driver->bind(udc->gadget, driver);
>>>         if (ret)
>>>                 goto err1;
>>>
>>>         /* If OTG, the otg core starts the UDC when needed */
>>>         if (udc->gadget->otg_dev) {
>>> +		udc->gadget->is_otg = true;
>>
>> gadget->is_otg is only set to true if fully OTG is supported and it
>> needs to send OTG descriptors at this case. DRD devices should not send
>> OTG descriptors.
>>
>>> +		udc->gadget->otg_caps = usb_otg_get_otg_caps(udc->gadget-
>>> otg_dev);
>>
>> Getting otg capabilities should be prior to driver->bind since
>> usb_otg_descriptor_init is called at that. Besides, Gadget driver may be
>> probed before otg driver is registered
>>
>> I am wonder if we can implement defer probe for gadget/udc/host driver if
>> otg driver is not probed, in that case, some designs can be simpler like
>> wait list in otg driver.
> 
> I even don't see much benefit of this kind of random order of OTG/HCD/GADGET
> registration, anyway OTG register can be done firstly.

You cannot control the order in systems where all 3 are implemented by separate
hardware modules. We have to consider that they can be registered
in any order and make sure it works.

returning -EPROBE_DEFER in usb_otg_add_gadget_udc()/usb_otg_add_hcd() if OTG
controller driver is not yet probed makes perfect sense and is the way to solve
this dependency issue.

> HCD and GADGET are both separated drivers, but OTG is newly added
> and what we need is just a registration in controller driver.

How do you solve the problem when host registers before OTG? I tried to solve it
using the wait_list in usb-otg.c. The other alternative is -EPROBE_DEFER during
usb_otg_add_hcd/udc().
