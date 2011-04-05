From: "Avinash.H.M" <avinashhm@ti.com>
Subject: [PATCH 2/2 v2] OMAP2/3: hwmod: fix gpio-reset timeouts seen during bootup.
Date: Tue,  5 Apr 2011 21:10:15 +0530
Message-ID: <1302018015-8858-3-git-send-email-avinashhm@ti.com>
References: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57965 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1DEPkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 11:40:49 -0400
In-Reply-To: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Avinash.H.M" <avinashhm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

GPIO module expects the debounce clocks to be enabled during reset. It doesn't
reset properly and timeouts are seen, if this clock isn't enabled during
reset. Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flags to the GPIO HWMODs, with
which the debounce clocks are enabled during reset.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Avinash.H.M <avinashhm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    4 ++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    5 +++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 ++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 82ff5f7..e0bda0a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1640,6 +1640,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio1_slaves[] = {
 
 static struct omap_hwmod omap2420_gpio1_hwmod = {
 	.name		= "gpio1",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap242x_gpio1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio1_irqs),
 	.main_clk	= "gpios_fck",
@@ -1670,6 +1671,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio2_slaves[] = {
 
 static struct omap_hwmod omap2420_gpio2_hwmod = {
 	.name		= "gpio2",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap242x_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio2_irqs),
 	.main_clk	= "gpios_fck",
@@ -1700,6 +1702,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio3_slaves[] = {
 
 static struct omap_hwmod omap2420_gpio3_hwmod = {
 	.name		= "gpio3",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap242x_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio3_irqs),
 	.main_clk	= "gpios_fck",
@@ -1730,6 +1733,7 @@ static struct omap_hwmod_ocp_if *omap2420_gpio4_slaves[] = {
 
 static struct omap_hwmod omap2420_gpio4_hwmod = {
 	.name		= "gpio4",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap242x_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio4_irqs),
 	.main_clk	= "gpios_fck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index ce292f0..99cd7bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1743,6 +1743,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio1_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio1_hwmod = {
 	.name		= "gpio1",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio1_irqs),
 	.main_clk	= "gpios_fck",
@@ -1773,6 +1774,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio2_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio2_hwmod = {
 	.name		= "gpio2",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio2_irqs),
 	.main_clk	= "gpios_fck",
@@ -1803,6 +1805,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio3_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio3_hwmod = {
 	.name		= "gpio3",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio3_irqs),
 	.main_clk	= "gpios_fck",
@@ -1833,6 +1836,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio4_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio4_hwmod = {
 	.name		= "gpio4",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio4_irqs),
 	.main_clk	= "gpios_fck",
@@ -1863,6 +1867,7 @@ static struct omap_hwmod_ocp_if *omap2430_gpio5_slaves[] = {
 
 static struct omap_hwmod omap2430_gpio5_hwmod = {
 	.name		= "gpio5",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap243x_gpio5_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio5_irqs),
 	.main_clk	= "gpio5_fck",
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c74f972..7552b2f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2142,6 +2142,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio1_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio1_hwmod = {
 	.name		= "gpio1",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio1_irqs),
 	.main_clk	= "gpio1_ick",
@@ -2178,6 +2179,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio2_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio2_hwmod = {
 	.name		= "gpio2",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio2_irqs),
 	.main_clk	= "gpio2_ick",
@@ -2214,6 +2216,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio3_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio3_hwmod = {
 	.name		= "gpio3",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio3_irqs),
 	.main_clk	= "gpio3_ick",
@@ -2250,6 +2253,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio4_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 	.name		= "gpio4",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio4_irqs),
 	.main_clk	= "gpio4_ick",
@@ -2286,6 +2290,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio5_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 	.name		= "gpio5",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio5_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio5_irqs),
 	.main_clk	= "gpio5_ick",
@@ -2322,6 +2327,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio6_slaves[] = {
 
 static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 	.name		= "gpio6",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap3xxx_gpio6_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio6_irqs),
 	.main_clk	= "gpio6_ick",
-- 
1.7.1

