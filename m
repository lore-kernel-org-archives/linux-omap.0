From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/5] OMAP2/3: hwmod: fix gpio-reset timeouts seen during
	bootup.
Date: Wed, 20 Apr 2011 13:28:47 -0600
Message-ID: <20110420192846.16986.65752.stgit@twilight.localdomain>
References: <20110420192601.16986.56558.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49018 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab1DTTpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Apr 2011 15:45:45 -0400
In-Reply-To: <20110420192601.16986.56558.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, "Avinash.H.M" <avinashhm@ti.com>

From: Avinash.H.M <avinashhm@ti.com>

GPIO module expects the debounce clocks to be enabled during reset. It doesn't
reset properly and timeouts are seen, if this clock isn't enabled during
reset. Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flags to the GPIO HWMODs, with
which the debounce clocks are enabled during reset.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Avinash.H.M <avinashhm@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    4 ++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    5 +++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 ++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index f50e56a..c4d0ae8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1639,6 +1639,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio1_slaves[] = {
 
 static struct omap_hwmod omap2420_gpio1_hwmod = {
 	.name		= "gpio1",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap242x_gpio1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio1_irqs),
 	.main_clk	= "gpios_fck",
@@ -1669,6 +1670,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio2_slaves[] = {
 
 static struct omap_hwmod omap2420_gpio2_hwmod = {
 	.name		= "gpio2",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap242x_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio2_irqs),
 	.main_clk	= "gpios_fck",
@@ -1699,6 +1701,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio3_slaves[] = {
 
 static struct omap_hwmod omap2420_gpio3_hwmod = {
 	.name		= "gpio3",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap242x_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio3_irqs),
 	.main_clk	= "gpios_fck",
@@ -1729,6 +1732,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio4_slaves[] = {
 
 static struct omap_hwmod omap2420_gpio4_hwmod = {
 	.name		= "gpio4",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap242x_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio4_irqs),
 	.main_clk	= "gpios_fck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 96753f7..9682dd5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1742,6 +1742,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio1_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio1_hwmod = {
 	.name		= "gpio1",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio1_irqs),
 	.main_clk	= "gpios_fck",
@@ -1772,6 +1773,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio2_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio2_hwmod = {
 	.name		= "gpio2",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio2_irqs),
 	.main_clk	= "gpios_fck",
@@ -1802,6 +1804,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio3_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio3_hwmod = {
 	.name		= "gpio3",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio3_irqs),
 	.main_clk	= "gpios_fck",
@@ -1832,6 +1835,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio4_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio4_hwmod = {
 	.name		= "gpio4",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio4_irqs),
 	.main_clk	= "gpios_fck",
@@ -1862,6 +1866,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio5_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio5_hwmod = {
 	.name		= "gpio5",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio5_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio5_irqs),
 	.main_clk	= "gpio5_fck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9bee155..909a84d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2141,6 +2141,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio1_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio1_hwmod = {
 	.name		= "gpio1",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio1_irqs),
 	.main_clk	= "gpio1_ick",
@@ -2177,6 +2178,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio2_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio2_hwmod = {
 	.name		= "gpio2",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio2_irqs),
 	.main_clk	= "gpio2_ick",
@@ -2213,6 +2215,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio3_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio3_hwmod = {
 	.name		= "gpio3",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio3_irqs),
 	.main_clk	= "gpio3_ick",
@@ -2249,6 +2252,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio4_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 	.name		= "gpio4",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio4_irqs),
 	.main_clk	= "gpio4_ick",
@@ -2285,6 +2289,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio5_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 	.name		= "gpio5",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio5_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio5_irqs),
 	.main_clk	= "gpio5_ick",
@@ -2321,6 +2326,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio6_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 	.name		= "gpio6",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio6_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio6_irqs),
 	.main_clk	= "gpio6_ick",


