From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/8] ARM: OMAP: Remove plat/io.h by moving it into mach/io.h
Date: Tue, 21 Feb 2012 15:40:49 -0800
Message-ID: <20120221234049.18709.28987.stgit@kaulin.local>
References: <20120221233619.18709.87982.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25361 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab2BUXku (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 18:40:50 -0500
In-Reply-To: <20120221233619.18709.87982.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is needed so we can eventually remove mach/io.h
for omap2+.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/io.h |   78 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/common.h          |   10 ++++
 arch/arm/mach-omap2/include/mach/io.h |   60 +++++++++++++++++++++++-
 arch/arm/mach-omap2/pm24xx.c          |    2 -
 arch/arm/plat-omap/dma.c              |    2 +
 arch/arm/plat-omap/include/plat/io.h  |   84 ---------------------------------
 arch/arm/plat-omap/usb.c              |    2 +
 7 files changed, 150 insertions(+), 88 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/io.h

diff --git a/arch/arm/mach-omap1/include/mach/io.h b/arch/arm/mach-omap1/include/mach/io.h
index 57bdf74..07ffba8 100644
--- a/arch/arm/mach-omap1/include/mach/io.h
+++ b/arch/arm/mach-omap1/include/mach/io.h
@@ -1,5 +1,81 @@
 /*
  * arch/arm/mach-omap1/include/mach/io.h
+ *
+ * IO definitions for TI OMAP processors and boards
+ *
+ * Copied from arch/arm/mach-sa1100/include/mach/io.h
+ * Copyright (C) 1997-1999 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Modifications:
+ *  06-12-1997	RMK	Created.
+ *  07-04-1999	RMK	Major cleanup
  */
 
-#include <plat/io.h>
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#include <mach/hardware.h>
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+/*
+ * ----------------------------------------------------------------------------
+ * I/O mapping
+ * ----------------------------------------------------------------------------
+ */
+
+#ifdef __ASSEMBLER__
+#define IOMEM(x)		(x)
+#else
+#define IOMEM(x)		((void __force __iomem *)(x))
+#endif
+
+/*
+ * ----------------------------------------------------------------------------
+ * Omap specific register access
+ * ----------------------------------------------------------------------------
+ */
+
+#ifndef __ASSEMBLER__
+
+/*
+ * NOTE: Please use ioremap + __raw_read/write where possible instead of these
+ */
+
+extern u8 omap_readb(u32 pa);
+extern u16 omap_readw(u32 pa);
+extern u32 omap_readl(u32 pa);
+extern void omap_writeb(u8 v, u32 pa);
+extern void omap_writew(u16 v, u32 pa);
+extern void omap_writel(u32 v, u32 pa);
+
+#endif
+
+#endif
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f78ec4e..09ca9e9 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -242,5 +242,15 @@ struct omap_sdrc_params;
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
 
+/*
+ * NOTE: Please use ioremap + __raw_read/write where possible instead of these
+ */
+extern u8 omap_readb(u32 pa);
+extern u16 omap_readw(u32 pa);
+extern u32 omap_readl(u32 pa);
+extern void omap_writeb(u8 v, u32 pa);
+extern void omap_writew(u16 v, u32 pa);
+extern void omap_writel(u32 v, u32 pa);
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/include/mach/io.h b/arch/arm/mach-omap2/include/mach/io.h
index fd78f31..7306404 100644
--- a/arch/arm/mach-omap2/include/mach/io.h
+++ b/arch/arm/mach-omap2/include/mach/io.h
@@ -1,5 +1,63 @@
 /*
  * arch/arm/mach-omap2/include/mach/io.h
+ *
+ * IO definitions for TI OMAP processors and boards
+ *
+ * Copied from arch/arm/mach-sa1100/include/mach/io.h
+ * Copyright (C) 1997-1999 Russell King
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Modifications:
+ *  06-12-1997	RMK	Created.
+ *  07-04-1999	RMK	Major cleanup
  */
 
-#include <plat/io.h>
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#include <mach/hardware.h>
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+/*
+ * ----------------------------------------------------------------------------
+ * I/O mapping
+ * ----------------------------------------------------------------------------
+ */
+
+#ifdef __ASSEMBLER__
+#define IOMEM(x)		(x)
+#else
+#define IOMEM(x)		((void __force __iomem *)(x))
+#endif
+
+#endif
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index ac0d629..894ed2d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -26,7 +26,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/gpio.h>
@@ -42,7 +41,6 @@
 
 #include <mach/irqs.h>
 
-#include "iomap.h"
 #include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 002fb4d..95c3ed6 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -164,6 +164,8 @@ static inline void set_gdma_dev(int req, int dev)
 }
 #else
 #define set_gdma_dev(req, dev)	do {} while (0)
+#define omap_readl(reg)		0
+#define omap_writel(val, reg)	do {} while (0)
 #endif
 
 void omap_set_dma_priority(int lch, int dst_port, int priority)
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
deleted file mode 100644
index 93261d9..0000000
--- a/arch/arm/plat-omap/include/plat/io.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/io.h
- *
- * IO definitions for TI OMAP processors and boards
- *
- * Copied from arch/arm/mach-sa1100/include/mach/io.h
- * Copyright (C) 1997-1999 Russell King
- *
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Modifications:
- *  06-12-1997	RMK	Created.
- *  07-04-1999	RMK	Major cleanup
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#include <mach/hardware.h>
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-/*
- * ----------------------------------------------------------------------------
- * I/O mapping
- * ----------------------------------------------------------------------------
- */
-
-#ifdef __ASSEMBLER__
-#define IOMEM(x)		(x)
-#else
-#define IOMEM(x)		((void __force __iomem *)(x))
-#endif
-
-/*
- * ----------------------------------------------------------------------------
- * Omap specific register access
- * ----------------------------------------------------------------------------
- */
-
-#ifndef __ASSEMBLER__
-
-/*
- * NOTE: Please use ioremap + __raw_read/write where possible instead of these
- */
-
-extern u8 omap_readb(u32 pa);
-extern u16 omap_readw(u32 pa);
-extern u32 omap_readl(u32 pa);
-extern void omap_writeb(u8 v, u32 pa);
-extern void omap_writew(u16 v, u32 pa);
-extern void omap_writel(u32 v, u32 pa);
-
-#endif
-
-#endif
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index f357088..55a5cd1 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -29,6 +29,8 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 
+#include "../mach-omap2/common.h"
+
 #ifdef	CONFIG_ARCH_OMAP_OTG
 
 void __init

