From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 00/13] USB: OTG/DRD Core functionality
Date: Thu, 3 Dec 2015 14:24:10 +0530
Message-ID: <56600332.30708@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
 <20151203081951.GA18533@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151203081951.GA18533@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Peter,

On 03/12/15 13:49, Peter Chen wrote:
> On Mon, Aug 24, 2015 at 04:21:11PM +0300, Roger Quadros wrote:
>> Hi,
>>
>> This series centralizes OTG/Dual-role functionality in the kernel.
>> As of now I've got Dual-role functionality working pretty reliably on
>> dra7-evm and am437x-gp-evm.
>>
>> DWC3 controller and platform related patches will be sent separately.
>>
>> Series is based on Greg's usb-next tree.
> 
> Hi Roger,
> 
> Will you go on for this patch set?

Yes, but I can only work on this from Feb onwards.

cheers,
-roger
> 
> Peter
>>
>> Changelog:
>> ---------
>> v4:
>> - Added DT support for tying otg-controller to host and gadget
>>  controllers. For DT we no longer have the constraint that
>>  OTG controller needs to be parent of host and gadget. They can be
>>  tied together using the "otg-controller" property.
>> - Relax the requirement for DT case that otg controller must register before
>>  host/gadget. We maintain a wait list of host/gadget devices
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
>> Why?:
>> ----
>>
>> Most of the OTG drivers have been dealing with the OTG state machine
>> themselves and there is a scope for code re-use. This has been
>> partly addressed by the usb/common/usb-otg-fsm.c but it still
>> leaves the instantiation of the state machine and OTG timers
>> to the controller drivers. We re-use usb-otg-fsm.c but
>> go one step further by instantiating the state machine and timers
>> thus making it easier for drivers to implement OTG functionality.
>>
>> Newer OTG cores support standard host interface (e.g. xHCI) so
>> host and gadget functionality are no longer closely knit like older
>> cores. There needs to be a way to co-ordinate the operation of the
>> host and gadget in OTG mode. i.e. to stop and start them from a
>> central location. This central location should be the USB OTG core.
>>
>> Host and gadget controllers might be sharing resources and can't
>> be always running. One has to be stopped for the other to run.
>> This can't be done as of now and can be done from the OTG core.
>>
>> What?:
>> -----
>>
>> The OTG core instantiates the OTG/DRD Finite State Machine
>> per OTG controller and manages starting/stopping the
>> host and gadget controllers based on the bus state.
>>     
>> It provides APIs for the following
>>     
>> - Registering an OTG capable controller
>> struct otg_fsm *usb_otg_register(struct device *dev,
>>                                  struct usb_otg_config *config);
>>
>> int usb_otg_unregister(struct device *dev);
>>
>> - Registering Host controllers to OTG core (used by hcd-core)
>> int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>                          unsigned long irqflags, struct otg_hcd_ops *ops);
>> int usb_otg_unregister_hcd(struct usb_hcd *hcd);
>>
>>
>> - Registering Gadget controllers to OTG core (used by udc-core)
>> int usb_otg_register_gadget(struct usb_gadget *gadget,
>>                             struct otg_gadget_ops *ops);
>> int usb_otg_unregister_gadget(struct usb_gadget *gadget);
>>
>>
>> - Providing inputs to and kicking the OTG state machine
>> void usb_otg_sync_inputs(struct otg_fsm *fsm);
>> int usb_otg_kick_fsm(struct device *hcd_gcd_device);
>>
>> - Getting controller device structure from OTG state machine instance
>> struct device *usb_otg_fsm_to_dev(struct otg_fsm *fsm);
>>
>> 'struct otg_fsm' is the interface to the OTG state machine.
>> It contains inputs to the fsm, status of the fsm and operations
>> for the OTG controller driver.
>>
>> - Helper APIs for starting/stopping host/gadget controllers
>> int usb_otg_start_host(struct otg_fsm *fsm, int on);
>> int usb_otg_start_gadget(struct otg_fsm *fsm, int on);
>>
>> Usage model:
>> -----------
>>
>> - The OTG core needs to know what host and gadget controllers are
>> linked to the OTG controller. For DT boots we can provide that
>> information by adding "otg-controller" property to the host and
>> gadget controller nodes that points to the right otg controller.
>> For legacy boot we assume that OTG controller is the parent
>> of the host and gadget controllers. For DT if "otg-controller"
>> property is not present then parent child relationship constraint
>> applies.
>>
>> - The OTG controller driver must call usb_otg_register() to register
>> itself with the OTG core. It must also provide the required
>> OTG configuration, fsm operations and timer timeouts (optional)
>> via struct usb_otg_config. The fsm operations will be called
>> depending on the OTG bus state.
>>
>> - The host/gadget core stacks are modified to inform the OTG core
>> whenever a new host/gadget device is added. The OTG core then
>> checks if the host/gadget is part of the OTG controller and if yes
>> then prevents the host/gadget from starting till both host and
>> gadget are registered, OTG state machine is running and the
>> USB bus state is appropriate to start host/gadget.
>> For this, APIs have been added to host/gadget stacks to start/stop
>> the controllers from the OTG core.
>> For DT boots, If the OTG controller hasn't yet been registered
>> while the host/gadget are added, the OTG core will hold it in a wait list
>> and register them when the OTG controller registers.
>>
>> - No modification is needed for the host/gadget controller drivers.
>> They must ensure that their start/stop methods can be called repeatedly
>> and any shared resources between host & gadget are properly managed.
>> The OTG core ensures that both are not started simultaneously.
>>
>> - The OTG core instantiates one OTG state machine per OTG controller
>> and the necessary OTG timers to manage OTG state timeouts.
>> If none of the otg features are set during usb_otg_register() then it
>> instanciates a DRD (dual-role device) state machine instead.
>> The state machine is started when both host & gadget register and
>> stopped when either of them unregisters. The controllers are started
>> and stopped depending on bus state.
>>
>> - During the lifetime of the OTG state machine, inputs can be
>> provided to it by modifying the appropriate members of 'struct otg_fsm'
>> and calling usb_otg_sync_inputs(). This is typically done by the
>> OTG controller driver that called usb_otg_register().
>>
>> --
>> cheers,
>> -roger
>>
>> Roger Quadros (13):
>>   usb: otg-fsm: Add documentation for struct otg_fsm
>>   usb: otg-fsm: support multiple instances
>>   usb: otg-fsm: Prevent build warning "VDBG" redefined
>>   otg-fsm: move usb_bus_start_enum into otg-fsm->ops
>>   usb: hcd.h: Add OTG to HCD interface
>>   usb: gadget.h: Add OTG to gadget interface
>>   usb: otg: add OTG core
>>   usb: doc: dt-binding: Add otg-controller property
>>   usb: chipidea: move from CONFIG_USB_OTG_FSM to CONFIG_USB_OTG
>>   usb: hcd: Adapt to OTG core
>>   usb: core: hub: Notify OTG fsm when A device sets b_hnp_enable
>>   usb: gadget: udc: adapt to OTG core
>>   usb: otg: Add dual-role device (DRD) support
>>
>>  Documentation/devicetree/bindings/usb/generic.txt |    5 +
>>  Documentation/usb/chipidea.txt                    |    2 +-
>>  MAINTAINERS                                       |    4 +-
>>  drivers/usb/Kconfig                               |    2 +-
>>  drivers/usb/Makefile                              |    1 +
>>  drivers/usb/chipidea/Makefile                     |    2 +-
>>  drivers/usb/chipidea/ci.h                         |    2 +-
>>  drivers/usb/chipidea/otg_fsm.c                    |    1 +
>>  drivers/usb/chipidea/otg_fsm.h                    |    2 +-
>>  drivers/usb/common/Makefile                       |    3 +-
>>  drivers/usb/common/usb-otg-fsm.c                  |   26 +-
>>  drivers/usb/common/usb-otg.c                      | 1223 +++++++++++++++++++++
>>  drivers/usb/common/usb-otg.h                      |   71 ++
>>  drivers/usb/core/Kconfig                          |   11 +-
>>  drivers/usb/core/hcd.c                            |   55 +-
>>  drivers/usb/core/hub.c                            |   10 +-
>>  drivers/usb/gadget/udc/udc-core.c                 |  124 ++-
>>  drivers/usb/phy/Kconfig                           |    2 +-
>>  drivers/usb/phy/phy-fsl-usb.c                     |    3 +
>>  include/linux/usb/gadget.h                        |   14 +
>>  include/linux/usb/hcd.h                           |   14 +
>>  include/linux/usb/otg-fsm.h                       |  116 +-
>>  include/linux/usb/otg.h                           |  191 +++-
>>  23 files changed, 1808 insertions(+), 76 deletions(-)
>>  create mode 100644 drivers/usb/common/usb-otg.c
>>  create mode 100644 drivers/usb/common/usb-otg.h
>>
>> -- 
>> 2.1.4
>>
> 
