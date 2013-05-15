From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 3/6] ARM: OMAP2+: hwmod-data: UART IP needs software control to manage sidle modes
Date: Wed, 15 May 2013 20:18:39 +0530
Message-ID: <1368629322-3170-4-git-send-email-rnayak@ti.com>
References: <1368629322-3170-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58303 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759384Ab3EOOtp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 May 2013 10:49:45 -0400
In-Reply-To: <1368629322-3170-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: santosh.shilimkar@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, nm@ti.com, Rajendra Nayak <rnayak@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP UART IP needs software control for slave idle modes based on functional
state of the IP. i.e The IP slave idle settings should be set to 'noidle' when
being used and then put back to 'smart_idle' when unused. Currently this is
handled by the driver with function pointers implemented in platform code.
This however breaks in case of device tree because of missing idle handling
APIs.

Previous patches in this series added a flag HWMOD_SWSUP_SIDLE_ACTIVE which
takes care of the mentioned requirement. Hence add the flag for all UART IPs
to take advantage of feature supported by framework.

Subsequent patches removes the slave idle handling from driver code.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index c8c64b3..d05fc7b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -512,6 +512,7 @@ struct omap_hwmod omap2xxx_uart1_hwmod = {
 	.mpu_irqs	= omap2_uart1_mpu_irqs,
 	.sdma_reqs	= omap2_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -531,6 +532,7 @@ struct omap_hwmod omap2xxx_uart2_hwmod = {
 	.mpu_irqs	= omap2_uart2_mpu_irqs,
 	.sdma_reqs	= omap2_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -550,6 +552,7 @@ struct omap_hwmod omap2xxx_uart3_hwmod = {
 	.mpu_irqs	= omap2_uart3_mpu_irqs,
 	.sdma_reqs	= omap2_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 01d8f32..075f7cc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1995,6 +1995,7 @@ static struct omap_hwmod am33xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &uart_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= am33xx_uart1_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
@@ -2015,6 +2016,7 @@ static struct omap_hwmod am33xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= am33xx_uart2_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
@@ -2042,6 +2044,7 @@ static struct omap_hwmod am33xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= am33xx_uart3_irqs,
 	.sdma_reqs	= uart3_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
@@ -2062,6 +2065,7 @@ static struct omap_hwmod am33xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= am33xx_uart4_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
@@ -2082,6 +2086,7 @@ static struct omap_hwmod am33xx_uart5_hwmod = {
 	.name		= "uart5",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= am33xx_uart5_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
@@ -2102,6 +2107,7 @@ static struct omap_hwmod am33xx_uart6_hwmod = {
 	.name		= "uart6",
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= am33xx_uart6_irqs,
 	.sdma_reqs	= uart1_edma_reqs,
 	.main_clk	= "dpll_per_m2_div4_ck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 4083606..31c7126 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -490,6 +490,7 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.mpu_irqs	= omap2_uart1_mpu_irqs,
 	.sdma_reqs	= omap2_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -508,6 +509,7 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.mpu_irqs	= omap2_uart2_mpu_irqs,
 	.sdma_reqs	= omap2_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = CORE_MOD,
@@ -526,6 +528,7 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.mpu_irqs	= omap2_uart3_mpu_irqs,
 	.sdma_reqs	= omap2_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = OMAP3430_PER_MOD,
@@ -555,6 +558,7 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
 	.mpu_irqs	= uart4_mpu_irqs,
 	.sdma_reqs	= uart4_sdma_reqs,
 	.main_clk	= "uart4_fck",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
 		.omap2 = {
 			.module_offs = OMAP3430_PER_MOD,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index eaba9dc..848b6dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3434,6 +3434,7 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= omap44xx_uart1_irqs,
 	.sdma_reqs	= omap44xx_uart1_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
@@ -3462,6 +3463,7 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= omap44xx_uart2_irqs,
 	.sdma_reqs	= omap44xx_uart2_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
@@ -3490,7 +3492,8 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
+				HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= omap44xx_uart3_irqs,
 	.sdma_reqs	= omap44xx_uart3_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
@@ -3519,6 +3522,7 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= omap44xx_uart4_irqs,
 	.sdma_reqs	= omap44xx_uart4_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
-- 
1.7.9.5

