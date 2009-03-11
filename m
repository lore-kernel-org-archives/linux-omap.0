From: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Subject: [PATCH 5/6] OMAP: omap_wdt: Correct manage of activation states.
Date: Wed, 11 Mar 2009 17:29:37 +0200
Message-ID: <6bfd4bd0c37668c409e3c2154ba2ab22c8a42800.1236609434.git.ext-atal.shargorodsky__23902.4936491207$1236785560$gmane$org@nokia.com>
References: <>
 <1236785378-14640-1-git-send-email-ext-atal.shargorodsky@nokia.com>
 <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
 <0fe7f2934f8416e9b5f05e2f18766362560116ee.1236609434.git.ext-atal.shargorodsky@nokia.com>
 <7992fd993e5b420f9c2aac55f6e674169b36c666.1236609434.git.ext-atal.shargorodsky@nokia.com>
 <0db69821a1be58e0b8889609ff2b2ee272aa3286.1236609434.git.ext-atal.shargorodsky@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45611 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbZCKPbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 11:31:00 -0400
In-Reply-To: <0db69821a1be58e0b8889609ff2b2ee272aa3286.1236609434.git.ext-atal.shargorodsky@nokia.com>
In-Reply-To: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
References: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>

Needed to support CONFIG_WATCHDOG_NOWAYOUT option.

Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
---
 drivers/watchdog/omap_wdt.c |   40 ++++++++++++++++++++++++++--------------
 1 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index d033139..6f6a524 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -56,10 +56,13 @@ MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
 static unsigned int wdt_trgr_pattern = 0x1234;
 static spinlock_t wdt_lock;
 
+#define OMAP_WDT_STATE_OPENED_BIT	1
+#define OMAP_WDT_STATE_ACTIVATED_BIT	8
+
 struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
-	int             omap_wdt_users;
+	int             omap_wdt_state;
 	struct clk      *mpu_wdt_ick;
 	struct clk      *mpu_wdt_fck;
 	struct resource *mem;
@@ -152,19 +155,25 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
 	void __iomem *base = wdev->base;
 
-	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
+	if (test_and_set_bit(OMAP_WDT_STATE_OPENED_BIT,
+			(unsigned long *)&(wdev->omap_wdt_state)))
 		return -EBUSY;
 
 	omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
-	clk_enable(wdev->mpu_wdt_fck);
+	if (wdev->omap_wdt_state & (1 << OMAP_WDT_STATE_ACTIVATED_BIT))
+		omap_wdt_ping(wdev);
+	else {
+		clk_enable(wdev->mpu_wdt_fck);
 
-	/* initialize prescaler */
-	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
-		cpu_relax();
+		/* initialize prescaler */
+		while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
+			cpu_relax();
 
-	__raw_writel((1 << 5) | (PTV << 2), base + OMAP_WATCHDOG_CNTRL);
-	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
-		cpu_relax();
+		__raw_writel((1 << 5) | (PTV << 2), base + OMAP_WATCHDOG_CNTRL);
+		while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
+			cpu_relax();
+		wdev->omap_wdt_state |= (1 << OMAP_WDT_STATE_ACTIVATED_BIT);
+	}
 
 	file->private_data = (void *) wdev;
 
@@ -189,10 +198,13 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 	omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
 
 	clk_disable(wdev->mpu_wdt_fck);
+	wdev->omap_wdt_state &= ~(1 << OMAP_WDT_STATE_ACTIVATED_BIT);
 #else
+	/* Give the user application some time to recover in case of crash. */
+	omap_wdt_ping(wdev);
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
 #endif
-	wdev->omap_wdt_users = 0;
+	wdev->omap_wdt_state &= ~(1 << OMAP_WDT_STATE_OPENED_BIT);
 
 	return 0;
 }
@@ -307,7 +319,7 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 		goto err_kzalloc;
 	}
 
-	wdev->omap_wdt_users = 0;
+	wdev->omap_wdt_state = 0;
 	wdev->mem = mem;
 
 	if (cpu_is_omap16xx()) {
@@ -417,7 +429,7 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	if (wdev->omap_wdt_users) {
+	if (wdev->omap_wdt_state & (1<<OMAP_WDT_STATE_ACTIVATED_BIT)) {
 		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 		omap_wdt_disable(wdev);
 		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
@@ -465,7 +477,7 @@ static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	if (wdev->omap_wdt_users) {
+	if (wdev->omap_wdt_state & (1<<OMAP_WDT_STATE_ACTIVATED_BIT)) {
 		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 		omap_wdt_disable(wdev);
 		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
@@ -478,7 +490,7 @@ static int omap_wdt_resume(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	if (wdev->omap_wdt_users) {
+	if (wdev->omap_wdt_state & (1<<OMAP_WDT_STATE_ACTIVATED_BIT)) {
 		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 		omap_wdt_enable(wdev);
 		omap_wdt_ping(wdev);
-- 
1.5.4.3

