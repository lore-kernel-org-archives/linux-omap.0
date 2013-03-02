From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v2 00/10] usb: dwc3/xhci/phy: Enable runtime power management
Date: Sat, 02 Mar 2013 18:53:01 +0530
Message-ID: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

This patch-series enables runtime power management on xhci-plat,
dwc3-core, dwc3-exynos as well as on samsung-usb3 type PHY.
This allows usb 3.0 host ports to be power managed at runtime.
We also turn off the PHY ref_clk PLL, which supplies reference clock
to USB3 type phy, when ports are not in use.

Based on 'usb-next' alongwith following patch series:
  [PATCH v4 00/11] usb: dwc3: PM support patchset
  http://www.mail-archive.com/linux-usb@vger.kernel.org/msg14676.html

  [PATCH v2] usb: xhci: add the suspend/resume functionality
  http://www.mail-archive.com/linux-usb@vger.kernel.org/msg14614.html

  [PATCH v6 0/2] Adding USB 3.0 DRD-phy support for exynos5250
  http://www.mail-archive.com/linux-usb@vger.kernel.org/msg15813.html

Changes from v1:
 - Adding required PHY APIs to handle runtime power management
   instead of directly twiddling with phy->dev.
 - Handling runtime power management of usb PHYs in dwc3 core
   driver instead of in any glue layer.
 - Splitting the patch "[PATCH 4/4] usb: phy: samsung: Enable runtime power management on samsung-usb"
   to required number to bifurcate functionality.

Vivek Gautam (10):
  usb: phy: Add APIs for runtime power management
  USB: dwc3: Adjust runtime pm to allow autosuspend
  usb: dwc3: Enable runtime pm only after PHYs are initialized
  usb: dwc3: Add runtime power management callbacks
  usb: dwc3: exynos: Enable runtime power management
  usb: xhci: Enable runtime pm in xhci-plat
  usb: phy: samsung: Enable runtime power management on usb3phy
  usb: phy: samsung: Add support for external reference clock
  usb: phy: samsung: Add support for PHY ref_clk gpio
  usb: phy: samsung: Add support for PHY refclk switching

 drivers/usb/dwc3/core.c           |   40 +++++++++++--
 drivers/usb/dwc3/dwc3-exynos.c    |   13 ++++
 drivers/usb/host/xhci-plat.c      |    7 ++
 drivers/usb/phy/samsung-usb3phy.c |  122 +++++++++++++++++++++++++++++++++++--
 drivers/usb/phy/samsung-usbphy.c  |   26 ++++++++
 drivers/usb/phy/samsung-usbphy.h  |    1 +
 include/linux/usb/phy.h           |   26 ++++++++
 7 files changed, 224 insertions(+), 11 deletions(-)

-- 
1.7.6.5
