From: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] OMAP: Finish ehci omap phy reset cycle before adding hcd.
Date: Fri,  4 May 2012 04:24:47 -0700
Message-ID: <1336130687-5933-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Raja Govindraj <govindraj.raja-l0cyMroinI0@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' (1fcb57d0f) created a regression
with Beagleboard xM if booting the kernel after running 'usb start' under u-boot.

Finishing the reset before calling 'usb_add_hcd' fixes the regression. This is most likely due to
usb_add_hcd calling the driver's reset and init functions which expect the hardware to be
up and running.

Signed-off-by: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 5c78f9e..e669c6a 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -242,15 +242,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	ehci_reset(omap_ehci);
 
-	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
-	if (ret) {
-		dev_err(dev, "failed to add hcd with err %d\n", ret);
-		goto err_add_hcd;
-	}
-
-	/* root ports should always stay powered */
-	ehci_port_power(omap_ehci, 1);
