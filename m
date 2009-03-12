From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 23/86] [ARM] omap: watchdog: convert clocks to match by devid and conid
Date: Thu, 12 Mar 2009 11:27:33 -0700
Message-ID: <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbZCLSam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:42 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:40 -0700 (PDT)
In-Reply-To: <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

This eliminates the need for separate OMAP24xx and OMAP34xx clock
requesting code sections.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c     |    2 +-
 arch/arm/mach-omap2/clock24xx.c |    4 +-
 arch/arm/mach-omap2/clock34xx.c |    4 +-
 drivers/watchdog/omap_wdt.c     |   93 ++++++++++----------------------------
 4 files changed, 30 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 88c7163..8ae7827 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -85,7 +85,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"arm_gpio_ck",	&arm_gpio_ck,	CK_1510 | CK_310),
 	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"armwdt_ck",	&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("omap_wdt",	"fck",		&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"arminth_ck",	&arminth_ck1510, CK_1510 | CK_310),
 	CLK(NULL,	"arminth_ck",	&arminth_ck16xx, CK_16XX),
 	/* CK_GEN2 clocks */
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 36093ea..6a6278e 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -163,8 +163,8 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"mpu_wdt_ick",	&mpu_wdt_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck,	CK_243X | CK_242X),
+	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X | CK_242X),
+	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X | CK_242X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 2c22750..b3334b3 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -214,10 +214,10 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
 	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_343X),
-	CLK(NULL,	"wdt2_fck",	&wdt2_fck,	CK_343X),
+	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_343X),
 	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
 	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
-	CLK(NULL,	"wdt2_ick",	&wdt2_ick,	CK_343X),
+	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_343X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_343X),
 	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_343X),
 	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 2f2ce74..1a4c699 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -60,9 +60,8 @@ struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
 	int             omap_wdt_users;
-	struct clk      *armwdt_ck;
-	struct clk      *mpu_wdt_ick;
-	struct clk      *mpu_wdt_fck;
+	struct clk      *ick;
+	struct clk      *fck;
 	struct resource *mem;
 	struct miscdevice omap_wdt_miscdev;
 };
@@ -146,13 +145,9 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	if (cpu_is_omap16xx())
-		clk_enable(wdev->armwdt_ck);	/* Enable the clock */
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
-		clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
-	}
+	if (wdev->ick)
+		clk_enable(wdev->ick);    /* Enable the interface clock */
+	clk_enable(wdev->fck);    /* Enable the functional clock */
 
 	/* initialize prescaler */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
@@ -181,13 +176,9 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 
 	omap_wdt_disable(wdev);
 
-	if (cpu_is_omap16xx())
-		clk_disable(wdev->armwdt_ck);	/* Disable the clock */
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
-		clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
-	}
+	if (wdev->ick)
+		clk_disable(wdev->ick);
+	clk_disable(wdev->fck);
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
 #endif
@@ -303,44 +294,21 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 	wdev->omap_wdt_users = 0;
 	wdev->mem = mem;
 
-	if (cpu_is_omap16xx()) {
-		wdev->armwdt_ck = clk_get(&pdev->dev, "armwdt_ck");
-		if (IS_ERR(wdev->armwdt_ck)) {
-			ret = PTR_ERR(wdev->armwdt_ck);
-			wdev->armwdt_ck = NULL;
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		wdev->ick = clk_get(&pdev->dev, "ick");
+		if (IS_ERR(wdev->ick)) {
+			ret = PTR_ERR(wdev->ick);
+			wdev->ick = NULL;
 			goto err_clk;
 		}
 	}
-
-	if (cpu_is_omap24xx()) {
-		wdev->mpu_wdt_ick = clk_get(&pdev->dev, "mpu_wdt_ick");
-		if (IS_ERR(wdev->mpu_wdt_ick)) {
-			ret = PTR_ERR(wdev->mpu_wdt_ick);
-			wdev->mpu_wdt_ick = NULL;
-			goto err_clk;
-		}
-		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "mpu_wdt_fck");
-		if (IS_ERR(wdev->mpu_wdt_fck)) {
-			ret = PTR_ERR(wdev->mpu_wdt_fck);
-			wdev->mpu_wdt_fck = NULL;
-			goto err_clk;
-		}
+	wdev->fck = clk_get(&pdev->dev, "fck");
+	if (IS_ERR(wdev->fck)) {
+		ret = PTR_ERR(wdev->fck);
+		wdev->fck = NULL;
+		goto err_clk;
 	}
 
-	if (cpu_is_omap34xx()) {
-		wdev->mpu_wdt_ick = clk_get(&pdev->dev, "wdt2_ick");
-		if (IS_ERR(wdev->mpu_wdt_ick)) {
-			ret = PTR_ERR(wdev->mpu_wdt_ick);
-			wdev->mpu_wdt_ick = NULL;
-			goto err_clk;
-		}
-		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "wdt2_fck");
-		if (IS_ERR(wdev->mpu_wdt_fck)) {
-			ret = PTR_ERR(wdev->mpu_wdt_fck);
-			wdev->mpu_wdt_fck = NULL;
-			goto err_clk;
-		}
-	}
 	wdev->base = ioremap(res->start, res->end - res->start + 1);
 	if (!wdev->base) {
 		ret = -ENOMEM;
@@ -380,12 +348,10 @@ err_ioremap:
 	wdev->base = NULL;
 
 err_clk:
-	if (wdev->armwdt_ck)
-		clk_put(wdev->armwdt_ck);
-	if (wdev->mpu_wdt_ick)
-		clk_put(wdev->mpu_wdt_ick);
-	if (wdev->mpu_wdt_fck)
-		clk_put(wdev->mpu_wdt_fck);
+	if (wdev->ick)
+		clk_put(wdev->ick);
+	if (wdev->fck)
+		clk_put(wdev->fck);
 	kfree(wdev);
 
 err_kzalloc:
@@ -417,20 +383,11 @@ static int omap_wdt_remove(struct platform_device *pdev)
 	release_mem_region(res->start, res->end - res->start + 1);
 	platform_set_drvdata(pdev, NULL);
 
-	if (wdev->armwdt_ck) {
-		clk_put(wdev->armwdt_ck);
-		wdev->armwdt_ck = NULL;
+	if (wdev->ick) {
+		clk_put(wdev->ick);
 	}
 
-	if (wdev->mpu_wdt_ick) {
-		clk_put(wdev->mpu_wdt_ick);
-		wdev->mpu_wdt_ick = NULL;
-	}
-
-	if (wdev->mpu_wdt_fck) {
-		clk_put(wdev->mpu_wdt_fck);
-		wdev->mpu_wdt_fck = NULL;
-	}
+	clk_put(wdev->fck);
 	iounmap(wdev->base);
 
 	kfree(wdev);
-- 
1.6.1.2

