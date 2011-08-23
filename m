From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next v2] usb: fix dwc3 build when USB_GADGET_DWC3 is not
 enabled
Date: Tue, 23 Aug 2011 12:52:47 -0700
Message-ID: <20110823125247.fbbf9636.rdunlap@xenotime.net>
References: <20110823160432.d24f8cad00951286bc18461e@canb.auug.org.au>
	<20110823110702.f5ea377c.rdunlap@xenotime.net>
	<20110823185235.GA11299@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110823185235.GA11299@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm <akpm@linux-foundation.org>, gregkh@suse.de, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix build error when CONFIG_USB_GADGET_DWC3 is not enabled:

ERROR: "dwc3_send_gadget_ep_cmd" [drivers/usb/dwc3/dwc3.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/usb/dwc3/gadget.h |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-next-20110823.orig/drivers/usb/dwc3/gadget.h
+++ linux-next-20110823/drivers/usb/dwc3/gadget.h
@@ -202,6 +202,11 @@ void dwc3_gadget_exit(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc) { return 0; }
 static inline void dwc3_gadget_exit(struct dwc3 *dwc) { }
+static inline int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
+		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
+{
+	return 0;
+}
 #endif
 
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
