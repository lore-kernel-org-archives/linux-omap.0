From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/6] Re-map the CTIs IRQs from MPU to DEBUGSS
Date: Wed, 9 May 2012 16:35:36 -0500
Message-ID: <1336599336-10866-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49102 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162Ab2EIVfm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 17:35:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

In order to use the CTI interrupts inconjunction with the DEBUGSS we need to
re-map the CTI IRQs to the DEBUGSS HWMOD. This is based upon Benoit Cousson's
patch [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073319.html

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4906129..4720947 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -482,10 +482,17 @@ static struct omap_hwmod_class omap44xx_debugss_hwmod_class = {
 };
 
 /* debugss */
+static struct omap_hwmod_irq_info omap44xx_debugss_irqs[] = {
+	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
 static struct omap_hwmod omap44xx_debugss_hwmod = {
 	.name		= "debugss",
 	.class		= &omap44xx_debugss_hwmod_class,
 	.clkdm_name	= "emu_sys_clkdm",
+	.mpu_irqs	= omap44xx_debugss_irqs,
 	.main_clk	= "trace_clk_div_ck",
 	.prcm = {
 		.omap4 = {
@@ -2446,8 +2453,6 @@ static struct omap_hwmod_class omap44xx_mpu_hwmod_class = {
 /* mpu */
 static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] = {
 	{ .name = "pl310", .irq = 0 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
 	{ .irq = -1 }
 };
 
-- 
1.7.5.4

