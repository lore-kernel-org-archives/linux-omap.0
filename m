From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 13/16] OMAP4: hwmod data: Fix L3 interconnect data order and alignement
Date: Thu, 23 Jun 2011 19:43:42 +0200
Message-ID: <1308851025-26313-14-git-send-email-b-cousson@ti.com>
References: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52880 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934018Ab1FWRoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 13:44:32 -0400
In-Reply-To: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Change the position of the ocp_if structure to match the template.

Remove unneeded comma at the end of address space flag field.

Remove USER_SDMA since this ocp link is only from the l3_main_1
path that is accessible only from the MPU in that case and not
the SDMA.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e1c69ff..58843df 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -264,17 +264,11 @@ static struct omap_hwmod_ocp_if omap44xx_mmc2__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* L3 target configuration and error log registers */
-static struct omap_hwmod_irq_info omap44xx_l3_targ_irqs[] = {
-	{ .irq = 9  + OMAP44XX_IRQ_GIC_START },
-	{ .irq = 10 + OMAP44XX_IRQ_GIC_START },
-};
-
 static struct omap_hwmod_addr_space omap44xx_l3_main_1_addrs[] = {
 	{
 		.pa_start	= 0x44000000,
 		.pa_end		= 0x44000fff,
-		.flags		= ADDR_TYPE_RT,
+		.flags		= ADDR_TYPE_RT
 	},
 };
 
@@ -285,7 +279,7 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 	.clk		= "l3_div_ck",
 	.addr		= omap44xx_l3_main_1_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.user		= OCP_USER_MPU,
 };
 
 /* l3_main_1 slave ports */
@@ -299,13 +293,18 @@ static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] = {
 	&omap44xx_mpu__l3_main_1,
 };
 
+static struct omap_hwmod_irq_info omap44xx_l3_main_1_irqs[] = {
+	{ .name = "dbg_err", .irq = 9 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "app_err", .irq = 10 + OMAP44XX_IRQ_GIC_START },
+};
+
 static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.name		= "l3_main_1",
 	.class		= &omap44xx_l3_hwmod_class,
-	.mpu_irqs	= omap44xx_l3_targ_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_targ_irqs),
 	.slaves		= omap44xx_l3_main_1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_slaves),
+	.mpu_irqs	= omap44xx_l3_main_1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_l3_main_1_irqs),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -354,7 +353,7 @@ static struct omap_hwmod_addr_space omap44xx_l3_main_2_addrs[] = {
 	{
 		.pa_start	= 0x44800000,
 		.pa_end		= 0x44801fff,
-		.flags		= ADDR_TYPE_RT,
+		.flags		= ADDR_TYPE_RT
 	},
 };
 
@@ -365,7 +364,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
 	.clk		= "l3_div_ck",
 	.addr		= omap44xx_l3_main_2_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_l3_main_2_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.user		= OCP_USER_MPU,
 };
 
 /* l4_cfg -> l3_main_2 */
@@ -409,7 +408,7 @@ static struct omap_hwmod_addr_space omap44xx_l3_main_3_addrs[] = {
 	{
 		.pa_start	= 0x45000000,
 		.pa_end		= 0x45000fff,
-		.flags		= ADDR_TYPE_RT,
+		.flags		= ADDR_TYPE_RT
 	},
 };
 
@@ -420,7 +419,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_3 = {
 	.clk		= "l3_div_ck",
 	.addr		= omap44xx_l3_main_3_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_l3_main_3_addrs),
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.user		= OCP_USER_MPU,
 };
 
 /* l3_main_2 -> l3_main_3 */
-- 
1.7.0.4

