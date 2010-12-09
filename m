From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 5/5] OMAP4: hwmod & clock data: Fix GPIO opt_clks and ocp_if iclk
Date: Fri, 10 Dec 2010 00:33:35 +0100
Message-ID: <1291937615-18571-6-git-send-email-b-cousson@ti.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52348 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315Ab0LIXei (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 18:34:38 -0500
In-Reply-To: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Fix opt clocks name in clock framework and hwmod.

Add the missing iclk in the ocp_if structure.

Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to ensure
the the GPIO optional clock is enable during reset.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Tested-by: Charulatha V <charu@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c       |   12 ++++++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   23 +++++++++++++++++------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 1599836..c59a5a9 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2856,17 +2856,17 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),
 	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
 	CLK(NULL,	"fpka_fck",			&fpka_fck,	CK_443X),
-	CLK(NULL,	"gpio1_dbck",			&gpio1_dbclk,	CK_443X),
+	CLK(NULL,	"gpio1_dbclk",			&gpio1_dbclk,	CK_443X),
 	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_443X),
-	CLK(NULL,	"gpio2_dbck",			&gpio2_dbclk,	CK_443X),
+	CLK(NULL,	"gpio2_dbclk",			&gpio2_dbclk,	CK_443X),
 	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_443X),
-	CLK(NULL,	"gpio3_dbck",			&gpio3_dbclk,	CK_443X),
+	CLK(NULL,	"gpio3_dbclk",			&gpio3_dbclk,	CK_443X),
 	CLK(NULL,	"gpio3_ick",			&gpio3_ick,	CK_443X),
-	CLK(NULL,	"gpio4_dbck",			&gpio4_dbclk,	CK_443X),
+	CLK(NULL,	"gpio4_dbclk",			&gpio4_dbclk,	CK_443X),
 	CLK(NULL,	"gpio4_ick",			&gpio4_ick,	CK_443X),
-	CLK(NULL,	"gpio5_dbck",			&gpio5_dbclk,	CK_443X),
+	CLK(NULL,	"gpio5_dbclk",			&gpio5_dbclk,	CK_443X),
 	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_443X),
-	CLK(NULL,	"gpio6_dbck",			&gpio6_dbclk,	CK_443X),
+	CLK(NULL,	"gpio6_dbclk",			&gpio6_dbclk,	CK_443X),
 	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_443X),
 	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_443X),
 	CLK(NULL,	"gpu_fck",			&gpu_fck,	CK_443X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 102c76f..0ed9cdd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -696,6 +696,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__gpio1 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_gpio1_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
 	.addr		= omap44xx_gpio1_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio1_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -707,7 +708,7 @@ static struct omap_hwmod_ocp_if *omap44xx_gpio1_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
+	{ .role = "dbclk", .clk = "gpio1_dbclk" },
 };
 
 static struct omap_hwmod omap44xx_gpio1_hwmod = {
@@ -747,6 +748,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio2_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio2_hwmod,
+	.clk		= "l4_div_ck",
 	.addr		= omap44xx_gpio2_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio2_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -758,12 +760,13 @@ static struct omap_hwmod_ocp_if *omap44xx_gpio2_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
+	{ .role = "dbclk", .clk = "gpio2_dbclk" },
 };
 
 static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio2_irqs),
 	.main_clk	= "gpio2_ick",
@@ -798,6 +801,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio3_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio3_hwmod,
+	.clk		= "l4_div_ck",
 	.addr		= omap44xx_gpio3_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio3_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -809,12 +813,13 @@ static struct omap_hwmod_ocp_if *omap44xx_gpio3_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
+	{ .role = "dbclk", .clk = "gpio3_dbclk" },
 };
 
 static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio3_irqs),
 	.main_clk	= "gpio3_ick",
@@ -849,6 +854,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio4_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio4_hwmod,
+	.clk		= "l4_div_ck",
 	.addr		= omap44xx_gpio4_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio4_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -860,12 +866,13 @@ static struct omap_hwmod_ocp_if *omap44xx_gpio4_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
+	{ .role = "dbclk", .clk = "gpio4_dbclk" },
 };
 
 static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio4_irqs),
 	.main_clk	= "gpio4_ick",
@@ -900,6 +907,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio5_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio5 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio5_hwmod,
+	.clk		= "l4_div_ck",
 	.addr		= omap44xx_gpio5_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio5_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -911,12 +919,13 @@ static struct omap_hwmod_ocp_if *omap44xx_gpio5_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
+	{ .role = "dbclk", .clk = "gpio5_dbclk" },
 };
 
 static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.name		= "gpio5",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio5_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio5_irqs),
 	.main_clk	= "gpio5_ick",
@@ -951,6 +960,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio6_addrs[] = {
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio6_hwmod,
+	.clk		= "l4_div_ck",
 	.addr		= omap44xx_gpio6_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio6_addrs),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -962,12 +972,13 @@ static struct omap_hwmod_ocp_if *omap44xx_gpio6_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
-	{ .role = "dbclk", .clk = "sys_32k_ck" },
+	{ .role = "dbclk", .clk = "gpio6_dbclk" },
 };
 
 static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.name		= "gpio6",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio6_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio6_irqs),
 	.main_clk	= "gpio6_ick",
-- 
1.7.0.4

