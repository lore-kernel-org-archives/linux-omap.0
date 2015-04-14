From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH v2 00/13] USB: OTG/DRD Core functionality
Date: Tue, 14 Apr 2015 13:41:47 +0300
Message-ID: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This is an attempt to centralize OTG/Dual-role functionality in the kernel.
As of now I've got Dual-role functionality working pretty reliably on
dra7-evm. xhci side of things for OTG/DRD use are fixed in
http://thread.gmane.org/gmane.linux.kernel/1923161

Changelog:
---------
v2
- Use add/remove_hcd() instead of start/stop_hcd() to enable/disable
the host controller
- added dual-role-device (DRD) state machine which is a much simpler
mode of operation when compared to OTG. Here we don't support fancy
OTG features like HNP, SRP, on the fly role-swap. The mode of operation
is determined based on ID pin (cable type) and the role doesn't change
till the cable type changes.

Why?:
----

Most of the OTG drivers have been dealing with the OTG state machine
themselves and there is a scope for code re-use. This has been
partly addressed by the usb/common/usb-otg-fsm.c but it still
leaves the instantiation of the state machine and OTG timers
to the controller drivers. We re-use usb-otg-fsm.c but
go one step further by instantiating the state machine and timers
thus making it easier for drivers to implement OTG functionality.

Newer OTG cores support standard host interface (e.g. xHCI?) so
host and gadget functionality are no longer closely knit like older
cores. There needs to be a way to co-ordinate the operation of the
host and gadget in OTG mode. i.e. to stop and start them from a
central location. This central location should be the USB OTG core.

Host and gadget controllers might be sharing resources and can't
be always running. One has to be stopped for the other to run.
This can't be done as of now and can be done from the OTG core.

What?:
-----

The OTG core instantiates the OTG/DRD Finite State Machine
per OTG controller and manages starting/stopping the
host and gadget controllers based on the bus state.
    
It provides APIs for the following
    
- Registering an OTG capable controller
struct otg_fsm *usb_otg_register(struct device *parent_dev,
                                 struct otg_fsm_ops *fsm_ops,
				 bool drd_only);
int usb_otg_unregister(struct device *parent_dev);

- Registering Host controllers to OTG core (used by hcd-core)
int usb_otg_register_hcd(struct usb_hcd *hcd);
int usb_otg_unregister_hcd(struct usb_hcd *hcd);

- Registering Gadget controllers to OTG core (used by udc-core)
int usb_otg_register_gadget(struct usb_gadget *gadget);
int usb_otg_unregister_gadget(struct usb_gadget *gadget);

- Providing inputs to and kicking the OTG state machine
void usb_otg_sync_inputs(struct otg_fsm *fsm);
int usb_otg_kick_fsm(struct device *hcd_gcd_device);

'struct otg_fsm' is the interface to the OTG state machine.
It contains inputs to the fsm, status of the fsm and operations
for the OTG controller driver.

Usage model:
-----------

- The OTG controller device is assumed to be the parent of
the host and gadget controller. It must call usb_otg_register()
before populating the host and gadget devices so that the OTG
core is aware that it is an OTG device before the host & gadget
register. The OTG controller must provide struct otg_fsm_ops *
which will be called by the OTG core depending on OTG bus state.

- The host/gadget core stacks are modified to inform the OTG core
whenever a new host/gadget device is added. The OTG core then
checks if the host/gadget is part of the OTG controller and if yes
then prevents the host/gadget from starting till both host and
gadget are registered, OTG state machine is running and the
USB bus state is appropriate to start host/gadget.
 For this APIs have been added to host/gadget stacks to start/stop
the controllers from the OTG core.

- No modification is needed for the host/gadget controller drivers.
They must ensure that their start/stop methods can be called repeatedly
and any shared resources between host & gadget are properly managed.
The OTG core ensures that both are not started simultaneously.

- The OTG core instantiates one OTG state machine per OTG
controller and the necessary OTG timers to manage OTG state timeouts.
The state machine is started when both host & gadget register and
stopped when either of them unregisters. The controllers are started
and stopped depending on bus state.

- During the lifetime of the OTG state machine, inputs can be
provided to it by modifying the appropriate members of 'struct otg_fsm'
and calling usb_otg_sync_inputs(). This is typically done by the
OTG controller driver that called usb_otg_register() since it is
the only external component that has the 'struct otg_fsm' handle.

Pending items:
- We probably need a otg class.
- sysfs interface for application OTG inputs and OTG status information
- resolve symbol dependency for module use.

--
cheers,
-roger

Roger Quadros (13):
  usb: otg-fsm: Add documentation for struct otg_fsm
  usb: otg-fsm: support multiple instances
  usb: otg-fsm: Prevent build warning "VDBG" redefined
  usb: gadget: add usb_gadget_start/stop()
  usb: otg: add OTG core
  usb: hcd: Add hcd add/remove functions for OTG use
  usb: otg: Add dual-role device (DRD) support
  usb: otg: hub: Notify OTG fsm when A device sets b_hnp_enable
  usb: gadget: udc: adapt to OTG
  udc-core: fix lock circular dependency on udc_lock
  usb: add "dual-role" mode to dr_mode device tree helper
  usb: dwc3: add dual-role support
  ARM: dts: dra7x-evm: Enable dual-role for usb1

 Documentation/devicetree/bindings/usb/generic.txt |   2 +-
 arch/arm/boot/dts/dra7-evm.dts                    |   2 +-
 arch/arm/boot/dts/dra72-evm.dts                   |   2 +-
 drivers/usb/Makefile                              |   1 +
 drivers/usb/common/Makefile                       |   1 +
 drivers/usb/common/common.c                       |   1 +
 drivers/usb/common/usb-otg-fsm.c                  |  19 +-
 drivers/usb/common/usb-otg.c                      | 902 ++++++++++++++++++++++
 drivers/usb/common/usb-otg.h                      |  71 ++
 drivers/usb/core/Kconfig                          |   8 +
 drivers/usb/core/hcd.c                            |  24 +-
 drivers/usb/core/hub.c                            |  11 +-
 drivers/usb/dwc3/core.c                           | 146 +++-
 drivers/usb/dwc3/core.h                           |   6 +
 drivers/usb/dwc3/platform_data.h                  |   1 +
 drivers/usb/gadget/udc/udc-core.c                 | 119 ++-
 include/linux/usb/gadget.h                        |   3 +
 include/linux/usb/hcd.h                           |   3 +
 include/linux/usb/otg-fsm.h                       | 104 ++-
 include/linux/usb/otg.h                           |   1 +
 include/linux/usb/usb-otg.h                       |  95 +++
 21 files changed, 1476 insertions(+), 46 deletions(-)
 create mode 100644 drivers/usb/common/usb-otg.c
 create mode 100644 drivers/usb/common/usb-otg.h
 create mode 100644 include/linux/usb/usb-otg.h

-- 
2.1.0
