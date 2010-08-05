From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 6/7] OMAP: hwmod: Temporary prevent reset during _setup for GPIOs
Date: Thu,  5 Aug 2010 17:47:55 +0200
Message-ID: <1281023276-15679-7-git-send-email-b-cousson@ti.com>
References: <1281023276-15679-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39663 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933260Ab0HEPsS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 11:48:18 -0400
In-Reply-To: <1281023276-15679-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, Benoit Cousson <b-cousson@ti.com>

For some reason, GPIO 2, 3, 4, 5 and 6 does not return the resetdone
status after a softreset.
The reset still seems to work fine becasue all the other registers
are reset with the default values.
Prevent the softreset until the root cause is found.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 83a208d..5d440d5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1704,6 +1704,7 @@ static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
 static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio2_irqs),
 	.main_clk	= "gpio2_ick",
@@ -1755,6 +1756,7 @@ static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
 static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio3_irqs),
 	.main_clk	= "gpio3_ick",
@@ -1806,6 +1808,7 @@ static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
 static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio4_irqs),
 	.main_clk	= "gpio4_ick",
@@ -1857,6 +1860,7 @@ static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
 static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.name		= "gpio5",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_gpio5_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio5_irqs),
 	.main_clk	= "gpio5_ick",
@@ -1908,6 +1912,7 @@ static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
 static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.name		= "gpio6",
 	.class		= &omap44xx_gpio_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_gpio6_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio6_irqs),
 	.main_clk	= "gpio6_ick",
-- 
1.6.1.3

