From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/3] usb: dwc3: Add support for AM654 USB
Date: Wed, 5 Dec 2018 17:14:36 +0200
Message-ID: <1544022879-5704-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, robh+dt@kernel.org, nsekhar@ti.com, t-kristo@ti.com, vigneshr@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

TI's AM654 USB SoC has 2 instances of the DWC3 controller.
This series adds AM654 USB wrapper support to the keystone-usb driver.

cheers,
-roger

Roger Quadros (3):
  usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
  dt-bindings: usb: keystone-usb: Add ti,am654-dwc3 support
  usb: dwc3: keystone: Add support for ti,am654-dwc3

 Documentation/devicetree/bindings/usb/keystone-usb.txt |  4 ++--
 drivers/usb/dwc3/Kconfig                               |  6 +++---
 drivers/usb/dwc3/dwc3-keystone.c                       | 11 ++++++++++-
 drivers/usb/dwc3/gadget.c                              |  2 ++
 4 files changed, 17 insertions(+), 6 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
