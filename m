From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 0/9] usb: dwc3: add dual-role support
Date: Wed, 2 Sep 2015 17:24:15 +0300
Message-ID: <1441203864-15786-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds dual role support to dwc3 controller driver.
Series depends on [1] for core OTG/dual-role support.

Patches are based on greg/usb-next.

Tested on am437x-gp-evm and dra7-evm after platform related patches are
applied. Those are available at [2].

[1] core OTG/DRD support - http://thread.gmane.org/gmane.linux.kernel/2025239
[2] platform support - http://thread.gmane.org/gmane.linux.usb.general/127898

cheers,
-roger

Felipe Balbi (1):
  usb: dwc3: core: Adapt to named interrupts

Roger Quadros (8):
  usb: dwc3: add dual-role support
  usb: dwc3: core.h: add some register definitions
  usb: dwc3: dwc3-omap: Make the wrapper interrupt shared
  usb: dwc3: core: make dual-role work with OTG irq
  usb: dwc3: save/restore OTG registers during suspend/resume
  usb: dwc3: gadget: Fix suspend/resume during dual-role mode
  usb: dwc3: core: Prevent otg events from disabling themselves
  usb: dwc3: core: don't break during suspend/resume while we're
    dual-role

 drivers/usb/dwc3/core.c          | 422 +++++++++++++++++++++++++++++++++++++--
 drivers/usb/dwc3/core.h          | 103 ++++++++++
 drivers/usb/dwc3/dwc3-omap.c     |   4 +-
 drivers/usb/dwc3/gadget.c        |   8 +-
 drivers/usb/dwc3/platform_data.h |   1 +
 5 files changed, 516 insertions(+), 22 deletions(-)

-- 
2.1.4
