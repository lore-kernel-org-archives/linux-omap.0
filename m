From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/5] soc: ti: pm33xx: Push the am33xx_push_sram_idle to the top
Date: Fri, 22 Mar 2019 22:46:18 +0530
Message-ID: <20190322171619.4180-5-j-keerthy@ti.com>
References: <20190322171619.4180-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190322171619.4180-1-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, alexandre.belloni@bootlin.com, a.zummo@towertech.it, t-kristo@ti.com
Cc: linux-rtc@vger.kernel.org, d-gerlach@ti.com, j-keerthy@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Push the am33xx_push_sram_idle function to the top as a preparation
for rtc+ddr mode as the function will be called by multiple functions
currently present before it.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/soc/ti/pm33xx.c | 100 ++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index d0dab323651f..69128993776d 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -49,6 +49,56 @@ static u32 sram_suspend_address(unsigned long addr)
 		AMX3_PM_SRAM_SYMBOL_OFFSET(addr));
 }
 
+static int am33xx_push_sram_idle(void)
+{
+	struct am33xx_pm_ro_sram_data ro_sram_data;
+	int ret;
+	u32 table_addr, ro_data_addr;
+	void *copy_addr;
+
+	ro_sram_data.amx3_pm_sram_data_virt = ocmcram_location_data;
+	ro_sram_data.amx3_pm_sram_data_phys =
+		gen_pool_virt_to_phys(sram_pool_data, ocmcram_location_data);
+	ro_sram_data.rtc_base_virt = pm_ops->get_rtc_base_addr();
+
+	/* Save physical address to calculate resume offset during pm init */
+	am33xx_do_wfi_sram_phys = gen_pool_virt_to_phys(sram_pool,
+							ocmcram_location);
+
+	am33xx_do_wfi_sram = sram_exec_copy(sram_pool, (void *)ocmcram_location,
+					    pm_sram->do_wfi,
+					    *pm_sram->do_wfi_sz);
+	if (!am33xx_do_wfi_sram) {
+		dev_err(pm33xx_dev,
+			"PM: %s: am33xx_do_wfi copy to sram failed\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	table_addr =
+		sram_suspend_address((unsigned long)pm_sram->emif_sram_table);
+	ret = ti_emif_copy_pm_function_table(sram_pool, (void *)table_addr);
+	if (ret) {
+		dev_dbg(pm33xx_dev,
+			"PM: %s: EMIF function copy failed\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	ro_data_addr =
+		sram_suspend_address((unsigned long)pm_sram->ro_sram_data);
+	copy_addr = sram_exec_copy(sram_pool, (void *)ro_data_addr,
+				   &ro_sram_data,
+				   sizeof(ro_sram_data));
+	if (!copy_addr) {
+		dev_err(pm33xx_dev,
+			"PM: %s: ro_sram_data copy to sram failed\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_SUSPEND
 static int am33xx_pm_suspend(suspend_state_t suspend_state)
 {
@@ -219,56 +269,6 @@ static int am33xx_pm_alloc_sram(void)
 	return ret;
 }
 
-static int am33xx_push_sram_idle(void)
-{
-	struct am33xx_pm_ro_sram_data ro_sram_data;
-	int ret;
-	u32 table_addr, ro_data_addr;
-	void *copy_addr;
-
-	ro_sram_data.amx3_pm_sram_data_virt = ocmcram_location_data;
-	ro_sram_data.amx3_pm_sram_data_phys =
-		gen_pool_virt_to_phys(sram_pool_data, ocmcram_location_data);
-	ro_sram_data.rtc_base_virt = pm_ops->get_rtc_base_addr();
-
-	/* Save physical address to calculate resume offset during pm init */
-	am33xx_do_wfi_sram_phys = gen_pool_virt_to_phys(sram_pool,
-							ocmcram_location);
-
-	am33xx_do_wfi_sram = sram_exec_copy(sram_pool, (void *)ocmcram_location,
-					    pm_sram->do_wfi,
-					    *pm_sram->do_wfi_sz);
-	if (!am33xx_do_wfi_sram) {
-		dev_err(pm33xx_dev,
-			"PM: %s: am33xx_do_wfi copy to sram failed\n",
-			__func__);
-		return -ENODEV;
-	}
-
-	table_addr =
-		sram_suspend_address((unsigned long)pm_sram->emif_sram_table);
-	ret = ti_emif_copy_pm_function_table(sram_pool, (void *)table_addr);
-	if (ret) {
-		dev_dbg(pm33xx_dev,
-			"PM: %s: EMIF function copy failed\n", __func__);
-		return -EPROBE_DEFER;
-	}
-
-	ro_data_addr =
-		sram_suspend_address((unsigned long)pm_sram->ro_sram_data);
-	copy_addr = sram_exec_copy(sram_pool, (void *)ro_data_addr,
-				   &ro_sram_data,
-				   sizeof(ro_sram_data));
-	if (!copy_addr) {
-		dev_err(pm33xx_dev,
-			"PM: %s: ro_sram_data copy to sram failed\n",
-			__func__);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
 static int am33xx_pm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.17.1
