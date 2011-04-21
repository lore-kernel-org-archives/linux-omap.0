From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 1/2] arm: omap: fix bug with multiple smsc911x devices
Date: Thu, 21 Apr 2011 17:50:11 +0300
Message-ID: <1303397412-24813-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:54595
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754184Ab1DUOuj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 10:50:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, Tim Nordell <tim.nordell@logicpd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

kobject (c06a4250): tried to init an initialized object, something is
seriously wrong.

introduced by commit 66293989:
(omap: convert boards that use SMSC911x to use gpmc-smsc911x)

fixed by allocating struct platform_device dynamically.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
This has been boot tested with nfs root on cm-t35,
and build tested on all other affected boards.

 arch/arm/mach-omap2/board-cm-t35.c              |    2 ++
 arch/arm/mach-omap2/board-igep0020.c            |    1 +
 arch/arm/mach-omap2/board-ldp.c                 |    1 +
 arch/arm/mach-omap2/board-omap3evm.c            |    1 +
 arch/arm/mach-omap2/board-omap3logic.c          |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c        |    1 +
 arch/arm/mach-omap2/board-overo.c               |    2 ++
 arch/arm/mach-omap2/board-zoom-debugboard.c     |    1 +
 arch/arm/mach-omap2/gpmc-smsc911x.c             |   16 +++++-----------
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |    1 +
 10 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index b5772c1..7c70f56 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -69,6 +69,7 @@
 #include <plat/gpmc-smsc911x.h>
 
 static struct omap_smsc911x_platform_data cm_t35_smsc911x_cfg = {
+	.id		= 0,
 	.cs             = CM_T35_SMSC911X_CS,
 	.gpio_irq       = CM_T35_SMSC911X_GPIO,
 	.gpio_reset     = -EINVAL,
@@ -76,6 +77,7 @@ static struct omap_smsc911x_platform_data cm_t35_smsc911x_cfg = {
 };
 
 static struct omap_smsc911x_platform_data sb_t35_smsc911x_cfg = {
+	.id		= 1,
 	.cs             = SB_T35_SMSC911X_CS,
 	.gpio_irq       = SB_T35_SMSC911X_GPIO,
 	.gpio_reset     = -EINVAL,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5b9bde7..2bf12fb 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -195,6 +195,7 @@ static void __init igep2_flash_init(void) {}
 #include <plat/gpmc-smsc911x.h>
 
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
+	.id		= -1,
 	.cs             = IGEP2_SMSC911X_CS,
 	.gpio_irq       = IGEP2_SMSC911X_GPIO,
 	.gpio_reset     = -EINVAL,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ea9f049..94cfd82 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -218,6 +218,7 @@ static struct spi_board_info ldp_spi_board_info[] __initdata = {
 };
 
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
+	.id		= -1,
 	.cs             = LDP_SMSC911X_CS,
 	.gpio_irq       = LDP_SMSC911X_GPIO,
 	.gpio_reset     = -EINVAL,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3fc85c6..fc5c1d8 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -104,6 +104,7 @@ static void __init omap3_evm_get_revision(void)
 #include <plat/gpmc-smsc911x.h>
 
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
+	.id		= -1,
 	.cs             = OMAP3EVM_SMSC911X_CS,
 	.gpio_irq       = OMAP3EVM_ETHR_GPIO_IRQ,
 	.gpio_reset     = -EINVAL,
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index a49e6cf..06248e7 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -144,6 +144,7 @@ static void __init board_mmc_init(void)
 }
 
 static struct omap_smsc911x_platform_data __initdata board_smsc911x_data = {
+	.id		= -1,
 	.cs             = OMAP3LOGIC_SMSC911X_CS,
 	.gpio_irq       = -EINVAL,
 	.gpio_reset     = -EINVAL,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 848016c..ae4eaf5 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -64,6 +64,7 @@
 #define OMAP3STALKER_SMC911X_CS	5
 
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
+	.id		= -1,
 	.cs             = OMAP3STALKER_SMC911X_CS,
 	.gpio_irq       = OMAP3STALKER_ETHR_GPIO_IRQ,
 	.gpio_reset     = -EINVAL,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4016166..165e1fa 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -149,6 +149,7 @@ static inline void __init overo_ads7846_init(void) { return; }
 #include <plat/gpmc-smsc911x.h>
 
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
+	.id		= 0,
 	.cs             = OVERO_SMSC911X_CS,
 	.gpio_irq       = OVERO_SMSC911X_GPIO,
 	.gpio_reset     = -EINVAL,
@@ -156,6 +157,7 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
 };
 
 static struct omap_smsc911x_platform_data smsc911x2_cfg = {
+	.id		= 1,
 	.cs             = OVERO_SMSC911X2_CS,
 	.gpio_irq       = OVERO_SMSC911X2_GPIO,
 	.gpio_reset     = -EINVAL,
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 2ee9ab9..d6f6e93 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -28,6 +28,7 @@
 #define ZOOM_ETHR_START	DEBUG_BASE
 
 static struct omap_smsc911x_platform_data zoom_smsc911x_cfg = {
+	.id		= -1,
 	.cs             = ZOOM_SMSC911X_CS,
 	.gpio_irq       = ZOOM_SMSC911X_GPIO,
 	.gpio_reset     = -EINVAL,
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index b331f3c..d30293a 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -41,16 +41,6 @@ static struct smsc911x_platform_config gpmc_smsc911x_config = {
 	.flags		= SMSC911X_USE_16BIT,
 };
 
-static struct platform_device gpmc_smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(gpmc_smsc911x_resources),
-	.resource	= gpmc_smsc911x_resources,
-	.dev		= {
-		.platform_data = &gpmc_smsc911x_config,
-	},
-};
-
 /*
  * Initialize smsc911x device connected to the GPMC. Note that we
  * assume that pin multiplexing is done in the board-*.c file,
@@ -58,6 +48,7 @@ static struct platform_device gpmc_smsc911x_device = {
  */
 void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 {
+	struct platform_device *pdev;
 	unsigned long cs_mem_base;
 	int ret;
 
@@ -97,7 +88,10 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 	if (gpmc_cfg->flags)
 		gpmc_smsc911x_config.flags = gpmc_cfg->flags;
 
-	if (platform_device_register(&gpmc_smsc911x_device) < 0) {
+	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
+		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
+		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));
+	if (!pdev) {
 		printk(KERN_ERR "Unable to register smsc911x device\n");
 		gpio_free(gpmc_cfg->gpio_reset);
 		goto free2;
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
index 872de0bf..d3f1579 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
@@ -14,6 +14,7 @@
 #ifndef __ASM_ARCH_OMAP_GPMC_SMSC911X_H__
 
 struct omap_smsc911x_platform_data {
+	int	id;
 	int	cs;
 	int	gpio_irq;
 	int	gpio_reset;
-- 
1.7.3.4

