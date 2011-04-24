From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2 1/2] arm: omap: fix bug with multiple smsc911x devices
Date: Sun, 24 Apr 2011 11:27:55 +0300
Message-ID: <1303633675-18589-1-git-send-email-grinberg@compulab.co.il>
References: <BANLkTi=PtDVewo-g-oZJw5=AG5TqvFBf0w@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:50853
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755644Ab1DXI2C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 24 Apr 2011 04:28:02 -0400
In-Reply-To: <BANLkTi=PtDVewo-g-oZJw5=AG5TqvFBf0w@mail.gmail.com>
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

v2:	keep the id field uninitialized (0) on boards with
	only one smsc911x controller (thanks Mike)


 arch/arm/mach-omap2/board-cm-t35.c              |    2 ++
 arch/arm/mach-omap2/board-overo.c               |    2 ++
 arch/arm/mach-omap2/gpmc-smsc911x.c             |   16 +++++-----------
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |    1 +
 4 files changed, 10 insertions(+), 11 deletions(-)

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

