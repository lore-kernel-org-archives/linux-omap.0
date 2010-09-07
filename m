From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/6] omap4: l2x0: Override the default l2x0_disable
Date: Tue,  7 Sep 2010 13:27:20 +0530
Message-ID: <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42707 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab0IGH6F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Sep 2010 03:58:05 -0400
In-Reply-To: <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

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

