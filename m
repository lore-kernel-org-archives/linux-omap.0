From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH v2 00/13] USB: OTG/DRD Core functionality
Date: Tue, 21 Apr 2015 10:34:01 +0300
Message-ID: <5535FD69.6070900@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com> <20150420030531.GA30878@shlinux2> <5534AA8C.1070400@ti.com> <BY1PR0301MB0855ACDA4337AE3FC7F616E081EF0@BY1PR0301MB0855.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BY1PR0301MB0855ACDA4337AE3FC7F616E081EF0@BY1PR0301MB0855.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <Peter.Chen@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "balbi@ti.com" <balbi@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Jun.Li@freescale.com" <Jun.Li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "macpaul@gmail.com" <macpaul@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 21/04/15 09:04, Peter Chen wrote:
>  
>>
>> On 20/04/15 06:05, Peter Chen wrote:
>>> On Tue, Apr 14, 2015 at 01:41:47PM +0300, Roger Quadros wrote:
>>>> This is an attempt to centralize OTG/Dual-role functionality in the kernel.
>>>> As of now I've got Dual-role functionality working pretty reliably on
>>>> dra7-evm. xhci side of things for OTG/DRD use are fixed in
>>>> http://thread.gmane.org/gmane.linux.kernel/1923161
>>>
>>> Hi Roger,
>>>
>>> Currently, there are two main problems for DRD/OTG framework.
>>>
>>> - For multi-platform supports, we may define CONFIG_USB_OTG, but the
>>> gadget should not add its otg descriptor to its configuration
>>> descriptors if it does not support one of otg features (SRP/HNP/ADP).
>>> Macpaul Lin's patch set [1] is the right way to do it.
>>
>> Agreed. That check (whether OTG descriptor can be added and which version
>> of it) has to be done at runtime and it must be added only if hardware supports
>> OTG _and_ kernel OTG support is enabled.
>>
> 
> Ok, let's put this patch set in mainline first, since your patch set may need some
> information from it.
>  
>>> - We are lack of framework to handle OTG (DRD) switch, it is great you
>>> are designing it. The main problem for this framework is how to handle
>>> DRD/OTG FSM unify. My thought is we add two paths for them separate.
>>> For easy, I suggest if the platform supports one of otg features, then
>>> it goes to fully otg fsm, else it goes to simply otg fsm (like your
>>> drd fsm). If you agree with it too, you may not need to add another
>> "dr_mode"
>>> value.
>>
>> It would be nice that way but unfortunately it does't work in all cases.
>> e.g. What if the SoC itself supports all OTG features but the board is not
>> designed for OTG. Or the product designer simply is not interested in full OTG
>> support but just dual-role. So we need some flexibility for the device
>> tree/platform-data to specify that. This is where a new "dr_mode" == "dual-
>> role" is needed.
>>
> 
> Since "dr_mode" has been widely used now, if we add a new property for it,  we
> need to change all drivers.
> 
> Your OTG/DRD framework needs to (partial) use otg fsm, and we will not teach old
> driver to use it since there are some driver related stuffs.

fair enough. Let's not change dr_mode then and decide based on other parameters.

> 
> SRP/HNP/ADP support can be board level capabilities, and we may consider the
> otg device which does not support otg fsm (hardware finishes fsm). So I suggest
> we have below properties at dts:
> 
> - otg-support /* fully otg support */
> - otg-fsm-support /* fully otg fsm support */

what is the difference between otg-support and otg-fsm-support?

> - otg-ver /* eh & otg supplement version */

we can get otg version from the OTG controller. What exactly is the
otg-ver in dts for?

> - adp-support /* board adp support */ 
> - srp-support /* board srp support */
> - hnp-support /* board hnp support */

So if these options are not provided in DTS but the OTG core supports them then
we keep the respective feature disabled?
Won't this need dts change for existing boards?

Instead how about having disable flags instead.
 - adp-disable	/* board doesn't support adp */
 - srp-disable	/* board doesn't support srp */
 - hnp-disable	/* board doesn't support hnp */

Now, if the flags are not provided in dts we use the OTG core's flags.

> 
> Currently, if CONFIG_USB_OTG and CONFIG_USB_OTG_FSM are enabled, we will
> have otg fsm code (usb-otg-fsm.c).
> 
> if (otg-support & otg-fsm-support)
> 	this device has fully otg support, and will follow full otg fsm transitions. 
> else
> 	this device is drd, and will follow simple otg fsm transtions. 
> 

cheers,
-roger
