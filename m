From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 14/18 FIX] omap: Overo: Add support for second ethernet
	port
Date: Fri, 21 May 2010 13:15:58 -0700
Message-ID: <AANLkTin8FdLGx1UOwFrbxHwjkwK3DgeC95YbpniSR_HN@mail.gmail.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
	 <20100505193315.21568.55530.stgit@baageli.muru.com>
	 <AANLkTinxHaxG89pUhD7nmMjQSF-p-FB1FWj_w-de9y1r@mail.gmail.com>
	 <20100519182727.GG5818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57408 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab0EUUQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 16:16:00 -0400
Received: by vws9 with SMTP id 9so1217969vws.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 13:15:58 -0700 (PDT)
In-Reply-To: <20100519182727.GG5818@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Previous patch was truncated by patchwork, this patch supplies the
missing chunks

Signed-off-by: Steve Sakoman <sakoman@gmail.com>
---

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 24b32d7..035eb35 100644
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
