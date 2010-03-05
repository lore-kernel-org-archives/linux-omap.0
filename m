From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Fri, 5 Mar 2010 04:12:35 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52500 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab0CEKMk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 05:12:40 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 7db8ef8ac43e42a486b02c0647417da2b2387552 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 5 Mar 2010 03:57:19 -0600
Subject: [PATCH 2/2] DSPBRIDGE: DSP recovery feature

This patch implements a workqueue in charge of reseting
DSP in case of fatal error.

Original idea taken from:
http://android.git.kernel.org/?p=kernel/omap.git;a=commit;h=8af1fbcda4b05a8777b4f3819da98340bd5d9de2

Features:
-Recovery is done reloading baseimage.
-Workqueue will load last baseimage loaded.
-In order workqueue can reload the baseimage absolute path for
baseimage must be used.
-Workqueue will wait until all the dspbridge handles are closed
-During recovery process all ioctl calls will return -EIO
-After DSP crash applications must close their dspbridge handles
and open a new dspbridge handle, bridge_open function will block until
recovery process is done or timeout.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/drv.h |    3 +
 drivers/dsp/bridge/Kconfig                 |    8 ++++
 drivers/dsp/bridge/pmgr/wcd.c              |   14 +++----
 drivers/dsp/bridge/rmgr/drv_interface.c    |   63 ++++++++++++++++++++++++++++
 drivers/dsp/bridge/rmgr/proc.c             |    9 +---
 drivers/dsp/bridge/wmd/ue_deh.c            |    6 ++-
 6 files changed, 88 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 2191a87..d6e1c73 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -389,4 +389,7 @@ extern u32 drv_request_resources(u32 dw_context, u32 *pDevNodeString);
  */
 extern u32 drv_release_resources(u32 dw_context, struct drv_object *hdrv_obj);
 
+#ifdef CONFIG_BRIDGE_RECOVERY
+	void bridge_recover_schedule(void);
+#endif
 #endif /* DRV_ */
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index 8d33142..a0cf5f0 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -52,6 +52,14 @@ config WDT_TIMEOUT
 	   Watchdog timer timeout value, after that time if the watchdog timer
 	   counter is not reset the wdt overflow interrupt will be triggered
 
+config BRIDGE_RECOVERY
+	bool "DSP Recovery Support"
+	depends on MPU_BRIDGE
+	help
+	  In case of DSP fatal error, BRIDGE driver will try to
+	  recover itself.
+
+
 comment "Bridge Notifications"
 	depends on MPU_BRIDGE
 
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 3338cca..c8b53c2 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -381,7 +381,7 @@ u32 wcd_init_complete2(void)
 	u32 status = DSP_SOK;
 	struct cfg_devnode *dev_node;
 	struct dev_object *hdev_obj;
-	u32 dev_type;
+	u32 dev_type, tmp;
 
 	DBC_REQUIRE(wcd_c_refs > 0);
 
@@ -396,13 +396,11 @@ u32 wcd_init_complete2(void)
 		if (DSP_FAILED(dev_get_dev_type(hdev_obj, &dev_type)))
 			continue;
 
-		if ((dev_type == DSP_UNIT) || (dev_type == IVA_UNIT)) {
-			if (DSP_FAILED(proc_auto_start(dev_node, hdev_obj))) {
-				status = DSP_EFAIL;
-				/* break; */
-			}
-		}
-	}			/* End For Loop */
+		if ((dev_type == DSP_UNIT) || (dev_type == IVA_UNIT))
+			if (cfg_get_auto_start(dev_node, &tmp) == DSP_SOK
+									&& tmp)
+				proc_auto_start(dev_node, hdev_obj);
+	}
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index b866661..0fe7ed3 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -91,6 +91,15 @@ static s32 shm_size = 0x500000;	/* 5 MB */
 static u32 phys_mempool_base;
 static u32 phys_mempool_size;
 static int tc_wordswapon;	/* Default value is always false */
+#ifdef CONFIG_BRIDGE_RECOVERY
+#define REC_TIMEOUT 5000	/*recovery timeout in msecs */
+static atomic_t bridge_cref;	/* number of bridge open handles */
+static struct workqueue_struct *bridge_rec_queue;
+static struct work_struct bridge_recovery_work;
+static DECLARE_COMPLETION_ONSTACK(bridge_comp);
+static DECLARE_COMPLETION_ONSTACK(bridge_open_comp);
+static bool recover;
+#endif
 
 #ifdef CONFIG_PM
 struct omap34_xx_bridge_suspend_data {
@@ -189,6 +198,33 @@ u32 vdd1_dsp_freq[6][4] = {
 	{0, 430000, 355000, 430000},
 };
 
+#ifdef CONFIG_BRIDGE_RECOVERY
+static void bridge_recover(struct work_struct *work)
+{
+	struct dev_object *dev;
+	struct cfg_devnode *dev_node;
+	if (atomic_read(&bridge_cref)) {
+		INIT_COMPLETION(bridge_comp);
+		while (!wait_for_completion_timeout(&bridge_comp,
+						msecs_to_jiffies(REC_TIMEOUT)))
+			pr_info("%s:%d handle(s) still opened\n",
+					__func__, atomic_read(&bridge_cref));
+	}
+	dev = dev_get_first();
+	dev_get_dev_node(dev, &dev_node);
+	if (!dev_node || DSP_FAILED(proc_auto_start(dev_node, dev)))
+		pr_err("DSP could not be restarted\n");
+	recover = false;
+	complete_all(&bridge_open_comp);
+}
+
+void bridge_recover_schedule(void)
+{
+	INIT_COMPLETION(bridge_open_comp);
+	recover = true;
+	queue_work(bridge_rec_queue, &bridge_recovery_work);
+}
+#endif
 #ifdef CONFIG_BRIDGE_DVFS
 static int dspbridge_post_scale(struct notifier_block *op, unsigned long level,
 				void *ptr)
@@ -323,6 +359,12 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 		}
 	}
 
