From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] arm: omap: fix bug with multiple smsc911x
 devices
Date: Tue, 3 May 2011 00:37:45 -0700
Message-ID: <20110503073745.GI2092@atomide.com>
References: <BANLkTi=PtDVewo-g-oZJw5=AG5TqvFBf0w@mail.gmail.com>
 <1303633675-18589-1-git-send-email-grinberg@compulab.co.il>
 <4DBFA040.9060305@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:34206 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750837Ab1ECHhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 03:37:50 -0400
Content-Disposition: inline
In-Reply-To: <4DBFA040.9060305@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Mike Rapoport <mike@compulab.co.il>, Tim Nordell <tim.nordell@logicpd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [110502 23:23]:
> 
> > kobject (c06a4250): tried to init an initialized object, something is
> > seriously wrong.
> >
> > introduced by commit 66293989:
> > (omap: convert boards that use SMSC911x to use gpmc-smsc911x)
> >
> > fixed by allocating struct platform_device dynamically.

Thanks, I'll merge this into Mike's original patch in
devel-cleanup branch for the next merge window.

Updated patch below.

Regards,

Tony


From: Mike Rapoport <mike@compulab.co.il>
Date: Sat, 16 Apr 2011 22:29:30 +0000
Subject: [PATCH] omap: convert boards that use SMSC911x to use gpmc-smsc911x

Convert boards that use SMSC911x to use gpmc-smsc911x.
Also allocate struct platform_device dynamically.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
[tony@atomide.com: folded in a fix from Igor Grindberg]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 02a12b4..7c70f56 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -66,86 +66,28 @@
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <linux/smsc911x.h>
+#include <plat/gpmc-smsc911x.h>
 
