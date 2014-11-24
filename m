From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/8] usb: musb: Add function pointers for IO access functions
Date: Mon, 24 Nov 2014 11:04:59 -0800
Message-ID: <1416855906-13931-2-git-send-email-tony@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416855906-13931-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

MUSB currently breaks badly if we try to build in support
for multiple platforms. This also happens if done as loadable
modules, which is not nice for distros.

Let's fix the issue by adding new struct musb_io for the IO
access functions that the platform code can populate. Note
that we don't want to use the current ops as that's really
platform_data and and set as a const.

This should allow eventually adding function pointers also
for the DMA code to struct musb_io, but that's a whole
different set of patches. For now, let's just fix the PIO
access.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.h | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_io.h   | 18 ++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 414e57a..7c7f38c 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -173,8 +173,25 @@ enum musb_g_ep0_state {
 
 /******************************** TYPES *************************************/
 
+struct musb_io;
+
 /**
  * struct musb_platform_ops - Operations passed to musb_core by HW glue layer
+ * @quirks:	flags for platform specific quirks
+ * @enable:	enable device
+ * @disable:	disable device
+ * @ep_offset:	returns the end point offset
+ * @ep_select:	selects the specified end point
+ * @fifo_mode:	sets the fifo mode
+ * @fifo_offset: returns the fifo offset
+ * @readb:	read 8 bits
+ * @writeb:	write 8 bits
+ * @readw:	read 16 bits
+ * @writew:	write 16 bits
+ * @readl:	read 32 bits
+ * @writel:	write 32 bits
+ * @read_fifo:	reads the fifo
+ * @write_fifo:	writes to fifo
  * @init:	turns on clocks, sets up platform-specific registers, etc
  * @exit:	undoes @init
  * @set_mode:	forcefully changes operating mode
@@ -184,12 +201,34 @@ enum musb_g_ep0_state {
  * @adjust_channel_params: pre check for standard dma channel_program func
  */
 struct musb_platform_ops {
+
+#define MUSB_DMA_UX500		BIT(6)
+#define MUSB_DMA_CPPI41		BIT(5)
+#define MUSB_DMA_CPPI		BIT(4)
+#define MUSB_DMA_TUSB_OMAP	BIT(3)
+#define MUSB_DMA_INVENTRA	BIT(2)
+#define MUSB_IN_TUSB		BIT(1)
+#define MUSB_INDEXED_EP		BIT(0)
+	u32	quirks;
+
 	int	(*init)(struct musb *musb);
 	int	(*exit)(struct musb *musb);
 
 	void	(*enable)(struct musb *musb);
 	void	(*disable)(struct musb *musb);
 
+	u32	(*ep_offset)(u8 epnum, u16 offset);
+	void	(*ep_select)(void __iomem *mbase, u8 epnum);
+	u16	fifo_mode;
+	u32	(*fifo_offset)(u8 epnum);
+	u8	(*readb)(const void __iomem *addr, unsigned offset);
+	void	(*writeb)(void __iomem *addr, unsigned offset, u8 data);
+	u16	(*readw)(const void __iomem *addr, unsigned offset);
+	void	(*writew)(void __iomem *addr, unsigned offset, u16 data);
+	u32	(*readl)(const void __iomem *addr, unsigned offset);
+	void	(*writel)(void __iomem *addr, unsigned offset, u32 data);
+	void	(*read_fifo)(struct musb_hw_ep *hw_ep, u16 len, u8 *buf);
+	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
 	int	(*set_mode)(struct musb *musb, u8 mode);
 	void	(*try_idle)(struct musb *musb, unsigned long timeout);
 	int	(*reset)(struct musb *musb);
@@ -292,6 +331,7 @@ struct musb {
 	/* device lock */
 	spinlock_t		lock;
 
+	struct musb_io		io;
 	const struct musb_platform_ops *ops;
 	struct musb_context_registers context;
 
diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index eebeed7..46c01c8 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -37,6 +37,24 @@
 
 #include <linux/io.h>
 
+/**
+ * struct musb_io - IO functions for MUSB
+ * @quirks:	platform specific flags
+ * @ep_offset:	platform specific function to get end point offset
+ * @ep_select:	platform specific function to select end point
+ * @fifo_offset: platform specific function to get fifo offset
+ * @read_fifo:	platform specific function to read fifo
+ * @write_fifo:	platform specific function to write fifo
+ */
+struct musb_io {
+	u32	quirks;
+	u32	(*ep_offset)(u8 epnum, u16 offset);
+	void	(*ep_select)(void __iomem *mbase, u8 epnum);
+	u32	(*fifo_offset)(u8 epnum);
+	void	(*read_fifo)(struct musb_hw_ep *hw_ep, u16 len, u8 *buf);
+	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
+};
+
 #ifndef CONFIG_BLACKFIN
 
 /* NOTE:  these offsets are all in bytes */
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
