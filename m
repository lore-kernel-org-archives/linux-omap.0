From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
Date: Sat, 31 Jul 2010 23:15:48 +0530
Message-ID: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52940 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab0GaRpz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jul 2010 13:45:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The machine_kexec() calls outer_disable which can crash on OMAP4
becasue of trustzone restrictions.

This patch overrides the default l2x0_disable with a OMAP4
specific implementation taking care of trustzone

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 13dc979..b557cc2 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -44,6 +44,13 @@ void __init gic_init_irq(void)
 }
 
 #ifdef CONFIG_CACHE_L2X0
+
+static void omap4_l2x0_disable(void)
+{
+	/* Disable PL310 L2 Cache controller */
+	omap_smc1(0x102, 0x0);
+}
+
 static int __init omap_l2_cache_init(void)
 {
 	/*
@@ -66,6 +73,12 @@ static int __init omap_l2_cache_init(void)
 	 */
 	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
 
+	/*
+	 * Override default outer_cache.disable with a OMAP4
+	 * specific one
+	*/
+	outer_cache.disable = omap4_l2x0_disable;
+
 	return 0;
 }
 early_initcall(omap_l2_cache_init);
-- 
1.6.0.4

