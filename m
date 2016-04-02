From: Felipe Balbi <balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/6] usb: dwc3: keystone: initialize dma_mask and coherent
Date: Sat,  2 Apr 2016 11:28:56 +0300
Message-ID: <1459585739-21204-4-git-send-email-felipe.balbi@linux.intel.com>
References: <1459585739-21204-1-git-send-email-felipe.balbi@linux.intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459585739-21204-1-git-send-email-felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Ivan T . Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

dma_get_mask(dev) just returns
dev->dma_mask. Current code was using dma_get_mask()
return to initialize dev->dma_mask. That's
essentially a no-op. Instead, let's default to a
32-bit DMA mask passed to
dma_coerce_mask_and_coherent().

Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-keystone.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 2be268d2423d..53bbc9dccf7e 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -39,8 +39,6 @@
 #define USBSS_IRQ_COREIRQ_EN	BIT(0)
 #define USBSS_IRQ_COREIRQ_CLR	BIT(0)
 
-static u64 kdwc3_dma_mask;
