From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/7] omap_hwmod: use a terminator record with
	omap_hwmod_dma_info arrays
Date: Sat, 02 Jul 2011 02:44:56 -0600
Message-ID: <20110702084454.582.43800.stgit@dusk>
References: <20110702084348.582.65635.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44633 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab1GBIp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Jul 2011 04:45:58 -0400
In-Reply-To: <20110702084348.582.65635.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Previously, struct omap_hwmod_dma_info arrays were unterminated; and
users of these arrays used the ARRAY_SIZE() macro to determine the
length of the array.  However, ARRAY_SIZE() only works when the array
is in the same scope as the macro user.

So far this hasn't been a problem.  However, to reduce duplicated
data, a subsequent patch will move common data to a separate, shared
file.  When this is done, ARRAY_SIZE() will no longer be usable.

This patch removes ARRAY_SIZE() usage for struct omap_hwmod_dma_info
arrays and uses a sentinel value (irq == -1) as the array terminator
instead.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   30 ++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |   20 ++++-----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |   32 +++++++-------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   43 +++++++++----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   60 +++++++++++++-------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +--
 6 files changed, 106 insertions(+), 87 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 21e3eb8..d1a8bde 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -702,6 +702,29 @@ static int _count_mpu_irqs(struct omap_hwmod *oh)
 }
 
 /**
+ * _count_sdma_reqs - count the number of SDMA request lines associated with @oh
+ * @oh: struct omap_hwmod *oh
+ *
+ * Count and return the number of SDMA request lines associated with
+ * the hwmod @oh.  Used to allocate struct resource data.  Returns 0
+ * if @oh is NULL.
+ */
+static int _count_sdma_reqs(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_dma_info *ohdi;
+	int i = 0;
+
+	if (!oh || !oh->sdma_reqs)
+		return 0;
+
+	do {
+		ohdi = &oh->sdma_reqs[i++];
+	} while (ohdi->dma_req != -1);
+
+	return i;
+}
+
+/**
  * _count_ocp_if_addr_spaces - count the number of address space entries for @oh
  * @oh: struct omap_hwmod *oh
  *
@@ -1987,7 +2010,7 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh)
 {
 	int ret, i;
 
-	ret = _count_mpu_irqs(oh) + oh->sdma_reqs_cnt;
+	ret = _count_mpu_irqs(oh) + _count_sdma_reqs(oh);
 
 	for (i = 0; i < oh->slaves_cnt; i++)
 		ret += _count_ocp_if_addr_spaces(oh->slaves[i]);
@@ -2007,7 +2030,7 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh)
  */
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 {
-	int i, j, mpu_irqs_cnt;
+	int i, j, mpu_irqs_cnt, sdma_reqs_cnt;
 	int r = 0;
 
 	/* For each IRQ, DMA, memory area, fill in array.*/
@@ -2021,7 +2044,8 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 		r++;
 	}
 
