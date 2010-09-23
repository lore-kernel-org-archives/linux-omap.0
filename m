From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC] omap: mailbox: fix detection for previously supported chips
Date: Wed, 22 Sep 2010 19:21:39 -0500
Message-ID: <1285201299-18306-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43404 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab0IWAbL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 20:31:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Fix the mailbox support detection for OMAP3630, 3530/25 and 2430.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
- Testing was made under 3630 and 3430 boards.
- Given that 2430 uses similar initialization than OMAP3, changes
  to handle this case was added to the patch.
- HWMOD adaptation hopefully should solve this mess, but as of now
  mailbox should work as before at least.

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

