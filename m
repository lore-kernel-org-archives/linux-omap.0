From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/8] usb: musb: Change to use new IO access
Date: Mon, 24 Nov 2014 11:05:02 -0800
Message-ID: <1416855906-13931-5-git-send-email-tony@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416855906-13931-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Change to use new IO access. This allows us to build in multiple
MUSB glue layers.

Cc: Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/am35x.c     |   3 +-
 drivers/usb/musb/blackfin.c  |   8 +--
 drivers/usb/musb/musb_core.c | 140 ++++++++++++++++++++++++++++++++++++++-----
 drivers/usb/musb/musb_io.h   |  88 +++------------------------
 drivers/usb/musb/musb_regs.h |  12 ----
 drivers/usb/musb/tusb6010.c  |   8 +--
 drivers/usb/musb/ux500_dma.c |   4 +-
 7 files changed, 143 insertions(+), 120 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index a2735df..13d1d77 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -408,7 +408,7 @@ static int am35x_musb_exit(struct musb *musb)
 }
 
 /* AM35x supports only 32bit read operation */
-void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
+static void am35x_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 {
 	void __iomem *fifo = hw_ep->fifo;
 	u32		val;
@@ -441,6 +441,7 @@ static const struct musb_platform_ops am35x_ops = {
 	.init		= am35x_musb_init,
 	.exit		= am35x_musb_exit,
 
+	.read_fifo	= am35x_read_fifo,
 	.enable		= am35x_musb_enable,
 	.disable	= am35x_musb_disable,
 
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 8b5ad57..c55fcfd 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -71,7 +71,7 @@ static void binf_writel(void __iomem *addr, unsigned offset, u32 data)
 /*
  * Load an endpoint's FIFO
  */
-void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
+static void bfin_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 {
 	struct musb *musb = hw_ep->musb;
 	void __iomem *fifo = hw_ep->fifo;
@@ -135,7 +135,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 /*
  * Unload an endpoint's FIFO
  */
-void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
+static void bfin_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 {
 	struct musb *musb = hw_ep->musb;
 	void __iomem *fifo = hw_ep->fifo;
@@ -474,8 +474,8 @@ static const struct musb_platform_ops bfin_ops = {
 	.writew		= bfin_writew,
 	.readl		= bfin_readl,
 	.writel		= bfin_writel,
-	.read_fifo	= musb_read_fifo,
-	.write_fifo	= musb_write_fifo,
+	.read_fifo	= bfin_read_fifo,
+	.write_fifo	= bfin_write_fifo,
 	.enable		= bfin_musb_enable,
 	.disable	= bfin_musb_disable,
 
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b841ee0..2fbe149 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -224,12 +224,46 @@ static struct usb_phy_io_ops musb_ulpi_access = {
 
 /*-------------------------------------------------------------------------*/
 
-#if !defined(CONFIG_USB_MUSB_TUSB6010) && !defined(CONFIG_USB_MUSB_BLACKFIN)
+static u32 musb_default_fifo_offset(u8 epnum)
+{
+	return 0x20 + (epnum * 4);
+}
+
+static u8 musb_default_readb(const void __iomem *addr, unsigned offset)
+{
+	return __raw_readb(addr + offset);
+}
+
+static void musb_default_writeb(void __iomem *addr, unsigned offset, u8 data)
+{
+	__raw_writeb(data, addr + offset);
+}
+
+static u16 musb_default_readw(const void __iomem *addr, unsigned offset)
+{
+	return __raw_readw(addr + offset);
+}
+
+static void musb_default_writew(void __iomem *addr, unsigned offset, u16 data)
+{
+	__raw_writew(data, addr + offset);
+}
+
+static u32 musb_default_readl(const void __iomem *addr, unsigned offset)
+{
+	return __raw_readl(addr + offset);
+}
+
+static void musb_default_writel(void __iomem *addr, unsigned offset, u32 data)
+{
+	__raw_writel(data, addr + offset);
+}
 
 /*
  * Load an endpoint's FIFO
  */
-void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
+static void musb_default_write_fifo(struct musb_hw_ep *hw_ep, u16 len,
+				    const u8 *src)
 {
 	struct musb *musb = hw_ep->musb;
 	void __iomem *fifo = hw_ep->fifo;
@@ -270,11 +304,10 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	}
 }
 
-#if !defined(CONFIG_USB_MUSB_AM35X)
 /*
  * Unload an endpoint's FIFO
  */
-void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
+static void musb_default_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 {
 	struct musb *musb = hw_ep->musb;
 	void __iomem *fifo = hw_ep->fifo;
@@ -312,10 +345,40 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 		ioread8_rep(fifo, dst, len);
 	}
 }
-#endif
 
-#endif	/* normal PIO */
+/*
+ * Old style IO functions
+ */
+u8 (*musb_readb)(const void __iomem *addr, unsigned offset);
+EXPORT_SYMBOL(musb_readb);
+
+void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
+EXPORT_SYMBOL(musb_writeb);
 
+u16 (*musb_readw)(const void __iomem *addr, unsigned offset);
+EXPORT_SYMBOL(musb_readw);
+
+void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
+EXPORT_SYMBOL(musb_writew);
+
+u32 (*musb_readl)(const void __iomem *addr, unsigned offset);
+EXPORT_SYMBOL(musb_readl);
+
+void (*musb_writel)(void __iomem *addr, unsigned offset, u32 data);
+EXPORT_SYMBOL(musb_writel);
+
+/*
+ * New style IO functions
+ */
+void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
+{
+	return hw_ep->musb->io.read_fifo(hw_ep, len, dst);
+}
+
+void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
+{
+	return hw_ep->musb->io.write_fifo(hw_ep, len, src);
+}
 
 /*-------------------------------------------------------------------------*/
 
@@ -1456,17 +1519,19 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
 	for (i = 0; i < musb->nr_endpoints; i++) {
 		struct musb_hw_ep	*hw_ep = musb->endpoints + i;
 
-		hw_ep->fifo = MUSB_FIFO_OFFSET(i) + mbase;
+		hw_ep->fifo = musb->io.fifo_offset(i) + mbase;
 #if defined(CONFIG_USB_MUSB_TUSB6010) || defined (CONFIG_USB_MUSB_TUSB6010_MODULE)
-		hw_ep->fifo_async = musb->async + 0x400 + MUSB_FIFO_OFFSET(i);
-		hw_ep->fifo_sync = musb->sync + 0x400 + MUSB_FIFO_OFFSET(i);
-		hw_ep->fifo_sync_va =
-			musb->sync_va + 0x400 + MUSB_FIFO_OFFSET(i);
-
-		if (i == 0)
-			hw_ep->conf = mbase - 0x400 + TUSB_EP0_CONF;
-		else
-			hw_ep->conf = mbase + 0x400 + (((i - 1) & 0xf) << 2);
+		if (musb->io.quirks & MUSB_IN_TUSB) {
+			hw_ep->fifo_async = musb->async + 0x400 + musb->io.fifo_offset(i);
+			hw_ep->fifo_sync = musb->sync + 0x400 + musb->io.fifo_offset(i);
+			hw_ep->fifo_sync_va =
+				musb->sync_va + 0x400 + musb->io.fifo_offset(i);
+
+			if (i == 0)
+				hw_ep->conf = mbase - 0x400 + TUSB_EP0_CONF;
+			else
+				hw_ep->conf = mbase + 0x400 + (((i - 1) & 0xf) << 2);
+		}
 #endif
 
 		hw_ep->regs = MUSB_EP_OFFSET(i, 0) + mbase;
@@ -1903,6 +1968,18 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb->ops = plat->platform_ops;
 	musb->port_mode = plat->mode;
 
+	/*
+	 * Initialize the default IO functions. At least omap2430 needs
+	 * these early. We initialize the platform specific IO functions
+	 * later on.
+	 */
+	musb_readb = musb_default_readb;
+	musb_writeb = musb_default_writeb;
+	musb_readw = musb_default_readw;
+	musb_writew = musb_default_writew;
+	musb_readl = musb_default_readl;
+	musb_writel = musb_default_writel;
+
 	/* The musb_platform_init() call:
 	 *   - adjusts musb->mregs
 	 *   - sets the musb->isr
@@ -1924,6 +2001,37 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		goto fail2;
 	}
 
+	if (musb->ops->quirks)
+		musb->io.quirks = musb->ops->quirks;
+
+	if (musb->ops->fifo_offset)
+		musb->io.fifo_offset = musb->ops->fifo_offset;
+	else
+		musb->io.fifo_offset = musb_default_fifo_offset;
+
+	if (musb->ops->readb)
+		musb_readb = musb->ops->readb;
+	if (musb->ops->writeb)
+		musb_writeb = musb->ops->writeb;
+	if (musb->ops->readw)
+		musb_readw = musb->ops->readw;
+	if (musb->ops->writew)
+		musb_writew = musb->ops->writew;
+	if (musb->ops->readl)
+		musb_readl = musb->ops->readl;
+	if (musb->ops->writel)
+		musb_writel = musb->ops->writel;
+
+	if (musb->ops->read_fifo)
+		musb->io.read_fifo = musb->ops->read_fifo;
+	else
+		musb->io.read_fifo = musb_default_read_fifo;
+
+	if (musb->ops->write_fifo)
+		musb->io.write_fifo = musb->ops->write_fifo;
+	else
+		musb->io.write_fifo = musb_default_write_fifo;
+
 	if (!musb->xceiv->io_ops) {
 		musb->xceiv->io_dev = musb->controller;
 		musb->xceiv->io_priv = musb->mregs;
diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 46c01c8..14aa217 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -55,86 +55,12 @@ struct musb_io {
 	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
 };
 
-#ifndef CONFIG_BLACKFIN
-
-/* NOTE:  these offsets are all in bytes */
-
-static inline u16 musb_readw(const void __iomem *addr, unsigned offset)
-	{ return __raw_readw(addr + offset); }
-
-static inline u32 musb_readl(const void __iomem *addr, unsigned offset)
-	{ return __raw_readl(addr + offset); }
-
-
-static inline void musb_writew(void __iomem *addr, unsigned offset, u16 data)
-	{ __raw_writew(data, addr + offset); }
-
-static inline void musb_writel(void __iomem *addr, unsigned offset, u32 data)
-	{ __raw_writel(data, addr + offset); }
-
-
-#if defined(CONFIG_USB_MUSB_TUSB6010) || defined (CONFIG_USB_MUSB_TUSB6010_MODULE)
-
-/*
- * TUSB6010 doesn't allow 8-bit access; 16-bit access is the minimum.
- */
-static inline u8 musb_readb(const void __iomem *addr, unsigned offset)
-{
-	u16 tmp;
-	u8 val;
-
-	tmp = __raw_readw(addr + (offset & ~1));
-	if (offset & 1)
-		val = (tmp >> 8);
-	else
-		val = tmp & 0xff;
-
-	return val;
-}
-
-static inline void musb_writeb(void __iomem *addr, unsigned offset, u8 data)
-{
-	u16 tmp;
-
-	tmp = __raw_readw(addr + (offset & ~1));
-	if (offset & 1)
-		tmp = (data << 8) | (tmp & 0xff);
-	else
-		tmp = (tmp & 0xff00) | data;
-
-	__raw_writew(tmp, addr + (offset & ~1));
-}
-
-#else
-
-static inline u8 musb_readb(const void __iomem *addr, unsigned offset)
-	{ return __raw_readb(addr + offset); }
-
-static inline void musb_writeb(void __iomem *addr, unsigned offset, u8 data)
-	{ __raw_writeb(data, addr + offset); }
-
-#endif	/* CONFIG_USB_MUSB_TUSB6010 */
-
-#else
-
-static inline u8 musb_readb(const void __iomem *addr, unsigned offset)
-	{ return (u8) (bfin_read16(addr + offset)); }
-
-static inline u16 musb_readw(const void __iomem *addr, unsigned offset)
-	{ return bfin_read16(addr + offset); }
-
-static inline u32 musb_readl(const void __iomem *addr, unsigned offset)
-	{ return (u32) (bfin_read16(addr + offset)); }
-
-static inline void musb_writeb(void __iomem *addr, unsigned offset, u8 data)
-	{ bfin_write16(addr + offset, (u16) data); }
-
-static inline void musb_writew(void __iomem *addr, unsigned offset, u16 data)
-	{ bfin_write16(addr + offset, data); }
-
-static inline void musb_writel(void __iomem *addr, unsigned offset, u32 data)
-	{ bfin_write16(addr + offset, (u16) data); }
-
-#endif /* CONFIG_BLACKFIN */
+/* Do not add new entries here, add them the struct musb_io instead */
+extern u8 (*musb_readb)(const void __iomem *addr, unsigned offset);
+extern void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
+extern u16 (*musb_readw)(const void __iomem *addr, unsigned offset);
+extern void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
+extern u32 (*musb_readl)(const void __iomem *addr, unsigned offset);
+extern void (*musb_writel)(void __iomem *addr, unsigned offset, u32 data);
 
 #endif
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index 37122a4..b2b1f73 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -239,14 +239,6 @@
 #define MUSB_INDEX		0x0E	/* 8 bit */
 #define MUSB_TESTMODE		0x0F	/* 8 bit */
 
-/* Get offset for a given FIFO from musb->mregs */
-#if defined(CONFIG_USB_MUSB_TUSB6010) ||	\
-	defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
-#define MUSB_FIFO_OFFSET(epnum)	(0x200 + ((epnum) * 0x20))
-#else
-#define MUSB_FIFO_OFFSET(epnum)	(0x20 + ((epnum) * 4))
-#endif
-
 /*
  * Additional Control Registers
  */
@@ -480,10 +472,6 @@ static inline u8  musb_read_txhubport(void __iomem *mbase, u8 epnum)
 #define MUSB_INDEX		USB_OFFSET(USB_INDEX)	/* 8 bit */
 #define MUSB_TESTMODE		USB_OFFSET(USB_TESTMODE)/* 8 bit */
 
-/* Get offset for a given FIFO from musb->mregs */
-#define MUSB_FIFO_OFFSET(epnum)	\
-	(USB_OFFSET(USB_EP0_FIFO) + ((epnum) * 8))
-
 /*
  * Additional Control Registers
  */
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 996ea21..38efebc 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -208,7 +208,7 @@ static inline void tusb_fifo_read_unaligned(void __iomem *fifo,
 	}
 }
 
-void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf)
+static void tusb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf)
 {
 	struct musb *musb = hw_ep->musb;
 	void __iomem	*ep_conf = hw_ep->conf;
@@ -258,7 +258,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf)
 		tusb_fifo_write_unaligned(fifo, buf, len);
 }
 
-void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *buf)
+static void tusb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *buf)
 {
 	struct musb *musb = hw_ep->musb;
 	void __iomem	*ep_conf = hw_ep->conf;
@@ -1177,8 +1177,8 @@ static const struct musb_platform_ops tusb_ops = {
 	.fifo_offset	= tusb_fifo_offset,
 	.readb		= tusb_readb,
 	.writeb		= tusb_writeb,
-	.read_fifo	= musb_read_fifo,
-	.write_fifo	= musb_write_fifo,
+	.read_fifo	= tusb_read_fifo,
+	.write_fifo	= tusb_write_fifo,
 	.enable		= tusb_musb_enable,
 	.disable	= tusb_musb_disable,
 
diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index 221faed..ff70f64 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -91,9 +91,9 @@ static bool ux500_configure_channel(struct dma_channel *channel,
 	struct scatterlist sg;
 	struct dma_slave_config slave_conf;
 	enum dma_slave_buswidth addr_width;
-	dma_addr_t usb_fifo_addr = (MUSB_FIFO_OFFSET(hw_ep->epnum) +
-					ux500_channel->controller->phy_base);
 	struct musb *musb = ux500_channel->controller->private_data;
+	dma_addr_t usb_fifo_addr = (musb->io.fifo_offset(hw_ep->epnum) +
+					ux500_channel->controller->phy_base);
 
 	dev_dbg(musb->controller,
 		"packet_sz=%d, mode=%d, dma_addr=0x%llx, len=%d is_tx=%d\n",
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
