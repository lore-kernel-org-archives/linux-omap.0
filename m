From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/4] OMAP4: HWMOD: fix DSS reset
Date: Tue,  2 Aug 2011 13:33:24 +0300
Message-ID: <1312281204-4708-4-git-send-email-tomi.valkeinen@ti.com>
References: <1312281204-4708-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59248 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753092Ab1HBKeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 06:34:06 -0400
Received: by fxbb27 with SMTP id b27so7591891fxb.18
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 03:34:04 -0700 (PDT)
In-Reply-To: <1312281204-4708-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Benoit Cousson <b-cousson@ti.com>

The HWMOD code currently fails to reset dispc and rfbi modules.

This patch adds all DSS clocks as opt clocks for dispc, and sets
HWMOD_CONTROL_OPT_CLKS_IN_RESET. This seems to fix the issue, although
this feels like a hack.

The reason why this patch fixes the reset issue is probably because
dispc is the first DSS module being reset, and by enabling all the
clocks during dispc's reset we also allow the other DSS modules to
finish their reset as a side effect.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 21f03d4..4731f6b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1349,8 +1349,15 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] = {
 	&omap44xx_l4_per__dss_dispc,
 };
 
+static struct omap_hwmod_opt_clk dss_dispc_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+	{ .role = "tv_clk", .clk = "dss_tv_clk" },
+	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap44xx_dispc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
 	.mpu_irqs	= omap44xx_dss_dispc_irqs,
@@ -1362,6 +1369,8 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
+	.opt_clks	= dss_dispc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
 	.slaves		= omap44xx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.7.4.1

