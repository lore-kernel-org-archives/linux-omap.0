From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH v2 00/13] USB: OTG/DRD Core functionality
Date: Wed, 22 Apr 2015 10:33:24 +0300
Message-ID: <55374EC4.40107@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com> <20150420030531.GA30878@shlinux2> <5534AA8C.1070400@ti.com> <BY1PR0301MB0855ACDA4337AE3FC7F616E081EF0@BY1PR0301MB0855.namprd03.prod.outlook.com> <5535FD69.6070900@ti.com> <20150422021723.GB2680@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50984 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbbDVHdr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2015 03:33:47 -0400
In-Reply-To: <20150422021723.GB2680@shlinux2>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "balbi@ti.com" <balbi@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Jun.Li@freescale.com" <Jun.Li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "macpaul@gmail.com" <macpaul@gmail.com>"tony@atomide.com" <tony@atomide.com>

On 22/04/15 05:17, Peter Chen wrote:
> On Tue, Apr 21, 2015 at 10:34:01AM +0300, Roger Quadros wrote:
>> On 21/04/15 09:04, Peter Chen wrote:
>>>  
>>>>
>>>> On 20/04/15 06:05, Peter Chen wrote:
>>>>> On Tue, Apr 14, 2015 at 01:41:47PM +0300, Roger Quadros wrote:
>>>>>> This is an attempt to centralize OTG/Dual-role functionality in the kernel.
>>>>>> As of now I've got Dual-role functionality working pretty reliably on
>>>>>> dra7-evm. xhci side of things for OTG/DRD use are fixed in
>>>>>> http://thread.gmane.org/gmane.linux.kernel/1923161
>>>>>
>>>>> Hi Roger,
>>>>>
>>>>> Currently, there are two main problems for DRD/OTG framework.
>>>>>
>>>>> - For multi-platform supports, we may define CONFIG_USB_OTG, but the
>>>>> gadget should not add its otg descriptor to its configuration
>>>>> descriptors if it does not support one of otg features (SRP/HNP/ADP).
>>>>> Macpaul Lin's patch set [1] is the right way to do it.
>>>>
>>>> Agreed. That check (whether OTG descriptor can be added and which version
>>>> of it) has to be done at runtime and it must be added only if hardware supports
>>>> OTG _and_ kernel OTG support is enabled.
>>>>
>>>
>>> Ok, let's put this patch set in mainline first, since your patch set may need some
>>> information from it.
>>>  
>>>>> - We are lack of framework to handle OTG (DRD) switch, it is great you
>>>>> are designing it. The main problem for this framework is how to handle
>>>>> DRD/OTG FSM unify. My thought is we add two paths for them separate.
>>>>> For easy, I suggest if the platform supports one of otg features, then
>>>>> it goes to fully otg fsm, else it goes to simply otg fsm (like your
>>>>> drd fsm). If you agree with it too, you may not need to add another
>>>> "dr_mode"
>>>>> value.
>>>>
>>>> It would be nice that way but unfortunately it does't work in all cases.
>>>> e.g. What if the SoC itself supports all OTG features but the board is not
>>>> designed for OTG. Or the product designer simply is not interested in full OTG
>>>> support but just dual-role. So we need some flexibility for the device
>>>> tree/platform-data to specify that. This is where a new "dr_mode" == "dual-
>>>> role" is needed.
>>>>
>>>
>>> Since "dr_mode" has been widely used now, if we add a new property for it,  we
>>> need to change all drivers.
>>>
>>> Your OTG/DRD framework needs to (partial) use otg fsm, and we will not teach old
>>> driver to use it since there are some driver related stuffs.
>>
>> fair enough. Let's not change dr_mode then and decide based on other parameters.
>>
>>>
>>> SRP/HNP/ADP support can be board level capabilities, and we may consider the
>>> otg device which does not support otg fsm (hardware finishes fsm). So I suggest
>>> we have below properties at dts:
>>>
>>> - otg-support /* fully otg support */
>>> - otg-fsm-support /* fully otg fsm support */
>>
>> what is the difference between otg-support and otg-fsm-support?
> 
> Like I mentioned at above, the hardware finishes HNP/SRP which does not
> use otg fsm code (usb-otg-fsm.c), most of legacy otg platforms (musb?)
> use this way, for these platforms, only need to set otg-support = 1

