From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 0/2] usb: dwc3: Change platform device IDs to AUTO
Date: Fri, 25 Jan 2013 16:52:00 +0530
Message-ID: <1359112922-2247-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Multiple dwc3 controllers will try to allocate multiple platform
devices for no_op_xceive (for usb2_phy and usb3_phy) as well as
xhci-hcd.
This patchset updates the platform devices IDs for allocated
devices to AUTO in order to support multiple dwc3 controllers.

This is based on 'dwc3' branch of Felipe Balbi's usb tree.

Vivek Gautam (2):
  usb: dwc3: exynos/omap: Change platform device IDs for no_op_xceive
    to AUTO
  usb: dwc3: host: Change platform device ID for xhci-hcd to AUTO

 drivers/usb/dwc3/dwc3-exynos.c |    4 ++--
 drivers/usb/dwc3/dwc3-omap.c   |    4 ++--
 drivers/usb/dwc3/host.c        |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.6.5
