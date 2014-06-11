From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 13/36] ARM: OMAP2+: gpmc.c: sanity check bank-width DT property
Date: Wed, 11 Jun 2014 11:56:18 +0300
Message-ID: <1402477001-31132-14-git-send-email-rogerq@ti.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1402477001-31132-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linux-mtd@lists.infradead.org, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Make sure bank-width property provided via DT is sane.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index c713616..70cb6b0 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1219,6 +1219,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	struct resource res;
 	unsigned long base;
 	int ret, cs;
+	struct device *dev = &pdev->dev;
 
 	if (of_property_read_u32(child, "reg", &cs) < 0) {
 		dev_err(&pdev->dev, "%s has no 'reg' property\n",
@@ -1284,7 +1285,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 			gpmc_s.device_width = GPMC_DEVWIDTH_16BIT;
 			break;
 		default:
-			dev_err(&pdev->dev, "%s: invalid 'nand-bus-width'\n",
+			dev_err(dev, "%s: invalid 'nand-bus-width'\n",
 				child->name);
 			ret = -EINVAL;
 			goto err;
@@ -1292,10 +1293,18 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 
 		gpmc_s.device_nand = true;
 	} else {
-		ret = of_property_read_u32(child, "bank-width",
-					   &gpmc_s.device_width);
-		if (ret < 0)
+		if (of_property_read_u32(child, "bank-width",
+					 &gpmc_s.device_width)) {
+			dev_err(dev, "%s: no 'bank-width' property\n",
+				child->name);
+			goto err;
+		}
+
+		if (gpmc_s.device_width < 1 || gpmc_s.device_width > 2) {
+			dev_err(dev, "%s: invalid 'bank-width'\n",
+				child->name);
 			goto err;
+		}
 	}
 
 	ret = gpmc_cs_program_settings(cs, &gpmc_s);
-- 
1.8.3.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
