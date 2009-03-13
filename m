From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] Set the smc91x timings for rx51
Date: Fri, 13 Mar 2009 11:04:01 -0700
Message-ID: <20090313180401.1548.83631.stgit@localhost>
References: <20090313180123.1548.1188.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62257 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbZCMSEA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 14:04:00 -0400
In-Reply-To: <20090313180123.1548.1188.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>

This could be converted into more generic smc91x init code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |  105 ++++++++++++++++++++------
 1 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 49c3d80..88f9f43 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -28,13 +28,14 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 
-#define RX51_ETHR_GPIO_IRQ		54
+#define	SMC91X_CS			1
+#define SMC91X_GPIO_IRQ			54
+#define SMC91X_GPIO_RESET		164
+#define SMC91X_GPIO_PWRDWN		86
 
 #define RX51_TSC2005_RESET_GPIO		104
 #define RX51_TSC2005_IRQ_GPIO		100
 
-#define	RX51_SMC91X_CS			1
-
 static struct resource rx51_smc91x_resources[] = {
 	[0] = {
 		.flags		= IORESOURCE_MEM,
@@ -71,7 +72,6 @@ static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
 	.single_channel = 1,
 };
 
-
 static struct spi_board_info rx51_peripherals_spi_board_info[] = {
 	[0] = {
 		.modalias		= "tsc2005",
@@ -143,37 +143,92 @@ static struct platform_device *rx51_peripherals_devices[] = {
 	&rx51_smc91x_device,
 };
 
+/*
+ * Timings are taken from smsc-lan91c96-ms.pdf
+ */
+static int smc91x_init_gpmc(int cs)
+{
+	struct gpmc_timings t;
+	const int t2_r = 45;		/* t2 in Figure 12.10 */
+	const int t2_w = 30;		/* t2 in Figure 12.11 */
+	const int t3 = 15;		/* t3 in Figure 12.10 */
+	const int t5_r = 0;		/* t5 in Figure 12.10 */
+	const int t6_r = 45;		/* t6 in Figure 12.10 */
+	const int t6_w = 0;		/* t6 in Figure 12.11 */
+	const int t7_w = 15;		/* t7 in Figure 12.11 */
+	const int t15 = 12;		/* t15 in Figure 12.2 */
+	const int t20 = 185;		/* t20 in Figure 12.2 */
+
+	memset(&t, 0, sizeof(t));
+
+	t.cs_on = t15;
+	t.cs_rd_off = t3 + t2_r + t5_r;	/* Figure 12.10 */
+	t.cs_wr_off = t3 + t2_w + t6_w;	/* Figure 12.11 */
+	t.adv_on = t3;			/* Figure 12.10 */
+	t.adv_rd_off = t3 + t2_r;	/* Figure 12.10 */
+	t.adv_wr_off = t3 + t2_w;	/* Figure 12.11 */
+	t.oe_off = t3 + t2_r + t5_r;	/* Figure 12.10 */
+	t.oe_on = t.oe_off - t6_r;	/* Figure 12.10 */
+	t.we_off = t3 + t2_w + t6_w;	/* Figure 12.11 */
+	t.we_on = t.we_off - t7_w;	/* Figure 12.11 */
+	t.rd_cycle = t20;		/* Figure 12.2 */
+	t.wr_cycle = t20;		/* Figure 12.4 */
+	t.access = t3 + t2_r + t5_r;	/* Figure 12.10 */
+	t.wr_access = t3 + t2_w + t6_w;	/* Figure 12.11 */
+
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, GPMC_CONFIG1_DEVICESIZE_16);
+
+	return gpmc_cs_set_timings(cs, &t);
+}
+
 static void __init rx51_init_smc91x(void)
 {
-	int eth_cs;
 	unsigned long cs_mem_base;
-	unsigned int rate;
-	struct clk *l3ck;
+	int ret;
 
-	eth_cs	= RX51_SMC91X_CS;
+	omap_cfg_reg(U8_34XX_GPIO54_DOWN);
+	omap_cfg_reg(G25_34XX_GPIO86_OUT);
+	omap_cfg_reg(H19_34XX_GPIO164_OUT);
 
-	l3ck = clk_get(NULL, "core_l3_ck");
-	if (IS_ERR(l3ck))
-		rate = 100000000;
-	else
-		rate = clk_get_rate(l3ck);
-
-	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
+	if (gpmc_cs_request(SMC91X_CS, SZ_16M, &cs_mem_base) < 0) {
 		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
 		return;
 	}
 
-	rx51_smc91x_resources[0].start = cs_mem_base + 0x0;
-	rx51_smc91x_resources[0].end   = cs_mem_base + 0xf;
-	udelay(100);
+	rx51_smc91x_resources[0].start = cs_mem_base + 0x300;
+	rx51_smc91x_resources[0].end = cs_mem_base + 0x30f;
 
-	if (gpio_request(RX51_ETHR_GPIO_IRQ, "SMC91X irq") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
-			RX51_ETHR_GPIO_IRQ);
-		return;
-	}
-	gpio_direction_input(RX51_ETHR_GPIO_IRQ);
-	rx51_smc91x_resources[1].start = gpio_to_irq(RX51_ETHR_GPIO_IRQ);
+	smc91x_init_gpmc(SMC91X_CS);
+
+	if (gpio_request(SMC91X_GPIO_IRQ, "SMC91X irq") < 0)
+		goto free1;
+
+	gpio_direction_input(SMC91X_GPIO_IRQ);
+	rx51_smc91x_resources[1].start = gpio_to_irq(SMC91X_GPIO_IRQ);
+
+	ret = gpio_request(SMC91X_GPIO_PWRDWN, "SMC91X powerdown");
+	if (ret)
+		goto free2;
+	gpio_direction_output(SMC91X_GPIO_PWRDWN, 0);
+
+	ret = gpio_request(SMC91X_GPIO_RESET, "SMC91X reset");
+	if (ret)
+		goto free3;
+	gpio_direction_output(SMC91X_GPIO_RESET, 0);
+	gpio_set_value(SMC91X_GPIO_RESET, 1);
+	msleep(100);
+	gpio_set_value(SMC91X_GPIO_RESET, 0);
+
+	return;
+
+free3:
+	gpio_free(SMC91X_GPIO_PWRDWN);
+free2:
+	gpio_free(SMC91X_GPIO_IRQ);
+free1:
+	gpmc_cs_free(SMC91X_CS);
+
+	printk(KERN_ERR "Could not initialize smc91x\n");
 }
 
 static void __init rx51_init_tsc2005(void)

