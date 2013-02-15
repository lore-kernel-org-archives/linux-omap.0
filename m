From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [RFC/RFT PATCH 1/2] ARM: OMAP2+: hwmod-data: UART IP needs software control of sidle modes
Date: Fri, 15 Feb 2013 17:38:26 +0530
Message-ID: <1360930106-32005-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35578 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab3BOMHS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 07:07:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: balbi@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

OMAP UART IP needs manual idle modes based on state of the
IP. Currently this is handled by the driver with function pointers
implemented in platform code.

This however breaks in case of device tree because of missing
idle handling. With the provided flags, idle mode handling is transparently
handled by runtime time pm code.

Subsequent patch removes the idle handling from driver code.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index e596117..1b67e9f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -512,6 +512,7 @@ struct omap_hwmod omap2xxx_uart1_hwmod = {
 	.mpu_irqs	= omap2_uart1_mpu_irqs,
 	.sdma_reqs	= omap2_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -531,6 +532,7 @@ struct omap_hwmod omap2xxx_uart2_hwmod = {
 	.mpu_irqs	= omap2_uart2_mpu_irqs,
 	.sdma_reqs	= omap2_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -550,6 +552,7 @@ struct omap_hwmod omap2xxx_uart3_hwmod = {
 	.mpu_irqs	= omap2_uart3_mpu_irqs,
 	.sdma_reqs	= omap2_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 646c14d..4e8cb65 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1908,6 +1908,7 @@ static struct omap_hwmod am33xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &uart_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= am33xx_uart1_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
@@ -1928,6 +1929,7 @@ static struct omap_hwmod am33xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= am33xx_uart2_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
@@ -1955,6 +1957,7 @@ static struct omap_hwmod am33xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= am33xx_uart3_irqs,
 	.sdma_reqs	= uart3_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
@@ -1975,6 +1978,7 @@ static struct omap_hwmod am33xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= am33xx_uart4_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
@@ -1995,6 +1999,7 @@ static struct omap_hwmod am33xx_uart5_hwmod = {
 	.name		= "uart5",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= am33xx_uart5_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
@@ -2015,6 +2020,7 @@ static struct omap_hwmod am33xx_uart6_hwmod = {
 	.name		= "uart6",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= am33xx_uart6_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8bb2628..dff0d77 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -490,6 +490,7 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.mpu_irqs	= omap2_uart1_mpu_irqs,
 	.sdma_reqs	= omap2_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -508,6 +509,7 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.mpu_irqs	= omap2_uart2_mpu_irqs,
 	.sdma_reqs	= omap2_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -526,6 +528,7 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.mpu_irqs	= omap2_uart3_mpu_irqs,
 	.sdma_reqs	= omap2_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = OMAP3430_PER_MOD,
@@ -555,6 +558,7 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
 	.mpu_irqs	= uart4_mpu_irqs,
 	.sdma_reqs	= uart4_sdma_reqs,
 	.main_clk	= "uart4_fck",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = OMAP3430_PER_MOD,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 793f54a..bc2d210 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3431,6 +3431,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_uart1_irqs,
 	.sdma_reqs	= omap44xx_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
@@ -3459,6 +3460,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_uart2_irqs,
 	.sdma_reqs	= omap44xx_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
@@ -3487,7 +3489,8 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
+				HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_uart3_irqs,
 	.sdma_reqs	= omap44xx_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
@@ -3516,6 +3519,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_uart4_irqs,
 	.sdma_reqs	= omap44xx_uart4_sdma_reqs,
 	.main_clk	= "uart4_fck",
-- 
1.7.9.5

