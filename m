From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/5] drivers: bus: omap_l3: Convert to use devm_kzalloc
Date: Tue, 4 Mar 2014 11:01:46 +0200
Message-ID: <1393923710-10377-2-git-send-email-peter.ujfalusi@ti.com>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can remove the kfree() calls from probe and remove.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti>
---
 drivers/bus/omap_l3_noc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index feeecae623f6..d25d727e7cfb 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -134,7 +134,7 @@ static int omap4_l3_probe(struct platform_device *pdev)
 	struct resource	*res;
 	int ret;
 
-	l3 = kzalloc(sizeof(*l3), GFP_KERNEL);
+	l3 = devm_kzalloc(&pdev->dev, sizeof(*l3), GFP_KERNEL);
 	if (!l3)
 		return -ENOMEM;
 
@@ -142,15 +142,13 @@ static int omap4_l3_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "couldn't find resource 0\n");
-		ret = -ENODEV;
-		goto err0;
+		return -ENODEV;
 	}
 
 	l3->l3_base[0] = ioremap(res->start, resource_size(res));
 	if (!l3->l3_base[0]) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
-		goto err0;
+		return -ENOMEM;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -214,8 +212,6 @@ err2:
 	iounmap(l3->l3_base[1]);
 err1:
 	iounmap(l3->l3_base[0]);
-err0:
-	kfree(l3);
 	return ret;
 }
 
@@ -228,7 +224,6 @@ static int omap4_l3_remove(struct platform_device *pdev)
 	iounmap(l3->l3_base[0]);
 	iounmap(l3->l3_base[1]);
 	iounmap(l3->l3_base[2]);
-	kfree(l3);
 
 	return 0;
 }
-- 
1.9.0
