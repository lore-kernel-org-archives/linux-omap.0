From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP3: Add SMSC911X support to Overo platform (V2)
Date: Fri, 13 Mar 2009 15:44:53 -0700
Message-ID: <20090313224453.8810.41743.stgit@localhost>
References: <20090313224259.8810.3283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63206 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbZCMWow (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 18:44:52 -0400
In-Reply-To: <20090313224259.8810.3283.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

From: Steve Sakoman <sakoman@gmail.com>

Gumstix will soon be shipping a variant of their Summit board that
includes an SMSC LAN9221 ethernet interface.  This patch provides
support via the smsc911x driver when enabled in kernel config.

The Overo defconfig is not updated since the LAN9221 is an option
not present on all systems.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-overo.c |   65 +++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d785aa8..fbe1ce0 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -52,6 +52,70 @@
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
 
+#define OVERO_SMSC911X_CS	5
+#define OVERO_SMSC911X_GPIO	176
+
+#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
+
+#include <linux/smsc911x.h>
+
+static struct resource overo_smsc911x_resources[] = {
+	{
+		.name	= "smsc911x-memory",
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
+	},
+};
+
+static struct smsc911x_platform_config overo_smsc911x_config = {
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+	.flags		= SMSC911X_USE_32BIT ,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+};
+
+static struct platform_device overo_smsc911x_device = {
+	.name		= "smsc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(overo_smsc911x_resources),
+	.resource	= &overo_smsc911x_resources,
+	.dev		= {
+		.platform_data = &overo_smsc911x_config,
+	},
+};
+
+static inline void __init overo_init_smsc911x(void)
+{
+	unsigned long cs_mem_base;
+
+	if (gpmc_cs_request(OVERO_SMSC911X_CS, SZ_16M, &cs_mem_base) < 0) {
+		printk(KERN_ERR "Failed request for GPMC mem for smsc911x\n");
+		return;
+	}
+
+	overo_smsc911x_resources[0].start = cs_mem_base + 0x0;
+	overo_smsc911x_resources[0].end   = cs_mem_base + 0xff;
+
+	if ((gpio_request(OVERO_SMSC911X_GPIO, "SMSC911X IRQ") == 0) &&
+	    (gpio_direction_input(OVERO_SMSC911X_GPIO) == 0)) {
+		gpio_export(OVERO_SMSC911X_GPIO, 0);
+	} else {
+		printk(KERN_ERR "could not obtain gpio for SMSC911X IRQ\n");
+		return;
+	}
+
+	overo_smsc911x_resources[1].start = OMAP_GPIO_IRQ(OVERO_SMSC911X_GPIO);
+	overo_smsc911x_resources[1].end	  = 0;
+
+	platform_device_register(&overo_smsc911x_device);
+}
+
+#else
+static inline void __init overo_init_smsc911x(void) { return; }
+#endif
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -225,6 +289,7 @@ static void __init overo_init(void)
 	twl4030_mmc_init(mmc);
 	overo_flash_init();
 	usb_musb_init();
+	overo_init_smsc911x();
 
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&

