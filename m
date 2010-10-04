From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] staging: tidspbridge: use omap_dsp_platform_data
Date: Mon,  4 Oct 2010 19:09:15 +0300
Message-ID: <1286208555-8829-3-git-send-email-felipe.contreras@gmail.com>
References: <1286208555-8829-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286208555-8829-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c      |   14 ++++++++------
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c  |   14 ++++++++------
 drivers/staging/tidspbridge/core/tiomap_io.c       |    4 +++-
 .../tidspbridge/include/dspbridge/host_os.h        |   19 -------------------
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |   10 ++++++----
 5 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index f914829..5aefc95 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -16,6 +16,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
+#include <plat/dsp.h>
+
 #include <linux/types.h>
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
@@ -264,8 +266,8 @@ static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt)
 {
 	struct bridge_dev_context *dev_context = dev_ctxt;
 	u32 temp;
-	struct dspbridge_platform_data *pdata =
-				    omap_dspbridge_dev->dev.platform_data;
+	struct omap_dsp_platform_data *pdata =
+		omap_dspbridge_dev->dev.platform_data;
 
 	temp = (*pdata->dsp_prm_read)(OMAP3430_IVA2_MOD, OMAP2_PM_PWSTST) &
 					OMAP_POWERSTATEST_MASK;
@@ -374,8 +376,8 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 	u32 clk_cmd;
 	struct io_mgr *hio_mgr;
 	u32 ul_load_monitor_timer;
-	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev->dev.platform_data;
+	struct omap_dsp_platform_data *pdata =
+		omap_dspbridge_dev->dev.platform_data;
 
 	/* The device context contains all the mmu setup info from when the
 	 * last dsp base image was loaded. The first entry is always
@@ -627,8 +629,8 @@ static int bridge_brd_stop(struct bridge_dev_context *dev_ctxt)
 	struct pg_table_attrs *pt_attrs;
 	u32 dsp_pwr_state;
 	int clk_status;
-	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev->dev.platform_data;
+	struct omap_dsp_platform_data *pdata =
+		omap_dspbridge_dev->dev.platform_data;
 
 	if (dev_context->dw_brd_state == BRD_STOPPED)
 		return status;
diff --git a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
index b789f8f..1bea23f 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430_pwr.c
@@ -16,6 +16,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
+#include <plat/dsp.h>
+
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/cfg.h>
@@ -54,8 +56,8 @@ int handle_constraints_set(struct bridge_dev_context *dev_context,
 {
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 	u32 *constraint_val;
-	struct dspbridge_platform_data *pdata =
-	    omap_dspbridge_dev->dev.platform_data;
+	struct omap_dsp_platform_data *pdata =
+		omap_dspbridge_dev->dev.platform_data;
 
 	constraint_val = (u32 *) (pargs);
 	/* Read the target value requested by DSP */
@@ -83,8 +85,8 @@ int handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 	u32 opplevel;
 	struct io_mgr *hio_mgr;
 #endif
-	struct dspbridge_platform_data *pdata =
-	    omap_dspbridge_dev->dev.platform_data;
+	struct omap_dsp_platform_data *pdata =
+		omap_dspbridge_dev->dev.platform_data;
 
 	pwr_state = (*pdata->dsp_prm_read)(OMAP3430_IVA2_MOD, OMAP2_PM_PWSTST) &
 						OMAP_POWERSTATEST_MASK;
@@ -152,8 +154,8 @@ int sleep_dsp(struct bridge_dev_context *dev_context, u32 dw_cmd,
 #endif /* CONFIG_TIDSPBRIDGE_NTFY_PWRERR */
 	u16 timeout = PWRSTST_TIMEOUT / 10;
 	u32 pwr_state, target_pwr_state;
-	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev->dev.platform_data;
+	struct omap_dsp_platform_data *pdata =
+		omap_dspbridge_dev->dev.platform_data;
 
 	/* Check if sleep code is valid */
 	if ((dw_cmd != PWR_DEEPSLEEP) && (dw_cmd != PWR_EMERGENCYDEEPSLEEP))
diff --git a/drivers/staging/tidspbridge/core/tiomap_io.c b/drivers/staging/tidspbridge/core/tiomap_io.c
index 190c028..2a3cd45 100644
--- a/drivers/staging/tidspbridge/core/tiomap_io.c
+++ b/drivers/staging/tidspbridge/core/tiomap_io.c
@@ -16,6 +16,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
+#include <plat/dsp.h>
+
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
 
@@ -388,7 +390,7 @@ int sm_interrupt_dsp(struct bridge_dev_context *dev_context, u16 mb_val)
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 	u32 opplevel = 0;
 #endif
-	struct dspbridge_platform_data *pdata =
+	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
 	struct cfg_hostres *resources = dev_context->resources;
 	int status = 0;
diff --git a/drivers/staging/tidspbridge/include/dspbridge/host_os.h b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
index 6b4feb4..6549898 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/host_os.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
@@ -52,25 +52,6 @@
 /* TODO -- Remove, once BP defines them */
 #define INT_DSP_MMU_IRQ        28
 
-struct dspbridge_platform_data {
-	void (*dsp_set_min_opp) (u8 opp_id);
-	 u8(*dsp_get_opp) (void);
-	void (*cpu_set_freq) (unsigned long f);
-	unsigned long (*cpu_get_freq) (void);
-	unsigned long mpu_speed[6];
-
-	/* functions to write and read PRCM registers */
-	void (*dsp_prm_write)(u32, s16 , u16);
-	u32 (*dsp_prm_read)(s16 , u16);
-	u32 (*dsp_prm_rmw_bits)(u32, u32, s16, s16);
-	void (*dsp_cm_write)(u32, s16 , u16);
-	u32 (*dsp_cm_read)(s16 , u16);
-	u32 (*dsp_cm_rmw_bits)(u32, u32, s16, s16);
-
-	u32 phys_mempool_base;
-	u32 phys_mempool_size;
-};
-
 #define PRCM_VDD1 1
 
 extern struct platform_device *omap_dspbridge_dev;
diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers/staging/tidspbridge/rmgr/drv_interface.c
index 7ee8949..b5b3a08 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -18,6 +18,8 @@
 
 /*  ----------------------------------- Host OS */
 
+#include <plat/dsp.h>
+
 #include <dspbridge/host_os.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
@@ -171,7 +173,7 @@ const struct omap_opp vdd1_rate_table_bridge[] = {
 #endif
 #endif
 
-struct dspbridge_platform_data *omap_dspbridge_pdata;
+struct omap_dsp_platform_data *omap_dspbridge_pdata;
 
 u32 vdd1_dsp_freq[6][4] = {
 	{0, 0, 0, 0},
@@ -218,8 +220,8 @@ void bridge_recover_schedule(void)
 static int dspbridge_scale_notification(struct notifier_block *op,
 		unsigned long val, void *ptr)
 {
-	struct dspbridge_platform_data *pdata =
-					omap_dspbridge_dev->dev.platform_data;
+	struct omap_dsp_platform_data *pdata =
+		omap_dspbridge_dev->dev.platform_data;
 
 	if (CPUFREQ_POSTCHANGE == val && pdata->dsp_get_opp)
 		pwr_pm_post_scale(PRCM_VDD1, pdata->dsp_get_opp());
@@ -242,7 +244,7 @@ static struct notifier_block iva_clk_notifier = {
  */
 static int omap3_bridge_startup(struct platform_device *pdev)
 {
-	struct dspbridge_platform_data *pdata = pdev->dev.platform_data;
+	struct omap_dsp_platform_data *pdata = pdev->dev.platform_data;
 	struct drv_data *drv_datap = NULL;
 	u32 phys_membase, phys_memsize;
 	int err;
-- 
1.7.3.1.2.g7fe2b
