From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 24/86] [ARM] omap: watchdog: provide a dummy ick for OMAP1
Date: Thu, 12 Mar 2009 11:27:34 -0700
Message-ID: <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbZCLSap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:45 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:43 -0700 (PDT)
In-Reply-To: <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Eliminate the OMAP1 vs OMAP2 clock knowledge in the watchdog driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c |    2 ++
 drivers/watchdog/omap_wdt.c |   23 ++++++++---------------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 8ae7827..758abaa 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -86,6 +86,8 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK("omap_wdt",	"fck",		&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap_wdt",	"ick",		&armper_ck.clk,	CK_16XX),
+	CLK("omap_wdt", "ick",		&dummy_ck,	CK_1510 | CK_310),
 	CLK(NULL,	"arminth_ck",	&arminth_ck1510, CK_1510 | CK_310),
 	CLK(NULL,	"arminth_ck",	&arminth_ck16xx, CK_16XX),
 	/* CK_GEN2 clocks */
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1a4c699..aa5ad6e 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -145,8 +145,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	if (wdev->ick)
-		clk_enable(wdev->ick);    /* Enable the interface clock */
+	clk_enable(wdev->ick);    /* Enable the interface clock */
 	clk_enable(wdev->fck);    /* Enable the functional clock */
 
 	/* initialize prescaler */
@@ -176,8 +175,7 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 
 	omap_wdt_disable(wdev);
 
-	if (wdev->ick)
-		clk_disable(wdev->ick);
+	clk_disable(wdev->ick);
 	clk_disable(wdev->fck);
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
@@ -294,13 +292,11 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 	wdev->omap_wdt_users = 0;
 	wdev->mem = mem;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		wdev->ick = clk_get(&pdev->dev, "ick");
-		if (IS_ERR(wdev->ick)) {
-			ret = PTR_ERR(wdev->ick);
-			wdev->ick = NULL;
-			goto err_clk;
-		}
+	wdev->ick = clk_get(&pdev->dev, "ick");
+	if (IS_ERR(wdev->ick)) {
+		ret = PTR_ERR(wdev->ick);
+		wdev->ick = NULL;
+		goto err_clk;
 	}
 	wdev->fck = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(wdev->fck)) {
@@ -383,10 +379,7 @@ static int omap_wdt_remove(struct platform_device *pdev)
 	release_mem_region(res->start, res->end - res->start + 1);
 	platform_set_drvdata(pdev, NULL);
 
-	if (wdev->ick) {
-		clk_put(wdev->ick);
-	}
-
+	clk_put(wdev->ick);
 	clk_put(wdev->fck);
 	iounmap(wdev->base);
 
-- 
1.6.1.2

