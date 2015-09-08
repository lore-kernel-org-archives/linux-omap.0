From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 07/13] usb: otg: add OTG core
Date: Tue, 8 Sep 2015 20:29:56 +0300
Message-ID: <55EF1B14.6080809@ti.com>
References: <Pine.LNX.4.44L0.1509081031200.1533-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1509081031200.1533-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Chen <peter.chen@freescale.com>, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Alan,

On 08/09/15 17:34, Alan Stern wrote:
> On Tue, 8 Sep 2015, Roger Quadros wrote:
> 
>> On 08/09/15 11:31, Peter Chen wrote:
>>> On Mon, Sep 07, 2015 at 01:23:01PM +0300, Roger Quadros wrote:
>>>> On 07/09/15 04:23, Peter Chen wrote:
>>>>> On Mon, Aug 24, 2015 at 04:21:18PM +0300, Roger Quadros wrote:
>>>>>> + * This is used by the USB Host stack to register the Host controller
>>>>>> + * to the OTG core. Host controller must not be started by the
>>>>>> + * caller as it is left upto the OTG state machine to do so.
>>>>>> + *
>>>>>> + * Returns: 0 on success, error value otherwise.
>>>>>> + */
>>>>>> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>>>>> +			 unsigned long irqflags, struct otg_hcd_ops *ops)
>>>>>> +{
>>>>>> +	struct usb_otg *otgd;
>>>>>> +	struct device *hcd_dev = hcd->self.controller;
>>>>>> +	struct device *otg_dev = usb_otg_get_device(hcd_dev);
>>>>>> +
>>>>>
>>>>> One big problem here is: there are two designs for current (IP) driver
>>>>> code, one creates dedicated hcd device as roothub's parent, like dwc3.
>>>>> Another one doesn't do this, roothub's parent is core device (or otg device
>>>>> in your patch), like chipidea and dwc2.
>>>>>
>>>>> Then, otg_dev will be glue layer device for chipidea after that.
>>>>
>>>> OK. Let's add a way for the otg controller driver to provide the host and gadget
>>>> information to the otg core for such devices like chipidea and dwc2.
>>>>
>>>
>>> Roger, not only chipidea and dwc2, I think the musb uses the same
>>> hierarchy. If the host, device, and otg share the same register
>>> region, host part can't be a platform driver since we don't want
>>> to remap the same register region again.
>>>
>>> So, in the design, we may need to consider both situations, one
>>> is otg/host/device has its own register region, and host is a
>>> separate platform device (A), the other is three parts share the
>>> same register region, there is only one platform driver (B).
>>>
>>> A:
>>>
>>> 			IP core device 
>>> 			    |
>>> 			    |
>>> 		      |-----|-----|
>>> 		      gadget   host platform device	
>>> 		      		|
>>> 				roothub
>>>
>>> B:
>>>
>>> 			IP core device
>>> 			    |
>>> 			    |
>>> 		      |-----|-----|
>>> 		      gadget   	 roothub
>>> 		      		
>>>
>>>> This API must be called before the hcd/gadget-driver is added so that the otg
>>>> core knows it's linked to an OTG controller.
>>>>
>>>> Any better idea?
>>>>
>>>
>>> A flag stands for this hcd controller is the same with otg controller
>>> can be used, this flag can be stored at struct usb_otg_config.
>>
>> What if there is another architecture like so?
>>
>> C:
>> 			[Parent]
>> 			   |
>> 			   |
>> 		|------------------|--------------|
>> 	[OTG core]		[gadget]	[host]
>>
>> We need a more flexible mechanism to link the gadget and
>> host device to the otg core for non DT case.
>>
>> How about adding struct usb_otg parameter to usb_otg_register_hcd()?
>>
>> e.g.
>> int usb_otg_register_hcd(struct usb_otg *otg, struct usb_hcd *hcd, ..)
>>
>> If otg is NULL it will try DT otg-controller property or parent to
>> get the otg controller.
> 
> This seems a lot like something Peter and I discussed recently.  See
> 
> 	http://marc.info/?l=linux-usb&m=143977568021328&w=2
> 
> and the following messages in that thread.
> 

If I understood right, your proposal was to add a usb_pointers data
struct to the device's drvdata?

This is fine only if the otg/gadget/host share the same device.
It does not solve the problem where each have different platform devices.

cheers,
-roger
