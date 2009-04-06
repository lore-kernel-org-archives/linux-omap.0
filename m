From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [RFC][PATCH] OMAP3: Clock FW: Camera module doesn't have IDLEST bit
Date: Mon, 6 Apr 2009 17:48:51 -0500
Message-ID: <A24693684029E5489D1D202277BE89442EB826F5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56146 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbZDFWtA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 18:49:00 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>

>From 8ea977337f4bd6121e9410bfd7f02fbd7f9cb762 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Mon, 6 Apr 2009 17:44:32 -0500
Subject: [PATCH] OMAP3: Clock FW: Camera module doesn't have IDLEST bit

This patch avoids waiting for the camera module to become ready,
since it doesn't have IDLEST bit.

Based on a earlier hack done by Paul Walmsley on Sep 9 2008 on
linux-omap tree.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
CC: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 70ec10d..f009017 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2052,7 +2052,7 @@ static struct clk dss_ick = {
 
 static struct clk cam_mclk = {
 	.name		= "cam_mclk",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &dpll4_m5x2_ck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
@@ -2063,7 +2063,7 @@ static struct clk cam_mclk = {
 static struct clk cam_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "cam_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
@@ -2074,7 +2074,7 @@ static struct clk cam_ick = {
 
 static struct clk csi2_96m_fck = {
 	.name		= "csi2_96m_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &core_96m_fck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
-- 
1.5.6.5

