From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v10 00/14] USB OTG/dual-role framework
Date: Tue, 14 Jun 2016 11:12:24 +0300
Message-ID: <575FBC68.1070905@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <20160614021756.GB25052@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160614021756.GB25052@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

+Alan. (Sorry Alan, I forgot to add copy you in this series).

Hi,

On 14/06/16 05:17, Peter Chen wrote:
> On Fri, Jun 10, 2016 at 04:07:09PM +0300, Roger Quadros wrote:
>> Hi,
>>
>> This series centralizes OTG/Dual-role functionality in the kernel.
>> As of now I've got Dual-role functionality working pretty reliably on
>> dra7-evm and am437x-gp-evm.
>>
>> DWC3 controller and TI platform related patches will be sent separately.
>>
>> Series is based on v4.7-rc1 + balbi/usb.git testing/next
>> commit 4a2786c10462df650965785462ca82c185164d98.
>>
> 
> Roger, I have acked for all your patches. You can send v11 for all
> patches. When you get Felipe's ack for gadget part, Alan's ack
> for hcd part, and your dwc3 and platform related patches ack,
> you can let Felipe help to queue this patch set since some of
> the code based on his tree. Thank you for your hard work for it.

Thanks Peter,

I'll send v11, with your Acks.

cheers,
-roger

