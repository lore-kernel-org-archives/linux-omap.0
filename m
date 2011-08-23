From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] usb: fix dwc3 build when USB_GADGET_DWC3 is not
 enabled
Date: Tue, 23 Aug 2011 11:07:02 -0700
Message-ID: <20110823110702.f5ea377c.rdunlap@xenotime.net>
References: <20110823160432.d24f8cad00951286bc18461e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110823160432.d24f8cad00951286bc18461e@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, akpm <akpm@linux-foundation.org>, gregkh@suse.de
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix build error when CONFIG_USB_GADGET_DWC3 is not enabled:

ERROR: "dwc3_send_gadget_ep_cmd" [drivers/usb/dwc3/dwc3.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/usb/dwc3/debugfs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20110823.orig/drivers/usb/dwc3/debugfs.c
+++ linux-next-20110823/drivers/usb/dwc3/debugfs.c
@@ -437,7 +437,9 @@ static int dwc3_testmode_open(struct ino
 	struct dwc3_gadget_ep_cmd_params par0;
 	struct dwc3_gadget_ep_cmd_params par1;
 	struct dwc3_trb         trb;
+#ifdef CONFIG_USB_GADGET_DWC3
 	int ret;
+#endif
 	u8 *buf0;
 	u8 *buf1;
 
@@ -478,8 +480,10 @@ static int dwc3_testmode_open(struct ino
 
 	dwc3_send_testmode_cmd(dwc, 1);
 
+#ifdef CONFIG_USB_GADGET_DWC3
 	ret = dwc3_send_gadget_ep_cmd(dwc, 0, DWC3_DEPCMD_STARTTRANSFER, &par0);
 	ret = dwc3_send_gadget_ep_cmd(dwc, 1, DWC3_DEPCMD_STARTTRANSFER, &par1);
+#endif
 
 	dwc3_send_testmode_cmd(dwc, 0);
 	return -EBUSY;
