From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/5] omap4: l2x0: Construct the AUXCTRL value using defines
Date: Fri, 19 Nov 2010 23:01:03 +0530
Message-ID: <1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
 <1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53787 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755907Ab0KSRb2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 12:31:28 -0500
In-Reply-To: <1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, mans@mansr.com, tony@atomide.com, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch removes the hardcoded value of auxctrl value and
construct it using bitfields

Bit 25 is reserved and is always set to 1. Same value
of this bit is retained in this patch

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 2f89555..c814604 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -53,6 +53,8 @@ static void omap4_l2x0_disable(void)
 
 static int __init omap_l2_cache_init(void)
 {
+	u32 aux_ctrl = 0;
+
 	/*
 	 * To avoid code running on other OMAPs in
 	 * multi-omap builds
@@ -72,10 +74,17 @@ static int __init omap_l2_cache_init(void)
 	 * Way size - 32KB (es1.0)
 	 * Way size - 64KB (es2.0 +)
 	 */
+	aux_ctrl = ((1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
+			(0x1 << 25) |
+			(0x1 << L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT) |
+			(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT));
+
 	if (omap_rev() == OMAP4430_REV_ES1_0)
-		l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
+		aux_ctrl |= 0x2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
 	else
-		l2x0_init(l2cache_base, 0x0e070000, 0xc0000fff);
+		aux_ctrl |= 0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
+
+	l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
 
 	/*
 	 * Override default outer_cache.disable with a OMAP4
-- 
1.6.0.4

