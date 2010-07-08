From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/13] omap: Overo: Fix support for second ethernet port
Date: Thu, 08 Jul 2010 16:54:38 +0300
Message-ID: <20100708135438.26276.12585.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55498 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858Ab0GHNym (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:54:42 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org

From: Steve Sakoman <sakoman@gmail.com>

The original patch got truncated when applied from patchwork.kernel.org
as discussed at:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28953.html

This patch supplies the missing chunks.

Signed-off-by: Steve Sakoman <sakoman@gmail.com>
[tony@atomide.com: added more info to the patch description]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-overo.c |   42 +++++++++++++++++++++++++++++++++++--
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 79ac414..4ceeb56 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -166,9 +166,26 @@ static struct platform_device overo_smsc911x_device = {
 	},
 };
 
+static struct platform_device overo_smsc911x2_device = {
+	.name		= "smsc911x",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(overo_smsc911x2_resources),
+	.resource	= overo_smsc911x2_resources,
+	.dev		= {
+		.platform_data = &overo_smsc911x_config,
+	},
+};
+
+static struct platform_device *smsc911x_devices[] = {
+	&overo_smsc911x_device,
+	&overo_smsc911x2_device,
+};
+
 static inline void __init overo_init_smsc911x(void)
 {
-	unsigned long cs_mem_base;
+	unsigned long cs_mem_base, cs_mem_base2;
+
+	/* set up first smsc911x chip */
 
 	if (gpmc_cs_request(OVERO_SMSC911X_CS, SZ_16M, &cs_mem_base) < 0) {
 		printk(KERN_ERR "Failed request for GPMC mem for smsc911x\n");
@@ -189,7 +206,28 @@ static inline void __init overo_init_smsc911x(void)
 	overo_smsc911x_resources[1].start = OMAP_GPIO_IRQ(OVERO_SMSC911X_GPIO);
 	overo_smsc911x_resources[1].end	  = 0;
 
-	platform_device_register(&overo_smsc911x_device);
+	/* set up second smsc911x chip */
+
+	if (gpmc_cs_request(OVERO_SMSC911X2_CS, SZ_16M, &cs_mem_base2) < 0) {
+		printk(KERN_ERR "Failed request for GPMC mem for smsc911x2\n");
+		return;
+	}
+
+	overo_smsc911x2_resources[0].start = cs_mem_base2 + 0x0;
+	overo_smsc911x2_resources[0].end   = cs_mem_base2 + 0xff;
+
+	if ((gpio_request(OVERO_SMSC911X2_GPIO, "SMSC911X2 IRQ") == 0) &&
+	    (gpio_direction_input(OVERO_SMSC911X2_GPIO) == 0)) {
+		gpio_export(OVERO_SMSC911X2_GPIO, 0);
+	} else {
+		printk(KERN_ERR "could not obtain gpio for SMSC911X2 IRQ\n");
+		return;
+	}
+
+	overo_smsc911x2_resources[1].start = OMAP_GPIO_IRQ(OVERO_SMSC911X2_GPIO);
+	overo_smsc911x2_resources[1].end   = 0;
+
+	platform_add_devices(smsc911x_devices, ARRAY_SIZE(smsc911x_devices));
 }
 
 #else

