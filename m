From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/2] omap: mailbox: fix detection for previously supported chips
Date: Thu, 23 Sep 2010 22:41:05 -0500
Message-ID: <1285299665-21639-2-git-send-email-omar.ramirez@ti.com>
References: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52697 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888Ab0IXDuh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 23:50:37 -0400
In-Reply-To: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Fix the mailbox detection for OMAP3630, 3530/25 and 2430.

Given that 2430 has an iva too include it, as the same steps
for omap3 apply.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
CC: Suman Anna <s-anna@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: linux-omap@vger.kernel.org
---
 arch/arm/mach-omap2/mailbox.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 42dbfa4..26d6fb0 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -394,15 +394,19 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 
 	if (false)
 		;
-#if defined(CONFIG_ARCH_OMAP3430)
-	else if (cpu_is_omap3430()) {
+#if defined(CONFIG_ARCH_OMAP3)
+	else if (omap3_has_iva()) {
 		list = omap3_mboxes;
 
 		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
 	}
 #endif
-#if defined(CONFIG_ARCH_OMAP2420)
-	else if (cpu_is_omap2420()) {
+#if defined(CONFIG_ARCH_OMAP2)
+	else if (cpu_is_omap2430()) {
+		list = omap2_mboxes;
+
+		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
+	} else if (cpu_is_omap2420()) {
 		list = omap2_mboxes;
 
 		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
-- 
1.7.1

