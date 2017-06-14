From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] ARM: OMAP2+: Drop unused serial.h
Date: Wed, 14 Jun 2017 00:31:18 -0700
Message-ID: <20170614073118.28246-8-tony@atomide.com>
References: <20170614073118.28246-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170614073118.28246-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Hoeun Ryu <hoeun.ryu@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With mach-omap2 booting in device tree only mode this file
is now unused and can be removed.

Cc: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h                       |  1 -
 arch/arm/mach-omap2/include/mach/serial.h          | 66 ----------------------
 arch/arm/mach-omap2/io.c                           |  1 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  1 -
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  1 -
 arch/arm/mach-omap2/serial.h                       |  1 -
 7 files changed, 72 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/include/mach/serial.h
 delete mode 100644 arch/arm/mach-omap2/serial.h

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -38,7 +38,6 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include "i2c.h"
-#include "serial.h"
 
 #include "usb.h"
 
diff --git a/arch/arm/mach-omap2/include/mach/serial.h b/arch/arm/mach-omap2/include/mach/serial.h
deleted file mode 100644
--- a/arch/arm/mach-omap2/include/mach/serial.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments
- * Added OMAP4 support- Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-/* OMAP2 serial ports */
-#define OMAP2_UART1_BASE	0x4806a000
-#define OMAP2_UART2_BASE	0x4806c000
-#define OMAP2_UART3_BASE	0x4806e000
-
-/* OMAP3 serial ports */
-#define OMAP3_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP3_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP3_UART3_BASE	0x49020000
-#define OMAP3_UART4_BASE	0x49042000	/* Only on 36xx */
-#define OMAP3_UART4_AM35XX_BASE	0x4809E000	/* Only on AM35xx */
-
-/* OMAP4 serial ports */
-#define OMAP4_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP4_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP4_UART3_BASE	0x48020000
-#define OMAP4_UART4_BASE	0x4806e000
-
-/* TI81XX serial ports */
-#define TI81XX_UART1_BASE	0x48020000
-#define TI81XX_UART2_BASE	0x48022000
-#define TI81XX_UART3_BASE	0x48024000
-
-/* AM3505/3517 UART4 */
-#define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
-
-/* AM33XX serial port */
-#define AM33XX_UART1_BASE	0x44E09000
-
-/* OMAP5 serial ports */
-#define OMAP5_UART1_BASE	OMAP2_UART1_BASE
-#define OMAP5_UART2_BASE	OMAP2_UART2_BASE
-#define OMAP5_UART3_BASE	OMAP4_UART3_BASE
-#define OMAP5_UART4_BASE	OMAP4_UART4_BASE
-#define OMAP5_UART5_BASE	0x48066000
-#define OMAP5_UART6_BASE	0x48068000
-
-/* External port on Zoom2/3 */
-#define ZOOM_UART_BASE		0x10000000
-#define ZOOM_UART_VIRT		0xfa400000
-
-#define OMAP_PORT_SHIFT		2
-#define ZOOM_PORT_SHIFT		1
-
-#define OMAP24XX_BASE_BAUD	(48000000/16)
-
-#ifndef __ASSEMBLER__
-
-struct omap_board_data;
-struct omap_uart_port_info;
-
-extern void omap_serial_init(void);
-extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
-extern void omap_serial_init_port(struct omap_board_data *bdata,
-		struct omap_uart_port_info *platform_data);
-#endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -40,7 +40,6 @@
 #include "omap-pm.h"
 #include "sdrc.h"
 #include "control.h"
-#include "serial.h"
 #include "sram.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -28,7 +28,6 @@
 #include "prm-regbits-24xx.h"
 #include "i2c.h"
 #include "mmc.h"
-#include "serial.h"
 #include "wd_timer.h"
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -16,7 +16,6 @@
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
 #include "l4_2xxx.h"
-#include "serial.h"
 
 #include "omap_hwmod_common_data.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -35,7 +35,6 @@
 
 #include "i2c.h"
 #include "wd_timer.h"
-#include "serial.h"
 
 /*
  * OMAP3xxx hardware module integration data
diff --git a/arch/arm/mach-omap2/serial.h b/arch/arm/mach-omap2/serial.h
deleted file mode 100644
--- a/arch/arm/mach-omap2/serial.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <mach/serial.h>
-- 
2.13.0
