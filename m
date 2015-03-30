From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] usb/dwc3: comment update
Date: Mon, 30 Mar 2015 09:40:13 +0200
Message-ID: <1427701202-11165-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The top of include/linux/pci_ids.h says:
	Do not add new entries to this file unless the definitions
	are shared between multiple drivers.
Drop comment in usb/dwc3 which conflicts with this.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 8d95056..759855b 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -24,7 +24,6 @@
 
 #include "platform_data.h"
 
-/* FIXME define these in <linux/pci_ids.h> */
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3	0xabcd
 #define PCI_DEVICE_ID_INTEL_BYT		0x0f37
-- 
MST