So dr_mode = "otg" _and_ otg-support = 1?

Again wouldn't this involve changes to dts for musb like platforms
supporting full OTG?

Instead we could add a new field saying otg-fsm-type
"otg-hw", "otg-sw", "drd-sw"

If the field is absent it defaults to "otg-hw".
This also means we don't need otg-fsm-support flag.

Now the pseudo-code to decide fsm is

if (dr_mode == "otg" && CONFIG_USB_OTG)
	if (otg-fsm-type == "otg-sw") {
		if (CONFIG_USB_OTG_FSM)
			full otg fsm support via sw
		else
			error "CONFIG_USB_OTG_FSM" not set
	} else if (otg-fsm-type == "drd-sw") {
		dual role fsm support
	} else {
		full otg support via hw
	}

	if (otg-fsm-type == "otg
else
	error "CONFIG_USB_OTG" not set

> 
> For platforms which software finishes HNP/SRP using otg fsm code, need
> to set both flags.
> 
> For platforms which only do role switch through id pin, do not need to
> set both.
> 

OK. I get it now.

>>
>>> - otg-ver /* eh & otg supplement version */
>>
>> we can get otg version from the OTG controller. What exactly is the
>> otg-ver in dts for?
> 
> Since most of otg stuffs are software's, eg, for otg descriptor, we will
> only use otg 2.0 descriptor when both CONFIG_USB_OTG20 and otg-ver = 20
> are set.

CONFIG_USB_OTG20 is redundant now. Plus I mentioned in the respective thread
that it is not suitable for booting single image on different platforms.

As of now I can see 2 inputs regarding otg-ver
- One comes from otg-ver DT property or platform data.
- Second that may come from OTG controller registers. e.g. It might support
OTG v3.0 but system designer wants to limit to OTG v2.0 via otg-ver.

Controller driver can decide among the 2 and set the appropriate otg version
in the data structure.

> 
>>
>>> - adp-support /* board adp support */ 
>>> - srp-support /* board srp support */
>>> - hnp-support /* board hnp support */
>>
>> So if these options are not provided in DTS but the OTG core supports them then
>> we keep the respective feature disabled?
> 
> Yes.
> 
>> Won't this need dts change for existing boards?
> 
> Does you know any dts based platform supports hnp/srp?

I'm the wrong person to ask this. Maybe Felipe/Tony can comment.
Irrespective of whether any dts platforms supports hsn/srp or not
we must assume that till date dr_mode = otg implies full otg support
and we cannot change its meaning.

We can add new fields to indicate dual-role mode which is a new feature.

> For chipidea platform, currently, we depends on kernel
> configurations (CONFIG_USB_OTG_FSM), but it is incorrect way.
> 
>>
>> Instead how about having disable flags instead.
>>  - adp-disable	/* board doesn't support adp */
>>  - srp-disable	/* board doesn't support srp */
>>  - hnp-disable	/* board doesn't support hnp */
>>
>> Now, if the flags are not provided in dts we use the OTG core's flags.
>>
> 
> How the OTG core's know if it supports these?

By OTG core, I meant OTG controller core. At least the dwc3 OTG controller has
register bits to identify if it supports adp/srp/hnp.

But we also need to keep in mind that adp feature can be provided separately even
if the OTG controller core doesn't support it.

cheers,
-roger

> 
>>>
>>> Currently, if CONFIG_USB_OTG and CONFIG_USB_OTG_FSM are enabled, we will
>>> have otg fsm code (usb-otg-fsm.c).
>>>
>>> if (otg-support & otg-fsm-support)
>>> 	this device has fully otg support, and will follow full otg fsm transitions. 
>>> else
>>> 	this device is drd, and will follow simple otg fsm transtions. 
>>>
>>
>> cheers,
>> -roger
>>
> 

