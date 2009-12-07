From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 2/3] [OMAP] Add spi100k configuration to OMAP1
Date: Sun,  6 Dec 2009 20:48:18 -0800
Message-ID: <1260161299-17656-3-git-send-email-darkstar6262@gmail.com>
References: <1260161299-17656-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58904 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934510AbZLGEth (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Dec 2009 23:49:37 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so690286pwj.21
        for <linux-omap@vger.kernel.org>; Sun, 06 Dec 2009 20:49:44 -0800 (PST)
In-Reply-To: <1260161299-17656-1-git-send-email-darkstar6262@gmail.com>
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
 arch/arm/mach-omap1/clock.c               |    4 ++
 arch/arm/mach-omap1/devices.c             |   70 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap7xx.h |    3 +
 arch/arm/plat-omap/include/plat/spi100k.h |   15 ++++++
 4 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/spi100k.h

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
index 23ded2d..9f1c1cc 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -24,6 +24,12 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 
+#if defined(CONFIG_SPI_OMAP_100K)
+#include <plat/omap7xx.h>
+#include <plat/spi100k.h>
+#include <linux/spi/spi.h>
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_RTC_DRV_OMAP) || defined(CONFIG_RTC_DRV_OMAP_MODULE)
@@ -196,6 +202,69 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
 
 /*-------------------------------------------------------------------------*/
 
+/* OMAP7xx SPI support */
+#if defined(CONFIG_SPI_OMAP_100K)
+
+#include <plat/omap7xx.h>
+#include <plat/spi100k.h>
+#include <linux/spi/spi.h>
+
+static struct omap_spi100k_platform_config omap_spi1_config = {
+        .num_cs         = 2,
+};
+
+static struct resource omap_spi1_resources[] = {
+	{
+		.start          = OMAP7XX_SPI1_BASE,
+		.end            = OMAP7XX_SPI1_BASE + 0x7ff,
+		.flags          = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device omap_spi1 = {
+        .name           = "omap1_spi100k",
+        .id             = 1,
+        .num_resources  = ARRAY_SIZE(omap_spi1_resources),
+        .resource       = omap_spi1_resources,
+        .dev            = {
+                .platform_data = &omap_spi1_config,
+        },
+};
+
+static struct omap_spi100k_platform_config omap_spi2_config = {
+        .num_cs         = 2,
+};
+
+static struct resource omap_spi2_resources[] = {
+        {
+                .start          = OMAP7XX_SPI2_BASE,
+                .end            = OMAP7XX_SPI2_BASE + 0x7ff,
+                .flags          = IORESOURCE_MEM,
+        },
+};
+
+struct platform_device omap_spi2 = {
+        .name           = "omap1_spi100k",
+        .id             = 2,
+        .num_resources  = ARRAY_SIZE(omap_spi2_resources),
+        .resource       = omap_spi2_resources,
+        .dev            = {
+	        .platform_data = &omap_spi2_config,
+	},
+};
+
+static void omap_init_spi100k(void)
+{
+        platform_device_register(&omap_spi1);
+        platform_device_register(&omap_spi2);
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
@@ -263,6 +332,7 @@ static int __init omap1_init_devices(void)
 
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
diff --git a/arch/arm/plat-omap/include/plat/spi100k.h b/arch/arm/plat-omap/include/plat/spi100k.h
new file mode 100644
index 0000000..a4e877f
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/spi100k.h
@@ -0,0 +1,15 @@
+#ifndef _SPI100K_H
+#define _SPI100K_H
+
+struct omap_spi100k_platform_config {
+	unsigned short	num_cs;
+};
+
+struct omap_spi100k_device_config {
+	unsigned turbo_mode:1;
+
+	/* Do we want one channel enabled at the same time? */
+	unsigned single_channel:1;
+};
+#endif /* _SPI100K_H */
+
-- 
1.6.3.3

