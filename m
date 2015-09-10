From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 07/13] usb: otg: add OTG core
Date: Thu, 10 Sep 2015 17:17:36 +0300
Message-ID: <55F19100.3020209@ti.com>
References: <20150907012327.GG4914@shlinux2> <55ED6585.5050200@ti.com>
 <20150908083059.GD7802@shlinux2> <55EED3B5.5030806@ti.com>
 <20150909022116.GF7802@shlinux2> <55EFF6FA.1000705@ti.com>
 <20150909081304.GM7802@shlinux2> <55EFFCE0.5070109@ti.com>
 <20150909084544.GO7802@shlinux2> <55F0083E.6050802@ti.com>
 <20150910053507.GA19400@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150910053507.GA19400@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/09/15 08:35, Peter Chen wrote:
> On Wed, Sep 09, 2015 at 01:21:50PM +0300, Roger Quadros wrote:
>> On 09/09/15 11:45, Peter Chen wrote:
>>> On Wed, Sep 09, 2015 at 12:33:20PM +0300, Roger Quadros wrote:
>>>> On 09/09/15 11:13, Peter Chen wrote:
>>>>> On Wed, Sep 09, 2015 at 12:08:10PM +0300, Roger Quadros wrote:
>>>>>> On 09/09/15 05:21, Peter Chen wrote:
>>>>>>> On Tue, Sep 08, 2015 at 03:25:25PM +0300, Roger Quadros wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 08/09/15 11:31, Peter Chen wrote:
>>>>>>>>> On Mon, Sep 07, 2015 at 01:23:01PM +0300, Roger Quadros wrote:
>>>>>>>>>> On 07/09/15 04:23, Peter Chen wrote:
>>>>>>>>>>> On Mon, Aug 24, 2015 at 04:21:18PM +0300, Roger Quadros wrote:
>>>>>>>>>>>> + * This is used by the USB Host stack to register the Host controller
>>>>>>>>>>>> + * to the OTG core. Host controller must not be started by the
>>>>>>>>>>>> + * caller as it is left upto the OTG state machine to do so.
>>>>>>>>>>>> + *
>>>>>>>>>>>> + * Returns: 0 on success, error value otherwise.
>>>>>>>>>>>> + */
>>>>>>>>>>>> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>>>>>>>>>>> +			 unsigned long irqflags, struct otg_hcd_ops *ops)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +	struct usb_otg *otgd;
>>>>>>>>>>>> +	struct device *hcd_dev = hcd->self.controller;
>>>>>>>>>>>> +	struct device *otg_dev = usb_otg_get_device(hcd_dev);
>>>>>>>>>>>> +
>>>>>>>>>>>
>>>>>>>>>>> One big problem here is: there are two designs for current (IP) driver
>>>>>>>>>>> code, one creates dedicated hcd device as roothub's parent, like dwc3.
>>>>>>>>>>> Another one doesn't do this, roothub's parent is core device (or otg device
>>>>>>>>>>> in your patch), like chipidea and dwc2.
>>>>>>>>>>>
>>>>>>>>>>> Then, otg_dev will be glue layer device for chipidea after that.
>>>>>>>>>>
>>>>>>>>>> OK. Let's add a way for the otg controller driver to provide the host and gadget
>>>>>>>>>> information to the otg core for such devices like chipidea and dwc2.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Roger, not only chipidea and dwc2, I think the musb uses the same
>>>>>>>>> hierarchy. If the host, device, and otg share the same register
>>>>>>>>> region, host part can't be a platform driver since we don't want
>>>>>>>>> to remap the same register region again.
>>>>>>>>>
>>>>>>>>> So, in the design, we may need to consider both situations, one
>>>>>>>>> is otg/host/device has its own register region, and host is a
>>>>>>>>> separate platform device (A), the other is three parts share the
>>>>>>>>> same register region, there is only one platform driver (B).
>>>>>>>>>
>>>>>>>>> A:
>>>>>>>>>
>>>>>>>>> 			IP core device 
>>>>>>>>> 			    |
>>>>>>>>> 			    |
>>>>>>>>> 		      |-----|-----|
>>>>>>>>> 		      gadget   host platform device	
>>>>>>>>> 		      		|
>>>>>>>>> 				roothub
>>>>>>>>>
>>>>>>>>> B:
>>>>>>>>>
>>>>>>>>> 			IP core device
>>>>>>>>> 			    |
>>>>>>>>> 			    |
>>>>>>>>> 		      |-----|-----|
>>>>>>>>> 		      gadget   	 roothub
>>>>>>>>> 		      		
>>>>>>>>>
>>>>>>>>>> This API must be called before the hcd/gadget-driver is added so that the otg
>>>>>>>>>> core knows it's linked to an OTG controller.
>>>>>>>>>>
>>>>>>>>>> Any better idea?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> A flag stands for this hcd controller is the same with otg controller
>>>>>>>>> can be used, this flag can be stored at struct usb_otg_config.
>>>>>>>>
>>>>>>>> What if there is another architecture like so?
>>>>>>>>
>>>>>>>> C:
>>>>>>>> 			[Parent]
>>>>>>>> 			   |
>>>>>>>> 			   |
>>>>>>>> 		|------------------|--------------|
>>>>>>>> 	[OTG core]		[gadget]	[host]
>>>>>>>>
>>>>>>>> We need a more flexible mechanism to link the gadget and
>>>>>>>> host device to the otg core for non DT case.
>>>>>>>>
>>>>>>>> How about adding struct usb_otg parameter to usb_otg_register_hcd()?
>>>>>>>>
>>>>>>>> e.g.
>>>>>>>> int usb_otg_register_hcd(struct usb_otg *otg, struct usb_hcd *hcd, ..)
>>>>>>>>
>>>>>>>> If otg is NULL it will try DT otg-controller property or parent to
>>>>>>>> get the otg controller.
>>>>>>>
>>>>>>> How usb_otg_register_hcd get struct usb_otg, from where?
>>>>>>
>>>>>> This only works when the parent driver creating the hcd has registered the
>>>>>> otg controller too.
>>>>>>
>>>>>
>>>>> Sorry? So we need to find another way to solve this issue, right?
>>>>
>>>> For existing cases this is sufficient.
>>>> The otg device is either the one supplied during usb_otg_register_hcd
>>>> (cases B and C) or it is the parent device (case A).
>>>
>>> How we differentiate case A and case B at usb_otg_register_hcd?
>>> Would you show me the sample code?
>>
>> Case A:
>>
>> hcd platform driver doesn't know about otg device so it calls
>>
>> 	usb_add_hcd(hcd,..)->usb_otg_register_hcd(NULL, hcd,..);
>>
>> Case B:
>>
>> core driver knows about both otg and hcd so it calls
>> 	usb_otg_register_hcd(otg, hcd,...);
>>
> 
> Ok, Get your points, you mean invoke usb_otg_register_hcd at platform
> driver directly instead of at hcd.c. It may be not a good solution
> due to we use different otg APIs for two cases, it may confuse the
> users, unless we can have some APIs (flags) are easy to read and well
> documentation.
> 

I need to think how else we can solve this problem so that it is usable
for all scenarios. If you get some bright ideas please do share :)

cheers,
-roger
