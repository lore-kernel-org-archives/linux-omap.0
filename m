From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/3] musb: Add 'extvbus' in musb_hdrc_platform_data
Date: Mon, 14 Dec 2009 19:09:42 +0530
Message-ID: <1260797982-28880-3-git-send-email-ajay.gupta@ti.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42249 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbZLNNjx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Dec 2009 08:39:53 -0500
In-Reply-To: <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net, Ajay Kumar Gupta <ajay.gupta@ti.com>

Some of the board might use external Vbus power supply on musb
interface which would require to program ULPI_BUSCONTROL register.

Adding 'extvbus' flag which can be set from such boards which will
be checked at musb driver files before programming ULPI_BUSCONTROL.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_core.c |    8 ++++++++
 drivers/usb/musb/musb_regs.h |    5 +++++
 include/linux/usb/musb.h     |    3 +++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index cd4462b..826d01d 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2027,6 +2027,7 @@ bad_config:
 	/* host side needs more setup */
 	if (is_host_enabled(musb)) {
 		struct usb_hcd	*hcd = musb_to_hcd(musb);
+		u8 busctl;
 
 		otg_set_host(musb->xceiv, &hcd->self);
 
@@ -2034,6 +2035,13 @@ bad_config:
 			hcd->self.otg_port = 1;
 		musb->xceiv->host = &hcd->self;
 		hcd->power_budget = 2 * (plat->power ? : 250);
+
+		/* program PHY to use external vBus if required */
+		if (plat->extvbus) {
+			busctl = musb_readb(musb->mregs, MUSB_ULPI_BUSCONTROL);
+			busctl |= ULPI_USE_EXTVBUS;
+			musb_writeb(musb->mregs, MUSB_ULPI_BUSCONTROL, busctl);
+		}
 	}
 
 	/* For the host-only role, we can activate right away.
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index 8ca8f23..cba724d 100644
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
1.6.2.4

