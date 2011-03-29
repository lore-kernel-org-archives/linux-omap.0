From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/5] OMAP4: l3: minor cleanup for parenthesis and extra spaces
Date: Tue, 29 Mar 2011 11:20:19 -0600
Message-ID: <1301419219-30547-6-git-send-email-omar.ramirez@ti.com>
References: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34326 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351Ab1C2Rbp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 13:31:45 -0400
In-Reply-To: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Removing unneeded parenthesis and two consecutive spaces around:
	std_err_main =  readl(std_err_main_addr);
			^^
While at it collapsing an if statement to detect the type of error
based on the irq received.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index def3de8..7b9f190 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -63,10 +63,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 	char *source_name;
 
 	/* Get the Type of interrupt */
-	if (irq == l3->app_irq)
-		inttype = L3_APPLICATION_ERROR;
-	else
-		inttype = L3_DEBUG_ERROR;
+	inttype = irq == l3->app_irq ? L3_APPLICATION_ERROR : L3_DEBUG_ERROR;
 
 	for (i = 0; i < L3_MODULES; i++) {
 		/*
@@ -84,10 +81,10 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 
 			err_src = j;
 			/* Read the stderrlog_main_source from clk domain */
-			std_err_main_addr = base + (*(l3_targ[i] + err_src));
-			std_err_main =  readl(std_err_main_addr);
+			std_err_main_addr = base + *(l3_targ[i] + err_src);
+			std_err_main = readl(std_err_main_addr);
 
-			switch ((std_err_main & CUSTOM_ERROR)) {
+			switch (std_err_main & CUSTOM_ERROR) {
 			case STANDARD_ERROR:
 				source_name =
 				l3_targ_stderrlog_main_name[i][err_src];
@@ -143,7 +140,7 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 	}
 
 	l3->l3_base[0] = ioremap(res->start, resource_size(res));
-	if (!(l3->l3_base[0])) {
+	if (!l3->l3_base[0]) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
 		goto err0;
@@ -157,7 +154,7 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 	}
 
 	l3->l3_base[1] = ioremap(res->start, resource_size(res));
-	if (!(l3->l3_base[1])) {
+	if (!l3->l3_base[1]) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
 		goto err1;
@@ -171,7 +168,7 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 	}
 
 	l3->l3_base[2] = ioremap(res->start, resource_size(res));
-	if (!(l3->l3_base[2])) {
+	if (!l3->l3_base[2]) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
 		goto err2;
-- 
1.7.1

