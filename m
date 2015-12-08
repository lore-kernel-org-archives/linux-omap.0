From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mtd: omap_elm: print interrupt resource using %pr
Date: Tue, 08 Dec 2015 16:39:45 +0100
Message-ID: <2101351.RbJOfbsbGX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

When CONFIG_LPAE is set on ARM, resource_size_t is 64-bit wide
and we get a warning about an incorrect format string for printing
the interrupt number in elm_probe:

drivers/mtd/nand/omap_elm.c: In function 'elm_probe':
drivers/mtd/nand/omap_elm.c:417:23: warning: format '%i' expects argument of type 'int', but argument 3 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]

This patch avoids the type mismatch by printing the interrupt as
a resource using the %pr format string.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/omap_elm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap_elm.c b/drivers/mtd/nand/omap_elm.c
index 235ec7992b4c..11f174b07217 100644
--- a/drivers/mtd/nand/omap_elm.c
+++ b/drivers/mtd/nand/omap_elm.c
@@ -414,7 +414,7 @@ static int elm_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq->start, elm_isr, 0,
 			pdev->name, info);
 	if (ret) {
-		dev_err(&pdev->dev, "failure requesting irq %i\n", irq->start);
+		dev_err(&pdev->dev, "failure requesting %pr\n", &irq);
 		return ret;
 	}
 
-- 
2.1.0.rc2
