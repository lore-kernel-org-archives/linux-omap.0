From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/9] omap: use smc91x_platdata to setup smc91x
Date: Tue, 08 Dec 2009 16:49:58 -0800
Message-ID: <20091209004958.5944.81769.stgit@localhost>
References: <20091209004630.5944.40334.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64075 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967007AbZLIAty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 19:49:54 -0500
In-Reply-To: <20091209004630.5944.40334.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>

From: Ladislav Michl <ladis@linux-mips.org>

Use smc91x_platdata to setup smc91x, so we can get rid of OMAP specific stuff
in smc91x driver

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-fsample.c   |   10 ++++++++++
 arch/arm/mach-omap1/board-h2.c        |   10 ++++++++++
 arch/arm/mach-omap1/board-h3.c        |   10 ++++++++++
 arch/arm/mach-omap1/board-innovator.c |   13 +++++++++++++
 arch/arm/mach-omap1/board-osk.c       |   10 ++++++++++
 arch/arm/mach-omap1/board-perseus2.c  |   10 ++++++++++
 arch/arm/mach-omap1/board-voiceblue.c |   10 ++++++++++
 arch/arm/mach-omap2/board-apollon.c   |   10 ++++++++++
 arch/arm/mach-omap2/gpmc-smc91x.c     |    8 +++++---
 arch/arm/plat-omap/debug-devices.c    |   10 ++++++++++
 10 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index f4b72c1..91e7b2f 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -19,6 +19,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
+#include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -100,6 +101,12 @@ static int fsample_keymap[] = {
 	0
 };
 
