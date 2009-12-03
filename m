From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/9] omap: mux: Remove old mux code for 34xx
Date: Wed, 02 Dec 2009 16:22:46 -0800
Message-ID: <20091203002246.2769.11977.stgit@localhost>
References: <20091203001601.2769.20621.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55707 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbZLCAWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 19:22:41 -0500
In-Reply-To: <20091203001601.2769.20621.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Remove old mux code for 34xx

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |    1 
 arch/arm/mach-omap2/board-cm-t35.c       |    1 
 arch/arm/mach-omap2/board-igep0020.c     |    1 
 arch/arm/mach-omap2/board-omap3beagle.c  |    1 
 arch/arm/mach-omap2/board-omap3evm.c     |    1 
 arch/arm/mach-omap2/board-omap3pandora.c |    1 
 arch/arm/mach-omap2/board-overo.c        |    1 
 arch/arm/mach-omap2/board-rx51.c         |    1 
 arch/arm/mach-omap2/io.c                 |    1 
 arch/arm/mach-omap2/mux.c                |  368 +-----------------------------
 arch/arm/plat-omap/include/plat/mux.h    |  226 ------------------
 11 files changed, 14 insertions(+), 589 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ded3e87..4cfb7b6 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -31,7 +31,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/mcspi.h>
-#include <plat/mux.h>
 #include <plat/board.h>
 #include <plat/usb.h>
 #include <plat/common.h>
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 10a5955..507c922 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -38,7 +38,6 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
-#include <plat/mux.h>
 #include <plat/nand.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 7e3217a..44239e3 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -27,7 +27,6 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 9e606b1..6ada802 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -41,7 +41,6 @@
 #include <plat/common.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/timer-gp.h>
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 0457f61..18913e9 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -38,7 +38,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/common.h>
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index bca5ad9..c1cc99c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -40,7 +40,6 @@
 #include <mach/hardware.h>
 #include <plat/mcspi.h>
 #include <plat/usb.h>
-#include <plat/mux.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 1ebde4c..5b78a87 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -44,7 +44,6 @@
 #include <plat/gpmc.h>
 #include <mach/hardware.h>
 #include <plat/nand.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index fd71c00..67bb347 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -23,7 +23,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/mcspi.h>
-#include <plat/mux.h>
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/dma.h>
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6a4d8e4..b632ea0 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -34,6 +34,7 @@
 #include <plat/gpmc.h>
 #include <plat/serial.h>
 #include <plat/vram.h>
+#include <plat/mux.h>
 
 #ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index d968433..e071b3f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -67,13 +67,12 @@ static inline void omap_mux_write(u16 val, u16 reg)
 		__raw_writew(val, mux_base + reg);
 }
 
-#ifdef CONFIG_OMAP_MUX
+#if defined(CONFIG_ARCH_OMAP24XX) && defined(CONFIG_OMAP_MUX)
 
 static struct omap_mux_cfg arch_mux_cfg;
 
 /* NOTE: See mux.h for the enumeration */
 
