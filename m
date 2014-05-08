From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 0/5] Cleanup and fixes for dwc3-omap
Date: Thu, 8 May 2014 15:03:02 +0530
Message-ID: <1399541587-14067-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: balbi@ti.com, gregkh@linuxfoundation.org, rogerq@ti.com, kishon@ti.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

The series does some refactoring on dwc3_probe()

Patch 1-3 - reduce the size of dwc3_probe()
Patch 4 - Fix the crash on dwc3_omap removal
Patch 5 - Addresses the issue of  xhci hang while resuming from system sleep.


George Cherian (5):
  usb: dwc3: dwc3-omap: Add dwc3_omap_map_offset function
  usb: dwc3: dwc3-omap: Add dwc3_omap_set_utmi_mode() function
  usb: dwc3: dwc3-omap: Add dwc3_omap_extcon_register function
  usb: dwc3: dwc3-omap: Fix the crash on module removal
  usb: dwc3: dwc3-omap: Disable/Enable core interrupts in Suspend/Resume

 drivers/usb/dwc3/dwc3-omap.c | 211 +++++++++++++++++++++++--------------------
 1 file changed, 111 insertions(+), 100 deletions(-)

-- 
1.8.3.1
