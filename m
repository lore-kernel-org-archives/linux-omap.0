From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 0/5] dwc3: omap: fixes and dual-role preparation
Date: Tue, 10 May 2016 12:51:54 +0300
Message-ID: <1462873919-20532-1-git-send-email-rogerq@ti.com>
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

I tested this on OMAP5, DRA7 and didn't observe any regressions.

Based on balbi/next commit 2a58f9c12bb360f38fb39e470bb5ff94014356e6.

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

 drivers/usb/dwc3/core.c      | 26 ++++++++++++++++----------
 drivers/usb/dwc3/core.h      |  5 +++++
 drivers/usb/dwc3/dwc3-omap.c | 33 +++++++++++++++++----------------
 drivers/usb/dwc3/gadget.c    | 19 ++++++++++++++++++-
 drivers/usb/dwc3/host.c      | 19 +++++++++++++++++++
 5 files changed, 75 insertions(+), 27 deletions(-)

-- 
2.7.4
