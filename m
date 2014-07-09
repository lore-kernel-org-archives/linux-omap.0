From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 01/10] mtd: nand: omap: Use a single hardware controller
 instance
Date: Wed, 9 Jul 2014 15:37:21 +0300
Message-ID: <1404909450-11970-2-git-send-email-rogerq@ti.com>
References: <1404909450-11970-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1404909450-11970-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: jg1.han@samsung.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

There is only one NAND controller (ECC generator) that needs to be
shared among multiple devices. So point nand_chip->hwcontrol to
a single omap_hw_controller instance.
This way the NAND base driver can take care of serializing access
to this single controller (via nand_chip->controller->lock)
when multiple NAND devices are present.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/omap2.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index f0ed92e..5b8739c 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -149,8 +149,9 @@ static u_char bch4_vector[] = {0x00, 0x6b, 0x31, 0xdd, 0x41, 0xbc, 0x10};
 /* oob info generated runtime depending on ecc algorithm and layout selected */
 static struct nand_ecclayout omap_oobinfo;
 
+static struct nand_hw_control omap_hw_controller;
+
 struct omap_nand_info {
-	struct nand_hw_control		controller;
 	struct omap_nand_platform_data	*pdata;
 	struct mtd_info			mtd;
 	struct nand_chip		nand;
@@ -1649,9 +1650,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	spin_lock_init(&info->controller.lock);
-	init_waitqueue_head(&info->controller.wq);
-
 	info->pdev		= pdev;
 	info->gpmc_cs		= pdata->cs;
 	info->reg		= pdata->reg;
@@ -1672,7 +1670,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	info->phys_base = res->start;
 
-	nand_chip->controller = &info->controller;
+	/*
+	 * There is only one NAND controller (ECC generator) that needs to be
+	 * shared among multiple devices. The NAND base driver takes care of
+	 * serializing access to this single controller when multiple NAND
+	 * devices are present.
+	 */
+	nand_chip->hwcontrol = omap_hw_controller;
 
 	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
 	nand_chip->cmd_ctrl  = omap_hwcontrol;
-- 
1.8.3.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
