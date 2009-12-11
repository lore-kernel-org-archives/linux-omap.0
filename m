From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [RFC/PATCH 3/5] usb: musb: add support for ulpi block
Date: Fri, 11 Dec 2009 13:31:24 +0200
Message-ID: <1260531086-23857-4-git-send-email-felipe.balbi@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6ed0b2680912101251jeec28e6i216dfc51caab13aa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Madhusudhan Chikkature <madhu.cr-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

add register definitions and musb_ulpi_readb/writeb
support.

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_regs.h |   62 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index 473a94e..7e6e68e 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -72,6 +72,11 @@
 #define MUSB_DEVCTL_HR		0x02
 #define MUSB_DEVCTL_SESSION	0x01
 
+/* ULPI_REG_CONTROL */
+#define ULPI_REG_REQ		(1 << 0)
+#define ULPI_REG_CMPLT		(1 << 1)
+#define ULPI_RDN_WR		(1 << 2)
+
 /* TESTMODE */
 #define MUSB_TEST_FORCE_HOST	0x80
 #define MUSB_TEST_FIFO_ACCESS	0x40
@@ -247,6 +252,16 @@
 /* REVISIT: vctrl/vstatus: optional vendor utmi+phy register at 0x68 */
 #define MUSB_HWVERS		0x6C	/* 8 bit */
 
+/* ULPI Registers */
+#define ULPI_VBUS_CONTROL	0x70	/* 8 bit */
+#define ULPI_CARKIT_CONTROL	0x71	/* 8 bit */
+#define ULPI_INT_MASK		0x72	/* 8 bit */
+#define ULPI_INT_SRC		0x73	/* 8 bit */
+#define ULPI_REG_DATA		0x74	/* 8 bit */
+#define ULPI_REG_ADDR		0x75	/* 8 bit */
+#define ULPI_REG_CONTROL	0x76	/* 8 bit */
+#define ULPI_RAW_DATA		0x77	/* 8 bit */
+
 #define MUSB_EPINFO		0x78	/* 8 bit */
 #define MUSB_RAMINFO		0x79	/* 8 bit */
 #define MUSB_LINKINFO		0x7a	/* 8 bit */
@@ -502,4 +517,51 @@ static inline void  musb_write_txhubport(void __iomem *mbase, u8 epnum,
 
 #endif /* CONFIG_BLACKFIN */
 
+/* ULPI read/write support */
+static inline u8 musb_ulpi_readb(void __iomem *addr, u8 offset)
+{
+	int	i = 0;
+	u8	r;
+
+	musb_writeb(addr, ULPI_REG_ADDR, offset);
+	musb_writeb(addr, ULPI_REG_CONTROL, ULPI_REG_REQ | ULPI_RDN_WR);
+
+	while (!(musb_readb(addr, ULPI_REG_CONTROL) & ULPI_REG_CMPLT)) {
+		i++;
+		if (i == 10000) {
+			DBG(3, "ULPI read timed out\n");
+			return 0;
+		}
+
+	}
+	r = musb_readb(addr, ULPI_REG_CONTROL);
+	r &= ~ULPI_REG_CMPLT;
+	musb_writeb(addr, ULPI_REG_CONTROL, r);
+
+	return musb_readb(addr, ULPI_REG_DATA);
+}
+
+static inline void musb_ulpi_writeb(void __iomem *addr,
+	u8 offset, u8 data)
+{
+	int	i = 0;
+	u8	r = 0;
+
+	musb_writeb(addr, ULPI_REG_ADDR, offset);
+	musb_writeb(addr, ULPI_REG_DATA, data);
+	musb_writeb(addr, ULPI_REG_CONTROL, ULPI_REG_REQ);
+
+	while(!(musb_readb(addr, ULPI_REG_CONTROL) & ULPI_REG_CMPLT)) {
+		i++;
+		if (i == 10000) {
+			DBG(3, "ULPI write timed out\n");
+			return;
+		}
+	}
+
+	r = musb_readb(addr, ULPI_REG_CONTROL);
+	r &= ~ULPI_REG_CMPLT;
+	musb_writeb(addr, ULPI_REG_CONTROL, r);
+}
+
 #endif	/* __MUSB_REGS_H__ */
-- 
1.6.6.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
