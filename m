From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] ARM: DRA7: hwmod: Add data for GPTimers 13 through 16
Date: Mon, 16 Mar 2015 15:54:53 -0500
Message-ID: <1426539294-28375-2-git-send-email-s-anna@ti.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37769 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773AbbCPUzZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 16:55:25 -0400
In-Reply-To: <1426539294-28375-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Add the hwmod data for GPTimers 13, 14, 15 and 16. All these
timers are present in the L4PER3 clock domain.

The corresponding DT nodes are already present but disabled.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 96 +++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index e8692e7675b8..d0f03e73add4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1958,6 +1958,66 @@ static struct omap_hwmod dra7xx_timer11_hwmod = {
 	},
 };
 
+/* timer13 */
+static struct omap_hwmod dra7xx_timer13_hwmod = {
+	.name		= "timer13",
+	.class		= &dra7xx_timer_hwmod_class,
+	.clkdm_name	= "l4per3_clkdm",
+	.main_clk	= "timer13_gfclk_mux",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER3_TIMER13_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER3_TIMER13_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/* timer14 */
+static struct omap_hwmod dra7xx_timer14_hwmod = {
+	.name		= "timer14",
+	.class		= &dra7xx_timer_hwmod_class,
+	.clkdm_name	= "l4per3_clkdm",
+	.main_clk	= "timer14_gfclk_mux",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER3_TIMER14_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER3_TIMER14_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/* timer15 */
+static struct omap_hwmod dra7xx_timer15_hwmod = {
+	.name		= "timer15",
+	.class		= &dra7xx_timer_hwmod_class,
+	.clkdm_name	= "l4per3_clkdm",
+	.main_clk	= "timer15_gfclk_mux",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER3_TIMER15_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER3_TIMER15_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/* timer16 */
+static struct omap_hwmod dra7xx_timer16_hwmod = {
+	.name		= "timer16",
+	.class		= &dra7xx_timer_hwmod_class,
+	.clkdm_name	= "l4per3_clkdm",
+	.main_clk	= "timer16_gfclk_mux",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER3_TIMER16_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER3_TIMER16_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /*
  * 'uart' class
  *
@@ -3112,6 +3172,38 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__timer11 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per3 -> timer13 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per3__timer13 = {
+	.master		= &dra7xx_l4_per3_hwmod,
+	.slave		= &dra7xx_timer13_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per3 -> timer14 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per3__timer14 = {
+	.master		= &dra7xx_l4_per3_hwmod,
+	.slave		= &dra7xx_timer14_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per3 -> timer15 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per3__timer15 = {
+	.master		= &dra7xx_l4_per3_hwmod,
+	.slave		= &dra7xx_timer15_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per3 -> timer16 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per3__timer16 = {
+	.master		= &dra7xx_l4_per3_hwmod,
+	.slave		= &dra7xx_timer16_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_per1 -> uart1 */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__uart1 = {
 	.master		= &dra7xx_l4_per1_hwmod,
@@ -3350,6 +3442,10 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per1__timer9,
 	&dra7xx_l4_per1__timer10,
 	&dra7xx_l4_per1__timer11,
+	&dra7xx_l4_per3__timer13,
+	&dra7xx_l4_per3__timer14,
+	&dra7xx_l4_per3__timer15,
+	&dra7xx_l4_per3__timer16,
 	&dra7xx_l4_per1__uart1,
 	&dra7xx_l4_per1__uart2,
 	&dra7xx_l4_per1__uart3,
-- 
2.3.2

