From: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [RFC 15/23] usb: musb: raw read and write endian fix
Date: Sat, 16 Nov 2013 02:01:18 +0200
Message-ID: <1384560086-11994-16-git-send-email-taras.kondratiuk@linaro.org>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384560086-11994-1-git-send-email-taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-networking-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
Need to use endian neutral functions to read/write h/w registers.
I.e instead of __raw_read[lw] and __raw_write[lw] functions code
need to use read[lw]_relaxed and write[lw]_relaxed functions.
If the first simply reads/writes register, the second will byteswap
it if host operates in BE mode.

Changes are trivial sed like replacement of __raw_xxx functions
with xxx_relaxed variant.

Signed-off-by: Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/usb/musb/musb_io.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index eebeed7..76f4d2a 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -42,17 +42,17 @@
 /* NOTE:  these offsets are all in bytes */
 
 static inline u16 musb_readw(const void __iomem *addr, unsigned offset)
-	{ return __raw_readw(addr + offset); }
+	{ return readw_relaxed(addr + offset); }
 
 static inline u32 musb_readl(const void __iomem *addr, unsigned offset)
-	{ return __raw_readl(addr + offset); }
+	{ return readl_relaxed(addr + offset); }
 
 
 static inline void musb_writew(void __iomem *addr, unsigned offset, u16 data)
-	{ __raw_writew(data, addr + offset); }
+	{ writew_relaxed(data, addr + offset); }
 
 static inline void musb_writel(void __iomem *addr, unsigned offset, u32 data)
-	{ __raw_writel(data, addr + offset); }
+	{ writel_relaxed(data, addr + offset); }
 
 
 #if defined(CONFIG_USB_MUSB_TUSB6010) || defined (CONFIG_USB_MUSB_TUSB6010_MODULE)
@@ -65,7 +65,7 @@ static inline u8 musb_readb(const void __iomem *addr, unsigned offset)
 	u16 tmp;
 	u8 val;
 
-	tmp = __raw_readw(addr + (offset & ~1));
+	tmp = readw_relaxed(addr + (offset & ~1));
 	if (offset & 1)
 		val = (tmp >> 8);
 	else
@@ -78,22 +78,22 @@ static inline void musb_writeb(void __iomem *addr, unsigned offset, u8 data)
 {
 	u16 tmp;
 
-	tmp = __raw_readw(addr + (offset & ~1));
+	tmp = readw_relaxed(addr + (offset & ~1));
 	if (offset & 1)
 		tmp = (data << 8) | (tmp & 0xff);
 	else
 		tmp = (tmp & 0xff00) | data;
 
-	__raw_writew(tmp, addr + (offset & ~1));
+	writew_relaxed(tmp, addr + (offset & ~1));
 }
 
 #else
 
 static inline u8 musb_readb(const void __iomem *addr, unsigned offset)
-	{ return __raw_readb(addr + offset); }
+	{ return readb_relaxed(addr + offset); }
 
 static inline void musb_writeb(void __iomem *addr, unsigned offset, u8 data)
-	{ __raw_writeb(data, addr + offset); }
+	{ writeb_relaxed(data, addr + offset); }
 
 #endif	/* CONFIG_USB_MUSB_TUSB6010 */
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
