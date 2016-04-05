From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 00/12] USB OTG/dual-role framework
Date: Tue, 5 Apr 2016 17:05:05 +0300
Message-ID: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series centralizes OTG/Dual-role functionality in the kernel.
As of now I've got Dual-role functionality working pretty reliably on
dra7-evm and am437x-gp-evm.

DWC3 controller and platform related patches will be sent separately.

Series is based on v4.6-rc1 and depends on [1]
[1] - OTG fsm cleanup - https://lkml.org/lkml/2016/3/30/186

Why?:
----

Currently there is no central location where OTG/dual-role functionality is
implemented in the Linux USB stack and every USB controller driver is
doing their own thing for OTG/dual-role. We can benefit from code-reuse
and simplicity by adding the OTG/dual-role core driver.

Newer OTG cores support standard host interface (e.g. xHCI) so
host and gadget functionality are no longer closely knit like older
cores. There needs to be a way to co-ordinate the operation of the
host and gadget controllers in dual-role mode. i.e. to stop and start them
from a central location. This central location should be the
USB OTG/dual-role core.

Host and gadget controllers might be sharing resources and can't
be always running. One has to be stopped for the other to run.
This couldn't be done till now but can be done from the OTG core.

What?:
-----

The OTG/dual-role core consists of a set of APIs that allow
registration of OTG controller device and OTG capable host and gadget
controllers.

- The OTG controller driver can provide the OTG capabilities and the
Finite State Machine work function via 'struct usb_otg_config'
at the time of registration i.e. usb_otg_register();

	struct usb_otg *usb_otg_register(struct device *dev,
        	                         struct usb_otg_config *config);
	int usb_otg_unregister(struct device *dev);
	/**
	 * struct usb_otg_config - otg controller configuration
	 * @caps: otg capabilities of the controller
	 * @ops: otg fsm operations
	 * @otg_work: optional custom otg state machine work function
	 */
	struct usb_otg_config {
	        struct usb_otg_caps *otg_caps;
	        struct otg_fsm_ops *fsm_ops;
	        void (*otg_work)(struct work_struct *work);
	};

The dual-role state machine is built-into the OTG core so nothing
special needs to be provided if only dual-role functionality is desired.
The low level OTG controller driver ops are povided via
'struct otg_fsm_ops *fsm_ops' in the 'struct usb_otg_config'.

After registration, the OTG core waits for host, gadget controller
and the gadget function driver to be registered. Once all resources are
available it instantiates the Finite State Machine (FSM).
The host/gadget controllers are started/stopped according to the FSM.

- Host and gadget controllers that are a part of OTG/dual-role port must
use the OTG core provided APIs to add/remove the host/gadget.
i.e. hosts must use usb_otg_add_hcd() usb_otg_remove_hcd(),,
gadgets must use usb_otg_add_gadget_udc() usb_del_gadget_udc().
This ensures that the host and gadget controllers are not started till
the state machine is ready and the right bus conditions are met.
It also allows the host and gadget controllers to provide the OTG
controller device to link them together. For Device tree boots
the related OTG controller is automatically picked up via the
'otg-controller' property in the Host/Gadget controller nodes.

	int usb_otg_add_hcd(struct usb_hcd *hcd,
			    unsigned int irqnum, unsigned long irqflags,
			    struct device *otg_dev);
	void usb_otg_remove_hcd(struct usb_hcd *hcd);

	int usb_otg_add_gadget_udc(struct device *parent,
				   struct usb_gadget *gadget,
				   struct device *otg_dev);
	usb_del_gadget_udc() must be used for removal.


- During the lifetime of the FSM, the OTG controller driver can provide
inputs event changes using usb_otg_sync_inputs(). The OTG core will
then schedule the FSM work function (or internal dual-role state machine)
to update the FSM state. The FSM then calls the OTG controller
operations (fsm_ops) as necessary.
	void usb_otg_sync_inputs(struct usb_otg *otg);

- The following 2 functions are provided as helpers for use by the
OTG controller driver to start/stop the host/gadget controllers.
	int usb_otg_start_host(struct usb_otg *otg, int on);
	int usb_otg_start_gadget(struct usb_otg *otg, int on);

- The following function is provided for use by the USB host stack
to sync OTG related events to the OTG state machine.
e.g. change in host_bus->b_hnp_enable, gadget->b_hnp_enable
	int usb_otg_kick_fsm(struct device *otg_device);

