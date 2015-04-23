From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH v2 00/13] USB: OTG/DRD Core functionality
Date: Thu, 23 Apr 2015 09:35:21 +0300
Message-ID: <553892A9.8070001@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com> <20150420030531.GA30878@shlinux2> <5534AA8C.1070400@ti.com> <BY1PR0301MB0855ACDA4337AE3FC7F616E081EF0@BY1PR0301MB0855.namprd03.prod.outlook.com> <5535FD69.6070900@ti.com> <20150422021723.GB2680@shlinux2> <55374EC4.40107@ti.com> <20150422092229.GC2680@shlinux2> <55379738.1090808@ti.com> <20150423015206.GA1111@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150423015206.GA1111@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "balbi@ti.com" <balbi@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Jun.Li@freescale.com" <Jun.Li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "macpaul@gmail.com" <macpaul@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 23/04/15 04:52, Peter Chen wrote:
> On Wed, Apr 22, 2015 at 03:42:32PM +0300, Roger Quadros wrote:
>>> So we will have a separate drd fsm file, and the CONFIG_USB_OTG
>>> and CONFIG_USB_OTG_FSM are not needed to be defined, right?
>>>
>>
>> for drd case CONFIG_USB_OTG_FSM is definitely not needed.
>> I'm not sure if we can operate dual-role without CONFIG_USB_OTG.
>> I was thinking of combining the OTG core functionality (drivers/usb/common/usb-otg.c)
>> with CONFIG_USB_OTG.
>>
> 
> Ok, let's choose CONFIG_USB_OTG for both drd and usb fsm case.
> And we need to patch for hcd that only hnp supported hcd needs
> to request otg descriptor, etc.

Agreed. It makes things much simpler.

> 
> For yesterday's back-compatible old otg device, we can add otg
> features to these drivers, the current behavior for these drivers
> is: if CONFIG_USB_OTG is defined, it is an otg device, we can just
> keep the behavior unchanging. If these drivers need to use OTG framework
> in future, it needs to update its platform data or dts.

Right.

> 
> So, I prefer:
> 
> - For switching the role through the ID pin devices, we doesn't need any otg
> features, so no otg dts properties are needed.(expect dr_mode = "otg")
> - For adp/srp/hnp supported devices, we need (partial) otg features, and
> the fsm (hardware or software) are needed, we need some otg dts
> properties we discussed before.

Agreed.

I will try to incorporate these points in v3 of this series.

cheers,
-roger
> 
> 
>>>
>>> static const struct usb_descriptor_header *otg_desc_20[] = {
>>> 	(struct usb_descriptor_header *) &(struct usb_otg_descriptor_20){
>>> 		.bLength =		sizeof(struct usb_otg_descriptor_20),
>>> 		.bDescriptorType =	USB_DT_OTG,
>>>
>>> 		/*
>>> 		 * REVISIT SRP-only hardware is possible, although
>>> 		 * it would not be called "OTG" ...
>>> 		 */
>>> 		.bmAttributes =		USB_OTG_SRP | USB_OTG_HNP,
>>> 		.bcdOTG =               cpu_to_le16(0x0200),
>>> 	},
>>> 	NULL,
>>> };
>>
>> instead of hardcoding bmAttributes field, it must be obtained from the
>> appropriate data structure that was set by the controller driver
>> by reading DT and OTG hardware info.
>>
>>>
>>> During bind process:
>>>
>>> 	if (gadget_is_otg_13(c->cdev->gadget))
>>> 		c->descriptors = otg_desc_13;
>>> 	else if (gadget_is_otg_20(c->cdev->gadget))
>>> 		c->descriptors = otg_desc_20;
>>
>> Probably a helper utitily can do the necessary checks and build the
>> otg descriptor for us.
>> 		usb_otg_get_descriptor(c->descriptors);
>>
>> e.g. for OTG3.0 we have a new flag USB_OTG_RSP, and this helper
>> can be upgraded in the future.
> 
> ok, it is the implementation detail.
> 
