From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH v2 2/3] [OMAP] Add spi100k configuration to OMAP1
Date: Sat, 12 Dec 2009 17:34:47 -0800
Message-ID: <1260668088-27555-3-git-send-email-darkstar6262@gmail.com>
References: <1260668088-27555-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:49729 "HELO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933487AbZLMBfe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Dec 2009 20:35:34 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so1530960pzk.33
        for <linux-omap@vger.kernel.org>; Sat, 12 Dec 2009 17:35:34 -0800 (PST)
In-Reply-To: <1260668088-27555-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change implements the clocks, platform driver, and register
information necessary to use the spi100k bus with OMAP 7xx systems.

The clocks added are dummy clocks because, although we're pretty
sure there are clocks used for SPI, all current booting methods result
in proper operation without the enabling of any other clocks.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/clock.c               |    4 +++
 arch/arm/mach-omap1/devices.c             |   34 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap7xx.h |    3 ++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index dc8ca91..e584c0f 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -135,6 +135,10 @@ static struct omap_clk omap_clks[] = {
 	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK("i2c_omap.1", "ick",	&i2c_ick,	CK_16XX),
 	CLK("i2c_omap.1", "ick",	&dummy_ck,	CK_1510 | CK_310 | CK_7XX),
+	CLK("omap1_spi100k.1", "fck",	&dummy_ck,	CK_7XX),
+	CLK("omap1_spi100k.1", "ick",	&dummy_ck,	CK_7XX),
+	CLK("omap1_spi100k.2", "fck",	&dummy_ck,	CK_7XX),
+	CLK("omap1_spi100k.2", "ick",	&dummy_ck,	CK_7XX),
 	CLK("omap_uwire", "fck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK("omap-mcbsp.1", "ick",	&dspper_ck,	CK_16XX),
 	CLK("omap-mcbsp.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 23ded2d..20bc62c 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/spi/spi.h>
 
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
@@ -23,6 +24,7 @@
 #include <plat/mux.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
+#include <plat/omap7xx.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -196,6 +198,37 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 
 /*-------------------------------------------------------------------------*/
 
+/* OMAP7xx SPI support */
+#if defined(CONFIG_SPI_OMAP_100K) || defined(CONFIG_SPI_OMAP_100K_MODULE)
+
+struct platform_device omap_spi1 = {
+	.name           = "omap1_spi100k",
+	.id             = 1,
+};
+
+struct platform_device omap_spi2 = {
+	.name           = "omap1_spi100k",
+	.id             = 2,
+};
+
+static void omap_init_spi100k(void)
+{
+	omap_spi1.dev.platform_data = ioremap(OMAP7XX_SPI1_BASE, 0x7ff);
+	BUG_ON(!omap_spi1.dev.platform_data);
+
+	omap_spi2.dev.platform_data = ioremap(OMAP7XX_SPI2_BASE, 0x7ff);
+	BUG_ON(!omap_spi2.dev.platform_data);
+
+	platform_device_register(&omap_spi1);
+	platform_device_register(&omap_spi2);
+}
+
+#else
+static inline void omap_init_spi100k(void) {}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #if defined(CONFIG_OMAP_STI)
 
 #define OMAP1_STI_BASE		0xfffea000
@@ -263,6 +296,7 @@ static int __init omap1_init_devices(void)
 
 	omap_init_mbox();
 	omap_init_rtc();
+	omap_init_spi100k();
 	omap_init_sti();
 
 	return 0;
diff --git a/arch/arm/plat-omap/include/plat/omap7xx.h b/arch/arm/plat-omap/include/plat/omap7xx.h
index 53f5241..48e4757 100644
--- a/arch/arm/plat-omap/include/plat/omap7xx.h
+++ b/arch/arm/plat-omap/include/plat/omap7xx.h
@@ -46,6 +46,9 @@
 #define OMAP7XX_DSPREG_SIZE	SZ_128K
 #define OMAP7XX_DSPREG_START	0xE1000000
 
+#define OMAP7XX_SPI1_BASE	0xfffc0800
+#define OMAP7XX_SPI2_BASE	0xfffc1000
+
 /*
  * ----------------------------------------------------------------------------
  * OMAP7XX specific configuration registers
-- 
1.6.3.3

