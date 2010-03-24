From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 11/11] usb: musb: add ulpi access operations
Date: Wed, 24 Mar 2010 14:55:18 +0200
Message-ID: <1269435318-29153-12-git-send-email-felipe.balbi@nokia.com>
References: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51951 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090Ab0CXM4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:56:13 -0400
In-Reply-To: <1269435318-29153-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Heikki Krogerus <ext-heikki.krogerus@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Heikki Krogerus <ext-heikki.krogerus@nokia.com>

This adds helper functions for ULPI access, and implements
otg_io_access_ops for musb.

Signed-off-by: Heikki Krogerus <ext-heikki.krogerus@nokia.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |   86 ++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_regs.h |   10 +++++
 2 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9b88727..ae7728c 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -149,6 +149,87 @@ static inline struct musb *dev_to_musb(struct device *dev)
 
 /*-------------------------------------------------------------------------*/
 
+#ifndef CONFIG_BLACKFIN
+static int musb_ulpi_read(struct otg_transceiver *otg, u32 offset)
+{
+	void __iomem *addr = otg->io_priv;
+	int	i = 0;
+	u8	r;
+	u8	power;
+
+	/* Make sure the transceiver is not in low power mode */
+	power = musb_readb(addr, MUSB_POWER);
+	power &= ~MUSB_POWER_SUSPENDM;
+	musb_writeb(addr, MUSB_POWER, power);
+
+	/* REVISIT: musbhdrc_ulpi_an.pdf recommends setting the
+	 * ULPICarKitControlDisableUTMI after clearing POWER_SUSPENDM.
+	 */
+
+	musb_writeb(addr, MUSB_ULPI_REG_ADDR, (u8)offset);
+	musb_writeb(addr, MUSB_ULPI_REG_CONTROL,
+			MUSB_ULPI_REG_REQ | MUSB_ULPI_RDN_WR);
+
+	while (!(musb_readb(addr, MUSB_ULPI_REG_CONTROL)
+				& MUSB_ULPI_REG_CMPLT)) {
+		i++;
+		if (i == 10000) {
+			DBG(3, "ULPI read timed out\n");
+			return -ETIMEDOUT;
+		}
+
+	}
+	r = musb_readb(addr, MUSB_ULPI_REG_CONTROL);
+	r &= ~MUSB_ULPI_REG_CMPLT;
+	musb_writeb(addr, MUSB_ULPI_REG_CONTROL, r);
+
+	return musb_readb(addr, MUSB_ULPI_REG_DATA);
+}
+
+static int musb_ulpi_write(struct otg_transceiver *otg,
+		u32 offset, u32 data)
+{
+	void __iomem *addr = otg->io_priv;
+	int	i = 0;
+	u8	r = 0;
+	u8	power;
+
+	/* Make sure the transceiver is not in low power mode */
+	power = musb_readb(addr, MUSB_POWER);
+	power &= ~MUSB_POWER_SUSPENDM;
+	musb_writeb(addr, MUSB_POWER, power);
+
+	musb_writeb(addr, MUSB_ULPI_REG_ADDR, (u8)offset);
+	musb_writeb(addr, MUSB_ULPI_REG_DATA, (u8)data);
+	musb_writeb(addr, MUSB_ULPI_REG_CONTROL, MUSB_ULPI_REG_REQ);
+
+	while (!(musb_readb(addr, MUSB_ULPI_REG_CONTROL)
+				& MUSB_ULPI_REG_CMPLT)) {
+		i++;
+		if (i == 10000) {
+			DBG(3, "ULPI write timed out\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	r = musb_readb(addr, MUSB_ULPI_REG_CONTROL);
+	r &= ~MUSB_ULPI_REG_CMPLT;
+	musb_writeb(addr, MUSB_ULPI_REG_CONTROL, r);
+
+	return 0;
+}
+#else
+#define musb_ulpi_read(a, b)		NULL
+#define musb_ulpi_write(a, b, c)	NULL
+#endif
+
+static struct otg_io_access_ops musb_ulpi_access = {
+	.read = musb_ulpi_read,
+	.write = musb_ulpi_write,
+};
+
+/*-------------------------------------------------------------------------*/
+
 #if !defined(CONFIG_USB_TUSB6010) && !defined(CONFIG_BLACKFIN)
 
 /*
@@ -1954,6 +2035,11 @@ bad_config:
 		goto fail3;
 	}
 
+	if (!musb->xceiv->io_ops) {
+		musb->xceiv->io_priv = musb->mregs;
+		musb->xceiv->io_ops = &musb_ulpi_access;
+	}
+
 #ifndef CONFIG_MUSB_PIO_ONLY
 	if (use_dma && dev->dma_mask) {
 		struct dma_controller	*c;
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index fa55aac..2442675 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -75,6 +75,10 @@
 /* MUSB ULPI VBUSCONTROL */
 #define MUSB_ULPI_USE_EXTVBUS	0x01
 #define MUSB_ULPI_USE_EXTVBUSIND 0x02
+/* ULPI_REG_CONTROL */
+#define MUSB_ULPI_REG_REQ	(1 << 0)
+#define MUSB_ULPI_REG_CMPLT	(1 << 1)
+#define MUSB_ULPI_RDN_WR	(1 << 2)
 
 /* TESTMODE */
 #define MUSB_TEST_FORCE_HOST	0x80
@@ -251,6 +255,12 @@
 /* REVISIT: vctrl/vstatus: optional vendor utmi+phy register at 0x68 */
 #define MUSB_HWVERS		0x6C	/* 8 bit */
 #define MUSB_ULPI_BUSCONTROL	0x70	/* 8 bit */
+#define MUSB_ULPI_INT_MASK	0x72	/* 8 bit */
+#define MUSB_ULPI_INT_SRC	0x73	/* 8 bit */
+#define MUSB_ULPI_REG_DATA	0x74	/* 8 bit */
+#define MUSB_ULPI_REG_ADDR	0x75	/* 8 bit */
+#define MUSB_ULPI_REG_CONTROL	0x76	/* 8 bit */
+#define MUSB_ULPI_RAW_DATA	0x77	/* 8 bit */
 
 #define MUSB_EPINFO		0x78	/* 8 bit */
 #define MUSB_RAMINFO		0x79	/* 8 bit */
-- 
1.7.0.rc0.33.g7c3932

