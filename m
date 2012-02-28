From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/9] ARM: OMAP2/3: hwmod data: update old names
Date: Tue, 28 Feb 2012 04:10:51 -0700
Message-ID: <20120228111048.808.23906.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35169 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132Ab2B1LLd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:33 -0500
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Some of the 2xxx and 3xxx hwmod data files use the old naming style
for hwmods, ending in a "_hwmod".  These names are used by the OMAP
integration code to map hwmods to platform_devices, so they need to be
consistent, or the platform_devices won't be created.  Remove the
_hwmod suffix to conform with the rest of the OMAP SoC data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a5409ce..02a8b39 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1376,7 +1376,7 @@ static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
 };
 
 static struct omap_hwmod omap2420_mcspi1_hwmod = {
-	.name		= "mcspi1_hwmod",
+	.name		= "mcspi1",
 	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
 	.sdma_reqs	= omap2_mcspi1_sdma_reqs,
 	.main_clk	= "mcspi1_fck",
@@ -1405,7 +1405,7 @@ static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
 };
 
 static struct omap_hwmod omap2420_mcspi2_hwmod = {
-	.name		= "mcspi2_hwmod",
+	.name		= "mcspi2",
 	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
 	.sdma_reqs	= omap2_mcspi2_sdma_reqs,
 	.main_clk	= "mcspi2_fck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c4f56cb..e260ad7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1481,7 +1481,7 @@ static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
 };
 
 static struct omap_hwmod omap2430_mcspi1_hwmod = {
-	.name		= "mcspi1_hwmod",
+	.name		= "mcspi1",
 	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
 	.sdma_reqs	= omap2_mcspi1_sdma_reqs,
 	.main_clk	= "mcspi1_fck",
@@ -1510,7 +1510,7 @@ static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
 };
 
 static struct omap_hwmod omap2430_mcspi2_hwmod = {
-	.name		= "mcspi2_hwmod",
+	.name		= "mcspi2",
 	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
 	.sdma_reqs	= omap2_mcspi2_sdma_reqs,
 	.main_clk	= "mcspi2_fck",
@@ -1552,7 +1552,7 @@ static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
 };
 
 static struct omap_hwmod omap2430_mcspi3_hwmod = {
-	.name		= "mcspi3_hwmod",
+	.name		= "mcspi3",
 	.mpu_irqs	= omap2430_mcspi3_mpu_irqs,
 	.sdma_reqs	= omap2430_mcspi3_sdma_reqs,
 	.main_clk	= "mcspi3_fck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3c8dd92..536d0c6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1087,7 +1087,7 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 	.class		= &omap3xxx_timer_hwmod_class,
 };
 
-/* timer12*/
+/* timer12 */
 static struct omap_hwmod omap3xxx_timer12_hwmod;
 static struct omap_hwmod_irq_info omap3xxx_timer12_mpu_irqs[] = {
 	{ .irq = 95, },
@@ -2669,7 +2669,7 @@ static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] = {
 };
 
 static struct omap_hwmod omap34xx_sr1_hwmod = {
-	.name		= "sr1_hwmod",
+	.name		= "sr1",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
 	.vdd_name	= "mpu_iva",
@@ -2688,7 +2688,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 };
 
 static struct omap_hwmod omap36xx_sr1_hwmod = {
-	.name		= "sr1_hwmod",
+	.name		= "sr1",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
 	.vdd_name	= "mpu_iva",
@@ -2711,7 +2711,7 @@ static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] = {
 };
 
 static struct omap_hwmod omap34xx_sr2_hwmod = {
-	.name		= "sr2_hwmod",
+	.name		= "sr2",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
 	.vdd_name	= "core",
@@ -2730,7 +2730,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 };
 
 static struct omap_hwmod omap36xx_sr2_hwmod = {
-	.name		= "sr2_hwmod",
+	.name		= "sr2",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
 	.vdd_name	= "core",


