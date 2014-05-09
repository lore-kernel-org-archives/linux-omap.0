From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: omap4: hwmod_data: Clean up audio related structures (remove/merge them)
Date: Fri, 9 May 2014 11:11:31 +0300
Message-ID: <1399623091-30636-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40709 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbaEIIMK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 04:12:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

All audio related omap_hwmod_ocp_if *_dma can be removed from the data since
we can just add the user flag to the non dma structure.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 99 +++---------------------------
 1 file changed, 9 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 1219280bb976..41e54f759934 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3635,15 +3635,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_dmic_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> dmic (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_dmic_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_SDMA,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* dsp -> iva */
@@ -4209,15 +4201,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcbsp1_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> mcbsp1 (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_mcbsp1_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_SDMA,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_abe -> mcbsp2 */
@@ -4225,15 +4209,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcbsp2_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> mcbsp2 (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_mcbsp2_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_SDMA,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_abe -> mcbsp3 */
@@ -4241,15 +4217,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcbsp3_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> mcbsp3 (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_mcbsp3_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_SDMA,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_per -> mcbsp4 */
@@ -4265,15 +4233,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcpdm = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcpdm_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> mcpdm (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcpdm_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_mcpdm_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_SDMA,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_per -> mcspi1 */
@@ -4575,15 +4535,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer5_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> timer5 (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_timer5_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_SDMA,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_abe -> timer6 */
@@ -4591,15 +4543,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer6_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> timer6 (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_timer6_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_SDMA,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_abe -> timer7 */
@@ -4607,15 +4551,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer7_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> timer7 (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_timer7_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_SDMA,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_abe -> timer8 */
@@ -4623,15 +4559,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer8_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4_abe -> timer8 (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8_dma = {
-	.master		= &omap44xx_l4_abe_hwmod,
-	.slave		= &omap44xx_timer8_hwmod,
-	.clk		= "ocp_abe_iclk",
-	.user		= OCP_USER_SDMA,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_per -> timer9 */
@@ -4831,7 +4759,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l3_instr__debugss,
 	&omap44xx_l4_cfg__dma_system,
 	&omap44xx_l4_abe__dmic,
-	&omap44xx_l4_abe__dmic_dma,
 	&omap44xx_dsp__iva,
 	/* &omap44xx_dsp__sl2if, */
 	&omap44xx_l4_cfg__dsp,
@@ -4874,14 +4801,10 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_abe__mcasp,
 	&omap44xx_l4_abe__mcasp_dma,
 	&omap44xx_l4_abe__mcbsp1,
-	&omap44xx_l4_abe__mcbsp1_dma,
 	&omap44xx_l4_abe__mcbsp2,
-	&omap44xx_l4_abe__mcbsp2_dma,
 	&omap44xx_l4_abe__mcbsp3,
-	&omap44xx_l4_abe__mcbsp3_dma,
 	&omap44xx_l4_per__mcbsp4,
 	&omap44xx_l4_abe__mcpdm,
-	&omap44xx_l4_abe__mcpdm_dma,
 	&omap44xx_l4_per__mcspi1,
 	&omap44xx_l4_per__mcspi2,
 	&omap44xx_l4_per__mcspi3,
@@ -4913,13 +4836,9 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__timer3,
 	&omap44xx_l4_per__timer4,
 	&omap44xx_l4_abe__timer5,
-	&omap44xx_l4_abe__timer5_dma,
 	&omap44xx_l4_abe__timer6,
-	&omap44xx_l4_abe__timer6_dma,
 	&omap44xx_l4_abe__timer7,
-	&omap44xx_l4_abe__timer7_dma,
 	&omap44xx_l4_abe__timer8,
-	&omap44xx_l4_abe__timer8_dma,
 	&omap44xx_l4_per__timer9,
 	&omap44xx_l4_per__timer10,
 	&omap44xx_l4_per__timer11,
-- 
1.9.2