Changelog:
---------
v6:
- added otg specific APIs for host/gadget registration. behaviour of
original host/gadget API remains unchanged. Platform devices can now
pass the otg device explicitly while registering host/gadget.
- moved hcd specific operations from struct otg_fsm to struct hcd_ops.
- made struct usb_otg mandatory for all otg related APIs.
- allow otg controller to provide it's own otg_work function so that
it can implement it's own state machine.
- removed otg fsm and timers from usb-otg.c. Only dual-role state machine
is implemented.
- vbus is controlled in the dual-role state machine.
- PM runtime is used around drd_statemachine().
- added otg_dev to xhci platform data to allow platform code to specify
the otg controller tied to the xhci host controller.

v5: Internal version. Not sent to mailing list

v4:
- Added DT support for tying otg-controller to host and gadget
 controllers. For DT we no longer have the constraint that
 OTG controller needs to be parent of host and gadget. They can be
 tied together using the "otg-controller" property.
- Relax the requirement for DT case that otg controller must register
 before host/gadget. We maintain a wait list of host/gadget devices
 waiting on the otg controller.
- Use a single struct usb_otg for otg data.
- Don't override host/gadget start/stop APIs. Let the controller
 drivers do what they want as they know best. Helper API is provided
 for controller start/stop that controller driver can use.
- Introduce struct usb_otg_config to pass the otg capabilities,
 otg ops and otg timer timeouts during otg controller registration.
- rebased on Greg's usb.git/usb-next

v3:
- all otg related definations now in otg.h
- single kernel config USB_OTG to enable OTG core and FSM.
- resolved symbol dependency issues.
- use dev_vdbg instead of VDBG() in usb-otg-fsm.c
- rebased on v4.2-rc1

v2:
- Use add/remove_hcd() instead of start/stop_hcd() to enable/disable
 the host controller
- added dual-role-device (DRD) state machine which is a much simpler
 mode of operation when compared to OTG. Here we don't support fancy
 OTG features like HNP, SRP, on the fly role-swap. The mode of operation
 is determined based on ID pin (cable type) and the role doesn't change
 till the cable type changes.

--
cheers,
-roger

Roger Quadros (12):
  usb: hcd: Initialize hcd->flags to 0
  usb: hcd.h: Add OTG to HCD interface
  usb: otg-fsm: use usb_otg wherever possible
  usb: otg-fsm: move host controller operations into usb_otg->hcd_ops
  usb: gadget.h: Add OTG to gadget interface
  usb: otg: get rid of CONFIG_USB_OTG_FSM in favour of CONFIG_USB_OTG
  usb: otg: add OTG/dual-role core
  usb: hcd: Adapt to OTG core
  usb: gadget: udc: adapt to OTG core
  usb: doc: dt-binding: Add otg-controller property
  usb: core: hub: Notify OTG fsm when A device sets b_hnp_enable
  usb: host: xhci-plat: Add otg device to platform data

 Documentation/devicetree/bindings/usb/generic.txt  |    3 +
 Documentation/usb/chipidea.txt                     |    2 +-
 drivers/usb/Makefile                               |    1 +
 drivers/usb/chipidea/Makefile                      |    2 +-
 drivers/usb/chipidea/ci.h                          |    3 +-
 drivers/usb/chipidea/core.c                        |   12 +-
 drivers/usb/chipidea/debug.c                       |    2 +-
 drivers/usb/chipidea/otg_fsm.c                     |  178 ++--
 drivers/usb/chipidea/otg_fsm.h                     |    2 +-
 drivers/usb/chipidea/udc.c                         |   17 +-
 drivers/usb/common/Makefile                        |    3 +-
 drivers/usb/common/usb-otg-fsm.c                   |  191 ++--
 drivers/usb/common/usb-otg.c                       | 1058 ++++++++++++++++++++
 .../usb/{chipidea/otg_fsm.h => common/usb-otg.h}   |   61 +-
 drivers/usb/core/Kconfig                           |   10 +-
 drivers/usb/core/hcd.c                             |   72 ++
 drivers/usb/core/hub.c                             |   17 +-
 drivers/usb/gadget/udc/udc-core.c                  |  166 ++-
 drivers/usb/host/xhci-plat.c                       |   35 +-
 drivers/usb/phy/Kconfig                            |    2 +-
 drivers/usb/phy/phy-fsl-usb.c                      |  150 +--
 drivers/usb/phy/phy-fsl-usb.h                      |    3 +-
 include/linux/usb/gadget.h                         |   20 +
 include/linux/usb/hcd.h                            |   29 +
 include/linux/usb/otg-fsm.h                        |  139 +--
 include/linux/usb/otg.h                            |  259 ++++-
 include/linux/usb/xhci_pdriver.h                   |    3 +
 27 files changed, 1973 insertions(+), 467 deletions(-)
 create mode 100644 drivers/usb/common/usb-otg.c
 copy drivers/usb/{chipidea/otg_fsm.h => common/usb-otg.h} (63%)

-- 
2.5.0