> 
> Peter
> 
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
>> - The following function is provided for use by the USB gadget stack
>> to notify OTG/DRD about gadget function driver being ready/not-ready
>> 	int usb_otg_gadget_ready(struct usb_gadget *gadget, bool ready)
>>
>> Changelog:
>> ---------
>> v10:
>> - added missing mutex_unlock in failure path in usb_otg_unregister()
>> - removed unnecessary hrtimer.h and ktime.h in linux/usb/otg.h
>> - comment fixes: urb->URB.
>> - fix commit log: say dev_vdbg() instead of dev_dbg().
>> - Update comments so that HCD means Host Controller Driver.
>> - rebased on Felipe's balbi/usb.git /testing/next
>> - include <linux/usb/of.h> in usb-otg.c
>> - in usb_otg_start_host() check if hcd_ops->add() failed and return
>> error code if it did.
>> - in usb_otg_start/stop_gadget() check if hcd_ops->add() failed and return
>> error code if it did.
>> - follow kernel-doc style in usb-otg.c
>>
>> v9:
>> - In the DT bindings, clearly indicate which properties are for OTG controller
>> and which ones are for host/device controllers
>> - Removed host/gadget wait list from otg core. Use defer probing if host/gadget
>> registers before dual-role/otg controller.
>> - move gadget registering to otg core from udc_bind_to_driver()/usb_gadget_remove_driver()
>> to usb_add_gadget_udc_release()/usb_del_gadget_udc(). This means that we need
>> an additional mechanism to know when the gadget function driver registers.
>> So we add usb_otg_gadget_ready() API to allow gadget to notify otg core about
>> ready/not-ready function driver.
>> - update otg->caps based on capabilities provided by the controller and the
>> device tree overrides.
>> - in usb_drd_work() we must keep calling the drd_statemachine() as long as
>> there is a state change.
>> - updated kconfig so that usbotg can be a module when both host and gadget
>> are modules.
>> - rebased on v4.7-rc1
>>
>> v8:
>> - split out start/stop gadget and connect/disconnect operations.
>> - make CONFIG_OTG dpend on CONFIG_USB_GADGET as well apart from CONFIG_USB
>> - use create_freezable_workqueue() for OTG work as per Peter's suggestion.
>> - remove usb-otg.h as we're not initializing any OTG timers.
>> - don't include unnecessary headers in usb-otg.c (i.e. hrtimer.h & ktime.h)
>>
>> v7:
>> - added dual-role support for host controllers requiring a companion
>> controller. e.g. EHCI + OHCI.
>> - added of_usb_get_otg() to get the OTG controller device
>> from the USB controller's device node.
>> - addressed review comments.
>>
>> v6:
>> - added otg specific APIs for host/gadget registration. behaviour of
>> original host/gadget API remains unchanged. Platform devices can now
>> pass the otg device explicitly while registering host/gadget.
>> - moved hcd specific operations from struct otg_fsm to struct hcd_ops.
>> - made struct usb_otg mandatory for all otg related APIs.
>> - allow otg controller to provide it's own otg_work function so that
>> it can implement it's own state machine.
>> - removed otg fsm and timers from usb-otg.c. Only dual-role state machine
>> is implemented.
>> - vbus is controlled in the dual-role state machine.
>> - PM runtime is used around drd_statemachine().
>> - added otg_dev to xhci platform data to allow platform code to specify
>> the otg controller tied to the xhci host controller.
>>
>> v5: Internal version. Not sent to mailing list
>>
>> v4:
>> - Added DT support for tying otg-controller to host and gadget
>>  controllers. For DT we no longer have the constraint that
>>  OTG controller needs to be parent of host and gadget. They can be
>>  tied together using the "otg-controller" property.
>> - Relax the requirement for DT case that otg controller must register
>>  before host/gadget. We maintain a wait list of host/gadget devices
>>  waiting on the otg controller.
>> - Use a single struct usb_otg for otg data.
>> - Don't override host/gadget start/stop APIs. Let the controller
>>  drivers do what they want as they know best. Helper API is provided
>>  for controller start/stop that controller driver can use.
>> - Introduce struct usb_otg_config to pass the otg capabilities,
>>  otg ops and otg timer timeouts during otg controller registration.
>> - rebased on Greg's usb.git/usb-next
>>
>> v3:
>> - all otg related definations now in otg.h
>> - single kernel config USB_OTG to enable OTG core and FSM.
>> - resolved symbol dependency issues.
>> - use dev_vdbg instead of VDBG() in usb-otg-fsm.c
>> - rebased on v4.2-rc1
>>
>> v2:
>> - Use add/remove_hcd() instead of start/stop_hcd() to enable/disable
>>  the host controller
>> - added dual-role-device (DRD) state machine which is a much simpler
>>  mode of operation when compared to OTG. Here we don't support fancy
>>  OTG features like HNP, SRP, on the fly role-swap. The mode of operation
>>  is determined based on ID pin (cable type) and the role doesn't change
>>  till the cable type changes.
>>
>> --
>> cheers,
>> -roger
>>
>> Roger Quadros (13):
>>   usb: hcd: Initialize hcd->flags to 0
>>   usb: otg-fsm: Prevent build warning "VDBG" redefined
>>   usb: hcd.h: Add OTG to HCD interface
>>   usb: otg-fsm: use usb_otg wherever possible
>>   usb: otg-fsm: move host controller operations into usb_otg->hcd_ops
>>   usb: gadget.h: Add OTG to gadget interface
>>   usb: otg: get rid of CONFIG_USB_OTG_FSM in favour of CONFIG_USB_OTG
>>   usb: otg: add OTG/dual-role core
>>   usb: of: add an API to get OTG device from USB controller node
>>   usb: otg: use dev_vdbg() instead of VDBG()
>>   usb: hcd: Adapt to OTG core
>>   usb: gadget: udc: adapt to OTG core
>>   usb: host: xhci-plat: Add otg device to platform data
>>
>> Yoshihiro Shimoda (1):
>>   usb: otg: add hcd companion support
>>
>>  Documentation/devicetree/bindings/usb/generic.txt |   6 +
>>  Documentation/usb/chipidea.txt                    |   2 +-
>>  drivers/usb/Kconfig                               |  18 +
>>  drivers/usb/Makefile                              |   1 +
>>  drivers/usb/chipidea/Makefile                     |   2 +-
>>  drivers/usb/chipidea/ci.h                         |   3 +-
>>  drivers/usb/chipidea/core.c                       |  14 +-
>>  drivers/usb/chipidea/debug.c                      |   2 +-
>>  drivers/usb/chipidea/otg_fsm.c                    | 176 +++--
>>  drivers/usb/chipidea/otg_fsm.h                    |   2 +-
>>  drivers/usb/chipidea/udc.c                        |  17 +-
>>  drivers/usb/common/Makefile                       |   5 +-
>>  drivers/usb/common/common.c                       |  27 +
>>  drivers/usb/common/usb-otg-fsm.c                  | 203 ++---
>>  drivers/usb/common/usb-otg.c                      | 919 ++++++++++++++++++++++
>>  drivers/usb/core/Kconfig                          |  22 -
>>  drivers/usb/core/hcd.c                            |  56 ++
>>  drivers/usb/gadget/Kconfig                        |   1 +
>>  drivers/usb/gadget/udc/core.c                     | 202 ++++-
>>  drivers/usb/host/xhci-plat.c                      |  35 +-
>>  drivers/usb/phy/Kconfig                           |   2 +-
>>  drivers/usb/phy/phy-fsl-usb.c                     | 155 ++--
>>  drivers/usb/phy/phy-fsl-usb.h                     |   3 +-
>>  include/linux/usb/gadget.h                        |  22 +
>>  include/linux/usb/hcd.h                           |  29 +
>>  include/linux/usb/of.h                            |   9 +
>>  include/linux/usb/otg-fsm.h                       | 154 +---
>>  include/linux/usb/otg.h                           | 290 ++++++-
>>  include/linux/usb/xhci_pdriver.h                  |   3 +
>>  29 files changed, 1918 insertions(+), 462 deletions(-)
>>  create mode 100644 drivers/usb/common/usb-otg.c
>>
>> -- 
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
