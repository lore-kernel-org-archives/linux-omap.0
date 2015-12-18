From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] mtd: omap_elm: print interrupt resource using %pr
Date: Fri, 18 Dec 2015 14:15:17 +0100
Message-ID: <2327550.1yLrRnIh7I@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
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
v2: pass correct pointer

diff --git a/drivers/mtd/nand/omap_elm.c b/drivers/mtd/nand/omap_elm.c
index 235ec7992b4c..a3f32f939cc1 100644
--- a/drivers/mtd/nand/omap_elm.c
+++ b/drivers/mtd/nand/omap_elm.c
@@ -414,7 +414,7 @@ static int elm_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq->start, elm_isr, 0,
 			pdev->name, info);
 	if (ret) {
-		dev_err(&pdev->dev, "failure requesting irq %i\n", irq->start);
+		dev_err(&pdev->dev, "failure requesting %pr\n", irq);
 		return ret;
 	}
