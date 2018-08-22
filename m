From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which it is
 functional
Date: Wed, 22 Aug 2018 11:02:31 +0530
Message-ID: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
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
To: tony@atomide.com
Cc: d-gerlach@ti.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Enable DS0 for only those platforms on which it is functional

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/pm33xx-core.c    | 5 +++++
 drivers/soc/ti/pm33xx.c              | 9 +++++++++
 include/linux/platform_data/pm33xx.h | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index f4971e4..f0f6e8e 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -135,6 +135,11 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
 {
 	int ret = 0;
 
+	if (!(args & WFI_FLAG_DEEP_SLEEP0)) {
+		pr_err("DS0 mode not supported\n");
+		return -ENOTSUPP;
+	}
+
 	amx3_pre_suspend_common();
 	scu_power_mode(scu_base, SCU_PM_POWEROFF);
 	ret = cpu_suspend(args, fn);
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index d0dab32..53238d7 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -324,6 +324,15 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	suspend_wfi_flags |= WFI_FLAG_SAVE_EMIF;
 	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
 
+	/*
+	 * Deep Sleep0 mode is currently functional only on am437x-gp-evm,
+	 * am33xx-evm and boneblack family. Hence set the DS0 flag
+	 */
+	if (of_machine_is_compatible("ti,am437x-gp-evm") ||
+	    of_machine_is_compatible("ti,am335x-bone-black") ||
+	    of_machine_is_compatible("ti,am335x-evm"))
+		suspend_wfi_flags |= WFI_FLAG_DEEP_SLEEP0;
+
 	ret = pm_ops->init();
 	if (ret) {
 		dev_err(dev, "Unable to call core pm init!\n");
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index fbf5ed7..5c54b64 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -28,12 +28,14 @@
  * WFI_FLAG_WAKE_M3: Disable MPU clock or clockdomain to cause wkup_m3 to
  *		     execute when WFI instruction executes.
  * WFI_FLAG_RTC_ONLY: Configure the RTC to enter RTC+DDR mode.
+ * WFI_FLAG_DEEP_SLEEP0: Configure to enter Depp Sleep 0 mode.
  */
 #define WFI_FLAG_FLUSH_CACHE		BIT(0)
 #define WFI_FLAG_SELF_REFRESH		BIT(1)
 #define WFI_FLAG_SAVE_EMIF		BIT(2)
 #define WFI_FLAG_WAKE_M3		BIT(3)
 #define WFI_FLAG_RTC_ONLY		BIT(4)
+#define WFI_FLAG_DEEP_SLEEP0		BIT(5)
 
 #ifndef __ASSEMBLER__
 struct am33xx_pm_sram_addr {
-- 
1.9.1
