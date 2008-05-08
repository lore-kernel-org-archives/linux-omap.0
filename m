From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [RFC/PATCH 2/3] OMAP3 EVM: enable ethernet support
Date: Thu, 8 May 2008 09:48:51 -0700
Message-ID: <5e088bd90805080948u7599f122sf87e0ad129c41fd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:35779 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763881AbYEHQsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 12:48:53 -0400
Received: by fk-out-0910.google.com with SMTP id 18so870119fkq.5
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2008 09:48:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Steve Sakoman <steve@sakoman.com>

OMAP3 EVM: add ethernet support (smc911x)

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-omap3evm.c       |   45 ++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/board-omap3evm.h |    6 ++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c
b/arch/arm/mach-omap2/board-omap3evm.c
index 825da19..d8109ae 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -35,6 +35,49 @@
 #include <asm/arch/common.h>
 #include <asm/arch/mcspi.h>

+static struct resource omap3evm_smc911x_resources[] = {
+	[0] =	{
+		.start  = OMAP3EVM_ETHR_START,
+		.end    = (OMAP3EVM_ETHR_START + OMAP3EVM_ETHR_SIZE - 1),
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] =	{
+		.start  = OMAP_GPIO_IRQ(OMAP3EVM_ETHR_GPIO_IRQ),
+		.end    = OMAP_GPIO_IRQ(OMAP3EVM_ETHR_GPIO_IRQ),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap3evm_smc911x_device = {
+	.name		= "smc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(omap3evm_smc911x_resources),
+	.resource	= &omap3evm_smc911x_resources [0],
+};
+
+static inline void __init omap3evm_init_smc911x(void)
+{
+	int eth_cs;
+	struct clk *l3ck;
+	unsigned int rate;
+
+	eth_cs = OMAP3EVM_SMC911X_CS;
+
+	l3ck = clk_get(NULL, "l3_ck");
+	if (IS_ERR(l3ck))
+		rate = 100000000;
+	else
+		rate = clk_get_rate(l3ck);
+
+	if (omap_request_gpio(OMAP3EVM_ETHR_GPIO_IRQ) < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
+			OMAP3EVM_ETHR_GPIO_IRQ);
+		return;
+	}
+
+	omap_set_gpio_direction(OMAP3EVM_ETHR_GPIO_IRQ, 1);
+}
+
 static struct omap_uart_config omap3_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -111,6 +154,7 @@ static void __init omap3_evm_init_irq(void)
 	omap2_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
+	omap3evm_init_smc911x();
 }

 static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
@@ -124,6 +168,7 @@ static struct platform_device *omap3_evm_devices[]
__initdata = {
 #ifdef CONFIG_RTC_DRV_TWL4030
 	&omap3_evm_twl4030rtc_device,
 #endif
+	&omap3evm_smc911x_device,
 };

 static void __init omap3_evm_init(void)
diff --git a/include/asm-arm/arch-omap/board-omap3evm.h
b/include/asm-arm/arch-omap/board-omap3evm.h
index 67188c3..784d7f2 100644
--- a/include/asm-arm/arch-omap/board-omap3evm.h
+++ b/include/asm-arm/arch-omap/board-omap3evm.h
@@ -32,7 +32,13 @@
 extern void omap3evm_flash_init(void);

 #define OMAP3_EVM_TS_GPIO	175
+
 #define ONENAND_MAP		0x20000000

+#define OMAP3EVM_ETHR_START	0x2c000000
+#define OMAP3EVM_ETHR_SIZE	1024
+#define OMAP3EVM_ETHR_GPIO_IRQ	176
+#define OMAP3EVM_SMC911X_CS	5
+
 #endif /* __ASM_ARCH_OMAP3_EVM_H */

-- 
1.5.4.5
