From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/14] ARM: OMAP2+: Remove legacy twl4030 platform init code
Date: Fri, 11 Nov 2016 11:17:01 -0800
Message-ID: <20161111191711.5079-5-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This code is no longer used and can be removed as we
are using device tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile               |  2 +-
 arch/arm/mach-omap2/common-board-devices.h |  1 -
 arch/arm/mach-omap2/twl-common.c           | 81 ------------------------------
 arch/arm/mach-omap2/twl-common.h           | 42 ----------------
 4 files changed, 1 insertion(+), 125 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/twl-common.c
 delete mode 100644 arch/arm/mach-omap2/twl-common.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -257,4 +257,4 @@ obj-y					+= $(nand-m) $(nand-y)
 smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
 obj-y					+= $(smsc911x-m) $(smsc911x-y)
 
-obj-y					+= common-board-devices.o twl-common.o dss-common.o
+obj-y					+= common-board-devices.o dss-common.o
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -3,7 +3,6 @@
 
 #include <sound/tlv320aic3x.h>
 #include <linux/mfd/menelaus.h>
-#include "twl-common.h"
 
 #define NAND_BLOCK_SIZE	SZ_128K
 
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
deleted file mode 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * twl-common.c
- *
- * Copyright (C) 2011 Texas Instruments, Inc..
- * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/i2c.h>
-#include <linux/i2c/twl.h>
-#include <linux/gpio.h>
-#include <linux/string.h>
-#include <linux/phy/phy.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/fixed.h>
-
-#include "soc.h"
-#include "twl-common.h"
-#include "pm.h"
-#include "voltage.h"
-#include "mux.h"
-
-static struct i2c_board_info __initdata pmic_i2c_board_info = {
-	.addr		= 0x48,
-	.flags		= I2C_CLIENT_WAKE,
-};
-
-void __init omap_pmic_late_init(void)
-{
-	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
-	if (!pmic_i2c_board_info.irq)
-		return;
-
-	omap3_twl_init();
-	omap4_twl_init();
-}
-
-#if IS_ENABLED(CONFIG_SND_OMAP_SOC_OMAP_TWL4030)
-#include <linux/platform_data/omap-twl4030.h>
-
-/* Commonly used configuration */
-static struct omap_tw4030_pdata omap_twl4030_audio_data;
-
-static struct platform_device audio_device = {
-	.name		= "omap-twl4030",
-	.id		= -1,
-};
-
-void omap_twl4030_audio_init(char *card_name,
-				    struct omap_tw4030_pdata *pdata)
-{
-	if (!pdata)
-		pdata = &omap_twl4030_audio_data;
-
-	pdata->card_name = card_name;
-
-	audio_device.dev.platform_data = pdata;
-	platform_device_register(&audio_device);
-}
-
-#else /* SOC_OMAP_TWL4030 */
-void omap_twl4030_audio_init(char *card_name,
-				    struct omap_tw4030_pdata *pdata)
-{
-	return;
-}
-#endif /* SOC_OMAP_TWL4030 */
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
deleted file mode 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ /dev/null
@@ -1,42 +0,0 @@
-#ifndef __OMAP_PMIC_COMMON__
-#define __OMAP_PMIC_COMMON__
-
-#include "common.h"
-
-#define TWL_COMMON_PDATA_USB		(1 << 0)
-#define TWL_COMMON_PDATA_BCI		(1 << 1)
-#define TWL_COMMON_PDATA_MADC		(1 << 2)
-#define TWL_COMMON_PDATA_AUDIO		(1 << 3)
-
-/* Common LDO regulators for TWL4030/TWL6030 */
-#define TWL_COMMON_REGULATOR_VDAC	(1 << 0)
-#define TWL_COMMON_REGULATOR_VAUX1	(1 << 1)
-#define TWL_COMMON_REGULATOR_VAUX2	(1 << 2)
-#define TWL_COMMON_REGULATOR_VAUX3	(1 << 3)
-
-/* TWL6030 LDO regulators */
-#define TWL_COMMON_REGULATOR_VMMC	(1 << 4)
-#define TWL_COMMON_REGULATOR_VPP	(1 << 5)
-#define TWL_COMMON_REGULATOR_VUSIM	(1 << 6)
-#define TWL_COMMON_REGULATOR_VANA	(1 << 7)
-#define TWL_COMMON_REGULATOR_VCXIO	(1 << 8)
-#define TWL_COMMON_REGULATOR_VUSB	(1 << 9)
-#define TWL_COMMON_REGULATOR_CLK32KG	(1 << 10)
-#define TWL_COMMON_REGULATOR_V1V8	(1 << 11)
-#define TWL_COMMON_REGULATOR_V2V1	(1 << 12)
-
-/* TWL4030 LDO regulators */
-#define TWL_COMMON_REGULATOR_VPLL1	(1 << 4)
-#define TWL_COMMON_REGULATOR_VPLL2	(1 << 5)
-
-
-struct twl4030_platform_data;
-struct twl6040_platform_data;
-struct omap_tw4030_pdata;
-struct i2c_board_info;
-
-void omap_pmic_late_init(void);
-
-void omap_twl4030_audio_init(char *card_name, struct omap_tw4030_pdata *pdata);
-
-#endif /* __OMAP_PMIC_COMMON__ */
-- 
2.10.2
