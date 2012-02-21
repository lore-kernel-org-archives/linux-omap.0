From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/8] ARM: OMAP2+: Limit omap_read/write usage to legacy USB
 drivers
Date: Tue, 21 Feb 2012 15:40:51 -0800
Message-ID: <20120221234051.18709.3571.stgit@kaulin.local>
References: <20120221233619.18709.87982.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17281 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab2BUXkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 18:40:52 -0500
In-Reply-To: <20120221233619.18709.87982.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Drivers should no longer use omap_read/write functions
but instead use ioremap + read/write functions.

As some USB legacy code is still shared between omap1 and
omap2420, let's limit the omap_read/write to plat/usb.h.

Also, let's make drivers/video/omap/lcdc.c depend on
ARCH_OMAP1 as it is not needed for omap2+.

Note that the long term fix is to update the drivers to
use ioremap and read/write functions. That can now be
done as a separate patch series that is limited to the
USB drivers.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h          |   10 --------
 arch/arm/mach-omap2/io.c              |   40 ---------------------------------
 arch/arm/plat-omap/include/plat/usb.h |   40 +++++++++++++++++++++++++++++++++
 drivers/video/omap/Kconfig            |    2 +-
 4 files changed, 41 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 09ca9e9..f78ec4e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -242,15 +242,5 @@ struct omap_sdrc_params;
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
 
-/*
- * NOTE: Please use ioremap + __raw_read/write where possible instead of these
- */
-extern u8 omap_readb(u32 pa);
-extern u16 omap_readw(u32 pa);
-extern u32 omap_readl(u32 pa);
-extern void omap_writeb(u8 v, u32 pa);
-extern void omap_writew(u16 v, u32 pa);
-extern void omap_writel(u32 v, u32 pa);
-
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 0119807..3203128 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -487,43 +487,3 @@ void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 		_omap2_init_reprogram_sdrc();
 	}
 }
-
-/*
- * NOTE: Please use ioremap + __raw_read/write where possible instead of these
- */
-
-u8 omap_readb(u32 pa)
-{
-	return __raw_readb(OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_readb);
-
-u16 omap_readw(u32 pa)
-{
-	return __raw_readw(OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_readw);
-
-u32 omap_readl(u32 pa)
-{
-	return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_readl);
-
-void omap_writeb(u8 v, u32 pa)
-{
-	__raw_writeb(v, OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_writeb);
-
-void omap_writew(u16 v, u32 pa)
-{
-	__raw_writew(v, OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_writew);
-
-void omap_writel(u32 v, u32 pa)
-{
-	__raw_writel(v, OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_writel);
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index dc864b5..5f6ced4 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -3,6 +3,7 @@
 #ifndef	__ASM_ARCH_OMAP_USB_H
 #define	__ASM_ARCH_OMAP_USB_H
 
+#include <linux/io.h>
 #include <linux/usb/musb.h>
 #include <plat/board.h>
 
@@ -105,6 +106,45 @@ extern int omap4430_phy_set_clk(struct device *dev, int on);
 extern int omap4430_phy_init(struct device *dev);
 extern int omap4430_phy_exit(struct device *dev);
 extern int omap4430_phy_suspend(struct device *dev, int suspend);
+
+/*
+ * NOTE: Please update omap USB drivers to use ioremap + read/write
+ */
+
+#define OMAP2_L4_IO_OFFSET		0xb2000000
+#define OMAP2_L4_IO_ADDRESS(pa)		IOMEM((pa) + OMAP2_L4_IO_OFFSET)
+
+static inline u8 omap_readb(u32 pa)
+{
+	return __raw_readb(OMAP2_L4_IO_ADDRESS(pa));
+}
+
+static inline u16 omap_readw(u32 pa)
+{
+	return __raw_readw(OMAP2_L4_IO_ADDRESS(pa));
+}
+
+static inline u32 omap_readl(u32 pa)
+{
+	return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
+}
+
+static inline void omap_writeb(u8 v, u32 pa)
+{
+	__raw_writeb(v, OMAP2_L4_IO_ADDRESS(pa));
+}
+
+
+static inline void omap_writew(u16 v, u32 pa)
+{
+	__raw_writew(v, OMAP2_L4_IO_ADDRESS(pa));
+}
+
+static inline void omap_writel(u32 v, u32 pa)
+{
+	__raw_writel(v, OMAP2_L4_IO_ADDRESS(pa));
+}
+
 #endif
 
 extern void am35x_musb_reset(void);
diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 84ff232..295d1cc 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -11,7 +11,7 @@ config FB_OMAP
 
 config FB_OMAP_LCDC_EXTERNAL
 	bool "External LCD controller support"
-	depends on FB_OMAP
+	depends on FB_OMAP && ARCH_OMAP1
 	help
 	  Say Y here, if you want to have support for boards with an
 	  external LCD controller connected to the SoSSI/RFBI interface.