-static struct smsc911x_platform_config cm_t35_smsc911x_config = {
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-};
-
-static struct resource cm_t35_smsc911x_resources[] = {
-	{
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= OMAP_GPIO_IRQ(CM_T35_SMSC911X_GPIO),
-		.end	= OMAP_GPIO_IRQ(CM_T35_SMSC911X_GPIO),
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct platform_device cm_t35_smsc911x_device = {
-	.name		= "smsc911x",
+static struct omap_smsc911x_platform_data cm_t35_smsc911x_cfg = {
 	.id		= 0,
-	.num_resources	= ARRAY_SIZE(cm_t35_smsc911x_resources),
-	.resource	= cm_t35_smsc911x_resources,
-	.dev		= {
-		.platform_data = &cm_t35_smsc911x_config,
-	},
-};
-
-static struct resource sb_t35_smsc911x_resources[] = {
-	{
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= OMAP_GPIO_IRQ(SB_T35_SMSC911X_GPIO),
-		.end	= OMAP_GPIO_IRQ(SB_T35_SMSC911X_GPIO),
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
+	.cs             = CM_T35_SMSC911X_CS,
+	.gpio_irq       = CM_T35_SMSC911X_GPIO,
+	.gpio_reset     = -EINVAL,
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
 };
 
-static struct platform_device sb_t35_smsc911x_device = {
-	.name		= "smsc911x",
+static struct omap_smsc911x_platform_data sb_t35_smsc911x_cfg = {
 	.id		= 1,
-	.num_resources	= ARRAY_SIZE(sb_t35_smsc911x_resources),
-	.resource	= sb_t35_smsc911x_resources,
-	.dev		= {
-		.platform_data = &cm_t35_smsc911x_config,
-	},
+	.cs             = SB_T35_SMSC911X_CS,
+	.gpio_irq       = SB_T35_SMSC911X_GPIO,
+	.gpio_reset     = -EINVAL,
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
 };
 
-static void __init cm_t35_init_smsc911x(struct platform_device *dev,
-					int cs, int irq_gpio)
-{
-	unsigned long cs_mem_base;
-
-	if (gpmc_cs_request(cs, SZ_16M, &cs_mem_base) < 0) {
-		pr_err("CM-T35: Failed request for GPMC mem for smsc911x\n");
-		return;
-	}
-
-	dev->resource[0].start = cs_mem_base + 0x0;
-	dev->resource[0].end   = cs_mem_base + 0xff;
-
-	if ((gpio_request(irq_gpio, "ETH IRQ") == 0) &&
-	    (gpio_direction_input(irq_gpio) == 0)) {
-		gpio_export(irq_gpio, 0);
-	} else {
-		pr_err("CM-T35: could not obtain gpio for SMSC911X IRQ\n");
-		return;
-	}
-
-	platform_device_register(dev);
-}
-
 static void __init cm_t35_init_ethernet(void)
 {
-	cm_t35_init_smsc911x(&cm_t35_smsc911x_device,
-			     CM_T35_SMSC911X_CS, CM_T35_SMSC911X_GPIO);
-	cm_t35_init_smsc911x(&sb_t35_smsc911x_device,
-			     SB_T35_SMSC911X_CS, SB_T35_SMSC911X_GPIO);
+	gpmc_smsc911x_init(&cm_t35_smsc911x_cfg);
+	gpmc_smsc911x_init(&sb_t35_smsc911x_cfg);
 }
 #else
 static inline void __init cm_t35_init_ethernet(void) { return; }
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 34cf982..5b9bde7 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -192,57 +192,18 @@ static void __init igep2_flash_init(void) {}
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
 #include <linux/smsc911x.h>
+#include <plat/gpmc-smsc911x.h>
 
-static struct smsc911x_platform_config igep2_smsc911x_config = {
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS  ,
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-};
-
-static struct resource igep2_smsc911x_resources[] = {
-	{
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= OMAP_GPIO_IRQ(IGEP2_SMSC911X_GPIO),
-		.end	= OMAP_GPIO_IRQ(IGEP2_SMSC911X_GPIO),
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct platform_device igep2_smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(igep2_smsc911x_resources),
-	.resource	= igep2_smsc911x_resources,
-	.dev		= {
-		.platform_data = &igep2_smsc911x_config,
-	},
+static struct omap_smsc911x_platform_data smsc911x_cfg = {
+	.cs             = IGEP2_SMSC911X_CS,
+	.gpio_irq       = IGEP2_SMSC911X_GPIO,
+	.gpio_reset     = -EINVAL,
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
 };
 
 static inline void __init igep2_init_smsc911x(void)
 {
-	unsigned long cs_mem_base;
-
-	if (gpmc_cs_request(IGEP2_SMSC911X_CS, SZ_16M, &cs_mem_base) < 0) {
-		pr_err("IGEP v2: Failed request for GPMC mem for smsc911x\n");
-		gpmc_cs_free(IGEP2_SMSC911X_CS);
-		return;
-	}
-
-	igep2_smsc911x_resources[0].start = cs_mem_base + 0x0;
-	igep2_smsc911x_resources[0].end   = cs_mem_base + 0xff;
-
-	if ((gpio_request(IGEP2_SMSC911X_GPIO, "SMSC911X IRQ") == 0) &&
-	    (gpio_direction_input(IGEP2_SMSC911X_GPIO) == 0)) {
-		gpio_export(IGEP2_SMSC911X_GPIO, 0);
-	} else {
-		pr_err("IGEP v2: Could not obtain gpio for for SMSC911X IRQ\n");
-		return;
-	}
-
-	platform_device_register(&igep2_smsc911x_device);
+	gpmc_smsc911x_init(&smsc911x_cfg);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index e2ba779..ea9f049 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -43,6 +43,7 @@
 
 #include <asm/delay.h>
 #include <plat/usb.h>
+#include <plat/gpmc-smsc911x.h>
 
 #include "board-flash.h"
 #include "mux.h"
@@ -54,36 +55,6 @@
 #define DEBUG_BASE		0x08000000
 #define LDP_ETHR_START		DEBUG_BASE
 
-static struct resource ldp_smsc911x_resources[] = {
-	[0] = {
-		.start	= LDP_ETHR_START,
-		.end	= LDP_ETHR_START + SZ_4K,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= 0,
-		.end	= 0,
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct smsc911x_platform_config ldp_smsc911x_config = {
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-	.flags		= SMSC911X_USE_32BIT,
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-};
-
-static struct platform_device ldp_smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(ldp_smsc911x_resources),
-	.resource	= ldp_smsc911x_resources,
-	.dev		= {
-		.platform_data = &ldp_smsc911x_config,
-	},
-};
-
 static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_1),
 	KEY(1, 0, KEY_2),
@@ -246,33 +217,16 @@ static struct spi_board_info ldp_spi_board_info[] __initdata = {
 	},
 };
 
+static struct omap_smsc911x_platform_data smsc911x_cfg = {
+	.cs             = LDP_SMSC911X_CS,
+	.gpio_irq       = LDP_SMSC911X_GPIO,
+	.gpio_reset     = -EINVAL,
+	.flags		= SMSC911X_USE_32BIT,
+};
+
 static inline void __init ldp_init_smsc911x(void)
 {
-	int eth_cs;
-	unsigned long cs_mem_base;
-	int eth_gpio = 0;
-
-	eth_cs = LDP_SMSC911X_CS;
-
-	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smsc911x\n");
-		return;
-	}
-
-	ldp_smsc911x_resources[0].start = cs_mem_base + 0x0;
-	ldp_smsc911x_resources[0].end   = cs_mem_base + 0xff;
-	udelay(100);
-
-	eth_gpio = LDP_SMSC911X_GPIO;
-
-	ldp_smsc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
-
-	if (gpio_request(eth_gpio, "smsc911x irq") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
-				eth_gpio);
-		return;
-	}
-	gpio_direction_input(eth_gpio);
+	gpmc_smsc911x_init(&smsc911x_cfg);
 }
 
 static struct platform_device ldp_lcd_device = {
@@ -389,7 +343,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 };
 
 static struct platform_device *ldp_devices[] __initdata = {
-	&ldp_smsc911x_device,
 	&ldp_lcd_device,
 	&ldp_gpio_keys_device,
 };
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5a1a916..3fc85c6 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -101,49 +101,20 @@ static void __init omap3_evm_get_revision(void)
 }
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
-static struct resource omap3evm_smsc911x_resources[] = {
-	[0] =	{
-		.start	= OMAP3EVM_ETHR_START,
-		.end	= (OMAP3EVM_ETHR_START + OMAP3EVM_ETHR_SIZE - 1),
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] =	{
-		.start	= OMAP_GPIO_IRQ(OMAP3EVM_ETHR_GPIO_IRQ),
-		.end	= OMAP_GPIO_IRQ(OMAP3EVM_ETHR_GPIO_IRQ),
-		.flags	= (IORESOURCE_IRQ | IRQF_TRIGGER_LOW),
-	},
-};
+#include <plat/gpmc-smsc911x.h>
 
-static struct smsc911x_platform_config smsc911x_config = {
-	.phy_interface  = PHY_INTERFACE_MODE_MII,
-	.irq_polarity   = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type       = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-	.flags          = (SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS),
-};
-
-static struct platform_device omap3evm_smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(omap3evm_smsc911x_resources),
-	.resource	= &omap3evm_smsc911x_resources[0],
-	.dev		= {
-		.platform_data = &smsc911x_config,
-	},
+static struct omap_smsc911x_platform_data smsc911x_cfg = {
+	.cs             = OMAP3EVM_SMSC911X_CS,
+	.gpio_irq       = OMAP3EVM_ETHR_GPIO_IRQ,
+	.gpio_reset     = -EINVAL,
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
 };
 
 static inline void __init omap3evm_init_smsc911x(void)
 {
-	int eth_cs, eth_rst;
 	struct clk *l3ck;
 	unsigned int rate;
 
-	if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
-		eth_rst = OMAP3EVM_GEN1_ETHR_GPIO_RST;
-	else
-		eth_rst = OMAP3EVM_GEN2_ETHR_GPIO_RST;
-
-	eth_cs = OMAP3EVM_SMSC911X_CS;
-
 	l3ck = clk_get(NULL, "l3_ck");
 	if (IS_ERR(l3ck))
 		rate = 100000000;
@@ -152,33 +123,13 @@ static inline void __init omap3evm_init_smsc911x(void)
 
 	/* Configure ethernet controller reset gpio */
 	if (cpu_is_omap3430()) {
-		if (gpio_request(eth_rst, "SMSC911x gpio") < 0) {
-			pr_err(KERN_ERR "Failed to request %d for smsc911x\n",
-					eth_rst);
-			return;
-		}
-
-		if (gpio_direction_output(eth_rst, 1) < 0) {
-			pr_err(KERN_ERR "Failed to set direction of %d for" \
-					" smsc911x\n", eth_rst);
-			return;
-		}
-		/* reset pulse to ethernet controller*/
-		usleep_range(150, 220);
-		gpio_set_value(eth_rst, 0);
-		usleep_range(150, 220);
-		gpio_set_value(eth_rst, 1);
-		usleep_range(1, 2);
-	}
-
-	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x irq") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
-			OMAP3EVM_ETHR_GPIO_IRQ);
-		return;
+		if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
+			smsc911x_cfg.gpio_reset = OMAP3EVM_GEN1_ETHR_GPIO_RST;
+		else
+			smsc911x_cfg.gpio_reset = OMAP3EVM_GEN2_ETHR_GPIO_RST;
 	}
 
-	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
-	platform_device_register(&omap3evm_smsc911x_device);
+	gpmc_smsc911x_init(&smsc911x_cfg);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index a6e0b91..848016c 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -56,50 +56,25 @@
 #include "timer-gp.h"
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
+#include <plat/gpmc-smsc911x.h>
+
 #define OMAP3STALKER_ETHR_START	0x2c000000
 #define OMAP3STALKER_ETHR_SIZE	1024
 #define OMAP3STALKER_ETHR_GPIO_IRQ	19
 #define OMAP3STALKER_SMC911X_CS	5
 
-static struct resource omap3stalker_smsc911x_resources[] = {
-	[0] = {
-	       .start	= OMAP3STALKER_ETHR_START,
-	       .end	=
-	       (OMAP3STALKER_ETHR_START + OMAP3STALKER_ETHR_SIZE - 1),
-	       .flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-	       .start	= OMAP_GPIO_IRQ(OMAP3STALKER_ETHR_GPIO_IRQ),
-	       .end	= OMAP_GPIO_IRQ(OMAP3STALKER_ETHR_GPIO_IRQ),
-	       .flags	= (IORESOURCE_IRQ | IRQF_TRIGGER_LOW),
-	},
-};
-
-static struct smsc911x_platform_config smsc911x_config = {
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+static struct omap_smsc911x_platform_data smsc911x_cfg = {
+	.cs             = OMAP3STALKER_SMC911X_CS,
+	.gpio_irq       = OMAP3STALKER_ETHR_GPIO_IRQ,
+	.gpio_reset     = -EINVAL,
 	.flags		= (SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS),
 };
 
-static struct platform_device omap3stalker_smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(omap3stalker_smsc911x_resources),
-	.resource	= &omap3stalker_smsc911x_resources[0],
-	.dev		= {
-		.platform_data	= &smsc911x_config,
-	},
-};
-
 static inline void __init omap3stalker_init_eth(void)
 {
-	int eth_cs;
 	struct clk *l3ck;
 	unsigned int rate;
 
-	eth_cs = OMAP3STALKER_SMC911X_CS;
-
 	l3ck = clk_get(NULL, "l3_ck");
 	if (IS_ERR(l3ck))
 		rate = 100000000;
@@ -107,16 +82,7 @@ static inline void __init omap3stalker_init_eth(void)
 		rate = clk_get_rate(l3ck);
 
 	omap_mux_init_gpio(19, OMAP_PIN_INPUT_PULLUP);
-	if (gpio_request(OMAP3STALKER_ETHR_GPIO_IRQ, "SMC911x irq") < 0) {
-		printk(KERN_ERR
-		       "Failed to request GPIO%d for smc911x IRQ\n",
-		       OMAP3STALKER_ETHR_GPIO_IRQ);
-		return;
-	}
-
-	gpio_direction_input(OMAP3STALKER_ETHR_GPIO_IRQ);
-
-	platform_device_register(&omap3stalker_smsc911x_device);
+	gpmc_smsc911x_init(&smsc911x_cfg);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 59ca333..165e1fa 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -146,106 +146,28 @@ static inline void __init overo_ads7846_init(void) { return; }
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
 #include <linux/smsc911x.h>
+#include <plat/gpmc-smsc911x.h>
 
-static struct resource overo_smsc911x_resources[] = {
-	{
-		.name	= "smsc911x-memory",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct resource overo_smsc911x2_resources[] = {
-	{
-		.name	= "smsc911x2-memory",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct smsc911x_platform_config overo_smsc911x_config = {
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-	.flags		= SMSC911X_USE_32BIT ,
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-};
-
-static struct platform_device overo_smsc911x_device = {
-	.name		= "smsc911x",
+static struct omap_smsc911x_platform_data smsc911x_cfg = {
 	.id		= 0,
-	.num_resources	= ARRAY_SIZE(overo_smsc911x_resources),
-	.resource	= overo_smsc911x_resources,
-	.dev		= {
-		.platform_data = &overo_smsc911x_config,
-	},
+	.cs             = OVERO_SMSC911X_CS,
+	.gpio_irq       = OVERO_SMSC911X_GPIO,
+	.gpio_reset     = -EINVAL,
+	.flags		= SMSC911X_USE_32BIT,
 };
 
-static struct platform_device overo_smsc911x2_device = {
-	.name		= "smsc911x",
+static struct omap_smsc911x_platform_data smsc911x2_cfg = {
 	.id		= 1,
-	.num_resources	= ARRAY_SIZE(overo_smsc911x2_resources),
-	.resource	= overo_smsc911x2_resources,
-	.dev		= {
-		.platform_data = &overo_smsc911x_config,
-	},
-};
-
-static struct platform_device *smsc911x_devices[] = {
-	&overo_smsc911x_device,
-	&overo_smsc911x2_device,
+	.cs             = OVERO_SMSC911X2_CS,
+	.gpio_irq       = OVERO_SMSC911X2_GPIO,
+	.gpio_reset     = -EINVAL,
+	.flags		= SMSC911X_USE_32BIT,
 };
 
-static inline void __init overo_init_smsc911x(void)
+static void __init overo_init_smsc911x(void)
 {
-	unsigned long cs_mem_base, cs_mem_base2;
-
-	/* set up first smsc911x chip */
-
-	if (gpmc_cs_request(OVERO_SMSC911X_CS, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed request for GPMC mem for smsc911x\n");
-		return;
-	}
-
-	overo_smsc911x_resources[0].start = cs_mem_base + 0x0;
-	overo_smsc911x_resources[0].end   = cs_mem_base + 0xff;
-
-	if ((gpio_request(OVERO_SMSC911X_GPIO, "SMSC911X IRQ") == 0) &&
-	    (gpio_direction_input(OVERO_SMSC911X_GPIO) == 0)) {
-		gpio_export(OVERO_SMSC911X_GPIO, 0);
-	} else {
-		printk(KERN_ERR "could not obtain gpio for SMSC911X IRQ\n");
-		return;
-	}
-
-	overo_smsc911x_resources[1].start = OMAP_GPIO_IRQ(OVERO_SMSC911X_GPIO);
-	overo_smsc911x_resources[1].end	  = 0;
-
-	/* set up second smsc911x chip */
-
-	if (gpmc_cs_request(OVERO_SMSC911X2_CS, SZ_16M, &cs_mem_base2) < 0) {
-		printk(KERN_ERR "Failed request for GPMC mem for smsc911x2\n");
-		return;
-	}
-
-	overo_smsc911x2_resources[0].start = cs_mem_base2 + 0x0;
-	overo_smsc911x2_resources[0].end   = cs_mem_base2 + 0xff;
-
-	if ((gpio_request(OVERO_SMSC911X2_GPIO, "SMSC911X2 IRQ") == 0) &&
-	    (gpio_direction_input(OVERO_SMSC911X2_GPIO) == 0)) {
-		gpio_export(OVERO_SMSC911X2_GPIO, 0);
-	} else {
-		printk(KERN_ERR "could not obtain gpio for SMSC911X2 IRQ\n");
-		return;
-	}
-
-	overo_smsc911x2_resources[1].start = OMAP_GPIO_IRQ(OVERO_SMSC911X2_GPIO);
-	overo_smsc911x2_resources[1].end   = 0;
-
-	platform_add_devices(smsc911x_devices, ARRAY_SIZE(smsc911x_devices));
+	gpmc_smsc911x_init(&smsc911x_cfg);
+	gpmc_smsc911x_init(&smsc911x2_cfg);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 007ebdc..2ee9ab9 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 
 #include <plat/gpmc.h>
+#include <plat/gpmc-smsc911x.h>
 
 #include <mach/board-zoom.h>
 
@@ -26,60 +27,16 @@
 #define DEBUG_BASE		0x08000000
 #define ZOOM_ETHR_START	DEBUG_BASE
 
-static struct resource zoom_smsc911x_resources[] = {
-	[0] = {
-		.start	= ZOOM_ETHR_START,
-		.end	= ZOOM_ETHR_START + SZ_4K,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct smsc911x_platform_config zoom_smsc911x_config = {
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+static struct omap_smsc911x_platform_data zoom_smsc911x_cfg = {
+	.cs             = ZOOM_SMSC911X_CS,
+	.gpio_irq       = ZOOM_SMSC911X_GPIO,
+	.gpio_reset     = -EINVAL,
 	.flags		= SMSC911X_USE_32BIT,
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-};
-
-static struct platform_device zoom_smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(zoom_smsc911x_resources),
-	.resource	= zoom_smsc911x_resources,
-	.dev		= {
-		.platform_data = &zoom_smsc911x_config,
-	},
 };
 
 static inline void __init zoom_init_smsc911x(void)
 {
-	int eth_cs;
-	unsigned long cs_mem_base;
-	int eth_gpio = 0;
-
-	eth_cs = ZOOM_SMSC911X_CS;
-
-	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smsc911x\n");
-		return;
-	}
-
-	zoom_smsc911x_resources[0].start = cs_mem_base + 0x0;
-	zoom_smsc911x_resources[0].end   = cs_mem_base + 0xff;
-
-	eth_gpio = ZOOM_SMSC911X_GPIO;
-
-	zoom_smsc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
-
-	if (gpio_request(eth_gpio, "smsc911x irq") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
-				eth_gpio);
-		return;
-	}
-	gpio_direction_input(eth_gpio);
+	gpmc_smsc911x_init(&zoom_smsc911x_cfg);
 }
 
 static struct plat_serial8250_port serial_platform_data[] = {
@@ -150,7 +107,6 @@ static inline int omap_zoom_debugboard_detect(void)
 }
 
 static struct platform_device *zoom_devices[] __initdata = {
-	&zoom_smsc911x_device,
 	&zoom_debugboard_serial_device,
 };
 
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
index 872de0b..d3f1579 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
@@ -14,6 +14,7 @@
 #ifndef __ASM_ARCH_OMAP_GPMC_SMSC911X_H__
 
 struct omap_smsc911x_platform_data {
+	int	id;
 	int	cs;
 	int	gpio_irq;
 	int	gpio_reset;
