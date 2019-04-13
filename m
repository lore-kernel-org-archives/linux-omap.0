From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ARM: OMAP2+: Make some variables static
Date: Sat, 13 Apr 2019 22:17:44 +0800
Message-ID: <20190413141744.34488-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com, linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-omap@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:532:25: warning: symbol 'am33xx_gpio_hwmod_class' was not declared. Should it be static?
arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:542:19: warning: symbol 'am33xx_gpio1_hwmod' was not declared. Should it be static?
arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:562:19: warning: symbol 'am33xx_gpio2_hwmod' was not declared. Should it be static?
arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:582:19: warning: symbol 'am33xx_gpio3_hwmod' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 4c3543b..adb6271 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -529,7 +529,7 @@ static struct omap_hwmod_class_sysconfig am33xx_gpio_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-struct omap_hwmod_class am33xx_gpio_hwmod_class = {
+static struct omap_hwmod_class am33xx_gpio_hwmod_class = {
 	.name		= "gpio",
 	.sysc		= &am33xx_gpio_sysc,
 };
@@ -539,7 +539,7 @@ static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio1_dbclk" },
 };
 
-struct omap_hwmod am33xx_gpio1_hwmod = {
+static struct omap_hwmod am33xx_gpio1_hwmod = {
 	.name		= "gpio2",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
@@ -559,7 +559,7 @@ static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio2_dbclk" },
 };
 
-struct omap_hwmod am33xx_gpio2_hwmod = {
+static struct omap_hwmod am33xx_gpio2_hwmod = {
 	.name		= "gpio3",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
@@ -579,7 +579,7 @@ static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio3_dbclk" },
 };
 
-struct omap_hwmod am33xx_gpio3_hwmod = {
+static struct omap_hwmod am33xx_gpio3_hwmod = {
 	.name		= "gpio4",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-- 
2.7.4
