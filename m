From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 31/86] [ARM] omap: i2c: remove conditional ick clocks
Date: Thu, 12 Mar 2009 11:27:41 -0700
Message-ID: <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570AbZCLSbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:08 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:07 -0700 (PDT)
In-Reply-To: <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

By providing a dummy ick for OMAP1510 and OMAP310, we avoid having
SoC conditional clock information in i2c-omap.c.  Also, fix the
error handling by making sure we propagate the error returned via
clk_get().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c   |    1 +
 drivers/i2c/busses/i2c-omap.c |   28 +++++++++++++---------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 382e09a..d2c6139 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -132,6 +132,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
 	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
 	CLK("i2c_omap.1", "ick",	&i2c_ick,	CK_16XX),
+	CLK("i2c_omap.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
 	CLK("omap-mcbsp.1", "ick",	&dspper_ck,	CK_16XX),
 	CLK("omap-mcbsp.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
 	CLK("omap-mcbsp.2", "ick",	&armper_ck.clk,	CK_16XX),
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 96814fb..ece0125 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -193,22 +193,24 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 
 static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
-	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-		dev->iclk = clk_get(dev->dev, "ick");
-		if (IS_ERR(dev->iclk)) {
-			dev->iclk = NULL;
-			return -ENODEV;
-		}
+	int ret;
+
+	dev->iclk = clk_get(dev->dev, "ick");
+	if (IS_ERR(dev->iclk)) {
+		ret = PTR_ERR(dev->iclk);
+		dev->iclk = NULL;
+		return ret;
 	}
 
 	dev->fclk = clk_get(dev->dev, "fck");
 	if (IS_ERR(dev->fclk)) {
+		ret = PTR_ERR(dev->fclk);
 		if (dev->iclk != NULL) {
 			clk_put(dev->iclk);
 			dev->iclk = NULL;
 		}
 		dev->fclk = NULL;
-		return -ENODEV;
+		return ret;
 	}
 
 	return 0;
@@ -218,18 +220,15 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
 {
 	clk_put(dev->fclk);
 	dev->fclk = NULL;
-	if (dev->iclk != NULL) {
-		clk_put(dev->iclk);
-		dev->iclk = NULL;
-	}
+	clk_put(dev->iclk);
+	dev->iclk = NULL;
 }
 
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
 	WARN_ON(!dev->idle);
 
-	if (dev->iclk != NULL)
-		clk_enable(dev->iclk);
+	clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
 	dev->idle = 0;
 	if (dev->iestate)
@@ -254,8 +253,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	}
 	dev->idle = 1;
 	clk_disable(dev->fclk);
-	if (dev->iclk != NULL)
-		clk_disable(dev->iclk);
+	clk_disable(dev->iclk);
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
-- 
1.6.1.2

