From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [OMAP] I2C mux and clocks for omap7xx
Date: Sat,  5 Dec 2009 23:09:06 -0800
Message-ID: <1260083346-12838-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:55225 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbZLFHJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Dec 2009 02:09:16 -0500
Received: by pwj9 with SMTP id 9so358825pwj.21
        for <linux-omap@vger.kernel.org>; Sat, 05 Dec 2009 23:09:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change adds MUX pin configuration and clocks for I2C support
to OMAP 730 and 850-based devices.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/clock.c           |    4 ++--
 arch/arm/mach-omap1/i2c.c             |   10 ++++++++--
 arch/arm/mach-omap1/mux.c             |    4 ++++
 arch/arm/plat-omap/include/plat/mux.h |    4 ++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 42cbe20..dc8ca91 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -132,9 +132,9 @@ static struct omap_clk omap_clks[] = {
 	CLK("mmci-omap.1", "ick",	&armper_ck.clk,	CK_16XX),
 	/* Virtual clocks */
 	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
-	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
+	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK("i2c_omap.1", "ick",	&i2c_ick,	CK_16XX),
-	CLK("i2c_omap.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
+	CLK("i2c_omap.1", "ick",	&dummy_ck,	CK_1510 | CK_310 | CK_7XX),
 	CLK("omap_uwire", "fck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK("omap-mcbsp.1", "ick",	&dspper_ck,	CK_16XX),
 	CLK("omap-mcbsp.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index bc9d12b..1bf4735 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -21,13 +21,19 @@
 
 #include <plat/i2c.h>
 #include <plat/mux.h>
+#include <plat/cpu.h>
 
 int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			  struct i2c_board_info const *info,
 			  unsigned len)
 {
-	omap_cfg_reg(I2C_SDA);
-	omap_cfg_reg(I2C_SCL);
+	if (cpu_is_omap7xx()) {
+		omap_cfg_reg(I2C_7XX_SDA);
+		omap_cfg_reg(I2C_7XX_SCL);
+	} else {
+		omap_cfg_reg(I2C_SDA);
+		omap_cfg_reg(I2C_SCL);
+	}
 
 	return omap_plat_register_i2c_bus(bus_id, clkrate, info, len);
 }
diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 5e183cd..07212cc 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -58,6 +58,10 @@ MUX_CFG_7XX("W19_7XX_USB_DCRST",   3,    7,    1,    6,   0, 0)
 MUX_CFG_7XX("MMC_7XX_CMD",         2,    9,    0,    8,   1, 0)
 MUX_CFG_7XX("MMC_7XX_CLK",         2,   13,    0,   12,   1, 0)
 MUX_CFG_7XX("MMC_7XX_DAT0",        2,   17,    0,   16,   1, 0)
+
+/* I2C interface */
+MUX_CFG_7XX("I2C_7XX_SCL",         5,    1,    0,    0,   1, 0)
+MUX_CFG_7XX("I2C_7XX_SDA",         5,    5,    0,    0,   1, 0)
 };
 #define OMAP7XX_PINS_SZ		ARRAY_SIZE(omap7xx_pins)
 #else
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index 8ed5f25..8f069cc 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -179,6 +179,10 @@ enum omap7xx_index {
 	MMC_7XX_CMD,
 	MMC_7XX_CLK,
 	MMC_7XX_DAT0,
+
+	/* I2C */
+	I2C_7XX_SCL,
+	I2C_7XX_SDA,
 };
 
 enum omap1xxx_index {
-- 
1.6.3.3

