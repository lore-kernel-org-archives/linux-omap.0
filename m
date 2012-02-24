From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: OMAP2+: Limit omap_read/write usage to legacy
 USB drivers
Date: Fri, 24 Feb 2012 10:25:51 -0800
Message-ID: <20120224182551.GM18185@atomide.com>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234051.18709.3571.stgit@kaulin.local>
 <1329898441.2070.10.camel@deskari>
 <20120222185728.GJ18185@atomide.com>
 <20120222224411.GO18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63494 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab2BXSZy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 13:25:54 -0500
Content-Disposition: inline
In-Reply-To: <20120222224411.GO18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120222 14:13]:
> * Tony Lindgren <tony@atomide.com> [120222 10:27]:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120221 23:42]:
> > > On Tue, 2012-02-21 at 15:40 -0800, Tony Lindgren wrote:
> > > > Drivers should no longer use omap_read/write functions
> > > > but instead use ioremap + read/write functions.
> > > > 
> > > > As some USB legacy code is still shared between omap1 and
> > > > omap2420, let's limit the omap_read/write to plat/usb.h.
> > > > 
> > > > Also, let's make drivers/video/omap/lcdc.c depend on
> > > > ARCH_OMAP1 as it is not needed for omap2+.
> > > 
> > > I'm ok with the lcdc.c change, but I also have a patch series that makes
> > > the same change, plus removes the omap2 code from drivers/video/omap/.
> > 
> > OK, I'll drop the lcdc.c change from my series as that should
> > only affect randconfig builds.
> 
> Here's this one updated. Noticed one more legacy driver
> that needs omap_read/write defined to build on 2420.

This one needed some updates for usb.h after updating patch 7/8
in this series. Updated patch below.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 14:52:41 -0800
Subject: [PATCH] ARM: OMAP2+: Limit omap_read/write usage to legacy USB drivers

Drivers should no longer use omap_read/write functions
but instead use ioremap + read/write functions.

As some USB legacy code is still shared between omap1 and
omap2420, let's limit the omap_read/write to plat/usb.h.

Note that the long term fix is to update the drivers to
use ioremap and read/write functions. That can now be
done as a separate patch series that is limited to the
USB drivers.

Also make sure the legacy omap1-keypad.c driver builds
if selected for 2420 based systems.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

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
diff --git a/arch/arm/plat-omap/include/plat/keypad.h b/arch/arm/plat-omap/include/plat/keypad.h
index 793ce9d..a6b21ed 100644
--- a/arch/arm/plat-omap/include/plat/keypad.h
+++ b/arch/arm/plat-omap/include/plat/keypad.h
@@ -12,6 +12,8 @@
 
 #ifndef CONFIG_ARCH_OMAP1
 #warning Please update the board to use matrix-keypad driver
+#define omap_readw(reg)		0
+#define omap_writew(val, reg)	do {} while (0)
 #endif
 #include <linux/input/matrix_keypad.h>
 
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index dc864b5..d0fc9f4 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -3,6 +3,7 @@
 #ifndef	__ASM_ARCH_OMAP_USB_H
 #define	__ASM_ARCH_OMAP_USB_H
 
+#include <linux/io.h>
 #include <linux/usb/musb.h>
 #include <plat/board.h>
 
@@ -105,6 +106,46 @@ extern int omap4430_phy_set_clk(struct device *dev, int on);
 extern int omap4430_phy_init(struct device *dev);
 extern int omap4430_phy_exit(struct device *dev);
 extern int omap4430_phy_suspend(struct device *dev, int suspend);
+
+/*
+ * NOTE: Please update omap USB drivers to use ioremap + read/write
+ */
+
+#define OMAP2_L4_IO_OFFSET	0xb2000000
+#define IOMEM(x)		((void __force __iomem *)(x))
+#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET)
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
