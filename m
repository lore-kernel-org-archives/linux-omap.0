From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/7] OMAP3: clock: Camera module doesn't have IDLEST bit
Date: Tue, 14 Apr 2009 12:23:30 -0600
Message-ID: <20090414182328.22344.52886.stgit@localhost.localdomain>
References: <20090414182039.22344.49790.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45717 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbZDNS1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 14:27:13 -0400
In-Reply-To: <20090414182039.22344.49790.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Sergio Aguirre <saaguirre@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Sergio Aguirre <saaguirre@ti.com>

This patch avoids waiting for the camera module to become ready,
since it doesn't have IDLEST bit.

Based on a earlier hack done by Paul Walmsley on Sep 9 2008 on
linux-omap tree.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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


