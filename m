From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] USB: ohci-omap: defer probe if PHY is missing
Date: Mon,  2 Jan 2017 22:53:55 +0200
Message-ID: <20170102205355.18920-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Defer probe if PHY is missing. E.g. on Nokia 770 several modules needs
to be loaded to get the PHY going and ohci-omap should wait for those.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/host/ohci-omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 495c145..fe6f6b5 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -230,8 +230,7 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 				return status;
 			}
 		} else {
-			dev_err(hcd->self.controller, "can't find phy\n");
-			return -ENODEV;
+			return -EPROBE_DEFER;
 		}
 		ohci->start_hnp = start_hnp;
 	}
-- 
2.9.2
