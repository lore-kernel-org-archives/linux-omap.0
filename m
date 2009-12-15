From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] musb: Add 'extvbus' in musb_hdrc_platform_data
Date: Tue, 15 Dec 2009 19:01:49 +0530
Message-ID: <1260883909-26836-4-git-send-email-ajay.gupta@ti.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-2-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-3-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260883909-26836-3-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Some of the board might use external Vbus power supply on musb
interface which would require to program ULPI_BUSCONTROL register.

Adding 'extvbus' flag which can be set from such boards which will
be checked at musb driver files before programming ULPI_BUSCONTROL.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Appended MUSB_ before bot definitions.

 drivers/usb/musb/musb_core.c |    8 ++++++++
 drivers/usb/musb/musb_regs.h |    5 +++++
 include/linux/usb/musb.h     |    3 +++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 39ce125..479468e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2016,6 +2016,7 @@ bad_config:
 	/* host side needs more setup */
 	if (is_host_enabled(musb)) {
 		struct usb_hcd	*hcd = musb_to_hcd(musb);
+		u8 busctl;
 
 		otg_set_host(musb->xceiv, &hcd->self);
 
@@ -2023,6 +2024,13 @@ bad_config:
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
index 8ca8f23..895fb05 100644
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
index c5f006e..d77d532 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -75,6 +75,9 @@ struct musb_hdrc_platform_data {
 	/* (HOST or OTG) msec/2 after VBUS on till power good */
 	u8		potpgt;
 
+	/* (HOST or OTG) program PHY for external Vbus */
+	unsigned	extvbus:1;
+
 	/* Power the device on or off */
 	int		(*set_power)(int state);
 
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
