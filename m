From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v8 0/5] dwc3: omap: fixes and dual-role preparation
Date: Wed, 11 May 2016 17:36:41 +0300
Message-ID: <1462977406-22806-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

I've removed the patches that add dual role support. These are just
some fixes can go in before any actual dual role support.

About the OTG software mailbox, I tried checking internally in TI but
nobody was aware of any constraints. The events can be set as they are
obtained from the PMIC OTG comparators. My gut feeling is that we didn't have
VBUS and ID events working properly back then and so resulting
in a hackish software OTG mailbox implementation.

I tested this on omap5-uevm, dra7-evm and am572x-evm and didn't
observe any regressions.

Based on balbi/next commit 2a58f9c12bb360f38fb39e470bb5ff94014356e6.

v8:
- implement proper top and bottom half irq handler for dwc3-omap.
- remove otg_irq code, this can come later with dual-role support.
- use dwc3->gadget_irq while free_irq() in dwc3_gadget_stop().

v7:
- remove patches adding dual-role support.
- split out shared irq conversion from threaded irq conversion patch.
- added a new patch about not touching POWERPRESENT bit.

v6:
- use just otg irq to get otg events and don't depend on extcon at all.
- follow OTG flow in TRM strictly.
- use tracepoints instead of dev_dbg().
- match IRQ flags in dwc3_omap and core.c for shared otg interrupt.

v5: Internal revision. Not sent to mailing list.

v4: first version that was reviewed.

cheers,
-roger

Roger Quadros (5):
  usb: dwc3: omap: use request_threaded_irq()
  usb: dwc3: omap: Mark the interrupt handler as shared
  usb: dwc3: omap: Don't set POWERPRESENT
  usb: dwc3: omap: Pass VBUS and ID events transparently
  usb: dwc3: core: cleanup IRQ resources

 drivers/usb/dwc3/core.c      | 10 ---------
 drivers/usb/dwc3/core.h      |  3 +++
 drivers/usb/dwc3/dwc3-omap.c | 53 ++++++++++++++++++++++++++++----------------
 drivers/usb/dwc3/gadget.c    | 23 +++++++++++++++----
 drivers/usb/dwc3/host.c      | 19 ++++++++++++++++
 5 files changed, 75 insertions(+), 33 deletions(-)

-- 
2.7.4
