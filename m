From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/9] omap1: I2C mux and clocks for omap7xx
Date: Tue, 08 Dec 2009 16:51:09 -0800
Message-ID: <20091209005109.5944.68875.stgit@localhost>
References: <20091209004630.5944.40334.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53072 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967013AbZLIAvE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 19:51:04 -0500
In-Reply-To: <20091209004630.5944.40334.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

From: Cory Maccarrone <darkstar6262@gmail.com>

This change adds MUX pin configuration and clocks for I2C support
to OMAP 730 and 850-based devices.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

