From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH 0/9] USB: OTG Core functionality
Date: Wed, 18 Mar 2015 10:37:26 -0700
Message-ID: <20150318173726.GS31346@atomide.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150318 07:00]:
> Hi,
> 
> [NOTE: RFC only. Not for merge yet.]
> 
> This is an attempt to centralize OTG functionality in the kernel.
> Still work in progress but I wanted to get an early feedback
> to avoid major rework. :) 
> 
> Why?:
> ----
> 
> Most of the OTG drivers have been dealing with the OTG state machine
> themselves and there is a scope for code re-use. This has been
> partly addressed by the usb/common/usb-otg-fsm.c but it still
> leaves the instantiation of the state machine and OTG timers
> to the controller drivers. We re-use usb-otg-fsm.c but
> go one step further by instantiating the state machine and timers
> thus making it easier for drivers to implement OTG functionality.
> 
> Newer OTG cores support standard host interface (e.g. xHCI?) so
> host and gadget functionality are no longer closely knit like older
> cores. There needs to be a way to co-ordinate the operation of the
> host and gadget in OTG mode. i.e. to stop and start them from a
> central location. This central location should be the USB OTG core.
> 
> Host and gadget controllers might be sharing resources and can't
> be always running. One has to be stopped for the other to run.
> This can't be done as of now and can be done from the OTG core.
> 
> What?:
> -----
> 
> The OTG core instantiates the OTG Finite State Machine
> per OTG controller and manages starting/stopping the
> host and gadget controllers based on the bus state.
>     
> It provides APIs for the following
>     
> - Registering an OTG capable controller
> struct otg_fsm *usb_otg_register(struct device *parent_dev,
>                                  struct otg_fsm_ops *fsm_ops);
> int usb_otg_unregister(struct device *parent_dev);
> 
> - Registering Host controllers to OTG core (used by hcd-core)
> int usb_otg_register_hcd(struct usb_hcd *hcd);
> int usb_otg_unregister_hcd(struct usb_hcd *hcd);
> 
> - Registering Gadget controllers to OTG core (used by udc-core)
> int usb_otg_register_gadget(struct usb_gadget *gadget);
> int usb_otg_unregister_gadget(struct usb_gadget *gadget);
> 
> - Providing inputs to and kicking the OTG state machine
> void usb_otg_sync_inputs(struct otg_fsm *fsm);
> int usb_otg_kick_fsm(struct device *hcd_gcd_device);
> 
> 'struct otg_fsm' is the interface to the OTG state machine.
> It contains inputs to the fsm, status of the fsm and operations
> for the OTG controller driver.

Sounds good to me. I take you're also planning to provide some
common /sys/kernel/debug/otg type interfaces for OTG validation
tests? For things like SRP etc.

Regards,

Tony
 
> Usage model:
> -----------
> 
> - The OTG controller device is assumed to be the parent of
> the host and gadget controller. It must call usb_otg_register()
> before populating the host and gadget devices so that the OTG
> core is aware that it is an OTG device before the host & gadget
> register. The OTG controller must provide struct otg_fsm_ops *
> which will be called by the OTG core depending on OTG bus state.
> 
> - The host/gadget core stacks are modified to inform the OTG core
> whenever a new host/gadget device is added. The OTG core then
> checks if the host/gadget is part of the OTG controller and if yes
> then prevents the host/gadget from starting till both host and
> gadget are registered, OTG state machine is running and the
> USB bus state is appropriate to start host/gadget.
>  For this APIs have been added to host/gadget stacks to start/stop
> the controllers from the OTG core.
> 
> - No modification is needed for the host/gadget controller drivers.
> They must ensure that their start/stop methods can be called repeatedly
> and any shared resources between host & gadget are properly managed.
> The OTG core ensures that both are not started simultaneously.
> 
> - The OTG core instantiates one OTG state machine per OTG
> controller and the necessary OTG timers to manage OTG state timeouts.
> The state machine is started when both host & gadget register and
> stopped when either of them unregisters. The controllers are started
> and stopped depending on bus state.
> 
> - During the lifetime of the OTG state machine, inputs can be
> provided to it by modifying the appropriate members of 'struct otg_fsm'
> and calling usb_otg_sync_inputs(). This is typically done by the
> OTG controller driver that called usb_otg_register() since it is
> the only external component that has the 'struct otg_fsm' handle.
> 
> Pending items:
> - We probably need a otg class.
> - sysfs interface for application OTG inputs and OTG status information
> - resolve symbol dependency for module use.
> - otg driver for dwc3 core to get dual-role working on dra7-evm.
> 
> cheers,
> -roger
> 
> Roger Quadros (9):
>   usb: hcd: Introduce usb_start/stop_hcd()
>   usb: gadget: add usb_gadget_start/stop()
>   usb: otg: add OTG core
>   usb: otg: hub: Notify OTG fsm when A device sets b_hnp_enable
>   usb: hcd: adapt to OTG
>   usb: gadget: udc: adapt to OTG
>   usb: dwc3: adapt to OTG core
>   usb: otg-fsm: Remove unused members in struct otg_fsm
>   usb: otg-fsm: Add documentation for struct otg_fsm
> 
>  drivers/usb/Makefile              |   1 +
>  drivers/usb/common/Makefile       |   1 +
>  drivers/usb/common/usb-otg.c      | 732 ++++++++++++++++++++++++++++++++++++++
>  drivers/usb/common/usb-otg.h      |  71 ++++
>  drivers/usb/core/Kconfig          |   8 +
>  drivers/usb/core/hcd.c            | 153 +++++---
>  drivers/usb/core/hub.c            |  11 +-
>  drivers/usb/dwc3/core.c           | 101 ++++++
>  drivers/usb/dwc3/core.h           |   6 +
>  drivers/usb/dwc3/platform_data.h  |   1 +
>  drivers/usb/gadget/udc/udc-core.c | 172 ++++++++-
>  include/linux/usb/gadget.h        |   3 +
>  include/linux/usb/hcd.h           |   2 +
>  include/linux/usb/otg-fsm.h       |  81 ++++-
>  include/linux/usb/usb-otg.h       |  86 +++++
>  15 files changed, 1357 insertions(+), 72 deletions(-)
>  create mode 100644 drivers/usb/common/usb-otg.c
>  create mode 100644 drivers/usb/common/usb-otg.h
>  create mode 100644 include/linux/usb/usb-otg.h
> 
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
