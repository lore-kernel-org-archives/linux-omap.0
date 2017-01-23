From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/8] usb: dwc3: add dual-role support
Date: Mon, 23 Jan 2017 13:19:33 +0200
Message-ID: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

We rely on the OTG controller block to provide us with
VBUS and ID line status via an interrupt.

This is then used to switch the controller between host, peripheral
and idle roles based on the following table.

    ID  VBUS    dual-role state
    --  ----    ---------------
    0   x       A_HOST - Host controller active
    1   0       B_IDLE - Both Host and Gadget controllers inactive
    1   1       B_PERIPHERAL - Gadget controller active

Couple of things to clarify:
- There is a small window where we can potentially miss an
event related to OTG. I've added a comment in the code where this
could happen. How can we prevent this? Is it better to just leave
the OTG events unmasked (but keep otg_irq on ARM GIC disabled)
so that any new events can be captured by the OTG event register
and interrupt re-triggered if it has not been serviced by the
previous interrupt.
- I'm running the entire dual-role state change logic inside
the threaded interrupt handler with dwc->lock (spinlock) held
but IRQs enabled. OTG events are very rare i.e. manual intervention
so I don't see this as a problem. Just wanted to double check.
- Some SoC's (e.g. Qualcomm MSM) do not have the OTG controller block
but do have both host and peripheral controllers and so can operate
in dual role mode. Current series does not address this case.
We can get dual-role to work with such SoCs if core.c can get
information about ID and VBUS somehow (private interface
from parent or directly read extcon?).

cheers,
-roger

Roger Quadros (8):
  usb: otg-fsm: Prevent build warning "VDBG" redefined
  usb: dwc3-omap: Fix missing break in dwc3_omap_set_mailbox()
  usb: dwc3: use BIT() macro where possible
  usb: dwc3: core.h: add some register definitions
  usb: dwc3: add dual-role support
  ARM: dts: dra7x-evm: Enable dual-role mode for USB1
  ARM: dts: am43xx: Enable dual-role mode for USB1
  ARM: dts: am57xx-idk: Enable dual-role mode for USB2

 arch/arm/boot/dts/am437x-gp-evm.dts      |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts      |   2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts     |   2 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi |   2 +-
 arch/arm/boot/dts/dra7-evm.dts           |   2 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi  |   2 +-
 drivers/usb/common/usb-otg-fsm.c         |   7 +
 drivers/usb/dwc3/core.c                  | 583 ++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h                  | 312 ++++++++++++-----
 drivers/usb/dwc3/dwc3-omap.c             |  49 +--
 drivers/usb/dwc3/gadget.c                |  18 +-
 drivers/usb/dwc3/gadget.h                |  20 +-
 drivers/usb/phy/phy-fsl-usb.c            |   7 +
 include/linux/usb/otg-fsm.h              |  15 -
 14 files changed, 848 insertions(+), 175 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