-	for (i = 0; i < oh->sdma_reqs_cnt; i++) {
+	sdma_reqs_cnt = _count_sdma_reqs(oh);
+	for (i = 0; i < sdma_reqs_cnt; i++) {
 		(res + r)->name = (oh->sdma_reqs + i)->name;
 		(res + r)->start = (oh->sdma_reqs + i)->dma_req;
 		(res + r)->end = (oh->sdma_reqs + i)->dma_req;
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 73157ee..60c817e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -831,6 +831,7 @@ static struct omap_hwmod_class uart_class = {
 static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2420_uart1_slaves[] = {
@@ -841,7 +842,6 @@ static struct omap_hwmod omap2420_uart1_hwmod = {
 	.name		= "uart1",
 	.mpu_irqs	= omap2_uart1_mpu_irqs,
 	.sdma_reqs	= uart1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart1_sdma_reqs),
 	.main_clk	= "uart1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -863,6 +863,7 @@ static struct omap_hwmod omap2420_uart1_hwmod = {
 static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2420_uart2_slaves[] = {
@@ -873,7 +874,6 @@ static struct omap_hwmod omap2420_uart2_hwmod = {
 	.name		= "uart2",
 	.mpu_irqs	= omap2_uart2_mpu_irqs,
 	.sdma_reqs	= uart2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart2_sdma_reqs),
 	.main_clk	= "uart2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -895,6 +895,7 @@ static struct omap_hwmod omap2420_uart2_hwmod = {
 static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2420_uart3_slaves[] = {
@@ -905,7 +906,6 @@ static struct omap_hwmod omap2420_uart3_hwmod = {
 	.name		= "uart3",
 	.mpu_irqs	= omap2_uart3_mpu_irqs,
 	.sdma_reqs	= uart3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart3_sdma_reqs),
 	.main_clk	= "uart3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -942,6 +942,7 @@ static struct omap_hwmod_class omap2420_dss_hwmod_class = {
 
 static struct omap_hwmod_dma_info omap2420_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
+	{ .dma_req = -1 }
 };
 
 /* dss */
@@ -980,7 +981,6 @@ static struct omap_hwmod omap2420_dss_core_hwmod = {
 	.class		= &omap2420_dss_hwmod_class,
 	.main_clk	= "dss1_fck", /* instead of dss_fck */
 	.sdma_reqs	= omap2420_dss_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_dss_sdma_chs),
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1186,6 +1186,7 @@ static struct omap_i2c_dev_attr i2c_dev_attr;
 static struct omap_hwmod_dma_info i2c1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C1_TX },
 	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C1_RX },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2420_i2c1_slaves[] = {
@@ -1196,7 +1197,6 @@ static struct omap_hwmod omap2420_i2c1_hwmod = {
 	.name		= "i2c1",
 	.mpu_irqs	= omap2_i2c1_mpu_irqs,
 	.sdma_reqs	= i2c1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
 	.main_clk	= "i2c1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1220,6 +1220,7 @@ static struct omap_hwmod omap2420_i2c1_hwmod = {
 static struct omap_hwmod_dma_info i2c2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C2_TX },
 	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C2_RX },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2420_i2c2_slaves[] = {
@@ -1230,7 +1231,6 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.name		= "i2c2",
 	.mpu_irqs	= omap2_i2c2_mpu_irqs,
 	.sdma_reqs	= i2c2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(i2c2_sdma_reqs),
 	.main_clk	= "i2c2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1611,6 +1611,7 @@ static struct omap_hwmod_dma_info omap2420_mcspi1_sdma_reqs[] = {
 	{ .name = "rx2", .dma_req = 40 }, /* DMA_SPI1_RX2 */
 	{ .name = "tx3", .dma_req = 41 }, /* DMA_SPI1_TX3 */
 	{ .name = "rx3", .dma_req = 42 }, /* DMA_SPI1_RX3 */
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2420_mcspi1_slaves[] = {
@@ -1625,7 +1626,6 @@ static struct omap_hwmod omap2420_mcspi1_hwmod = {
 	.name		= "mcspi1_hwmod",
 	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
 	.sdma_reqs	= omap2420_mcspi1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_mcspi1_sdma_reqs),
 	.main_clk	= "mcspi1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1649,6 +1649,7 @@ static struct omap_hwmod_dma_info omap2420_mcspi2_sdma_reqs[] = {
 	{ .name = "rx0", .dma_req = 44 }, /* DMA_SPI2_RX0 */
 	{ .name = "tx1", .dma_req = 45 }, /* DMA_SPI2_TX1 */
 	{ .name = "rx1", .dma_req = 46 }, /* DMA_SPI2_RX1 */
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2420_mcspi2_slaves[] = {
@@ -1663,7 +1664,6 @@ static struct omap_hwmod omap2420_mcspi2_hwmod = {
 	.name		= "mcspi2_hwmod",
 	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
 	.sdma_reqs	= omap2420_mcspi2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_mcspi2_sdma_reqs),
 	.main_clk	= "mcspi2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1700,6 +1700,7 @@ static struct omap_hwmod_irq_info omap2420_mcbsp1_irqs[] = {
 static struct omap_hwmod_dma_info omap2420_mcbsp1_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 32 },
 	{ .name = "tx", .dma_req = 31 },
+	{ .dma_req = -1 }
 };
 
 /* l4_core -> mcbsp1 */
@@ -1721,7 +1722,6 @@ static struct omap_hwmod omap2420_mcbsp1_hwmod = {
 	.class		= &omap2420_mcbsp_hwmod_class,
 	.mpu_irqs	= omap2420_mcbsp1_irqs,
 	.sdma_reqs	= omap2420_mcbsp1_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_mcbsp1_sdma_chs),
 	.main_clk	= "mcbsp1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1747,6 +1747,7 @@ static struct omap_hwmod_irq_info omap2420_mcbsp2_irqs[] = {
 static struct omap_hwmod_dma_info omap2420_mcbsp2_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 34 },
 	{ .name = "tx", .dma_req = 33 },
+	{ .dma_req = -1 }
 };
 
 /* l4_core -> mcbsp2 */
@@ -1768,7 +1769,6 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 	.class		= &omap2420_mcbsp_hwmod_class,
 	.mpu_irqs	= omap2420_mcbsp2_irqs,
 	.sdma_reqs	= omap2420_mcbsp2_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_mcbsp2_sdma_chs),
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 62ecc68..af758b3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -903,6 +903,7 @@ static struct omap_hwmod_class uart_class = {
 static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2430_uart1_slaves[] = {
@@ -913,7 +914,6 @@ static struct omap_hwmod omap2430_uart1_hwmod = {
 	.name		= "uart1",
 	.mpu_irqs	= omap2_uart1_mpu_irqs,
 	.sdma_reqs	= uart1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart1_sdma_reqs),
 	.main_clk	= "uart1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -935,6 +935,7 @@ static struct omap_hwmod omap2430_uart1_hwmod = {
 static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2430_uart2_slaves[] = {
@@ -945,7 +946,6 @@ static struct omap_hwmod omap2430_uart2_hwmod = {
 	.name		= "uart2",
 	.mpu_irqs	= omap2_uart2_mpu_irqs,
 	.sdma_reqs	= uart2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart2_sdma_reqs),
 	.main_clk	= "uart2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -967,6 +967,7 @@ static struct omap_hwmod omap2430_uart2_hwmod = {
 static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2430_uart3_slaves[] = {
@@ -977,7 +978,6 @@ static struct omap_hwmod omap2430_uart3_hwmod = {
 	.name		= "uart3",
 	.mpu_irqs	= omap2_uart3_mpu_irqs,
 	.sdma_reqs	= uart3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart3_sdma_reqs),
 	.main_clk	= "uart3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1014,6 +1014,7 @@ static struct omap_hwmod_class omap2430_dss_hwmod_class = {
 
 static struct omap_hwmod_dma_info omap2430_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
+	{ .dma_req = -1 }
 };
 
 /* dss */
@@ -1046,7 +1047,6 @@ static struct omap_hwmod omap2430_dss_core_hwmod = {
 	.class		= &omap2430_dss_hwmod_class,
 	.main_clk	= "dss1_fck", /* instead of dss_fck */
 	.sdma_reqs	= omap2430_dss_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_dss_sdma_chs),
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1237,6 +1237,7 @@ static struct omap_i2c_dev_attr i2c_dev_attr = {
 static struct omap_hwmod_dma_info i2c1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C1_TX },
 	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C1_RX },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2430_i2c1_slaves[] = {
@@ -1247,7 +1248,6 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
 	.name		= "i2c1",
 	.mpu_irqs	= omap2_i2c1_mpu_irqs,
 	.sdma_reqs	= i2c1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
 	.main_clk	= "i2chs1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1278,6 +1278,7 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
 static struct omap_hwmod_dma_info i2c2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C2_TX },
 	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C2_RX },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2430_i2c2_slaves[] = {
@@ -1288,7 +1289,6 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.name		= "i2c2",
 	.mpu_irqs	= omap2_i2c2_mpu_irqs,
 	.sdma_reqs	= i2c2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(i2c2_sdma_reqs),
 	.main_clk	= "i2chs2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1716,6 +1716,7 @@ static struct omap_hwmod_dma_info omap2430_mcspi1_sdma_reqs[] = {
 	{ .name = "rx2", .dma_req = 40 }, /* DMA_SPI1_RX2 */
 	{ .name = "tx3", .dma_req = 41 }, /* DMA_SPI1_TX3 */
 	{ .name = "rx3", .dma_req = 42 }, /* DMA_SPI1_RX3 */
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2430_mcspi1_slaves[] = {
@@ -1730,7 +1731,6 @@ static struct omap_hwmod omap2430_mcspi1_hwmod = {
 	.name		= "mcspi1_hwmod",
 	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
 	.sdma_reqs	= omap2430_mcspi1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcspi1_sdma_reqs),
 	.main_clk	= "mcspi1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1754,6 +1754,7 @@ static struct omap_hwmod_dma_info omap2430_mcspi2_sdma_reqs[] = {
 	{ .name = "rx0", .dma_req = 44 }, /* DMA_SPI2_RX0 */
 	{ .name = "tx1", .dma_req = 45 }, /* DMA_SPI2_TX1 */
 	{ .name = "rx1", .dma_req = 46 }, /* DMA_SPI2_RX1 */
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2430_mcspi2_slaves[] = {
@@ -1768,7 +1769,6 @@ static struct omap_hwmod omap2430_mcspi2_hwmod = {
 	.name		= "mcspi2_hwmod",
 	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
 	.sdma_reqs	= omap2430_mcspi2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcspi2_sdma_reqs),
 	.main_clk	= "mcspi2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1797,6 +1797,7 @@ static struct omap_hwmod_dma_info omap2430_mcspi3_sdma_reqs[] = {
 	{ .name = "rx0", .dma_req = 16 }, /* DMA_SPI3_RX0 */
 	{ .name = "tx1", .dma_req = 23 }, /* DMA_SPI3_TX1 */
 	{ .name = "rx1", .dma_req = 24 }, /* DMA_SPI3_RX1 */
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap2430_mcspi3_slaves[] = {
@@ -1811,7 +1812,6 @@ static struct omap_hwmod omap2430_mcspi3_hwmod = {
 	.name		= "mcspi3_hwmod",
 	.mpu_irqs	= omap2430_mcspi3_mpu_irqs,
 	.sdma_reqs	= omap2430_mcspi3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcspi3_sdma_reqs),
 	.main_clk	= "mcspi3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1915,6 +1915,7 @@ static struct omap_hwmod_irq_info omap2430_mcbsp1_irqs[] = {
 static struct omap_hwmod_dma_info omap2430_mcbsp1_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 32 },
 	{ .name = "tx", .dma_req = 31 },
+	{ .dma_req = -1 }
 };
 
 /* l4_core -> mcbsp1 */
@@ -1936,7 +1937,6 @@ static struct omap_hwmod omap2430_mcbsp1_hwmod = {
 	.class		= &omap2430_mcbsp_hwmod_class,
 	.mpu_irqs	= omap2430_mcbsp1_irqs,
 	.sdma_reqs	= omap2430_mcbsp1_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcbsp1_sdma_chs),
 	.main_clk	= "mcbsp1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1963,6 +1963,7 @@ static struct omap_hwmod_irq_info omap2430_mcbsp2_irqs[] = {
 static struct omap_hwmod_dma_info omap2430_mcbsp2_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 34 },
 	{ .name = "tx", .dma_req = 33 },
+	{ .dma_req = -1 }
 };
 
 /* l4_core -> mcbsp2 */
@@ -1984,7 +1985,6 @@ static struct omap_hwmod omap2430_mcbsp2_hwmod = {
 	.class		= &omap2430_mcbsp_hwmod_class,
 	.mpu_irqs	= omap2430_mcbsp2_irqs,
 	.sdma_reqs	= omap2430_mcbsp2_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcbsp2_sdma_chs),
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2011,6 +2011,7 @@ static struct omap_hwmod_irq_info omap2430_mcbsp3_irqs[] = {
 static struct omap_hwmod_dma_info omap2430_mcbsp3_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 18 },
 	{ .name = "tx", .dma_req = 17 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap2430_mcbsp3_addrs[] = {
@@ -2042,7 +2043,6 @@ static struct omap_hwmod omap2430_mcbsp3_hwmod = {
 	.class		= &omap2430_mcbsp_hwmod_class,
 	.mpu_irqs	= omap2430_mcbsp3_irqs,
 	.sdma_reqs	= omap2430_mcbsp3_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcbsp3_sdma_chs),
 	.main_clk	= "mcbsp3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2069,6 +2069,7 @@ static struct omap_hwmod_irq_info omap2430_mcbsp4_irqs[] = {
 static struct omap_hwmod_dma_info omap2430_mcbsp4_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 20 },
 	{ .name = "tx", .dma_req = 19 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap2430_mcbsp4_addrs[] = {
@@ -2100,7 +2101,6 @@ static struct omap_hwmod omap2430_mcbsp4_hwmod = {
 	.class		= &omap2430_mcbsp_hwmod_class,
 	.mpu_irqs	= omap2430_mcbsp4_irqs,
 	.sdma_reqs	= omap2430_mcbsp4_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcbsp4_sdma_chs),
 	.main_clk	= "mcbsp4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2127,6 +2127,7 @@ static struct omap_hwmod_irq_info omap2430_mcbsp5_irqs[] = {
 static struct omap_hwmod_dma_info omap2430_mcbsp5_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 22 },
 	{ .name = "tx", .dma_req = 21 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap2430_mcbsp5_addrs[] = {
@@ -2158,7 +2159,6 @@ static struct omap_hwmod omap2430_mcbsp5_hwmod = {
 	.class		= &omap2430_mcbsp_hwmod_class,
 	.mpu_irqs	= omap2430_mcbsp5_irqs,
 	.sdma_reqs	= omap2430_mcbsp5_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcbsp5_sdma_chs),
 	.main_clk	= "mcbsp5_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2202,6 +2202,7 @@ static struct omap_hwmod_irq_info omap2430_mmc1_mpu_irqs[] = {
 static struct omap_hwmod_dma_info omap2430_mmc1_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = 61 }, /* DMA_MMC1_TX */
 	{ .name = "rx",	.dma_req = 62 }, /* DMA_MMC1_RX */
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_opt_clk omap2430_mmc1_opt_clks[] = {
@@ -2221,7 +2222,6 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap2430_mmc1_mpu_irqs,
 	.sdma_reqs	= omap2430_mmc1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mmc1_sdma_reqs),
 	.opt_clks	= omap2430_mmc1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap2430_mmc1_opt_clks),
 	.main_clk	= "mmchs1_fck",
@@ -2251,6 +2251,7 @@ static struct omap_hwmod_irq_info omap2430_mmc2_mpu_irqs[] = {
 static struct omap_hwmod_dma_info omap2430_mmc2_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = 47 }, /* DMA_MMC2_TX */
 	{ .name = "rx",	.dma_req = 48 }, /* DMA_MMC2_RX */
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_opt_clk omap2430_mmc2_opt_clks[] = {
@@ -2266,7 +2267,6 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap2430_mmc2_mpu_irqs,
 	.sdma_reqs	= omap2430_mmc2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mmc2_sdma_reqs),
 	.opt_clks	= omap2430_mmc2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap2430_mmc2_opt_clks),
 	.main_clk	= "mmchs2_fck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 6bac4bb..265f0b1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1213,6 +1213,7 @@ static struct omap_hwmod_class uart_class = {
 static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_uart1_slaves[] = {
@@ -1223,7 +1224,6 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.name		= "uart1",
 	.mpu_irqs	= omap2_uart1_mpu_irqs,
 	.sdma_reqs	= uart1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart1_sdma_reqs),
 	.main_clk	= "uart1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1245,6 +1245,7 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_uart2_slaves[] = {
@@ -1255,7 +1256,6 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.name		= "uart2",
 	.mpu_irqs	= omap2_uart2_mpu_irqs,
 	.sdma_reqs	= uart2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart2_sdma_reqs),
 	.main_clk	= "uart2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1277,6 +1277,7 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
 	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_uart3_slaves[] = {
@@ -1287,7 +1288,6 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.name		= "uart3",
 	.mpu_irqs	= omap2_uart3_mpu_irqs,
 	.sdma_reqs	= uart3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart3_sdma_reqs),
 	.main_clk	= "uart3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1314,6 +1314,7 @@ static struct omap_hwmod_irq_info uart4_mpu_irqs[] = {
 static struct omap_hwmod_dma_info uart4_sdma_reqs[] = {
 	{ .name = "rx",	.dma_req = OMAP36XX_DMA_UART4_RX, },
 	{ .name = "tx",	.dma_req = OMAP36XX_DMA_UART4_TX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_uart4_slaves[] = {
@@ -1324,7 +1325,6 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 	.name		= "uart4",
 	.mpu_irqs	= uart4_mpu_irqs,
 	.sdma_reqs	= uart4_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(uart4_sdma_reqs),
 	.main_clk	= "uart4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1367,6 +1367,7 @@ static struct omap_hwmod_class omap3xxx_dss_hwmod_class = {
 static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
 	{ .name = "dsi1", .dma_req = 74 },
+	{ .dma_req = -1 }
 };
 
 /* dss */
@@ -1426,8 +1427,6 @@ static struct omap_hwmod omap3430es1_dss_core_hwmod = {
 	.class		= &omap3xxx_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
 	.sdma_reqs	= omap3xxx_dss_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_dss_sdma_chs),
-
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1452,8 +1451,6 @@ static struct omap_hwmod omap3xxx_dss_core_hwmod = {
 	.class		= &omap3xxx_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
 	.sdma_reqs	= omap3xxx_dss_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_dss_sdma_chs),
-
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1720,6 +1717,7 @@ static struct omap_i2c_dev_attr i2c1_dev_attr = {
 static struct omap_hwmod_dma_info i2c1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C1_TX },
 	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C1_RX },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_i2c1_slaves[] = {
@@ -1730,7 +1728,6 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.mpu_irqs	= omap2_i2c1_mpu_irqs,
 	.sdma_reqs	= i2c1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
 	.main_clk	= "i2c1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1757,6 +1754,7 @@ static struct omap_i2c_dev_attr i2c2_dev_attr = {
 static struct omap_hwmod_dma_info i2c2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C2_TX },
 	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C2_RX },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_i2c2_slaves[] = {
@@ -1767,7 +1765,6 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.mpu_irqs	= omap2_i2c2_mpu_irqs,
 	.sdma_reqs	= i2c2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(i2c2_sdma_reqs),
 	.main_clk	= "i2c2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1799,6 +1796,7 @@ static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
 static struct omap_hwmod_dma_info i2c3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = OMAP34XX_DMA_I2C3_TX },
 	{ .name = "rx", .dma_req = OMAP34XX_DMA_I2C3_RX },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_i2c3_slaves[] = {
@@ -1809,7 +1807,6 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.mpu_irqs	= i2c3_mpu_irqs,
 	.sdma_reqs	= i2c3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(i2c3_sdma_reqs),
 	.main_clk	= "i2c3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2275,6 +2272,7 @@ static struct omap_hwmod_irq_info omap3xxx_mcbsp1_irqs[] = {
 static struct omap_hwmod_dma_info omap3xxx_mcbsp1_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 32 },
 	{ .name = "tx", .dma_req = 31 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap3xxx_mcbsp1_addrs[] = {
@@ -2306,7 +2304,6 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 	.class		= &omap3xxx_mcbsp_hwmod_class,
 	.mpu_irqs	= omap3xxx_mcbsp1_irqs,
 	.sdma_reqs	= omap3xxx_mcbsp1_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp1_sdma_chs),
 	.main_clk	= "mcbsp1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2333,6 +2330,7 @@ static struct omap_hwmod_irq_info omap3xxx_mcbsp2_irqs[] = {
 static struct omap_hwmod_dma_info omap3xxx_mcbsp2_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 34 },
 	{ .name = "tx", .dma_req = 33 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap3xxx_mcbsp2_addrs[] = {
@@ -2369,7 +2367,6 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.class		= &omap3xxx_mcbsp_hwmod_class,
 	.mpu_irqs	= omap3xxx_mcbsp2_irqs,
 	.sdma_reqs	= omap3xxx_mcbsp2_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_sdma_chs),
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2397,6 +2394,7 @@ static struct omap_hwmod_irq_info omap3xxx_mcbsp3_irqs[] = {
 static struct omap_hwmod_dma_info omap3xxx_mcbsp3_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 18 },
 	{ .name = "tx", .dma_req = 17 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap3xxx_mcbsp3_addrs[] = {
@@ -2432,7 +2430,6 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.class		= &omap3xxx_mcbsp_hwmod_class,
 	.mpu_irqs	= omap3xxx_mcbsp3_irqs,
 	.sdma_reqs	= omap3xxx_mcbsp3_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_sdma_chs),
 	.main_clk	= "mcbsp3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2460,6 +2457,7 @@ static struct omap_hwmod_irq_info omap3xxx_mcbsp4_irqs[] = {
 static struct omap_hwmod_dma_info omap3xxx_mcbsp4_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 20 },
 	{ .name = "tx", .dma_req = 19 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap3xxx_mcbsp4_addrs[] = {
@@ -2491,7 +2489,6 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 	.class		= &omap3xxx_mcbsp_hwmod_class,
 	.mpu_irqs	= omap3xxx_mcbsp4_irqs,
 	.sdma_reqs	= omap3xxx_mcbsp4_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp4_sdma_chs),
 	.main_clk	= "mcbsp4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2518,6 +2515,7 @@ static struct omap_hwmod_irq_info omap3xxx_mcbsp5_irqs[] = {
 static struct omap_hwmod_dma_info omap3xxx_mcbsp5_sdma_chs[] = {
 	{ .name = "rx", .dma_req = 22 },
 	{ .name = "tx", .dma_req = 21 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap3xxx_mcbsp5_addrs[] = {
@@ -2549,7 +2547,6 @@ static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
 	.class		= &omap3xxx_mcbsp_hwmod_class,
 	.mpu_irqs	= omap3xxx_mcbsp5_irqs,
 	.sdma_reqs	= omap3xxx_mcbsp5_sdma_chs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp5_sdma_chs),
 	.main_clk	= "mcbsp5_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2951,6 +2948,7 @@ static struct omap_hwmod_dma_info omap34xx_mcspi1_sdma_reqs[] = {
 	{ .name = "rx2", .dma_req = 40 },
 	{ .name = "tx3", .dma_req = 41 },
 	{ .name = "rx3", .dma_req = 42 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap34xx_mcspi1_slaves[] = {
@@ -2965,7 +2963,6 @@ static struct omap_hwmod omap34xx_mcspi1 = {
 	.name		= "mcspi1",
 	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
 	.sdma_reqs	= omap34xx_mcspi1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mcspi1_sdma_reqs),
 	.main_clk	= "mcspi1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2989,6 +2986,7 @@ static struct omap_hwmod_dma_info omap34xx_mcspi2_sdma_reqs[] = {
 	{ .name = "rx0", .dma_req = 44 },
 	{ .name = "tx1", .dma_req = 45 },
 	{ .name = "rx1", .dma_req = 46 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap34xx_mcspi2_slaves[] = {
@@ -3003,7 +3001,6 @@ static struct omap_hwmod omap34xx_mcspi2 = {
 	.name		= "mcspi2",
 	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
 	.sdma_reqs	= omap34xx_mcspi2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mcspi2_sdma_reqs),
 	.main_clk	= "mcspi2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -3032,6 +3029,7 @@ static struct omap_hwmod_dma_info omap34xx_mcspi3_sdma_reqs[] = {
 	{ .name = "rx0", .dma_req = 16 },
 	{ .name = "tx1", .dma_req = 23 },
 	{ .name = "rx1", .dma_req = 24 },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap34xx_mcspi3_slaves[] = {
@@ -3046,7 +3044,6 @@ static struct omap_hwmod omap34xx_mcspi3 = {
 	.name		= "mcspi3",
 	.mpu_irqs	= omap34xx_mcspi3_mpu_irqs,
 	.sdma_reqs	= omap34xx_mcspi3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mcspi3_sdma_reqs),
 	.main_clk	= "mcspi3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -3073,6 +3070,7 @@ static struct omap_hwmod_irq_info omap34xx_mcspi4_mpu_irqs[] = {
 static struct omap_hwmod_dma_info omap34xx_mcspi4_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 70 }, /* DMA_SPI4_TX0 */
 	{ .name = "rx0", .dma_req = 71 }, /* DMA_SPI4_RX0 */
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_ocp_if *omap34xx_mcspi4_slaves[] = {
@@ -3087,7 +3085,6 @@ static struct omap_hwmod omap34xx_mcspi4 = {
 	.name		= "mcspi4",
 	.mpu_irqs	= omap34xx_mcspi4_mpu_irqs,
 	.sdma_reqs	= omap34xx_mcspi4_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mcspi4_sdma_reqs),
 	.main_clk	= "mcspi4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -3218,6 +3215,7 @@ static struct omap_hwmod_irq_info omap34xx_mmc1_mpu_irqs[] = {
 static struct omap_hwmod_dma_info omap34xx_mmc1_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = 61, },
 	{ .name = "rx",	.dma_req = 62, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_opt_clk omap34xx_mmc1_opt_clks[] = {
@@ -3236,7 +3234,6 @@ static struct omap_hwmod omap3xxx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.mpu_irqs	= omap34xx_mmc1_mpu_irqs,
 	.sdma_reqs	= omap34xx_mmc1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mmc1_sdma_reqs),
 	.opt_clks	= omap34xx_mmc1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc1_opt_clks),
 	.main_clk	= "mmchs1_fck",
@@ -3266,6 +3263,7 @@ static struct omap_hwmod_irq_info omap34xx_mmc2_mpu_irqs[] = {
 static struct omap_hwmod_dma_info omap34xx_mmc2_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = 47, },
 	{ .name = "rx",	.dma_req = 48, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_opt_clk omap34xx_mmc2_opt_clks[] = {
@@ -3280,7 +3278,6 @@ static struct omap_hwmod omap3xxx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.mpu_irqs	= omap34xx_mmc2_mpu_irqs,
 	.sdma_reqs	= omap34xx_mmc2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mmc2_sdma_reqs),
 	.opt_clks	= omap34xx_mmc2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc2_opt_clks),
 	.main_clk	= "mmchs2_fck",
@@ -3309,6 +3306,7 @@ static struct omap_hwmod_irq_info omap34xx_mmc3_mpu_irqs[] = {
 static struct omap_hwmod_dma_info omap34xx_mmc3_sdma_reqs[] = {
 	{ .name = "tx",	.dma_req = 77, },
 	{ .name = "rx",	.dma_req = 78, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_opt_clk omap34xx_mmc3_opt_clks[] = {
@@ -3323,7 +3321,6 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.mpu_irqs	= omap34xx_mmc3_mpu_irqs,
 	.sdma_reqs	= omap34xx_mmc3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mmc3_sdma_reqs),
 	.opt_clks	= omap34xx_mmc3_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc3_opt_clks),
 	.main_clk	= "mmchs3_fck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index bbfc4db..a93c455 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -684,6 +684,7 @@ static struct omap_hwmod_dma_info omap44xx_aess_sdma_reqs[] = {
 	{ .name = "fifo5", .dma_req = 105 + OMAP44XX_DMA_REQ_START },
 	{ .name = "fifo6", .dma_req = 106 + OMAP44XX_DMA_REQ_START },
 	{ .name = "fifo7", .dma_req = 107 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 /* aess master ports */
@@ -738,7 +739,6 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.class		= &omap44xx_aess_hwmod_class,
 	.mpu_irqs	= omap44xx_aess_irqs,
 	.sdma_reqs	= omap44xx_aess_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_aess_sdma_reqs),
 	.main_clk	= "aess_fck",
 	.prcm		= {
 		.omap4 = {
@@ -953,6 +953,7 @@ static struct omap_hwmod_irq_info omap44xx_dmic_irqs[] = {
 
 static struct omap_hwmod_dma_info omap44xx_dmic_sdma_reqs[] = {
 	{ .dma_req = 66 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] = {
@@ -1002,7 +1003,6 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.class		= &omap44xx_dmic_hwmod_class,
 	.mpu_irqs	= omap44xx_dmic_irqs,
 	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dmic_sdma_reqs),
 	.main_clk	= "dmic_fck",
 	.prcm		= {
 		.omap4 = {
@@ -1220,6 +1220,7 @@ static struct omap_hwmod_irq_info omap44xx_dss_dispc_irqs[] = {
 
 static struct omap_hwmod_dma_info omap44xx_dss_dispc_sdma_reqs[] = {
 	{ .dma_req = 5 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_dss_dispc_dma_addrs[] = {
@@ -1269,7 +1270,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.class		= &omap44xx_dispc_hwmod_class,
 	.mpu_irqs	= omap44xx_dss_dispc_irqs,
 	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_sdma_reqs),
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
@@ -1311,6 +1311,7 @@ static struct omap_hwmod_irq_info omap44xx_dss_dsi1_irqs[] = {
 
 static struct omap_hwmod_dma_info omap44xx_dss_dsi1_sdma_reqs[] = {
 	{ .dma_req = 74 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_dss_dsi1_dma_addrs[] = {
@@ -1360,7 +1361,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.class		= &omap44xx_dsi_hwmod_class,
 	.mpu_irqs	= omap44xx_dss_dsi1_irqs,
 	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_sdma_reqs),
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
@@ -1381,6 +1381,7 @@ static struct omap_hwmod_irq_info omap44xx_dss_dsi2_irqs[] = {
 
 static struct omap_hwmod_dma_info omap44xx_dss_dsi2_sdma_reqs[] = {
 	{ .dma_req = 83 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_dss_dsi2_dma_addrs[] = {
@@ -1430,7 +1431,6 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.class		= &omap44xx_dsi_hwmod_class,
 	.mpu_irqs	= omap44xx_dss_dsi2_irqs,
 	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_sdma_reqs),
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
@@ -1471,6 +1471,7 @@ static struct omap_hwmod_irq_info omap44xx_dss_hdmi_irqs[] = {
 
 static struct omap_hwmod_dma_info omap44xx_dss_hdmi_sdma_reqs[] = {
 	{ .dma_req = 75 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_dss_hdmi_dma_addrs[] = {
@@ -1520,7 +1521,6 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.class		= &omap44xx_hdmi_hwmod_class,
 	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_sdma_reqs),
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
@@ -1556,6 +1556,7 @@ static struct omap_hwmod_class omap44xx_rfbi_hwmod_class = {
 static struct omap_hwmod omap44xx_dss_rfbi_hwmod;
 static struct omap_hwmod_dma_info omap44xx_dss_rfbi_sdma_reqs[] = {
 	{ .dma_req = 13 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_dss_rfbi_dma_addrs[] = {
@@ -1604,7 +1605,6 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap44xx_rfbi_hwmod_class,
 	.sdma_reqs	= omap44xx_dss_rfbi_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_sdma_reqs),
 	.main_clk	= "dss_fck",
 	.prcm = {
 		.omap4 = {
@@ -2137,6 +2137,7 @@ static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_i2c1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 26 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 27 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_i2c1_addrs[] = {
@@ -2168,7 +2169,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_sdma_reqs),
 	.main_clk	= "i2c1_fck",
 	.prcm = {
 		.omap4 = {
@@ -2190,6 +2190,7 @@ static struct omap_hwmod_irq_info omap44xx_i2c2_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_i2c2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 28 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 29 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_i2c2_addrs[] = {
@@ -2221,7 +2222,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_sdma_reqs),
 	.main_clk	= "i2c2_fck",
 	.prcm = {
 		.omap4 = {
@@ -2243,6 +2243,7 @@ static struct omap_hwmod_irq_info omap44xx_i2c3_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_i2c3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 24 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 25 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_i2c3_addrs[] = {
@@ -2274,7 +2275,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_sdma_reqs),
 	.main_clk	= "i2c3_fck",
 	.prcm = {
 		.omap4 = {
@@ -2296,6 +2296,7 @@ static struct omap_hwmod_irq_info omap44xx_i2c4_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_i2c4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 123 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 124 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_i2c4_addrs[] = {
@@ -2327,7 +2328,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_sdma_reqs),
 	.main_clk	= "i2c4_fck",
 	.prcm = {
 		.omap4 = {
@@ -2466,6 +2466,7 @@ static struct omap_hwmod_dma_info omap44xx_iss_sdma_reqs[] = {
 	{ .name = "2", .dma_req = 9 + OMAP44XX_DMA_REQ_START },
 	{ .name = "3", .dma_req = 11 + OMAP44XX_DMA_REQ_START },
 	{ .name = "4", .dma_req = 12 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 /* iss master ports */
@@ -2505,7 +2506,6 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.class		= &omap44xx_iss_hwmod_class,
 	.mpu_irqs	= omap44xx_iss_irqs,
 	.sdma_reqs	= omap44xx_iss_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_iss_sdma_reqs),
 	.main_clk	= "iss_fck",
 	.prcm		= {
 		.omap4 = {
@@ -2790,6 +2790,7 @@ static struct omap_hwmod_irq_info omap44xx_mcbsp1_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 32 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 33 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp1_addrs[] = {
@@ -2841,7 +2842,6 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.mpu_irqs	= omap44xx_mcbsp1_irqs,
 	.sdma_reqs	= omap44xx_mcbsp1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_sdma_reqs),
 	.main_clk	= "mcbsp1_fck",
 	.prcm = {
 		.omap4 = {
@@ -2863,6 +2863,7 @@ static struct omap_hwmod_irq_info omap44xx_mcbsp2_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 16 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 17 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp2_addrs[] = {
@@ -2914,7 +2915,6 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.mpu_irqs	= omap44xx_mcbsp2_irqs,
 	.sdma_reqs	= omap44xx_mcbsp2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_sdma_reqs),
 	.main_clk	= "mcbsp2_fck",
 	.prcm = {
 		.omap4 = {
@@ -2936,6 +2936,7 @@ static struct omap_hwmod_irq_info omap44xx_mcbsp3_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 18 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 19 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp3_addrs[] = {
@@ -2987,7 +2988,6 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.mpu_irqs	= omap44xx_mcbsp3_irqs,
 	.sdma_reqs	= omap44xx_mcbsp3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_sdma_reqs),
 	.main_clk	= "mcbsp3_fck",
 	.prcm = {
 		.omap4 = {
@@ -3009,6 +3009,7 @@ static struct omap_hwmod_irq_info omap44xx_mcbsp4_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mcbsp4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 30 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 31 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mcbsp4_addrs[] = {
@@ -3039,7 +3040,6 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.mpu_irqs	= omap44xx_mcbsp4_irqs,
 	.sdma_reqs	= omap44xx_mcbsp4_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_sdma_reqs),
 	.main_clk	= "mcbsp4_fck",
 	.prcm = {
 		.omap4 = {
@@ -3082,6 +3082,7 @@ static struct omap_hwmod_irq_info omap44xx_mcpdm_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mcpdm_sdma_reqs[] = {
 	{ .name = "up_link", .dma_req = 64 + OMAP44XX_DMA_REQ_START },
 	{ .name = "dn_link", .dma_req = 65 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mcpdm_addrs[] = {
@@ -3131,7 +3132,6 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.class		= &omap44xx_mcpdm_hwmod_class,
 	.mpu_irqs	= omap44xx_mcpdm_irqs,
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcpdm_sdma_reqs),
 	.main_clk	= "mcpdm_fck",
 	.prcm		= {
 		.omap4 = {
@@ -3181,6 +3181,7 @@ static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] = {
 	{ .name = "rx2", .dma_req = 39 + OMAP44XX_DMA_REQ_START },
 	{ .name = "tx3", .dma_req = 40 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx3", .dma_req = 41 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mcspi1_addrs[] = {
@@ -3216,7 +3217,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.mpu_irqs	= omap44xx_mcspi1_irqs,
 	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi1_sdma_reqs),
 	.main_clk	= "mcspi1_fck",
 	.prcm = {
 		.omap4 = {
@@ -3241,6 +3241,7 @@ static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] = {
 	{ .name = "rx0", .dma_req = 43 + OMAP44XX_DMA_REQ_START },
 	{ .name = "tx1", .dma_req = 44 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx1", .dma_req = 45 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mcspi2_addrs[] = {
@@ -3276,7 +3277,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.mpu_irqs	= omap44xx_mcspi2_irqs,
 	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi2_sdma_reqs),
 	.main_clk	= "mcspi2_fck",
 	.prcm = {
 		.omap4 = {
@@ -3301,6 +3301,7 @@ static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] = {
 	{ .name = "rx0", .dma_req = 15 + OMAP44XX_DMA_REQ_START },
 	{ .name = "tx1", .dma_req = 22 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx1", .dma_req = 23 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mcspi3_addrs[] = {
@@ -3336,7 +3337,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.mpu_irqs	= omap44xx_mcspi3_irqs,
 	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi3_sdma_reqs),
 	.main_clk	= "mcspi3_fck",
 	.prcm = {
 		.omap4 = {
@@ -3359,6 +3359,7 @@ static struct omap_hwmod_irq_info omap44xx_mcspi4_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 69 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx0", .dma_req = 70 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mcspi4_addrs[] = {
@@ -3394,7 +3395,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.mpu_irqs	= omap44xx_mcspi4_irqs,
 	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi4_sdma_reqs),
 	.main_clk	= "mcspi4_fck",
 	.prcm = {
 		.omap4 = {
@@ -3439,6 +3439,7 @@ static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mmc1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 60 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 61 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 /* mmc1 master ports */
@@ -3479,7 +3480,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.mpu_irqs	= omap44xx_mmc1_irqs,
 	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc1_sdma_reqs),
 	.main_clk	= "mmc1_fck",
 	.prcm		= {
 		.omap4 = {
@@ -3503,6 +3503,7 @@ static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mmc2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 46 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 47 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 /* mmc2 master ports */
@@ -3538,7 +3539,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.mpu_irqs	= omap44xx_mmc2_irqs,
 	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc2_sdma_reqs),
 	.main_clk	= "mmc2_fck",
 	.prcm		= {
 		.omap4 = {
@@ -3562,6 +3562,7 @@ static struct omap_hwmod_irq_info omap44xx_mmc3_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mmc3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 76 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 77 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mmc3_addrs[] = {
@@ -3592,7 +3593,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.mpu_irqs	= omap44xx_mmc3_irqs,
 	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc3_sdma_reqs),
 	.main_clk	= "mmc3_fck",
 	.prcm		= {
 		.omap4 = {
@@ -3614,6 +3614,7 @@ static struct omap_hwmod_irq_info omap44xx_mmc4_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mmc4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 56 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 57 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mmc4_addrs[] = {
@@ -3645,7 +3646,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.mpu_irqs	= omap44xx_mmc4_irqs,
 
 	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc4_sdma_reqs),
 	.main_clk	= "mmc4_fck",
 	.prcm		= {
 		.omap4 = {
@@ -3667,6 +3667,7 @@ static struct omap_hwmod_irq_info omap44xx_mmc5_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_mmc5_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 58 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 59 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_mmc5_addrs[] = {
@@ -3697,7 +3698,6 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.mpu_irqs	= omap44xx_mmc5_irqs,
 	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc5_sdma_reqs),
 	.main_clk	= "mmc5_fck",
 	.prcm		= {
 		.omap4 = {
@@ -4617,6 +4617,7 @@ static struct omap_hwmod_irq_info omap44xx_uart1_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_uart1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 48 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 49 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_uart1_addrs[] = {
@@ -4647,7 +4648,6 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.mpu_irqs	= omap44xx_uart1_irqs,
 	.sdma_reqs	= omap44xx_uart1_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_uart1_sdma_reqs),
 	.main_clk	= "uart1_fck",
 	.prcm = {
 		.omap4 = {
@@ -4669,6 +4669,7 @@ static struct omap_hwmod_irq_info omap44xx_uart2_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_uart2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 50 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 51 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_uart2_addrs[] = {
@@ -4699,7 +4700,6 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.mpu_irqs	= omap44xx_uart2_irqs,
 	.sdma_reqs	= omap44xx_uart2_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_uart2_sdma_reqs),
 	.main_clk	= "uart2_fck",
 	.prcm = {
 		.omap4 = {
@@ -4721,6 +4721,7 @@ static struct omap_hwmod_irq_info omap44xx_uart3_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_uart3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 52 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 53 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_uart3_addrs[] = {
@@ -4752,7 +4753,6 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
 	.mpu_irqs	= omap44xx_uart3_irqs,
 	.sdma_reqs	= omap44xx_uart3_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_uart3_sdma_reqs),
 	.main_clk	= "uart3_fck",
 	.prcm = {
 		.omap4 = {
@@ -4774,6 +4774,7 @@ static struct omap_hwmod_irq_info omap44xx_uart4_irqs[] = {
 static struct omap_hwmod_dma_info omap44xx_uart4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 54 + OMAP44XX_DMA_REQ_START },
 	{ .name = "rx", .dma_req = 55 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod_addr_space omap44xx_uart4_addrs[] = {
@@ -4804,7 +4805,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.mpu_irqs	= omap44xx_uart4_irqs,
 	.sdma_reqs	= omap44xx_uart4_sdma_reqs,
-	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_uart4_sdma_reqs),
 	.main_clk	= "uart4_fck",
 	.prcm = {
 		.omap4 = {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 3bd6d1d..822556e 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -112,7 +112,7 @@ struct omap_hwmod_irq_info {
 /**
  * struct omap_hwmod_dma_info - DMA channels used by the hwmod
  * @name: name of the DMA channel (module local name)
- * @dma_req: DMA request ID
+ * @dma_req: DMA request ID (should be non-negative except -1 = terminator)
  *
  * @name should be something short, e.g., "tx" or "rx".  It is for use
  * by platform_get_resource_byname().  It is defined locally to the
@@ -120,7 +120,7 @@ struct omap_hwmod_irq_info {
  */
 struct omap_hwmod_dma_info {
 	const char	*name;
-	u16		dma_req;
+	s16		dma_req;
 };
 
 /**
@@ -467,7 +467,7 @@ struct omap_hwmod_class {
  * @class: struct omap_hwmod_class * to the class of this hwmod
  * @od: struct omap_device currently associated with this hwmod (internal use)
  * @mpu_irqs: ptr to an array of MPU IRQs
- * @sdma_reqs: ptr to an array of System DMA request IDs (see sdma_reqs_cnt)
+ * @sdma_reqs: ptr to an array of System DMA request IDs
  * @prcm: PRCM data pertaining to this hwmod
  * @main_clk: main clock: OMAP clock name
  * @_clk: pointer to the main struct clk (filled in at runtime)
@@ -480,7 +480,6 @@ struct omap_hwmod_class {
  * @_sysc_cache: internal-use hwmod flags
  * @_mpu_rt_va: cached register target start address (internal use)
  * @_mpu_port_index: cached MPU register target slave ID (internal use)
- * @sdma_reqs_cnt: number of @sdma_reqs
  * @opt_clks_cnt: number of @opt_clks
  * @master_cnt: number of @master entries
  * @slaves_cnt: number of @slave entries
@@ -528,7 +527,6 @@ struct omap_hwmod {
 	u16				flags;
 	u8				_mpu_port_index;
 	u8				response_lat;
-	u8				sdma_reqs_cnt;
 	u8				rst_lines_cnt;
 	u8				opt_clks_cnt;
 	u8				masters_cnt;


