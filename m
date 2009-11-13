From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH] omap3evm: MIgrate to smsc911x ethernet driver.
Date: Fri, 13 Nov 2009 15:17:54 +0530
Message-ID: <1258105674-1322-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43720 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346AbZKMJry (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 04:47:54 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAD9lvYY014907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 03:47:59 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>

Migrate to smsc911x ethernet driver instead of smc911x driver.
The smsc911x ethernet driver supports NAPI and performs better
under heavy traffic. With the smc911x driver we were witnessing
very high iowait time for high IO load over NFS.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
This patch has been refreshed against the tip of for-next branch.
Tested by reverting commit 20dec08ce892df224 as it was breaking
compilation otherwise.

 arch/arm/configs/omap3_evm_defconfig |    4 +-
 arch/arm/mach-omap2/board-omap3evm.c |   43 +++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index da69732..e190fc8 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -617,8 +617,8 @@ CONFIG_MII=y
 # CONFIG_DM9000 is not set
 # CONFIG_ENC28J60 is not set
 # CONFIG_ETHOC is not set
-CONFIG_SMC911X=y
-# CONFIG_SMSC911X is not set
+# CONFIG_SMC911X is not set
+CONFIG_SMSC911X=y
 # CONFIG_DNET is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index be93142..e8a7617 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -22,11 +22,13 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/leds.h>
+#include <linux/interrupt.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/usb/otg.h>
+#include <linux/smsc911x.h>
 
 #include <linux/regulator/machine.h>
 
@@ -52,7 +54,7 @@
 #define OMAP3EVM_ETHR_SIZE	1024
 #define OMAP3EVM_ETHR_ID_REV	0x50
 #define OMAP3EVM_ETHR_GPIO_IRQ	176
-#define OMAP3EVM_SMC911X_CS	5
+#define OMAP3EVM_SMSC911X_CS	5
 
 static u8 omap3_evm_version;
 
@@ -84,7 +86,8 @@ static void __init omap3_evm_get_revision(void)
 	}
 }
 
-static struct resource omap3evm_smc911x_resources[] = {
+#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
+static struct resource omap3evm_smsc911x_resources[] = {
 	[0] =	{
 		.start	= OMAP3EVM_ETHR_START,
 		.end	= (OMAP3EVM_ETHR_START + OMAP3EVM_ETHR_SIZE - 1),
@@ -93,24 +96,34 @@ static struct resource omap3evm_smc911x_resources[] = {
 	[1] =	{
 		.start	= OMAP_GPIO_IRQ(OMAP3EVM_ETHR_GPIO_IRQ),
 		.end	= OMAP_GPIO_IRQ(OMAP3EVM_ETHR_GPIO_IRQ),
-		.flags	= IORESOURCE_IRQ,
+		.flags	= (IORESOURCE_IRQ | IRQF_TRIGGER_LOW),
 	},
 };
 
-static struct platform_device omap3evm_smc911x_device = {
-	.name		= "smc911x",
+static struct smsc911x_platform_config smsc911x_config = {
+	.phy_interface  = PHY_INTERFACE_MODE_MII,
+	.irq_polarity   = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type       = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+	.flags          = (SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS),
+};
+
+static struct platform_device omap3evm_smsc911x_device = {
+	.name		= "smsc911x",
 	.id		= -1,
-	.num_resources	= ARRAY_SIZE(omap3evm_smc911x_resources),
-	.resource	= &omap3evm_smc911x_resources[0],
+	.num_resources	= ARRAY_SIZE(omap3evm_smsc911x_resources),
+	.resource	= &omap3evm_smsc911x_resources[0],
+	.dev		= {
+		.platform_data = &smsc911x_config,
+	},
 };
 
-static inline void __init omap3evm_init_smc911x(void)
+static inline void __init omap3evm_init_smsc911x(void)
 {
 	int eth_cs;
 	struct clk *l3ck;
 	unsigned int rate;
 
-	eth_cs = OMAP3EVM_SMC911X_CS;
+	eth_cs = OMAP3EVM_SMSC911X_CS;
 
 	l3ck = clk_get(NULL, "l3_ck");
 	if (IS_ERR(l3ck))
@@ -118,15 +131,20 @@ static inline void __init omap3evm_init_smc911x(void)
 	else
 		rate = clk_get_rate(l3ck);
 
-	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMC911x irq") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
+	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x irq") < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
 			OMAP3EVM_ETHR_GPIO_IRQ);
 		return;
 	}
 
 	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
+	platform_device_register(&omap3evm_smsc911x_device);
 }
 
+#else
+static inline void __init omap3evm_init_smsc911x(void) { return; }
+#endif
+
 static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -368,12 +386,10 @@ static void __init omap3_evm_init_irq(void)
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
-	omap3evm_init_smc911x();
 }
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_lcd_device,
-	&omap3evm_smc911x_device,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
@@ -430,6 +446,7 @@ static void __init omap3_evm_init(void)
 	usb_musb_init();
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
+	omap3evm_init_smsc911x();
 }
 
 static void __init omap3_evm_map_io(void)
-- 
1.6.2.4

