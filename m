From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC PATCH 03/11] misc: SRAM: Add option to map SRAM to allow code
 execution
Date: Tue, 17 Sep 2013 05:43:29 -0700
Message-ID: <1379421817-15759-4-git-send-email-Russ.Dill@ti.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: mans@mansr.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kbuild@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Dave Martin <Dave.Martin@arm.com>
List-Id: linux-omap@vger.kernel.org

This is necessary for platforms that use SRAM to execute suspend/resume stubs.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 Documentation/devicetree/bindings/misc/sram.txt |  4 ++++
 drivers/misc/sram.c                             | 13 ++++++++++++-
 include/linux/platform_data/sram.h              |  8 ++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/sram.h

diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
index 4d0a00e..4fa9af3 100644
--- a/Documentation/devicetree/bindings/misc/sram.txt
+++ b/Documentation/devicetree/bindings/misc/sram.txt
@@ -8,6 +8,10 @@ Required properties:
 
 - reg : SRAM iomem address range
 
+Optional properties:
+
+- map-exec: Map range to allow code execution
+
 Example:
 
 sram: sram@5c000000 {
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index d87cc91..baa5008 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/genalloc.h>
+#include <linux/platform_data/sram.h>
 
 #define SRAM_GRANULARITY	32
 
@@ -38,14 +39,24 @@ struct sram_dev {
 
 static int sram_probe(struct platform_device *pdev)
 {
+	struct sram_platform_data *pdata = pdev->dev.platform_data;
 	void __iomem *virt_base;
 	struct sram_dev *sram;
 	struct resource *res;
 	unsigned long size;
+	bool map_exec = false;
 	int ret;
 
+	if (of_get_property(pdev->dev.of_node, "map-exec", NULL))
+		map_exec = true;
+	if (pdata && pdata->map_exec)
+		map_exec |= true;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	virt_base = devm_ioremap_resource(&pdev->dev, res);
+	if (map_exec)
+		virt_base = devm_ioremap_exec_resource(&pdev->dev, res);
+	else
+		virt_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(virt_base))
 		return PTR_ERR(virt_base);
 
diff --git a/include/linux/platform_data/sram.h b/include/linux/platform_data/sram.h
new file mode 100644
index 0000000..8f5c4ba
--- /dev/null
+++ b/include/linux/platform_data/sram.h
@@ -0,0 +1,8 @@
+#ifndef _LINUX_SRAM_H
+#define _LINUX_SRAM_H
+
+struct sram_platform_data {
+	bool map_exec;
+};
+
+#endif
-- 
1.8.3.2
