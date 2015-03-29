From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 65/86] usb/dwc3: comment update
Date: Sun, 29 Mar 2015 15:42:21 +0200
Message-ID: <1427635734-24786-66-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
update comment to list the correct header.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 8d95056..4285d8f 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -24,7 +24,7 @@
 
 #include "platform_data.h"
 
-/* FIXME define these in <linux/pci_ids.h> */
+/* FIXME define these in <uapi/linux/pci_ids.h> */
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3	0xabcd
 #define PCI_DEVICE_ID_INTEL_BYT		0x0f37
-- 
MST
