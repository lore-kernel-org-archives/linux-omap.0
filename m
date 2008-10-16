From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 1/28] [OMAPZOOM] OMAP3PM: Change CSI2 clock name
Date: Wed, 15 Oct 2008 20:16:22 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568835@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41241 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbYJPBQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:16:29 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1GNOk007083
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:16:28 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1GN8i003001
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:16:23 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP3PM: Change CSI2 clock name

This patch sets the name of the clock to csi2_96m_fck, to be in sync
with the name of the same clock in Paul Walmsley's clock framework.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/clock_34xx.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: omapkernel/arch/arm/mach-omap2/clock_34xx.h
===================================================================
--- omapkernel.orig/arch/arm/mach-omap2/clock_34xx.h	2008-10-14 18:48:29.000000000 -0500
+++ omapkernel/arch/arm/mach-omap2/clock_34xx.h	2008-10-14 18:52:32.000000000 -0500
@@ -937,8 +937,8 @@
 	.recalc = &omap3_clk_recalc,
 };
 
-static struct clk csi2_fck = {
-	.name = "csi2_fck",
+static struct clk csi2_96m_fck = {
+	.name = "csi2_96m_fck",
 	.prcmid = PRCM_CSI2,
 	.parent = &func_96m_ck,
 	.flags = CLOCK_IN_OMAP343X | F_CLK | POWER_ON_REQUIRED,
@@ -1490,7 +1490,7 @@
 	&dss_ick,
 	&cam_mclk,
 	&cam_ick,
-	&csi2_fck,
+	&csi2_96m_fck,
 	&gpt1_fck,
 	&gpt1_ick,
 	&sync_32k_fck,
