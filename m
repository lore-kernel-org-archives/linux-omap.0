From: "Arun KS" <getarunks@gmail.com>
Subject: [Resend] [PATCH 1/3] OMAP2EVM: add ethernet support (smc911x)
Date: Tue, 24 Jun 2008 20:36:59 +0530
Message-ID: <dfeb90390806240806t59a4feb2vbaafc75961bc9827@mail.gmail.com>
References: <dfeb90390806240504t3a900901t8879c3fc07aebb0f@mail.gmail.com>
	 <0d8b982e9147570fe343aff404e7a1c6@felipebalbi.com>
	 <dfeb90390806240554v549cf987h20c68685d3082f2b@mail.gmail.com>
	 <4c2f926971f553819251f824d239ca85@felipebalbi.com>
	 <dfeb90390806240625y7c1309fal44dce5ce3f7f62c1@mail.gmail.com>
	 <48e8658f507de35e2fab060ca2a9db43@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:27861 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbYFXPHC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 11:07:02 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1353523tic.23
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 08:07:00 -0700 (PDT)
In-Reply-To: <48e8658f507de35e2fab060ca2a9db43@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

OMAP2EVM: Add ethernet support (smc911x)

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap2evm.c       |   41 ++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/board-omap2evm.h |    5 ++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index d00e502..0048775 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -27,11 +27,47 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>

+static struct resource omap2evm_smc911x_resources[] = {
+       [0] =   {
+               .start  = OMAP2EVM_ETHR_START,
+               .end    = (OMAP2EVM_ETHR_START + OMAP2EVM_ETHR_SIZE - 1),
+               .flags  = IORESOURCE_MEM,
+       },
+       [1] =   {
+               .start  = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
+               .end    = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
+               .flags  = IORESOURCE_IRQ,
+       },
+};
+
+static struct platform_device omap2evm_smc911x_device = {
+       .name       = "smc911x",
+       .id     = -1,
+       .num_resources  = ARRAY_SIZE(omap2evm_smc911x_resources),
+       .resource   = &omap2evm_smc911x_resources [0],
+};
+
+static inline void __init omap2evm_init_smc911x(void)
+{
+       int gpio = OMAP2EVM_ETHR_GPIO_IRQ;
+       int ret;
+
+       ret = gpio_request(gpio, "smc911x IRQ");
+       if (ret < 0) {
+               printk(KERN_ERR "Failed to request GPIO %d for smc911x IRQ\n",
+               gpio);
+               return;
+       }
+       gpio_direction_input(gpio);
+
+}
+
 static void __init omap2_evm_init_irq(void)
 {
        omap2_init_common_hw();
        omap_init_irq();
        omap_gpio_init();
+       omap2evm_init_smc911x();
 }

 static struct omap_uart_config omap2_evm_uart_config __initdata = {
@@ -53,8 +89,13 @@ static int __init omap2_evm_i2c_init(void)
        return 0;
 }

+static struct platform_device *omap2_evm_devices[] __initdata = {
+    &omap2evm_smc911x_device,
+};
+
 static void __init omap2_evm_init(void)
 {
+       platform_add_devices(omap2_evm_devices, ARRAY_SIZE(omap2_evm_devices));
        omap_board_config = omap2_evm_config;
        omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
        omap_serial_init();
diff --git a/include/asm-arm/arch-omap/board-omap2evm.h
b/include/asm-arm/arch-omap/board-omap2evm.h
index 98273a9..d770c58 100644
--- a/include/asm-arm/arch-omap/board-omap2evm.h
+++ b/include/asm-arm/arch-omap/board-omap2evm.h
@@ -30,7 +30,8 @@
 #define __ASM_ARCH_OMAP2_EVM_H

 /* Placeholder for OMAP2EVM specific defines */
-#define OMAP24XX_ETHR_START            0x08000300
-#define OMAP24XX_ETHR_GPIO_IRQ         149
+#define OMAP2EVM_ETHR_START                    0x2c000000
+#define OMAP2EVM_ETHR_SIZE                     1024
+#define OMAP2EVM_ETHR_GPIO_IRQ         149

 #endif /* __ASM_ARCH_OMAP2_EVM_H */
--
1.5.3.4