+#ifdef CONFIG_BRIDGE_RECOVERY
+	bridge_rec_queue = create_workqueue("bridge_rec_queue");
+	INIT_WORK(&bridge_recovery_work, bridge_recover);
+	INIT_COMPLETION(bridge_comp);
+#endif
+
 	DBC_ASSERT(status == 0);
 	DBC_ASSERT(DSP_SUCCEEDED(init_status));
 
@@ -443,6 +485,13 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	 * dload_allocate a new process context and insert it into global
 	 * process context list.
 	 */
+
+#ifdef CONFIG_BRIDGE_RECOVERY
+	if (recover)
+		if (wait_for_completion_interruptible_timeout(&bridge_open_comp,
+				msecs_to_jiffies(REC_TIMEOUT * 3)) <= 0)
+			return -EBUSY;
+#endif
 	pr_ctxt = mem_calloc(sizeof(struct process_context), MEM_PAGED);
 	if (pr_ctxt) {
 		pr_ctxt->res_state = PROC_RES_ALLOCATED;
@@ -458,6 +507,10 @@ static int bridge_open(struct inode *ip, struct file *filp)
 
 	filp->private_data = pr_ctxt;
 
+#ifdef CONFIG_BRIDGE_RECOVERY
+	if (!status)
+		atomic_inc(&bridge_cref);
+#endif
 	return status;
 }
 
@@ -484,6 +537,10 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	filp->private_data = NULL;
 
 err:
+#ifdef CONFIG_BRIDGE_RECOVERY
+	if (!atomic_dec_return(&bridge_cref))
+		complete(&bridge_comp);
+#endif
 	return status;
 }
 
@@ -496,6 +553,12 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 	union Trapped_Args buf_in;
 
 	DBC_REQUIRE(filp != NULL);
+#ifdef CONFIG_BRIDGE_RECOVERY
+	if (recover) {
+		status = -EIO;
+		goto err;
+	}
+#endif
 #ifdef CONFIG_PM
 	status = omap34_xxbridge_suspend_lockout(&bridge_suspend_data, filp);
 	if (status != 0)
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 5bc7ec7..1c94729 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -53,6 +53,7 @@
 #include <dspbridge/msg.h>
 #include <dspbridge/wmdioctl.h>
 #include <dspbridge/drv.h>
+#include <dspbridge/reg.h>
 
 /*  ----------------------------------- This */
 #include <dspbridge/proc.h>
@@ -257,7 +258,6 @@ u32 proc_auto_start(struct cfg_devnode *dev_node_obj,
 		    struct dev_object *hdev_obj)
 {
 	u32 status = DSP_EFAIL;
-	u32 dw_auto_start = 0;	/* autostart flag */
 	struct proc_object *pProcObject;
 	char sz_exec_file[MAXCMDLINELEN];
 	char *argv[2];
@@ -293,11 +293,6 @@ u32 proc_auto_start(struct cfg_devnode *dev_node_obj,
 	if (DSP_FAILED(status))
 		goto func_cont;
 
-	status = cfg_get_auto_start(dev_node_obj, &dw_auto_start);
-	if (DSP_FAILED(status) || !dw_auto_start) {
-		status = DSP_EFAIL;
-		goto func_cont;
-	}
 	/* Get the default executable for this board... */
 	dev_get_dev_type(hdev_obj, (u32 *) &dev_type);
 	pProcObject->processor_id = dev_type;
@@ -1024,6 +1019,8 @@ u32 proc_load(void *hprocessor, const s32 argc_index, const char **user_args,
 		if (DSP_SUCCEEDED((*pProcObject->intf_fxns->pfn_brd_status)
 				  (pProcObject->hwmd_context, &brd_state))) {
 			pr_info("%s: Processor Loaded %s\n", __func__, pargv0);
+			reg_set_value(DEFEXEC, (u8 *)pargv0,
+							strlen(pargv0) + 1);
 			DBC_ASSERT(brd_state == BRD_LOADED);
 		}
 	}
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 5f1ea43..8b4e9be 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -287,8 +287,12 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		}
 
 		/* Filter subsequent notifications when an error occurs */
-		if (dev_context->dw_brd_state != BRD_ERROR)
+		if (dev_context->dw_brd_state != BRD_ERROR) {
 			ntfy_notify(deh_mgr_obj->ntfy_obj, ulEventMask);
+#ifdef CONFIG_BRIDGE_RECOVERY
+			bridge_recover_schedule();
+#endif
+		}
 
 		/* Set the Board state as ERROR */
 		dev_context->dw_brd_state = BRD_ERROR;
-- 
1.6.0.4

