From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v8 00/14] USB OTG/dual-role framework
Date: Mon, 30 May 2016 17:04:18 +0300
Message-ID: <574C4862.5090308@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <20160530092944.GA27513@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160530092944.GA27513@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 30/05/16 12:29, Peter Chen wrote:
> On Fri, May 13, 2016 at 01:03:14PM +0300, Roger Quadros wrote:
>> Hi,
>>
>> This series centralizes OTG/Dual-role functionality in the kernel.
>> As of now I've got Dual-role functionality working pretty reliably on
>> dra7-evm and am437x-gp-evm.
>> NOTE: my am437x-gp-evm broke so I couldn't test v8 on it.
>> But the changes since v7 are trivial and shouldn't impact am437x-gp-evm.
>>
>> DWC3 controller and platform related patches will be sent separately.
>>
>> Series is based on v4.6-rc1 and depends on first 2 patches of [1]
>> [1] - OTG fsm cleanup - https://lkml.org/lkml/2016/3/30/186
>>
>> Why?:
>> ----
>>
>> Currently there is no central location where OTG/dual-role functionality is
>> implemented in the Linux USB stack and every USB controller driver is
>> doing their own thing for OTG/dual-role. We can benefit from code-reuse
>> and simplicity by adding the OTG/dual-role core driver.
>>
>> Newer OTG cores support standard host interface (e.g. xHCI) so
>> host and gadget functionality are no longer closely knit like older
>> cores. There needs to be a way to co-ordinate the operation of the
>> host and gadget controllers in dual-role mode. i.e. to stop and start them
>> from a central location. This central location should be the
>> USB OTG/dual-role core.
>>
>> Host and gadget controllers might be sharing resources and can't
>> be always running. One has to be stopped for the other to run.
>> This couldn't be done till now but can be done from the OTG core.
>>
>> What?:
>> -----
>>
>> The OTG/dual-role core consists of a set of APIs that allow
>> registration of OTG controller device and OTG capable host and gadget
>> controllers.
>>
>> - The OTG controller driver can provide the OTG capabilities and the
>> Finite State Machine work function via 'struct usb_otg_config'
>> at the time of registration i.e. usb_otg_register();
>>
>> 	struct usb_otg *usb_otg_register(struct device *dev,
>>         	                         struct usb_otg_config *config);
>> 	int usb_otg_unregister(struct device *dev);
>> 	/**
>> 	 * struct usb_otg_config - otg controller configuration
>> 	 * @caps: otg capabilities of the controller
>> 	 * @ops: otg fsm operations
>> 	 * @otg_work: optional custom otg state machine work function
>> 	 */
>> 	struct usb_otg_config {
>> 	        struct usb_otg_caps *otg_caps;
>> 	        struct otg_fsm_ops *fsm_ops;
>> 	        void (*otg_work)(struct work_struct *work);
>> 	};
>>
>> The dual-role state machine is built-into the OTG core so nothing
>> special needs to be provided if only dual-role functionality is desired.
>> The low level OTG controller driver ops are povided via
>> 'struct otg_fsm_ops *fsm_ops' in the 'struct usb_otg_config'.
>>
>> After registration, the OTG core waits for host, gadget controller
>> and the gadget function driver to be registered. Once all resources are
>> available it instantiates the Finite State Machine (FSM).
>> The host/gadget controllers are started/stopped according to the FSM.
>>
>> - Host and gadget controllers that are a part of OTG/dual-role port must
>> use the OTG core provided APIs to add/remove the host/gadget.
>> i.e. hosts must use usb_otg_add_hcd() usb_otg_remove_hcd(),,
>> gadgets must use usb_otg_add_gadget_udc() usb_del_gadget_udc().
>> This ensures that the host and gadget controllers are not started till
>> the state machine is ready and the right bus conditions are met.
>> It also allows the host and gadget controllers to provide the OTG
>> controller device to link them together. For Device tree boots
>> the related OTG controller is automatically picked up via the
>> 'otg-controller' property in the Host/Gadget controller nodes.
>>
>> 	int usb_otg_add_hcd(struct usb_hcd *hcd,
>> 			    unsigned int irqnum, unsigned long irqflags,
>> 			    struct device *otg_dev);
>> 	void usb_otg_remove_hcd(struct usb_hcd *hcd);
>>
>> 	int usb_otg_add_gadget_udc(struct device *parent,
>> 				   struct usb_gadget *gadget,
>> 				   struct device *otg_dev);
>> 	usb_del_gadget_udc() must be used for removal.
>>
>>
>> - During the lifetime of the FSM, the OTG controller driver can provide
>> inputs event changes using usb_otg_sync_inputs(). The OTG core will
>> then schedule the FSM work function (or internal dual-role state machine)
>> to update the FSM state. The FSM then calls the OTG controller
>> operations (fsm_ops) as necessary.
>> 	void usb_otg_sync_inputs(struct usb_otg *otg);
>>
>> - The following 2 functions are provided as helpers for use by the
>> OTG controller driver to start/stop the host/gadget controllers.
>> 	int usb_otg_start_host(struct usb_otg *otg, int on);
>> 	int usb_otg_start_gadget(struct usb_otg *otg, int on);
>>
>> - The following function is provided for use by the USB host stack
>> to sync OTG related events to the OTG state machine.
>> e.g. change in host_bus->b_hnp_enable, gadget->b_hnp_enable
>> 	int usb_otg_kick_fsm(struct device *otg_device);
>>
>> Changelog:
>> ---------
>> v8:
>> - split out start/stop gadget and connect/disconnect operations.
>> - make CONFIG_OTG dpend on CONFIG_USB_GADGET as well apart from CONFIG_USB
>> - use create_freezable_workqueue() for OTG work as per Peter's suggestion.
>> - remove usb-otg.h as we're not initializing any OTG timers.
>> - don't include unnecessary headers in usb-otg.c (i.e. hrtimer.h & ktime.h)
>>
> 
> Since you have agreed to move CONFIG_USB_OTG out of HCD, I suggest you
> can have a folder to put current OTG and OTG_FSM stuffs under the root
> of usb folder, it can benefit the user who wants to add their dual-role
> switch driver or OTG driver. What do you think?

Yes, I will give it a try and post if any problems.

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