+static struct smc91x_platdata smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource smc91x_resources[] = {
 	[0] = {
 		.start	= H2P2_DBG_FPGA_ETHR_START,	/* Physical */
@@ -190,6 +197,9 @@ static struct platform_device nand_device = {
 static struct platform_device smc91x_device = {
 	.name		= "smc91x",
 	.id		= 0,
+	.dev	= {
+		.platform_data	= &smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(smc91x_resources),
 	.resource	= smc91x_resources,
 };
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 89ba8ec..eeafe6e 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -28,6 +28,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
 #include <linux/i2c/tps65010.h>
+#include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 #include <asm/gpio.h>
@@ -200,6 +201,12 @@ static struct platform_device h2_nand_device = {
 	.resource	= &h2_nand_resource,
 };
 
+static struct smc91x_platdata h2_smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource h2_smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP1610_ETHR_START,		/* Physical */
@@ -216,6 +223,9 @@ static struct resource h2_smc91x_resources[] = {
 static struct platform_device h2_smc91x_device = {
 	.name		= "smc91x",
 	.id		= 0,
+	.dev	= {
+		.platform_data	= &h2_smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(h2_smc91x_resources),
 	.resource	= h2_smc91x_resources,
 };
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index f5cc0a7..e0aee66 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -28,6 +28,7 @@
 #include <linux/input.h>
 #include <linux/spi/spi.h>
 #include <linux/i2c/tps65010.h>
+#include <linux/smc91x.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -202,6 +203,12 @@ static struct platform_device nand_device = {
 	.resource	= &nand_resource,
 };
 
+static struct smc91x_platdata smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP1710_ETHR_START,		/* Physical */
@@ -218,6 +225,9 @@ static struct resource smc91x_resources[] = {
 static struct platform_device smc91x_device = {
 	.name		= "smc91x",
 	.id		= 0,
+	.dev	= {
+		.platform_data	= &smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(smc91x_resources),
 	.resource	= smc91x_resources,
 };
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index cf0fdb9..91b3b8e 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -23,6 +23,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
+#include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -159,6 +160,12 @@ static struct map_desc innovator1510_io_desc[] __initdata = {
 	}
 };
 
+static struct smc91x_platdata innovator_smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource innovator1510_smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP1510_FPGA_ETHR_START,	/* Physical */
@@ -175,6 +182,9 @@ static struct resource innovator1510_smc91x_resources[] = {
 static struct platform_device innovator1510_smc91x_device = {
 	.name		= "smc91x",
 	.id		= 0,
+	.dev	= {
+		.platform_data	= &innovator_smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(innovator1510_smc91x_resources),
 	.resource	= innovator1510_smc91x_resources,
 };
@@ -241,6 +251,9 @@ static struct resource innovator1610_smc91x_resources[] = {
 static struct platform_device innovator1610_smc91x_device = {
 	.name		= "smc91x",
 	.id		= 0,
+	.dev	= {
+		.platform_data	= &innovator_smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(innovator1610_smc91x_resources),
 	.resource	= innovator1610_smc91x_resources,
 };
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 50c92c1..ccea4f4 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
+#include <linux/smc91x.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -115,6 +116,12 @@ static struct platform_device osk5912_flash_device = {
 	.resource	= &osk_flash_resource,
 };
 
+static struct smc91x_platdata osk5912_smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource osk5912_smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP_OSK_ETHR_START,		/* Physical */
@@ -131,6 +138,9 @@ static struct resource osk5912_smc91x_resources[] = {
 static struct platform_device osk5912_smc91x_device = {
 	.name		= "smc91x",
 	.id		= -1,
+	.dev	= {
+		.platform_data	= &osk5912_smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(osk5912_smc91x_resources),
 	.resource	= osk5912_smc91x_resources,
 };
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index ca7df1e..b9ea312 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -19,6 +19,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
+#include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -67,6 +68,12 @@ static int p2_keymap[] = {
 	0
 };
 
+static struct smc91x_platdata smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource smc91x_resources[] = {
 	[0] = {
 		.start	= H2P2_DBG_FPGA_ETHR_START,	/* Physical */
@@ -157,6 +164,9 @@ static struct platform_device nand_device = {
 static struct platform_device smc91x_device = {
 	.name		= "smc91x",
 	.id		= 0,
+	.dev	= {
+		.platform_data	= &smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(smc91x_resources),
 	.resource	= smc91x_resources,
 };
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 35c75c1..1691835 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -22,6 +22,7 @@
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -106,6 +107,12 @@ static struct platform_device voiceblue_flash_device = {
 	.resource	= &voiceblue_flash_resource,
 };
 
+static struct smc91x_platdata voiceblue_smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource voiceblue_smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP_CS2_PHYS + 0x300,
@@ -122,6 +129,9 @@ static struct resource voiceblue_smc91x_resources[] = {
 static struct platform_device voiceblue_smc91x_device = {
 	.name		= "smc91x",
 	.id		= 0,
+	.dev	= {
+		.platform_data	= &voiceblue_smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(voiceblue_smc91x_resources),
 	.resource	= voiceblue_smc91x_resources,
 };
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 8a2ce77..fbbd68d 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -26,6 +26,7 @@
 #include <linux/leds.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -120,6 +121,12 @@ static void __init apollon_flash_init(void)
 	apollon_flash_resource[0].end   = base + SZ_128K - 1;
 }
 
+static struct smc91x_platdata appolon_smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource apollon_smc91x_resources[] = {
 	[0] = {
 		.flags  = IORESOURCE_MEM,
@@ -134,6 +141,9 @@ static struct resource apollon_smc91x_resources[] = {
 static struct platform_device apollon_smc91x_device = {
 	.name		= "smc91x",
 	.id		= -1,
+	.dev	= {
+		.platform_data	= &appolon_smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(apollon_smc91x_resources),
 	.resource	= apollon_smc91x_resources,
 };
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index 6083e21..877c6f5 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -33,17 +33,19 @@ static struct resource gpmc_smc91x_resources[] = {
 };
 
 static struct smc91x_platdata gpmc_smc91x_info = {
-	.flags  = SMC91X_USE_16BIT | SMC91X_NOWAIT | SMC91X_IO_SHIFT_0,
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT | SMC91X_IO_SHIFT_0,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
 };
 
 static struct platform_device gpmc_smc91x_device = {
 	.name		= "smc91x",
 	.id		= -1,
-	.num_resources	= ARRAY_SIZE(gpmc_smc91x_resources),
-	.resource	= gpmc_smc91x_resources,
 	.dev		= {
 		.platform_data = &gpmc_smc91x_info,
 	},
+	.num_resources	= ARRAY_SIZE(gpmc_smc91x_resources),
+	.resource	= gpmc_smc91x_resources,
 };
 
 /*
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index 09c1107..923c962 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/smc91x.h>
 
 #include <mach/hardware.h>
 
@@ -24,6 +25,12 @@
  * platforms include H2, H3, H4, and Perseus2.
  */
 
+static struct smc91x_platdata smc91x_info = {
+	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource smc91x_resources[] = {
 	[0] = {
 		.flags  = IORESOURCE_MEM,
@@ -36,6 +43,9 @@ static struct resource smc91x_resources[] = {
 static struct platform_device smc91x_device = {
 	.name		= "smc91x",
 	.id		= -1,
+	.dev		= {
+		.platform_data = &smc91x_info,
+	},
 	.num_resources	= ARRAY_SIZE(smc91x_resources),
 	.resource	= smc91x_resources,
 };

