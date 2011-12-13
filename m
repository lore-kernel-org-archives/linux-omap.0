From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 1/5] OMAP3+: HWMOD: Add the default clockactivity for I2C
Date: Tue, 13 Dec 2011 16:25:54 +0530
Message-ID: <1323773758-6375-2-git-send-email-shubhrajyoti@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40494 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075Ab1LMK43 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 05:56:29 -0500
In-Reply-To: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, ben-linux@fluff.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Jon Hunter <jon-hunter@ti.com>

For I2C clockactivity field is added for OMAP3 and OMAP4 that defines how the
interface (OCP) and functional (system) clocks behave when the I2C module is
idle.

The configuration of the clock activity bit field (per TRM) is as follows:
0x0: Both clocks can be cut off
0x1: Only OCP clock must be kept active; system clock
     can be cut off
0x3: Both clocks must be kept active
0x2: Only system clock must be kept active; OCP clock
     can be cut off

The patch makes 0x2(CLOCKACT_TEST_ICLK) the default for OMAP3 and OMAP4.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 ++++---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7f8915a..1b59118 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1162,6 +1162,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
@@ -1636,7 +1637,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c1_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
-	.flags		= HWMOD_16BIT_REG,
+	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap2_i2c1_mpu_irqs,
 	.sdma_reqs	= omap2_i2c1_sdma_reqs,
 	.main_clk	= "i2c1_fck",
@@ -1670,7 +1671,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c2_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
-	.flags		= HWMOD_16BIT_REG,
+	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap2_i2c2_mpu_irqs,
 	.sdma_reqs	= omap2_i2c2_sdma_reqs,
 	.main_clk	= "i2c2_fck",
@@ -1715,7 +1716,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c3_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.name		= "i2c3",
-	.flags		= HWMOD_16BIT_REG,
+	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= i2c3_mpu_irqs,
 	.sdma_reqs	= i2c3_sdma_reqs,
 	.main_clk	= "i2c3_fck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index daaf165..c0d8a2e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2246,6 +2246,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP),
+	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -2300,7 +2301,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG,
+	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
 	.main_clk	= "i2c1_fck",
@@ -2356,7 +2357,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG,
+	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
 	.main_clk	= "i2c2_fck",
@@ -2412,7 +2413,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG,
+	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
 	.main_clk	= "i2c3_fck",
@@ -2468,7 +2469,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.flags		= HWMOD_16BIT_REG,
+	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
 	.main_clk	= "i2c4_fck",
-- 
1.7.1

