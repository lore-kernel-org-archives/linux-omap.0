From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 13/16] usb: musb: Add 'extvbus' in musb_hdrc_platform_data
Date: Tue, 19 Jan 2010 15:14:12 +0200
Message-ID: <1263906855-28341-14-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54511 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab0ASNPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:15:00 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Some of the board might use external Vbus power supply on musb
interface which would require to program ULPI_BUSCONTROL register.

Adding 'extvbus' flag which can be set from such boards which will
be checked at musb driver files before programming ULPI_BUSCONTROL.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musb_core.c |    8 ++++++++
 drivers/usb/musb/musb_regs.h |    5 +++++
 include/linux/usb/musb.h     |    3 +++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 4c8962f..074d380 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2031,6 +2031,7 @@ bad_config:
 	/* host side needs more setup */
 	if (is_host_enabled(musb)) {
 		struct usb_hcd	*hcd = musb_to_hcd(musb);
+		u8 busctl;
 
 		otg_set_host(musb->xceiv, &hcd->self);
 
@@ -2038,6 +2039,13 @@ bad_config:
 			hcd->self.otg_port = 1;
 		musb->xceiv->host = &hcd->self;
 		hcd->power_budget = 2 * (plat->power ? : 250);
+
+		/* program PHY to use external vBus if required */
+		if (plat->extvbus) {
+			busctl = musb_readb(musb->mregs, MUSB_ULPI_BUSCONTROL);
+			busctl |= MUSB_ULPI_USE_EXTVBUS;
+			musb_writeb(musb->mregs, MUSB_ULPI_BUSCONTROL, busctl);
+		}
 	}
 
 	/* For the host-only role, we can activate right away.
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index 473a94e..9a8621a 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -72,6 +72,10 @@
 #define MUSB_DEVCTL_HR		0x02
 #define MUSB_DEVCTL_SESSION	0x01
 
+/* MUSB ULPI VBUSCONTROL */
+#define MUSB_ULPI_USE_EXTVBUS	0x01
+#define MUSB_ULPI_USE_EXTVBUSIND 0x02
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
index d437556..4b7f8fa 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -76,6 +76,9 @@ struct musb_hdrc_platform_data {
 	/* (HOST or OTG) msec/2 after VBUS on till power good */
 	u8		potpgt;
 
+	/* (HOST or OTG) program PHY for external Vbus */
+	unsigned	extvbus:1;
+
 	/* Power the device on or off */
 	int		(*set_power)(int state);
 
-- 
1.6.6.rc0