-#ifdef CONFIG_ARCH_OMAP24XX
 static struct pin_config __initdata_or_module omap24xx_pins[] = {
 /*
  *	description			mux	mux	pull	pull	debug
@@ -283,333 +282,8 @@ MUX_CFG_24XX("AF19_2430_GPIO_85",	0x0113,	3,	0,	0,	1)
 
 #define OMAP24XX_PINS_SZ	ARRAY_SIZE(omap24xx_pins)
 
-#else
-#define omap24xx_pins		NULL
-#define OMAP24XX_PINS_SZ	0
-#endif	/* CONFIG_ARCH_OMAP24XX */
-
-#ifdef CONFIG_ARCH_OMAP34XX
-static struct pin_config __initdata_or_module omap34xx_pins[] = {
-/*
- *		Name, reg-offset,
- *		mux-mode | [active-mode | off-mode]
- */
-
-/* 34xx I2C */
-MUX_CFG_34XX("K21_34XX_I2C1_SCL", 0x1ba,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("J21_34XX_I2C1_SDA", 0x1bc,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AF15_34XX_I2C2_SCL", 0x1be,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AE15_34XX_I2C2_SDA", 0x1c0,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AF14_34XX_I2C3_SCL", 0x1c2,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AG14_34XX_I2C3_SDA", 0x1c4,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AD26_34XX_I2C4_SCL", 0xa00,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AE26_34XX_I2C4_SDA", 0xa02,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-
-/* PHY - HSUSB: 12-pin ULPI PHY: Port 1*/
-MUX_CFG_34XX("Y8_3430_USB1HS_PHY_CLK", 0x5da,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("Y9_3430_USB1HS_PHY_STP", 0x5d8,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("AA14_3430_USB1HS_PHY_DIR", 0x5ec,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AA11_3430_USB1HS_PHY_NXT", 0x5ee,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W13_3430_USB1HS_PHY_D0", 0x5dc,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W12_3430_USB1HS_PHY_D1", 0x5de,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W11_3430_USB1HS_PHY_D2", 0x5e0,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y11_3430_USB1HS_PHY_D3", 0x5ea,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W9_3430_USB1HS_PHY_D4", 0x5e4,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y12_3430_USB1HS_PHY_D5", 0x5e6,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W8_3430_USB1HS_PHY_D6", 0x5e8,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y13_3430_USB1HS_PHY_D7", 0x5e2,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-
-/* PHY - HSUSB: 12-pin ULPI PHY: Port 2*/
-MUX_CFG_34XX("AA8_3430_USB2HS_PHY_CLK", 0x5f0,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("AA10_3430_USB2HS_PHY_STP", 0x5f2,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("AA9_3430_USB2HS_PHY_DIR", 0x5f4,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB11_3430_USB2HS_PHY_NXT", 0x5f6,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB10_3430_USB2HS_PHY_D0", 0x5f8,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB9_3430_USB2HS_PHY_D1", 0x5fa,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W3_3430_USB2HS_PHY_D2", 0x1d4,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("T4_3430_USB2HS_PHY_D3", 0x1de,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("T3_3430_USB2HS_PHY_D4", 0x1d8,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("R3_3430_USB2HS_PHY_D5", 0x1da,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("R4_3430_USB2HS_PHY_D6", 0x1dc,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("T2_3430_USB2HS_PHY_D7", 0x1d6,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
-
-/* TLL - HSUSB: 12-pin TLL Port 1*/
-MUX_CFG_34XX("Y8_3430_USB1HS_TLL_CLK", 0x5da,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y9_3430_USB1HS_TLL_STP", 0x5d8,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AA14_3430_USB1HS_TLL_DIR", 0x5ec,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AA11_3430_USB1HS_TLL_NXT", 0x5ee,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W13_3430_USB1HS_TLL_D0", 0x5dc,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W12_3430_USB1HS_TLL_D1", 0x5de,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W11_3430_USB1HS_TLL_D2", 0x5e0,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y11_3430_USB1HS_TLL_D3", 0x5ea,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W9_3430_USB1HS_TLL_D4", 0x5e4,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y12_3430_USB1HS_TLL_D5", 0x5e6,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W8_3430_USB1HS_TLL_D6", 0x5e8,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y13_3430_USB1HS_TLL_D7", 0x5e2,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-
-/* TLL - HSUSB: 12-pin TLL Port 2*/
-MUX_CFG_34XX("AA8_3430_USB2HS_TLL_CLK", 0x5f0,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AA10_3430_USB2HS_TLL_STP", 0x5f2,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AA9_3430_USB2HS_TLL_DIR", 0x5f4,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB11_3430_USB2HS_TLL_NXT", 0x5f6,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB10_3430_USB2HS_TLL_D0", 0x5f8,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB9_3430_USB2HS_TLL_D1", 0x5fa,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W3_3430_USB2HS_TLL_D2", 0x1d4,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("T4_3430_USB2HS_TLL_D3", 0x1de,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("T3_3430_USB2HS_TLL_D4", 0x1d8,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("R3_3430_USB2HS_TLL_D5", 0x1da,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("R4_3430_USB2HS_TLL_D6", 0x1dc,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("T2_3430_USB2HS_TLL_D7", 0x1d6,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
-
-/* TLL - HSUSB: 12-pin TLL Port 3*/
-MUX_CFG_34XX("AA6_3430_USB3HS_TLL_CLK", 0x180,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB3_3430_USB3HS_TLL_STP", 0x166,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AA3_3430_USB3HS_TLL_DIR", 0x168,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y3_3430_USB3HS_TLL_NXT", 0x16a,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AA5_3430_USB3HS_TLL_D0", 0x186,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y4_3430_USB3HS_TLL_D1", 0x184,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y5_3430_USB3HS_TLL_D2", 0x188,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W5_3430_USB3HS_TLL_D3", 0x18a,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB12_3430_USB3HS_TLL_D4", 0x16c,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB13_3430_USB3HS_TLL_D5", 0x16e,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AA13_3430_USB3HS_TLL_D6", 0x170,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AA12_3430_USB3HS_TLL_D7", 0x172,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-
-/* PHY FSUSB: FS Serial for Port 1 (multiple PHY modes supported) */
-MUX_CFG_34XX("AF10_3430_USB1FS_PHY_MM1_RXDP", 0x5d8,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AG9_3430_USB1FS_PHY_MM1_RXDM", 0x5ee,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W13_3430_USB1FS_PHY_MM1_RXRCV", 0x5dc,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W12_3430_USB1FS_PHY_MM1_TXSE0", 0x5de,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W11_3430_USB1FS_PHY_MM1_TXDAT", 0x5e0,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("Y11_3430_USB1FS_PHY_MM1_TXEN_N", 0x5ea,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_OUTPUT)
-
-/* PHY FSUSB: FS Serial for Port 2 (multiple PHY modes supported) */
-MUX_CFG_34XX("AF7_3430_USB2FS_PHY_MM2_RXDP", 0x5f2,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AH7_3430_USB2FS_PHY_MM2_RXDM", 0x5f6,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB10_3430_USB2FS_PHY_MM2_RXRCV", 0x5f8,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AB9_3430_USB2FS_PHY_MM2_TXSE0", 0x5fa,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("W3_3430_USB2FS_PHY_MM2_TXDAT", 0x1d4,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("T4_3430_USB2FS_PHY_MM2_TXEN_N", 0x1de,
-		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_OUTPUT)
-
-/* PHY FSUSB: FS Serial for Port 3 (multiple PHY modes supported) */
-MUX_CFG_34XX("AH3_3430_USB3FS_PHY_MM3_RXDP", 0x166,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AE3_3430_USB3FS_PHY_MM3_RXDM", 0x16a,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AD1_3430_USB3FS_PHY_MM3_RXRCV", 0x186,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AE1_3430_USB3FS_PHY_MM3_TXSE0", 0x184,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AD2_3430_USB3FS_PHY_MM3_TXDAT", 0x188,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("AC1_3430_USB3FS_PHY_MM3_TXEN_N", 0x18a,
-		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
-
-
-/* 34XX GPIO - bidirectional, unless the name has an "_OUT" suffix.
- * (Always specify PIN_INPUT, except for names suffixed by "_OUT".)
- * No internal pullup/pulldown without "_UP" or "_DOWN" suffix.
- */
-MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("AG9_34XX_GPIO23", 0x5ee,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("U8_34XX_GPIO54_OUT", 0x0b4,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("U8_34XX_GPIO54_DOWN", 0x0b4,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLDOWN)
-MUX_CFG_34XX("L8_34XX_GPIO63", 0x0ce,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("G25_34XX_GPIO86_OUT", 0x0fc,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("AG4_34XX_GPIO134_OUT", 0x160,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("AF4_34XX_GPIO135_OUT", 0x162,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("AE4_34XX_GPIO136_OUT", 0x164,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
-
-/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
-MUX_CFG_34XX("H16_34XX_SDRC_CKE0", 0x262,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
-MUX_CFG_34XX("H17_34XX_SDRC_CKE1", 0x264,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
-
-/* MMC1 */
-MUX_CFG_34XX("N28_3430_MMC1_CLK", 0x144,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("M27_3430_MMC1_CMD", 0x146,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("N27_3430_MMC1_DAT0", 0x148,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("N26_3430_MMC1_DAT1", 0x14a,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("N25_3430_MMC1_DAT2", 0x14c,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("P28_3430_MMC1_DAT3", 0x14e,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("P27_3430_MMC1_DAT4", 0x150,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("P26_3430_MMC1_DAT5", 0x152,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("R27_3430_MMC1_DAT6", 0x154,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("R25_3430_MMC1_DAT7", 0x156,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-
-/* MMC2 */
-MUX_CFG_34XX("AE2_3430_MMC2_CLK", 0x158,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AG5_3430_MMC2_CMD", 0x15A,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AH5_3430_MMC2_DAT0", 0x15c,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AH4_3430_MMC2_DAT1", 0x15e,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AG4_3430_MMC2_DAT2", 0x160,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AF4_3430_MMC2_DAT3", 0x162,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AE4_3430_MMC2_DAT4", 0x164,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AH3_3430_MMC2_DAT5", 0x166,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AF3_3430_MMC2_DAT6", 0x168,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AE3_3430_MMC2_DAT7", 0x16A,
-		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
-
-/* MMC3 */
-MUX_CFG_34XX("AF10_3430_MMC3_CLK", 0x5d8,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AC3_3430_MMC3_CMD", 0x1d0,
-		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AE11_3430_MMC3_DAT0", 0x5e4,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AH9_3430_MMC3_DAT1", 0x5e6,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AF13_3430_MMC3_DAT2", 0x5e8,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
-		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
-
-/* SYS_NIRQ T2 INT1 */
-MUX_CFG_34XX("AF26_34XX_SYS_NIRQ", 0x1E0,
-		OMAP3_WAKEUP_EN | OMAP34XX_PIN_INPUT_PULLUP |
-		OMAP34XX_MUX_MODE0)
-/* EHCI GPIO's on OMAP3EVM (Rev >= E) */
-MUX_CFG_34XX("AH14_34XX_GPIO21", 0x5ea,
-	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("AF9_34XX_GPIO22", 0x5ec,
-	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
-MUX_CFG_34XX("U3_34XX_GPIO61", 0x0c8,
-	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
-};
-
-#define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
-
-#else
-#define omap34xx_pins		NULL
-#define OMAP34XX_PINS_SZ	0
-#endif	/* CONFIG_ARCH_OMAP34XX */
-
 #if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
+
 static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 reg)
 {
 	u16 orig;
@@ -631,7 +305,6 @@ static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 r
 #define omap2_cfg_debug(x, y)	do {} while (0)
 #endif
 
-#ifdef CONFIG_ARCH_OMAP24XX
 static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 {
 	static DEFINE_SPINLOCK(mux_spin_lock);
@@ -650,28 +323,6 @@ static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 
 	return 0;
 }
-#else
-#define omap24xx_cfg_reg	NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP34XX
-static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
-{
-	static DEFINE_SPINLOCK(mux_spin_lock);
-	unsigned long flags;
-	u16 reg = 0;
-
-	spin_lock_irqsave(&mux_spin_lock, flags);
-	reg |= cfg->mux_val;
-	omap2_cfg_debug(cfg, reg);
-	omap_mux_write(reg, cfg->mux_reg - OMAP_MUX_BASE_OFFSET);
-	spin_unlock_irqrestore(&mux_spin_lock, flags);
-
-	return 0;
-}
-#else
-#define omap34xx_cfg_reg	NULL
-#endif
 
 int __init omap2_mux_init(void)
 {
@@ -694,21 +345,23 @@ int __init omap2_mux_init(void)
 		arch_mux_cfg.pins	= omap24xx_pins;
 		arch_mux_cfg.size	= OMAP24XX_PINS_SZ;
 		arch_mux_cfg.cfg_reg	= omap24xx_cfg_reg;
-	} else if (cpu_is_omap34xx()) {
-		arch_mux_cfg.pins	= omap34xx_pins;
-		arch_mux_cfg.size	= OMAP34XX_PINS_SZ;
-		arch_mux_cfg.cfg_reg	= omap34xx_cfg_reg;
+
+		return omap_mux_register(&arch_mux_cfg);
 	}
 
-	return omap_mux_register(&arch_mux_cfg);
+	return 0;
 }
 
+#else
+int __init omap2_mux_init(void)
+{
+	return 0;
+}
 #endif	/* CONFIG_OMAP_MUX */
 
 /*----------------------------------------------------------------------------*/
 
 #ifdef CONFIG_ARCH_OMAP34XX
-
 static LIST_HEAD(muxmodes);
 static DEFINE_MUTEX(muxmode_mutex);
 
@@ -1353,3 +1006,4 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 }
 
 #endif	/* CONFIG_ARCH_OMAP34XX */
+
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index ba77de6..6067cf7 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -130,58 +130,11 @@
 #define OMAP2_PULL_UP		(1 << 4)
 #define OMAP2_ALTELECTRICALSEL	(1 << 5)
 
-/* 34xx specific mux bit defines */
-#define OMAP3_INPUT_EN		(1 << 8)
-#define OMAP3_OFF_EN		(1 << 9)
-#define OMAP3_OFFOUT_EN		(1 << 10)
-#define OMAP3_OFFOUT_VAL	(1 << 11)
-#define OMAP3_OFF_PULL_EN	(1 << 12)
-#define OMAP3_OFF_PULL_UP	(1 << 13)
-#define OMAP3_WAKEUP_EN		(1 << 14)
-
-/* 34xx mux mode options for each pin. See TRM for options */
-#define	OMAP34XX_MUX_MODE0	0
-#define	OMAP34XX_MUX_MODE1	1
-#define	OMAP34XX_MUX_MODE2	2
-#define	OMAP34XX_MUX_MODE3	3
-#define	OMAP34XX_MUX_MODE4	4
-#define	OMAP34XX_MUX_MODE5	5
-#define	OMAP34XX_MUX_MODE6	6
-#define	OMAP34XX_MUX_MODE7	7
-
-/* 34xx active pin states */
-#define OMAP34XX_PIN_OUTPUT		0
-#define OMAP34XX_PIN_INPUT		OMAP3_INPUT_EN
-#define OMAP34XX_PIN_INPUT_PULLUP	(OMAP2_PULL_ENA | OMAP3_INPUT_EN \
-						| OMAP2_PULL_UP)
-#define OMAP34XX_PIN_INPUT_PULLDOWN	(OMAP2_PULL_ENA | OMAP3_INPUT_EN)
-
-/* 34xx off mode states */
-#define OMAP34XX_PIN_OFF_NONE           0
-#define OMAP34XX_PIN_OFF_OUTPUT_HIGH	(OMAP3_OFF_EN | OMAP3_OFFOUT_EN \
-						| OMAP3_OFFOUT_VAL)
-#define OMAP34XX_PIN_OFF_OUTPUT_LOW	(OMAP3_OFF_EN | OMAP3_OFFOUT_EN)
-#define OMAP34XX_PIN_OFF_INPUT_PULLUP	(OMAP3_OFF_EN | OMAP3_OFF_PULL_EN \
-						| OMAP3_OFF_PULL_UP)
-#define OMAP34XX_PIN_OFF_INPUT_PULLDOWN	(OMAP3_OFF_EN | OMAP3_OFF_PULL_EN)
-#define OMAP34XX_PIN_OFF_WAKEUPENABLE	OMAP3_WAKEUP_EN
-
-#define MUX_CFG_34XX(desc, reg_offset, mux_value) {		\
-	.name		= desc,					\
-	.debug		= 0,					\
-	.mux_reg	= reg_offset,				\
-	.mux_val	= mux_value				\
-},
-
 struct pin_config {
 	char 			*name;
 	const unsigned int 	mux_reg;
 	unsigned char		debug;
 
-#if	defined(CONFIG_ARCH_OMAP34XX)
-	u16			mux_val; /* Wake-up, off mode, pull, mux mode */
-#endif
-
 #if	defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP24XX)
 	const unsigned char mask_offset;
 	const unsigned char mask;
@@ -681,181 +634,6 @@ enum omap24xx_index {
 
 };
 
-enum omap34xx_index {
-	/* 34xx I2C */
-	K21_34XX_I2C1_SCL,
-	J21_34XX_I2C1_SDA,
-	AF15_34XX_I2C2_SCL,
-	AE15_34XX_I2C2_SDA,
-	AF14_34XX_I2C3_SCL,
-	AG14_34XX_I2C3_SDA,
-	AD26_34XX_I2C4_SCL,
-	AE26_34XX_I2C4_SDA,
-
-	/* PHY - HSUSB: 12-pin ULPI PHY: Port 1*/
-	Y8_3430_USB1HS_PHY_CLK,
-	Y9_3430_USB1HS_PHY_STP,
-	AA14_3430_USB1HS_PHY_DIR,
-	AA11_3430_USB1HS_PHY_NXT,
-	W13_3430_USB1HS_PHY_DATA0,
-	W12_3430_USB1HS_PHY_DATA1,
-	W11_3430_USB1HS_PHY_DATA2,
-	Y11_3430_USB1HS_PHY_DATA3,
-	W9_3430_USB1HS_PHY_DATA4,
-	Y12_3430_USB1HS_PHY_DATA5,
-	W8_3430_USB1HS_PHY_DATA6,
-	Y13_3430_USB1HS_PHY_DATA7,
-
-	/* PHY - HSUSB: 12-pin ULPI PHY: Port 2*/
-	AA8_3430_USB2HS_PHY_CLK,
-	AA10_3430_USB2HS_PHY_STP,
-	AA9_3430_USB2HS_PHY_DIR,
-	AB11_3430_USB2HS_PHY_NXT,
-	AB10_3430_USB2HS_PHY_DATA0,
-	AB9_3430_USB2HS_PHY_DATA1,
-	W3_3430_USB2HS_PHY_DATA2,
-	T4_3430_USB2HS_PHY_DATA3,
-	T3_3430_USB2HS_PHY_DATA4,
-	R3_3430_USB2HS_PHY_DATA5,
-	R4_3430_USB2HS_PHY_DATA6,
-	T2_3430_USB2HS_PHY_DATA7,
-
-
-	/* TLL - HSUSB: 12-pin TLL Port 1*/
-	Y8_3430_USB1HS_TLL_CLK,
-	Y9_3430_USB1HS_TLL_STP,
-	AA14_3430_USB1HS_TLL_DIR,
-	AA11_3430_USB1HS_TLL_NXT,
-	W13_3430_USB1HS_TLL_DATA0,
-	W12_3430_USB1HS_TLL_DATA1,
-	W11_3430_USB1HS_TLL_DATA2,
-	Y11_3430_USB1HS_TLL_DATA3,
-	W9_3430_USB1HS_TLL_DATA4,
-	Y12_3430_USB1HS_TLL_DATA5,
-	W8_3430_USB1HS_TLL_DATA6,
-	Y13_3430_USB1HS_TLL_DATA7,
-
-	/* TLL - HSUSB: 12-pin TLL Port 2*/
-	AA8_3430_USB2HS_TLL_CLK,
-	AA10_3430_USB2HS_TLL_STP,
-	AA9_3430_USB2HS_TLL_DIR,
-	AB11_3430_USB2HS_TLL_NXT,
-	AB10_3430_USB2HS_TLL_DATA0,
-	AB9_3430_USB2HS_TLL_DATA1,
-	W3_3430_USB2HS_TLL_DATA2,
-	T4_3430_USB2HS_TLL_DATA3,
-	T3_3430_USB2HS_TLL_DATA4,
-	R3_3430_USB2HS_TLL_DATA5,
-	R4_3430_USB2HS_TLL_DATA6,
-	T2_3430_USB2HS_TLL_DATA7,
-
-	/* TLL - HSUSB: 12-pin TLL Port 3*/
-	AA6_3430_USB3HS_TLL_CLK,
-	AB3_3430_USB3HS_TLL_STP,
-	AA3_3430_USB3HS_TLL_DIR,
-	Y3_3430_USB3HS_TLL_NXT,
-	AA5_3430_USB3HS_TLL_DATA0,
-	Y4_3430_USB3HS_TLL_DATA1,
-	Y5_3430_USB3HS_TLL_DATA2,
-	W5_3430_USB3HS_TLL_DATA3,
-	AB12_3430_USB3HS_TLL_DATA4,
-	AB13_3430_USB3HS_TLL_DATA5,
-	AA13_3430_USB3HS_TLL_DATA6,
-	AA12_3430_USB3HS_TLL_DATA7,
-
-	/* PHY FSUSB: FS Serial for Port 1 (multiple PHY modes supported) */
-	AF10_3430_USB1FS_PHY_MM1_RXDP,
-	AG9_3430_USB1FS_PHY_MM1_RXDM,
-	W13_3430_USB1FS_PHY_MM1_RXRCV,
-	W12_3430_USB1FS_PHY_MM1_TXSE0,
-	W11_3430_USB1FS_PHY_MM1_TXDAT,
-	Y11_3430_USB1FS_PHY_MM1_TXEN_N,
-
-	/* PHY FSUSB: FS Serial for Port 2 (multiple PHY modes supported) */
-	AF7_3430_USB2FS_PHY_MM2_RXDP,
-	AH7_3430_USB2FS_PHY_MM2_RXDM,
-	AB10_3430_USB2FS_PHY_MM2_RXRCV,
-	AB9_3430_USB2FS_PHY_MM2_TXSE0,
-	W3_3430_USB2FS_PHY_MM2_TXDAT,
-	T4_3430_USB2FS_PHY_MM2_TXEN_N,
-
-	/* PHY FSUSB: FS Serial for Port 3 (multiple PHY modes supported) */
-	AH3_3430_USB3FS_PHY_MM3_RXDP,
-	AE3_3430_USB3FS_PHY_MM3_RXDM,
-	AD1_3430_USB3FS_PHY_MM3_RXRCV,
-	AE1_3430_USB3FS_PHY_MM3_TXSE0,
-	AD2_3430_USB3FS_PHY_MM3_TXDAT,
-	AC1_3430_USB3FS_PHY_MM3_TXEN_N,
-
-	/* 34xx GPIO
-	 *  - normally these are bidirectional, no internal pullup/pulldown
-	 *  - "_UP" suffix (GPIO3_UP) if internal pullup is configured
-	 *  - "_DOWN" suffix (GPIO3_DOWN) with internal pulldown
-	 *  - "_OUT" suffix (GPIO3_OUT) for output-only pins (unlike 24xx)
-	 */
-	AF26_34XX_GPIO0,
-	AF22_34XX_GPIO9,
-	AG9_34XX_GPIO23,
-	AH8_34XX_GPIO29,
-	U8_34XX_GPIO54_OUT,
-	U8_34XX_GPIO54_DOWN,
-	L8_34XX_GPIO63,
-	G25_34XX_GPIO86_OUT,
-	AG4_34XX_GPIO134_OUT,
-	AF4_34XX_GPIO135_OUT,
-	AE4_34XX_GPIO136_OUT,
-	AF6_34XX_GPIO140_UP,
-	AE6_34XX_GPIO141,
-	AF5_34XX_GPIO142,
-	AE5_34XX_GPIO143,
-	H19_34XX_GPIO164_OUT,
-	J25_34XX_GPIO170,
-
-	/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
-	H16_34XX_SDRC_CKE0,
-	H17_34XX_SDRC_CKE1,
-
-	/* MMC1 */
-	N28_3430_MMC1_CLK,
-	M27_3430_MMC1_CMD,
-	N27_3430_MMC1_DAT0,
-	N26_3430_MMC1_DAT1,
-	N25_3430_MMC1_DAT2,
-	P28_3430_MMC1_DAT3,
-	P27_3430_MMC1_DAT4,
-	P26_3430_MMC1_DAT5,
-	R27_3430_MMC1_DAT6,
-	R25_3430_MMC1_DAT7,
-
-	/* MMC2 */
-	AE2_3430_MMC2_CLK,
-	AG5_3430_MMC2_CMD,
-	AH5_3430_MMC2_DAT0,
-	AH4_3430_MMC2_DAT1,
-	AG4_3430_MMC2_DAT2,
-	AF4_3430_MMC2_DAT3,
-	AE4_3430_MMC2_DAT4,
-	AH3_3430_MMC2_DAT5,
-	AF3_3430_MMC2_DAT6,
-	AE3_3430_MMC2_DAT7,
-
-	/* MMC3 */
-	AF10_3430_MMC3_CLK,
-	AC3_3430_MMC3_CMD,
-	AE11_3430_MMC3_DAT0,
-	AH9_3430_MMC3_DAT1,
-	AF13_3430_MMC3_DAT2,
-	AF13_3430_MMC3_DAT3,
-
-	/* SYS_NIRQ T2 INT1 */
-	AF26_34XX_SYS_NIRQ,
-
-	/* EHCI GPIO's for OMAP3EVM (Rev >= E) */
-	AH14_34XX_GPIO21,
-	AF9_34XX_GPIO22,
-	U3_34XX_GPIO61,
-};
-
 struct omap_mux_cfg {
 	struct pin_config	*pins;
 	unsigned long		size;
@@ -865,14 +643,14 @@ struct omap_mux_cfg {
 #ifdef	CONFIG_OMAP_MUX
 /* setup pin muxing in Linux */
 extern int omap1_mux_init(void);
-extern int omap2_mux_init(void);
 extern int omap_mux_register(struct omap_mux_cfg *);
 extern int omap_cfg_reg(unsigned long reg_cfg);
 #else
 /* boot loader does it all (no warnings from CONFIG_OMAP_MUX_WARNINGS) */
 static inline int omap1_mux_init(void) { return 0; }
-static inline int omap2_mux_init(void) { return 0; }
 static inline int omap_cfg_reg(unsigned long reg_cfg) { return 0; }
 #endif
 
+extern int omap2_mux_init(void);
+
 #endif

