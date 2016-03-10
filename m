From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v4 1/7] ARM: OMAP2+: gpmc-nand: Set omap2-nand's parent dev to
 GPMC dev
Date: Thu, 10 Mar 2016 17:56:37 -0600
Message-ID: <1457654203-20856-2-git-send-email-fcooper@ti.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1457654203-20856-1-git-send-email-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, rogerq@ti.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

The dma channel information is located within the GPMC node which is the
NAND's parent node. The NAND driver requires a handle to the GPMC's dev
to properly parse the DMA properties. Therefore, set the NAND's parent dev
to the GPMC's dev so it can be referenced within the driver.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 4 changes:
Instead of storing the GPMC dev in a new property simply grab a reference
to it and set omap2-nand's dev.parent to it.

 arch/arm/mach-omap2/gpmc-nand.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 72918c4..77e453c 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -15,6 +15,7 @@
 #include <linux/omap-gpmc.h>
 #include <linux/mtd/nand.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
+#include <linux/of_platform.h>
 
 #include <asm/mach/flash.h>
 
@@ -77,6 +78,9 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 	int err	= 0;
 	struct gpmc_settings s;
 	struct platform_device *pdev;
+	struct platform_device *gpmc_dev;
+	struct device_node *gpmc_node;
+
 	struct resource gpmc_nand_res[] = {
 		{ .flags = IORESOURCE_MEM, },
 		{ .flags = IORESOURCE_IRQ, },
@@ -134,8 +138,18 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 	if (pdev) {
 		err = platform_device_add_resources(pdev, gpmc_nand_res,
 						    ARRAY_SIZE(gpmc_nand_res));
-		if (!err)
+		if (!err) {
 			pdev->dev.platform_data = gpmc_nand_data;
+
+			gpmc_node = of_get_parent(gpmc_nand_data->of_node);
+
+			if (gpmc_node) {
+				gpmc_dev = of_find_device_by_node(gpmc_node);
+
+				if (gpmc_dev)
+					pdev->dev.parent = &gpmc_dev->dev;
+			}
+		}
 	} else {
 		err = -ENOMEM;
 	}
-- 
2.7.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
