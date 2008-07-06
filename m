From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 2/4] ohci: make distrust_firmware a quirk
Date: Sun, 6 Jul 2008 14:26:10 +0400
Message-ID: <20080706102610.GA29923__14371.3615987965$1215345102$gmane$org@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:63709 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbYGFLui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jul 2008 07:50:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so678890fgg.17
        for <linux-omap@vger.kernel.org>; Sun, 06 Jul 2008 04:50:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/usb/host/ohci-hcd.c  |    6 +++++-
 drivers/usb/host/ohci-omap.c |    2 +-
 drivers/usb/host/ohci.h      |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index a8160d6..df6f0e9 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -483,6 +483,9 @@ static int ohci_init (struct ohci_hcd *ohci)
 	int ret;
 	struct usb_hcd *hcd = ohci_to_hcd(ohci);
 
+	if (distrust_firmware)
+		ohci->flags |= OHCI_QUIRK_HUB_POWER;
+
 	disable (ohci);
 	ohci->regs = hcd->regs;
 
@@ -689,7 +692,8 @@ retry:
 		temp |= RH_A_NOCP;
 		temp &= ~(RH_A_POTPGT | RH_A_NPS);
 		ohci_writel (ohci, temp, &ohci->regs->roothub.a);
-	} else if ((ohci->flags & OHCI_QUIRK_AMD756) || distrust_firmware) {
+	} else if ((ohci->flags & OHCI_QUIRK_AMD756) ||
+			ohci->flags & OHCI_QUIRK_HUB_POWER) {
 		/* hub power always on; required for AMD-756 and some
 		 * Mac platforms.  ganged overcurrent reporting, if any.
 		 */
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 6859fb5..4f21646 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -257,7 +257,7 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 			omap_cfg_reg(W4_USB_HIGHZ);
 		}
 		ohci_writel(ohci, rh, &ohci->regs->roothub.a);
-		distrust_firmware = 0;
+		ohci->flags &= ~OHCI_QUIRK_HUB_POWER;
 	} else if (machine_is_nokia770()) {
 		/* We require a self-powered hub, which should have
 		 * plenty of power. */
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index dc544dd..4e3d9b2 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -399,6 +399,7 @@ struct ohci_hcd {
 #define	OHCI_QUIRK_ZFMICRO	0x20			/* Compaq ZFMicro chipset*/
 #define	OHCI_QUIRK_NEC		0x40			/* lost interrupts */
 #define	OHCI_QUIRK_FRAME_NO	0x80			/* no big endian frame_no shift */
+#define OHCI_QUIRK_HUB_POWER	0x100			/* distrust firmware power/oc setup */
 	// there are also chip quirks/bugs in init logic
 
 	struct work_struct	nec_work;	/* Worker for NEC quirk */
-- 
1.5.6


-- 
With best wishes
Dmitry

