From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Fix section mismatch warning.
Date: Wed, 19 Nov 2008 19:22:29 +0530
Message-ID: <1227102749-19536-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51580 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbYKSNwi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 08:52:38 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAJDqV28011377
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 07:52:36 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This warning is observed when building for OMAP3EVM with pm-20081106.

WARNING: vmlinux.o(.data+0x89d4): Section mismatch in reference from the variable omap3evm_twldata to the variable .init.data:generic3430_t2scripts_data
The variable omap3evm_twldata references
the variable __initdata generic3430_t2scripts_data
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a72772f..65e0bdc 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -130,7 +130,7 @@ static struct twl4030_madc_platform_data omap3evm_madc_data = {
 	.irq_line	= 1,
 };
 
-static struct twl4030_platform_data omap3evm_twldata = {
+static struct twl4030_platform_data __initdata omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
-- 
1.5.6

