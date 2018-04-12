From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 01/14] memory: ti-emif-sram: Add resume function to recopy
 sram code
Date: Thu, 12 Apr 2018 09:23:46 +0530
Message-ID: <1523505239-16229-2-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: d-gerlach@ti.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, Russ.Dill@ti.com, haojian.zhuang@linaro.org, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

After an RTC+DDR cycle we lose sram context so emif pm functions present
in sram are lost. We can check if the first byte of the original
code in DDR contains the same first byte as the code in sram, and if
they do not match we know we have lost context and must recopy the
functions to the previous address to maintain PM functionality.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/memory/ti-emif-pm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
index 632651f..ec4a62c 100644
--- a/drivers/memory/ti-emif-pm.c
+++ b/drivers/memory/ti-emif-pm.c
@@ -249,6 +249,25 @@ int ti_emif_get_mem_type(void)
 };
 MODULE_DEVICE_TABLE(of, ti_emif_of_match);
 
+#ifdef CONFIG_PM_SLEEP
+static int ti_emif_resume(struct device *dev)
+{
+	unsigned long tmp =
+			__raw_readl((void *)emif_instance->ti_emif_sram_virt);
+
+	/*
+	 * Check to see if what we are copying is already present in the
+	 * first byte at the destination, only copy if it is not which
+	 * indicates we have lost context and sram no longer contains
+	 * the PM code
+	 */
+	if (tmp != ti_emif_sram)
+		ti_emif_push_sram(dev, emif_instance);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static int ti_emif_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -308,12 +327,17 @@ static int ti_emif_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops ti_emif_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, ti_emif_resume)
+};
+
 static struct platform_driver ti_emif_driver = {
 	.probe = ti_emif_probe,
 	.remove = ti_emif_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = of_match_ptr(ti_emif_of_match),
+		.pm = &ti_emif_pm_ops,
 	},
 };
 module_platform_driver(ti_emif_driver);
-- 
1.9.1
