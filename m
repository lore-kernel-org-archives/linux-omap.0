From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 03/10] ARM: OMAP4: Re-map the CTIs IRQs from MPU to DEBUGSS
Date: Thu, 7 Jun 2012 16:22:05 -0500
Message-ID: <1339104132-26885-4-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39025 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932931Ab2FGVXB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 17:23:01 -0400
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

In order to use the CTI interrupts inconjunction with the DEBUGSS we need to
re-map the CTI IRQs to the DEBUGSS HWMOD. The purpose for doing this is so we
can create a PMU device based upon the DEBUGSS HWMOD and use the CTI interrupts
for routing ARM PMU events for OMAP4430 devices.

This is based upon Benoit Cousson's patch [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073319.html

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 950454a..faf5a6d 100644
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
@@ -2447,8 +2454,6 @@ static struct omap_hwmod_class omap44xx_mpu_hwmod_class = {
 /* mpu */
 static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] = {
 	{ .name = "pl310", .irq = 0 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
 	{ .irq = -1 }
 };
 
-- 
1.7.9.5

