From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 00/10] usb: dwc3: add dual-role support
Date: Mon, 11 Apr 2016 14:34:56 +0300
Message-ID: <1460374506-9779-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds dual role support to dwc3 controller driver.
Series depends on the OTG/dual-role framework [1].

[1] - https://lkml.org/lkml/2016/4/5/492

Patches are based on v4.6-rc1.

v6:
- use just otg irq to get otg events and don't depend on extcon at all.
- follow OTG flow in TRM strictly.
- use tracepoints instead of dev_dbg().
- match IRQ flags in dwc3_omap and core.c for shared otg interrupt.

v5: Internal revision. Not sent to mailing list.

v4: first version that was reviewed.

cheers,
-roger

Felipe Balbi (2):
  usb: dwc3: omap: fix up error path on probe()
  usb: dwc3: core: fix PHY handling during suspend

Roger Quadros (8):
  usb: dwc3: core.h: add some register definitions
  usb: dwc3: omap: Make the wrapper interrupt shared
  usb: dwc3: omap: Pass VBUS and ID events transparently
  usb: dwc3: core: cleanup IRQ resources
  usb: dwc3: add dual-role support
  usb: dwc3: gadget: Fix suspend/resume during dual-role mode
  ARM: dts: dra7*-evm: Enable dual-role for usb1
  ARM: dts: am43xx: Enable dual-role on USB1

 arch/arm/boot/dts/am437x-gp-evm.dts  |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts  |   2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts |   2 +-
 arch/arm/boot/dts/dra7-evm.dts       |   2 +-
 arch/arm/boot/dts/dra72-evm.dts      |   2 +-
 drivers/usb/dwc3/core.c              | 565 +++++++++++++++++++++++++++++++++--
 drivers/usb/dwc3/core.h              | 109 ++++++-
 drivers/usb/dwc3/dwc3-omap.c         |  39 ++-
 drivers/usb/dwc3/gadget.c            |  31 +-
 drivers/usb/dwc3/host.c              |  21 ++
 10 files changed, 729 insertions(+), 46 deletions(-)

-- 
2.5.0
