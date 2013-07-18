From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 12/15] ARM: Samsung: Remove the MIPI PHY setup code
Date: Thu, 18 Jul 2013 12:16:21 +0530
Message-ID: <1374129984-765-13-git-send-email-kishon@ti.com>
References: <1374129984-765-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374129984-765-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Generic PHY drivers are used to handle the MIPI CSIS and MIPI DSIM
DPHYs so we can remove now unused code at arch/arm/plat-samsung.
In case there is any board file for S5PV210 platforms using MIPI
CSIS/DSIM (not any upstream currently) it should use the generic
PHY API to bind the PHYs to respective PHY consumer drivers and
a platform device for the PHY provider should be defined.

Signed-off-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Acked-by: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-exynos/include/mach/regs-pmu.h    |    5 --
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |    4 --
 arch/arm/plat-samsung/Kconfig                   |    5 --
 arch/arm/plat-samsung/Makefile                  |    1 -
 arch/arm/plat-samsung/setup-mipiphy.c           |   60 -----------------------
 5 files changed, 75 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/setup-mipiphy.c

diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index 57344b7..2cdb63e 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -44,11 +44,6 @@
 #define S5P_DAC_PHY_CONTROL			S5P_PMUREG(0x070C)
 #define S5P_DAC_PHY_ENABLE			(1 << 0)
 
-#define S5P_MIPI_DPHY_CONTROL(n)		S5P_PMUREG(0x0710 + (n) * 4)
-#define S5P_MIPI_DPHY_ENABLE			(1 << 0)
-#define S5P_MIPI_DPHY_SRESETN			(1 << 1)
-#define S5P_MIPI_DPHY_MRESETN			(1 << 2)
-
 #define S5P_INFORM0				S5P_PMUREG(0x0800)
 #define S5P_INFORM1				S5P_PMUREG(0x0804)
 #define S5P_INFORM2				S5P_PMUREG(0x0808)
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
index 032de66..e345584 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -147,10 +147,6 @@
 #define S5P_HDMI_PHY_CONTROL	S5P_CLKREG(0xE804)
 #define S5P_USB_PHY_CONTROL	S5P_CLKREG(0xE80C)
 #define S5P_DAC_PHY_CONTROL	S5P_CLKREG(0xE810)
-#define S5P_MIPI_DPHY_CONTROL(x) S5P_CLKREG(0xE814)
-#define S5P_MIPI_DPHY_ENABLE	(1 << 0)
-#define S5P_MIPI_DPHY_SRESETN	(1 << 1)
-#define S5P_MIPI_DPHY_MRESETN	(1 << 2)
 
 #define S5P_INFORM0		S5P_CLKREG(0xF000)
 #define S5P_INFORM1		S5P_CLKREG(0xF004)
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 3dc5cbe..db2d814 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -402,11 +402,6 @@ config S3C24XX_PWM
 	  Support for exporting the PWM timer blocks via the pwm device
 	  system
 
-config S5P_SETUP_MIPIPHY
-	bool
-	help
-	  Compile in common setup code for MIPI-CSIS and MIPI-DSIM devices
-
 config S3C_SETUP_CAMIF
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 98d07d8..98f1e31 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -41,7 +41,6 @@ obj-$(CONFIG_S5P_DEV_UART)	+= s5p-dev-uart.o
 obj-$(CONFIG_SAMSUNG_DEV_BACKLIGHT)	+= dev-backlight.o
 
 obj-$(CONFIG_S3C_SETUP_CAMIF)	+= setup-camif.o
-obj-$(CONFIG_S5P_SETUP_MIPIPHY)	+= setup-mipiphy.o
 
 # DMA support
 
diff --git a/arch/arm/plat-samsung/setup-mipiphy.c b/arch/arm/plat-samsung/setup-mipiphy.c
deleted file mode 100644
index 66df315..0000000
--- a/arch/arm/plat-samsung/setup-mipiphy.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * Copyright (C) 2011 Samsung Electronics Co., Ltd.
- *
- * S5P - Helper functions for MIPI-CSIS and MIPI-DSIM D-PHY control
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-#include <mach/regs-clock.h>
-
-static int __s5p_mipi_phy_control(int id, bool on, u32 reset)
-{
-	static DEFINE_SPINLOCK(lock);
-	void __iomem *addr;
-	unsigned long flags;
-	u32 cfg;
-
-	id = max(0, id);
-	if (id > 1)
-		return -EINVAL;
-
-	addr = S5P_MIPI_DPHY_CONTROL(id);
-
-	spin_lock_irqsave(&lock, flags);
-
-	cfg = __raw_readl(addr);
-	cfg = on ? (cfg | reset) : (cfg & ~reset);
-	__raw_writel(cfg, addr);
-
-	if (on) {
-		cfg |= S5P_MIPI_DPHY_ENABLE;
-	} else if (!(cfg & (S5P_MIPI_DPHY_SRESETN |
-			    S5P_MIPI_DPHY_MRESETN) & ~reset)) {
-		cfg &= ~S5P_MIPI_DPHY_ENABLE;
-	}
-
-	__raw_writel(cfg, addr);
-	spin_unlock_irqrestore(&lock, flags);
-
-	return 0;
-}
-
-int s5p_csis_phy_enable(int id, bool on)
-{
-	return __s5p_mipi_phy_control(id, on, S5P_MIPI_DPHY_SRESETN);
-}
-EXPORT_SYMBOL(s5p_csis_phy_enable);
