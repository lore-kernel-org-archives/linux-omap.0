From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 5/7] musb: Add 'extvbus' in musb_hdrc_board_data
Date: Sun, 15 Nov 2009 14:29:36 +0530
Message-ID: <1258275578-1773-6-git-send-email-ajay.gupta@ti.com>
References: <1258275578-1773-1-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-2-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-3-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-4-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-5-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34336 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbZKOI7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Nov 2009 03:59:44 -0500
In-Reply-To: <1258275578-1773-5-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: felipe.balbi@nokia.com, khilman@deeprootsystems.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Some of the board might use external Vbus power supply on musb
interface which would require to program ULPI_BUSCONTROL register.

Adding 'extvbus' flag which can be set from such boards which will
be checked at musb driver files before programming ULPI_BUSCONTROL.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |   12 +++++++++++-
 drivers/usb/musb/musb_regs.h |    5 +++++
 include/linux/usb/musb.h     |    3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 818ccda..c0a6760 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2027,15 +2027,25 @@ bad_config:
 	/* host side needs more setup */
 	if (is_host_enabled(musb)) {
 		struct usb_hcd	*hcd = musb_to_hcd(musb);
+		u8 busctl;
 
 		otg_set_host(musb->xceiv, &hcd->self);
 
 		if (is_otg_enabled(musb))
 			hcd->self.otg_port = 1;
 		musb->xceiv->host = &hcd->self;
-		if (plat->board_data)
+		if (plat->board_data) {
 			hcd->power_budget =
 				2 * (plat->board_data->power ? : 250);
+			/* program PHY to use external vBus if required */
+			if (plat->board_data->extvbus) {
+				busctl = musb_readb(musb->mregs,
+						MUSB_ULPI_BUSCONTROL);
+				busctl |= ULPI_USE_EXTVBUS;
+				musb_writeb(musb->mregs,
+						MUSB_ULPI_BUSCONTROL, busctl);
+			}
+		}
 	}
 
 	/* For the host-only role, we can activate right away.
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index cc1d71b..a0314df 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -72,6 +72,10 @@
 #define MUSB_DEVCTL_HR		0x02
 #define MUSB_DEVCTL_SESSION	0x01
 
+/* ULPI VBUSCONTROL */
+#define ULPI_USE_EXTVBUS	0x01
+#define ULPI_USE_EXTVBUSIND	0x02
+
 /* TESTMODE */
 #define MUSB_TEST_FORCE_HOST	0x80
 #define MUSB_TEST_FIFO_ACCESS	0x40
@@ -246,6 +250,7 @@
 
 /* REVISIT: vctrl/vstatus: optional vendor utmi+phy register at 0x68 */
 #define MUSB_HWVERS		0x6C	/* 8 bit */
+#define MUSB_ULPI_BUSCONTROL	0x70	/* 8 bit */
 
 #define MUSB_EPINFO		0x78	/* 8 bit */
 #define MUSB_RAMINFO		0x79	/* 8 bit */
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 6e1426c..604c404 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -33,7 +33,8 @@ struct musb_hdrc_board_data {
 	u8	power;
 	/* (HOST or OTG) msec/2 after VBUS on till power good */
 	u8		potpgt;
-
+	/* flag to program PHY to use external Vbus */
+	u8		extvbus;
 };
 
 struct musb_hdrc_config {
-- 
1.6.2.4

