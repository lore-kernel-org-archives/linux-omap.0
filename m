From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/2] OMAP: DSP: N800: remaining updates for dsp parts
Date: Sat, 17 Mar 2007 19:44:29 +0200
Message-ID: <11741534753734-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1174153470622-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1174153470622-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>


Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/board-n800-dsp.c |   12 +-
 arch/arm/plat-omap/devices.c         |    2 +-
 arch/arm/plat-omap/dsp/Kconfig       |    2 +-
 arch/arm/plat-omap/dsp/dsp.h         |    9 +-
 arch/arm/plat-omap/dsp/dsp_common.c  |    8 +-
 arch/arm/plat-omap/dsp/dsp_common.h  |   20 +-
 arch/arm/plat-omap/dsp/dsp_core.c    |  218 ++++++---------
 arch/arm/plat-omap/dsp/dsp_ctl.c     |   34 ++-
 arch/arm/plat-omap/dsp/dsp_mbcmd.h   |    4 +
 arch/arm/plat-omap/dsp/dsp_mem.c     |   13 +-
 arch/arm/plat-omap/dsp/error.c       |   31 +-
 arch/arm/plat-omap/dsp/fifo.h        |    5 +
 arch/arm/plat-omap/dsp/ipbuf.c       |    9 +-
 arch/arm/plat-omap/dsp/ipbuf.h       |   44 ++--
 arch/arm/plat-omap/dsp/mblog.c       |   32 ++-
 arch/arm/plat-omap/dsp/mmu.h         |   16 +
 arch/arm/plat-omap/dsp/proclist.h    |   15 +-
 arch/arm/plat-omap/dsp/task.c        |  526 +++++++++++++++++-----------------
 arch/arm/plat-omap/dsp/taskwatch.c   |   25 +-
 arch/arm/plat-omap/dsp/uaccess_dsp.h |    8 +-
 arch/arm/plat-omap/mmu.c             |    4 +-
 21 files changed, 512 insertions(+), 525 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-dsp.c b/arch/arm/mach-omap2/board-n800-dsp.c
index cb01363..a15ff96 100644
--- a/arch/arm/mach-omap2/board-n800-dsp.c
+++ b/arch/arm/mach-omap2/board-n800-dsp.c
@@ -50,7 +50,7 @@ static struct dsp_kfunc_device n800_audio_device = {
 /*
  * dsp peripheral device: TIMER
  */
-static int dsp_timer_probe(struct dsp_kfunc_device *kdev)
+static int dsp_timer_probe(struct dsp_kfunc_device *kdev, int stage)
 {
 	char clockname[20];
 
@@ -80,7 +80,7 @@ static int dsp_timer_probe(struct dsp_kfunc_device *kdev)
 	return PTR_ERR(kdev->ick);
 }
 
-static int dsp_timer_remove(struct dsp_kfunc_device *kdev)
+static int dsp_timer_remove(struct dsp_kfunc_device *kdev, int stage)
 {
 	clk_put(kdev->ick);
 	clk_put(kdev->fck);
@@ -92,7 +92,7 @@ static int dsp_timer_enable(struct dsp_kfunc_device *kdev, int stage)
 {
 	pr_debug("%s enabled(%d)\n", kdev->name, stage);
 
-	mutex_lock(&kdev->lock);
+	spin_lock(&kdev->lock);
 
 	if (kdev->enabled)
 		goto out;
@@ -101,7 +101,7 @@ static int dsp_timer_enable(struct dsp_kfunc_device *kdev, int stage)
 	clk_enable(kdev->fck);
 	clk_enable(kdev->ick);
  out:
-	mutex_unlock(&kdev->lock);
+	spin_unlock(&kdev->lock);
 
 	return 0;
 }
@@ -110,7 +110,7 @@ static int dsp_timer_disable(struct dsp_kfunc_device *kdev, int stage)
 {
 	pr_debug("%s disabled(%d)\n", kdev->name, stage);
 
-	mutex_lock(&kdev->lock);
+	spin_lock(&kdev->lock);
 
 	if (kdev->enabled == 0)
 		goto out;
@@ -119,7 +119,7 @@ static int dsp_timer_disable(struct dsp_kfunc_device *kdev, int stage)
 	clk_disable(kdev->ick);
 	clk_disable(kdev->fck);
  out:
-	mutex_unlock(&kdev->lock);
+	spin_unlock(&kdev->lock);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 2e0419f..27b5353 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -74,7 +74,7 @@ int dsp_kfunc_device_register(struct dsp_kfunc_device *kdev)
 {
 	static DEFINE_MUTEX(dsp_pdata_lock);
 
-	mutex_init(&kdev->lock);
+	spin_lock_init(&kdev->lock);
 
 	mutex_lock(&dsp_pdata_lock);
 	list_add_tail(&kdev->entry, &dsp_pdata.kdev_list);
diff --git a/arch/arm/plat-omap/dsp/Kconfig b/arch/arm/plat-omap/dsp/Kconfig
index 592740f..0d62bee 100644
--- a/arch/arm/plat-omap/dsp/Kconfig
+++ b/arch/arm/plat-omap/dsp/Kconfig
@@ -23,7 +23,7 @@ config OMAP_DSP_TASK_MULTIOPEN
 
 config OMAP_DSP_FBEXPORT
 	bool "Framebuffer export to DSP"
-	depends on OMAP_DSP
+	depends on OMAP_DSP && FB
 	help
           This enables to map the frame buffer to DSP.
 	  By doing this, DSP can access the frame buffer directly without
diff --git a/arch/arm/plat-omap/dsp/dsp.h b/arch/arm/plat-omap/dsp/dsp.h
index ae8df3e..a5512db 100644
--- a/arch/arm/plat-omap/dsp/dsp.h
+++ b/arch/arm/plat-omap/dsp/dsp.h
@@ -21,6 +21,9 @@
  *
  */
 
+#ifndef __PLAT_OMAP_DSP_DSP_H
+#define __PLAT_OMAP_DSP_DSP_H
+
 #include "hardware_dsp.h"
 #include "dsp_common.h"
 #include <asm/arch/mmu.h>
@@ -129,7 +132,7 @@ extern int dsp_mbcmd_send_and_wait_exarg(struct mbcmd *mb, struct mb_exarg *arg,
 #define dsp_mbcmd_send_and_wait(mb, q) \
 	dsp_mbcmd_send_and_wait_exarg((mb), NULL, (q))
 
-static __inline__ int __mbcompose_send_exarg(u8 cmd_h, u8 cmd_l, u16 data,
+static inline int __mbcompose_send_exarg(u8 cmd_h, u8 cmd_l, u16 data,
 					     struct mb_exarg *arg,
 					     int recovery_flag)
 {
@@ -143,7 +146,7 @@ static __inline__ int __mbcompose_send_exarg(u8 cmd_h, u8 cmd_l, u16 data,
 #define mbcompose_send_recovery(cmd_h, cmd_l, data) \
 	__mbcompose_send_exarg(MBOX_CMD_DSP_##cmd_h, (cmd_l), (data), NULL, 1)
 
-static __inline__ int __mbcompose_send_and_wait_exarg(u8 cmd_h, u8 cmd_l,
+static inline int __mbcompose_send_and_wait_exarg(u8 cmd_h, u8 cmd_l,
 						      u16 data,
 						      struct mb_exarg *arg,
 						      wait_queue_head_t *q)
@@ -242,3 +245,5 @@ extern struct omap_mmu dsp_mmu;
 
 #define dsp_mem_enable(addr)	omap_mmu_mem_enable(&dsp_mmu, (addr))
 #define dsp_mem_disable(addr)	omap_mmu_mem_disable(&dsp_mmu, (addr))
+
+#endif /* __PLAT_OMAP_DSP_DSP_H */
diff --git a/arch/arm/plat-omap/dsp/dsp_common.c b/arch/arm/plat-omap/dsp/dsp_common.c
index 2751324..310ae3c 100644
--- a/arch/arm/plat-omap/dsp/dsp_common.c
+++ b/arch/arm/plat-omap/dsp/dsp_common.c
@@ -56,7 +56,7 @@ dsp_long_t dspmem_base, dspmem_size,
 	   daram_base, daram_size,
 	   saram_base, saram_size;
 
-struct cpustat {
+static struct cpustat {
 	struct mutex lock;
 	enum cpustat_e stat;
 	enum cpustat_e req;
@@ -317,6 +317,8 @@ static int __init omap_dsp_init(void)
 	api_ck_handle = clk_get(NULL, "api_ck");
 	if (IS_ERR(api_ck_handle)) {
 		printk(KERN_ERR "omapdsp: could not acquire api_ck handle.\n");
+		if (dsp_ck_handle != NULL)
+			clk_put(dsp_ck_handle);
 		return PTR_ERR(api_ck_handle);
 	}
 
@@ -337,12 +339,14 @@ static int __init omap_dsp_init(void)
 	dsp_ick_handle = clk_get(NULL, "dsp_ick");
 	if (IS_ERR(dsp_ick_handle)) {
 		printk(KERN_ERR "omapdsp: could not acquire dsp_ick handle.\n");
+		if (dsp_fck_handle != NULL)
+			clk_put(dsp_fck_handle);
 		return PTR_ERR(dsp_ick_handle);
 	}
 #endif
 
 	init_done = 1;
-	printk(KERN_INFO "omap_dsp_init() done\n");
+	pr_info("omap_dsp_init() done\n");
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/dsp/dsp_common.h b/arch/arm/plat-omap/dsp/dsp_common.h
index 9a515dd..cf13c7e 100644
--- a/arch/arm/plat-omap/dsp/dsp_common.h
+++ b/arch/arm/plat-omap/dsp/dsp_common.h
@@ -146,18 +146,6 @@ void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void));
 void dsp_unregister_mem_cb(void);
 
 #if defined(CONFIG_ARCH_OMAP1)
-static inline void dsp_clk_autoidle(void) {}
-#elif defined(CONFIG_ARCH_OMAP2)
-static inline void dsp_clk_autoidle(void)
-{
-	/*XXX should be handled in mach-omap[1,2] XXX*/
-	PM_PWSTCTRL_DSP = (1 << 18) | (1 << 0);
-	CM_AUTOIDLE_DSP |= (1 << 1);
-	CM_CLKSTCTRL_DSP |= (1 << 0);
-}
-#endif
-
-#if defined(CONFIG_ARCH_OMAP1)
 static inline void dsp_clk_enable(void) {}
 static inline void dsp_clk_disable(void) {}
 #elif defined(CONFIG_ARCH_OMAP2)
@@ -186,7 +174,7 @@ struct dsp_kfunc_device {
 	char		*name;
 	struct clk	*fck;
 	struct clk	*ick;;
-	struct mutex	 lock;
+	spinlock_t	 lock;
 	int		 enabled;
 	int		 type;
 #define DSP_KFUNC_DEV_TYPE_COMMON	1
@@ -194,8 +182,8 @@ struct dsp_kfunc_device {
 
 	struct list_head	entry;
 
-	int	(*probe)(struct dsp_kfunc_device *);
-	int	(*remove)(struct dsp_kfunc_device *);
+	int	(*probe)(struct dsp_kfunc_device *, int);
+	int	(*remove)(struct dsp_kfunc_device *, int);
 	int	(*enable)(struct dsp_kfunc_device *, int);
 	int	(*disable)(struct dsp_kfunc_device *, int);
 };
@@ -212,7 +200,7 @@ struct omap_dsp {
 	int			mmu_irq;
 	struct omap_mbox	*mbox;
 	struct device		*dev;
-	struct list_head 	*kdev_list;
+	struct list_head	*kdev_list;
 	int			initialized;
 };
 
diff --git a/arch/arm/plat-omap/dsp/dsp_core.c b/arch/arm/plat-omap/dsp/dsp_core.c
index 4d10d4b..86a2d15 100644
--- a/arch/arm/plat-omap/dsp/dsp_core.c
+++ b/arch/arm/plat-omap/dsp/dsp_core.c
@@ -132,97 +132,44 @@ const struct cmdinfo *cmdinfo[MBOX_CMD_MAX] = {
 	[MBOX_CMD_DSP_DBG]      = &cif_dbg,
 };
 
-static int dsp_kfunc_probe_devices(struct omap_dsp *dsp)
-{
-	struct dsp_kfunc_device *p;
-	int ret, fail = 0;
-
-	mutex_lock(&dsp->lock);
-	list_for_each_entry(p, dsp->kdev_list, entry) {
-		if (p->probe == NULL)
-			continue;
-		ret = p->probe(p);
-		if (ret) {
-			printk(KERN_ERR
-			       "probing %s failed\n", p->name);
-			fail++;
-		}
-	}
-	mutex_unlock(&dsp->lock);
-
-	pr_debug("%s() fail:%d\n", __FUNCTION__, fail);
-
-	return fail;
+#define list_for_each_entry_safe_natural(p,n,h,m) \
+			list_for_each_entry_safe(p,n,h,m)
+#define __BUILD_KFUNC(fn, dir)							\
+static int __dsp_kfunc_##fn##_devices(struct omap_dsp *dsp, int type, int stage)\
+{										\
+	struct dsp_kfunc_device *p, *tmp;					\
+	int ret, fail = 0;							\
+										\
+	list_for_each_entry_safe_##dir(p, tmp, dsp->kdev_list, entry) {		\
+		if (type && (p->type != type))					\
+			continue;						\
+		if (p->fn == NULL)						\
+			continue;						\
+		ret = p->fn(p, stage);						\
+		if (ret) {							\
+			printk(KERN_ERR "%s %s failed\n", #fn, p->name);	\
+			fail++;							\
+		}								\
+	}									\
+	return fail;								\
 }
-
-static int dsp_kfunc_remove_devices(struct omap_dsp *dsp)
-{
-	struct dsp_kfunc_device *p;
-	int ret, fail = 0;
-
-	mutex_lock(&dsp->lock);
-	list_for_each_entry_reverse(p, dsp->kdev_list, entry) {
-		if (p->remove == NULL)
-			continue;
-		ret = p->remove(p);
-		if (ret) {
-			printk(KERN_ERR
-			       "removing %s failed\n", p->name);
-			fail++;
-		}
-	}
-	mutex_unlock(&dsp->lock);
-
-	pr_debug("%s() fail:%d\n", __FUNCTION__, fail);
-
-	return fail;
+#define BUILD_KFUNC(fn, dir)						\
+__BUILD_KFUNC(fn, dir)							\
+static inline int dsp_kfunc_##fn##_devices(struct omap_dsp *dsp)	\
+{									\
+	return __dsp_kfunc_##fn##_devices(dsp, 0, 0);			\
 }
-
-static int dsp_kfunc_enable_devices(struct omap_dsp *dsp, int type, int stage)
-{
-	struct dsp_kfunc_device *p;
-	int ret, fail = 0;
-
-	mutex_lock(&dsp->lock);
-	list_for_each_entry(p, dsp->kdev_list, entry) {
-		if ((p->type != type) || (p->enable == NULL))
-			continue;
-		ret = p->enable(p, stage);
-		if (ret) {
-			printk(KERN_ERR
-			       "enabling %s failed\n", p->name);
-			fail++;
-		}
-	}
-	mutex_unlock(&dsp->lock);
-
-	pr_debug("%s(%d) fail:%d\n", __FUNCTION__, type, fail);
-
-	return fail;
+#define BUILD_KFUNC_CTL(fn, dir)							\
+__BUILD_KFUNC(fn, dir)									\
+static inline int dsp_kfunc_##fn##_devices(struct omap_dsp *dsp, int type, int stage)	\
+{											\
+	return __dsp_kfunc_##fn##_devices(dsp, type, stage);				\
 }
 
-static int dsp_kfunc_disable_devices(struct omap_dsp *dsp, int type, int stage)
-{
-	struct dsp_kfunc_device *p;
-	int ret, fail = 0;
-
-	mutex_lock(&dsp->lock);
-	list_for_each_entry_reverse(p, omap_dsp->kdev_list, entry) {
-		if ((p->type != type) || (p->disable == NULL))
-			continue;
-		ret = p->disable(p, stage);
-		if (ret) {
-			printk(KERN_ERR
-			       "disabling %s failed\n", p->name);
-			fail++;
-		}
-	}
-	mutex_unlock(&dsp->lock);
-
-	pr_debug("%s(%d) fail:%d\n", __FUNCTION__, type, fail);
-
-	return fail;
-}
+BUILD_KFUNC(probe, natural)
+BUILD_KFUNC(remove, reverse)
+BUILD_KFUNC_CTL(enable, natural)
+BUILD_KFUNC_CTL(disable, reverse)
 
 int sync_with_dsp(u16 *adr, u16 val, int try_cnt)
 {
@@ -256,6 +203,7 @@ static int mbcmd_sender_prepare(void *data)
 	 *
 	 * Therefore, we can call this function here safely.
 	 */
+	dsp_mem_enable(ipbuf_sys_ad);
 	if (sync_with_dsp(&ipbuf_sys_ad->s, TID_FREE, 10) < 0) {
 		printk(KERN_ERR "omapdsp: ipbuf_sys_ad is busy.\n");
 		ret = -EBUSY;
@@ -267,6 +215,7 @@ static int mbcmd_sender_prepare(void *data)
 	}
 	ipbuf_sys_ad->s = arg->tid;
  out:
+	dsp_mem_disable(ipbuf_sys_ad);
 	return ret;
 }
 
@@ -296,9 +245,6 @@ int __dsp_mbcmd_send_exarg(struct mbcmd *mb, struct mb_exarg *arg,
 		goto out;
 	}
 
-	if (arg)
-		dsp_mem_enable(ipbuf_sys_ad);
-
 	ret = omap_mbox_msg_send(omap_dsp->mbox,
 				 *(mbox_msg_t *)mb, (void*)arg);
 	if (ret)
@@ -309,44 +255,37 @@ int __dsp_mbcmd_send_exarg(struct mbcmd *mb, struct mb_exarg *arg,
 
 	mblog_add(mb, DIR_A2D);
  out:
-	if (arg)
-		dsp_mem_disable(ipbuf_sys_ad);
-
 	return ret;
 }
 
 int dsp_mbcmd_send_and_wait_exarg(struct mbcmd *mb, struct mb_exarg *arg,
 				  wait_queue_head_t *q)
 {
-	long current_state;
-	DECLARE_WAITQUEUE(wait, current);
-
-	add_wait_queue(q, &wait);
-	current_state = current->state;
-	set_current_state(TASK_INTERRUPTIBLE);
-	if (dsp_mbcmd_send_exarg(mb, arg) < 0) {
-		set_current_state(current_state);
-		remove_wait_queue(q, &wait);
-		return -1;
-	}
-	schedule_timeout(DSP_TIMEOUT);
-	set_current_state(current_state);
-	remove_wait_queue(q, &wait);
+	int ret;
 
-	return 0;
+	DEFINE_WAIT(wait);
+	prepare_to_wait(q, &wait, TASK_INTERRUPTIBLE);
+	ret = dsp_mbcmd_send_exarg(mb, arg);
+	if (ret < 0)
+		goto out;
+	schedule_timeout(DSP_TIMEOUT);
+ out:
+	finish_wait(q, &wait);
+	return ret;
 }
 
 /*
  * mbcmd receiver
  */
-static int mbcmd_receiver(void *data)
+static int mbcmd_receiver(void* msg)
 {
-	struct mbcmd *mb = data;
+	struct mbcmd *mb = (struct mbcmd *)&msg;
 
 	if (cmdinfo[mb->cmd_h] == NULL) {
 		printk(KERN_ERR
-		       "invalid message for mbcmd_receiver().\n");
-		return -EINVAL;
+		       "invalid message (%08x) for mbcmd_receiver().\n",
+		       (mbox_msg_t)msg);
+		return -1;
 	}
 
 	(*mbseq_expect)++;
@@ -407,7 +346,7 @@ int dsp_mbox_config(void *p)
 static int __init dsp_mbox_init(void)
 {
 	omap_dsp->mbox = omap_mbox_get("dsp");
-	if (omap_dsp->mbox == NULL) {
+	if (IS_ERR(omap_dsp->mbox)) {
 		printk(KERN_ERR "failed to get mailbox handler for DSP.\n");
 		return -ENODEV;
 	}
@@ -420,8 +359,10 @@ static int __init dsp_mbox_init(void)
 
 static void dsp_mbox_exit(void)
 {
-	omap_dsp->mbox->rxq->callback = NULL;
 	omap_dsp->mbox->txq->callback = NULL;
+	omap_dsp->mbox->rxq->callback = NULL;
+
+	omap_mbox_put(omap_dsp->mbox);
 
 	if (mbsync_hold_mem_active) {
 		dsp_mem_disable((void *)daram_base);
@@ -517,36 +458,33 @@ int dsp_late_init(void)
 {
 	int ret;
 
-	/*dsp_clk_autoidle();*/
 	dsp_clk_enable();
-
 	dsp_mem_late_init();
 	ret = dsp_mbox_init();
 	if (ret)
 		goto fail_mbox;
-
 #ifdef CONFIG_ARCH_OMAP1
 	dsp_set_idle_boot_base(IDLEPG_BASE, IDLEPG_SIZE);
 #endif
 	ret = dsp_kfunc_enable_devices(omap_dsp,
 				       DSP_KFUNC_DEV_TYPE_COMMON, 0);
-	if (ret == 0)
+	if (ret)
 		goto fail_kfunc;
-
 	omap_dsp->enabled = 1;
 
 	return 0;
 
-fail_kfunc:
+ fail_kfunc:
 	dsp_mbox_exit();
-fail_mbox:
+ fail_mbox:
 	dsp_clk_disable();
+
 	return ret;
 }
 
 extern int  dsp_ctl_core_init(void);
 extern void dsp_ctl_core_exit(void);
-extern void dsp_ctl_init(void);
+extern int dsp_ctl_init(void);
 extern void dsp_ctl_exit(void);
 extern int  dsp_mem_init(void);
 extern void dsp_mem_exit(void);
@@ -581,36 +519,42 @@ static int __init dsp_drv_probe(struct platform_device *pdev)
 	ret = dsp_kfunc_probe_devices(info);
 	if (ret) {
 		ret = -ENXIO;
-		goto fail0;
+		goto fail_kfunc;
 	}
 
 	info->mmu_irq = platform_get_irq_byname(pdev, "dsp_mmu");
 	if (unlikely(info->mmu_irq) < 0) {
 		ret = -ENXIO;
-		goto fail1;
+		goto fail_irq;
 	}
 
-	if ((ret = dsp_ctl_core_init()) < 0)
-		goto fail2;
-	if ((ret = dsp_mem_init()) < 0)
-		goto fail3;
-	dsp_ctl_init();
+	ret = dsp_ctl_core_init();
+	if (ret)
+		goto fail_ctl_core;
+	ret = dsp_mem_init();
+	if (ret)
+		goto fail_mem;
+	ret = dsp_ctl_init();
+	if (unlikely(ret))
+		goto fail_ctl_init;
 	mblog_init();
-	if ((ret = dsp_taskmod_init()) < 0)
-		goto fail4;
+	ret = dsp_taskmod_init();
+	if (ret)
+		goto fail_taskmod;
 
 	return 0;
 
- fail4:
+ fail_taskmod:
 	mblog_exit();
 	dsp_ctl_exit();
+ fail_ctl_init:
 	dsp_mem_exit();
- fail3:
+ fail_mem:
 	dsp_ctl_core_exit();
- fail2:
- fail1:
+ fail_ctl_core:
+ fail_irq:
 	dsp_kfunc_remove_devices(info);
- fail0:
+ fail_kfunc:
 	kfree(info);
 
 	return ret;
@@ -642,7 +586,7 @@ static int dsp_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP1)
 static int dsp_drv_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	dsp_cfgstat_request(CFGSTAT_SUSPEND);
diff --git a/arch/arm/plat-omap/dsp/dsp_ctl.c b/arch/arm/plat-omap/dsp/dsp_ctl.c
index 5fea625..79c1fdf 100644
--- a/arch/arm/plat-omap/dsp/dsp_ctl.c
+++ b/arch/arm/plat-omap/dsp/dsp_ctl.c
@@ -269,15 +269,15 @@ static int dsp_cfg(void)
 #endif
 
 	/* send parameter */
-	if ((ret = dsp_setvar(VARID_ICRMASK, dsp_cpustat_get_icrmask())) < 0)
+	ret = dsp_setvar(VARID_ICRMASK, dsp_cpustat_get_icrmask());
+	if (ret < 0)
 		goto out;
 
 	/* create runtime sysfs entries */
 	ret = device_create_file(omap_dsp->dev, &dev_attr_loadinfo);
 	if (ret)
 		printk(KERN_ERR "device_create_file failed: %d\n", ret);
-
-out:
+ out:
 	dsp_mem_disable((void *)dspmem_base);
 	return ret;
 }
@@ -749,9 +749,8 @@ void mbox_dspcfg(struct mbcmd *mb)
 	 * revision check has been passed.
 	 */
 	if (!mbox_revision < 0) {
-		printk(KERN_INFO
-		       "mbox: DSPCFG command received, "
-		       "but revision check has not been passed.\n");
+		pr_info("mbox: DSPCFG command received, "
+			"but revision check has not been passed.\n");
 		return;
 	}
 
@@ -1038,15 +1037,28 @@ out:
 	return len;
 }
 
-void __init dsp_ctl_init(void)
+int __init dsp_ctl_init(void)
 {
 	int ret;
 
 	ret = device_create_file(omap_dsp->dev, &dev_attr_ifver);
-	ret |= device_create_file(omap_dsp->dev, &dev_attr_cpustat);
-	ret |= device_create_file(omap_dsp->dev, &dev_attr_icrmask);
-	if (ret)
-		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+	if (unlikely(ret))
+		return ret;
+	ret = device_create_file(omap_dsp->dev, &dev_attr_cpustat);
+	if (unlikely(ret))
+		goto fail_create_cpustat;
+	ret = device_create_file(omap_dsp->dev, &dev_attr_icrmask);
+	if (unlikely(ret))
+		goto fail_create_icrmask;
+
+	return 0;
+
+fail_create_icrmask:
+	device_remove_file(omap_dsp->dev, &dev_attr_cpustat);
+fail_create_cpustat:
+	device_remove_file(omap_dsp->dev, &dev_attr_ifver);
+
+	return ret;
 }
 
 void dsp_ctl_exit(void)
diff --git a/arch/arm/plat-omap/dsp/dsp_mbcmd.h b/arch/arm/plat-omap/dsp/dsp_mbcmd.h
index d30c3bc..fb35749 100644
--- a/arch/arm/plat-omap/dsp/dsp_mbcmd.h
+++ b/arch/arm/plat-omap/dsp/dsp_mbcmd.h
@@ -21,6 +21,8 @@
  *
  */
 
+#ifndef __PLAT_OMAP_DSP_MBCMD_H
+#define __PLAT_OMAP_DSP_MBCMD_H
 /*
  * mailbox command: 0x00 - 0x7f
  * when a driver wants to use mailbox, it must reserve mailbox commands here.
@@ -141,3 +143,5 @@
 
 #define BID_NULL		0xffff
 #define BID_PVT			0xfffe
+
+#endif /* __PLAT_OMAP_DSP_MBCMD_H */
diff --git a/arch/arm/plat-omap/dsp/dsp_mem.c b/arch/arm/plat-omap/dsp/dsp_mem.c
index bae65f7..30e766e 100644
--- a/arch/arm/plat-omap/dsp/dsp_mem.c
+++ b/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -352,6 +352,7 @@ static int dsp_mem_ioctl(struct inode *inode, struct file *file,
 	case MEM_IOCTL_MMUINIT:
 		if (dsp_mmu.exmap_tbl)
 			omap_mmu_unregister(&dsp_mmu);
+		dsp_mem_ipi_init();
 		return omap_mmu_register(&dsp_mmu);
 
 	case MEM_IOCTL_EXMAP:
@@ -432,17 +433,9 @@ void dsp_mem_stop(void)
 void dsp_mem_late_init(void)
 {
 	int ret = 0;
-#ifdef CONFIG_ARCH_OMAP2
-	int i, dspmem_pg_count;
-
-	dspmem_pg_count = dspmem_size >> 12;
-	for (i = 0; i < dspmem_pg_count; i++) {
-		writel(i, DSP_IPI_INDEX);
-		writel(DSP_IPI_ENTRY_ELMSIZEVALUE_16, DSP_IPI_ENTRY);
-	}
-	writel(1, DSP_IPI_ENABLE);
-	writel(IOMAP_VAL, DSP_IPI_IOMAP);
 
+	dsp_mem_ipi_init();
+#ifdef CONFIG_ARCH_OMAP2
 	dsp_mmu.clk    = dsp_fck_handle;
 	dsp_mmu.memclk = dsp_ick_handle;
 #elif defined(CONFIG_ARCH_OMAP1)
diff --git a/arch/arm/plat-omap/dsp/error.c b/arch/arm/plat-omap/dsp/error.c
index dc831ce..58df0b2 100644
--- a/arch/arm/plat-omap/dsp/error.c
+++ b/arch/arm/plat-omap/dsp/error.c
@@ -26,6 +26,7 @@
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <asm/arch/mailbox.h>
 #include <asm/uaccess.h>
 #include "dsp_mbcmd.h"
 #include "dsp.h"
@@ -50,24 +51,17 @@ static ssize_t dsp_err_read(struct file *file, char __user *buf, size_t count,
 {
 	unsigned long flags;
 	int status;
+	DEFINE_WAIT(wait);
 
 	if (count < 4)
 		return 0;
 
-	if (errcnt == 0) {
-		long current_state;
-		DECLARE_WAITQUEUE(wait, current);
-
-		add_wait_queue(&err_wait_q, &wait);
-		current_state = current->state;
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (errcnt == 0)	/* last check */
-			schedule();
-		set_current_state(current_state);
-		remove_wait_queue(&err_wait_q, &wait);
-		if (signal_pending(current))
-			return -EINTR;
-	}
+	prepare_to_wait(&err_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (errcnt == 0)
+		schedule();
+	finish_wait(&err_wait_q, &wait);
+	if (signal_pending(current))
+		return -EINTR;
 
 	local_irq_save(flags);
 	status = copy_to_user(buf, &errval, 4);
@@ -155,6 +149,12 @@ int dsp_err_isset(enum errcode_e code)
 	return (errval & dsp_err_desc[code].val) ? 1 : 0;
 }
 
+void dsp_err_notify(void)
+{
+	/* new error code should be assigned */
+	dsp_err_set(DSP_ERR_WDT, 0);
+}
+
 /*
  * functions called from mailbox interrupt routine
  */
@@ -216,11 +216,12 @@ void dsp_err_start(void)
 		if (dsp_err_isset(i))
 			dsp_err_clear(i);
 	}
-
+	omap_dsp->mbox->err_notify = dsp_err_notify;
 	errcnt = 0;
 }
 
 void dsp_err_stop(void)
 {
 	wake_up_interruptible(&err_wait_q);
+	omap_dsp->mbox->err_notify = NULL;
 }
diff --git a/arch/arm/plat-omap/dsp/fifo.h b/arch/arm/plat-omap/dsp/fifo.h
index 3a79867..c0dc26c 100644
--- a/arch/arm/plat-omap/dsp/fifo.h
+++ b/arch/arm/plat-omap/dsp/fifo.h
@@ -21,6 +21,9 @@
  *
  */
 
+#ifndef __PLAT_OMAP_DSP_FIFO_H
+#define __PLAT_OMAP_DSP_FIFO_H
+
 struct fifo_struct {
 	spinlock_t lock;
 	char *buf;
@@ -168,3 +171,5 @@ out:
 	spin_unlock(&fifo->lock);
 	return ret;
 }
+
+#endif /* __PLAT_OMAP_DSP_FIFO_H */
diff --git a/arch/arm/plat-omap/dsp/ipbuf.c b/arch/arm/plat-omap/dsp/ipbuf.c
index 943943b..aba8e74 100644
--- a/arch/arm/plat-omap/dsp/ipbuf.c
+++ b/arch/arm/plat-omap/dsp/ipbuf.c
@@ -112,10 +112,9 @@ int ipbuf_config(u16 ln, u16 lsz, void *base)
 	ipbcfg.bsycnt   = ln;	/* DSP holds all ipbufs initially. */
 	ipbcfg.cnt_full = 0;
 
-	printk(KERN_INFO
-	       "omapdsp: IPBUF configuration\n"
-	       "           %d words * %d lines at 0x%p.\n",
-	       ipbcfg.lsz, ipbcfg.ln, ipbcfg.base);
+	pr_info("omapdsp: IPBUF configuration\n"
+		"           %d words * %d lines at 0x%p.\n",
+		ipbcfg.lsz, ipbcfg.ln, ipbcfg.base);
 
 	ret = device_create_file(omap_dsp->dev, &dev_attr_ipbuf);
 	if (ret)
@@ -123,7 +122,7 @@ int ipbuf_config(u16 ln, u16 lsz, void *base)
 
 	return ret;
 
-free_out:
+ free_out:
 	kfree(g_ipbuf);
 	g_ipbuf = NULL;
 	return ret;
diff --git a/arch/arm/plat-omap/dsp/ipbuf.h b/arch/arm/plat-omap/dsp/ipbuf.h
index efaa2b7..926d353 100644
--- a/arch/arm/plat-omap/dsp/ipbuf.h
+++ b/arch/arm/plat-omap/dsp/ipbuf.h
@@ -21,6 +21,9 @@
  *
  */
 
+#ifndef __PLAT_OMAP_DSP_IPBUF_H
+#define __PLAT_OMAP_DSP_IPBUF_H
+
 struct ipbuf {
 	u16 c;			/* count */
 	u16 next;		/* link */
@@ -61,19 +64,8 @@ struct ipbuf_head {
 extern struct ipbcfg ipbcfg;
 extern struct ipbuf_sys *ipbuf_sys_da, *ipbuf_sys_ad;
 
-#define ipb_bsycnt_inc(ipbcfg)				\
-	do {						\
-		disable_irq(omap_dsp->mbox->irq);	\
-		(ipbcfg)->bsycnt++;			\
-		enable_irq(omap_dsp->mbox->irq);	\
-	} while(0)
-
-#define ipb_bsycnt_dec(ipbcfg)				\
-	do {						\
-		disable_irq(omap_dsp->mbox->irq);	\
-		(ipbcfg)->bsycnt--;			\
-		enable_irq(omap_dsp->mbox->irq);	\
-	} while(0)
+#define ipb_bsycnt_inc(ipbcfg)	atomic_inc((atomic_t *)&((ipbcfg)->bsycnt))
+#define ipb_bsycnt_dec(ipbcfg)	atomic_dec((atomic_t *)&((ipbcfg)->bsycnt))
 
 #define dsp_mem_enable_ipbuf()	dsp_mem_enable(ipbcfg.base)
 #define dsp_mem_disable_ipbuf()	dsp_mem_disable(ipbcfg.base)
@@ -105,7 +97,7 @@ struct ipblink {
 
 #define ipblink_empty(link)	((link)->top == BID_NULL)
 
-static __inline__ void __ipblink_del_top(struct ipblink *link)
+static inline void __ipblink_del_top(struct ipblink *link)
 {
 	struct ipbuf_head *ipb_h = bid_to_ipbuf(link->top);
 
@@ -115,14 +107,14 @@ static __inline__ void __ipblink_del_top(struct ipblink *link)
 		ipb_h->p->next = BID_NULL;
 }
 
-static __inline__ void ipblink_del_top(struct ipblink *link)
+static inline void ipblink_del_top(struct ipblink *link)
 {
 	spin_lock(&link->lock);
 	__ipblink_del_top(link);
 	spin_unlock(&link->lock);
 }
 
-static __inline__ void __ipblink_add_tail(struct ipblink *link, u16 bid)
+static inline void __ipblink_add_tail(struct ipblink *link, u16 bid)
 {
 	if (ipblink_empty(link))
 		link->top = bid;
@@ -131,14 +123,14 @@ static __inline__ void __ipblink_add_tail(struct ipblink *link, u16 bid)
 	link->tail = bid;
 }
 
-static __inline__ void ipblink_add_tail(struct ipblink *link, u16 bid)
+static inline void ipblink_add_tail(struct ipblink *link, u16 bid)
 {
 	spin_lock(&link->lock);
 	__ipblink_add_tail(link, bid);
 	spin_unlock(&link->lock);
 }
 
-static __inline__ void __ipblink_flush(struct ipblink *link)
+static inline void __ipblink_flush(struct ipblink *link)
 {
 	u16 bid;
 
@@ -149,46 +141,46 @@ static __inline__ void __ipblink_flush(struct ipblink *link)
 	}
 }
 
-static __inline__ void ipblink_flush(struct ipblink *link)
+static inline void ipblink_flush(struct ipblink *link)
 {
 	spin_lock(&link->lock);
 	__ipblink_flush(link);
 	spin_unlock(&link->lock);
 }
 
-static __inline__ void __ipblink_add_pvt(struct ipblink *link)
+static inline void __ipblink_add_pvt(struct ipblink *link)
 {
 	link->top  = BID_PVT;
 	link->tail = BID_PVT;
 }
 
-static __inline__ void ipblink_add_pvt(struct ipblink *link)
+static inline void ipblink_add_pvt(struct ipblink *link)
 {
 	spin_lock(&link->lock);
 	__ipblink_add_pvt(link);
 	spin_unlock(&link->lock);
 }
 
-static __inline__ void __ipblink_del_pvt(struct ipblink *link)
+static inline void __ipblink_del_pvt(struct ipblink *link)
 {
 	link->top  = BID_NULL;
 	link->tail = BID_NULL;
 }
 
-static __inline__ void ipblink_del_pvt(struct ipblink *link)
+static inline void ipblink_del_pvt(struct ipblink *link)
 {
 	spin_lock(&link->lock);
 	__ipblink_del_pvt(link);
 	spin_unlock(&link->lock);
 }
 
-static __inline__ void __ipblink_flush_pvt(struct ipblink *link)
+static inline void __ipblink_flush_pvt(struct ipblink *link)
 {
 	if (!ipblink_empty(link))
 		ipblink_del_pvt(link);
 }
 
-static __inline__ void ipblink_flush_pvt(struct ipblink *link)
+static inline void ipblink_flush_pvt(struct ipblink *link)
 {
 	spin_lock(&link->lock);
 	__ipblink_flush_pvt(link);
@@ -197,3 +189,5 @@ static __inline__ void ipblink_flush_pvt(struct ipblink *link)
 
 #define ipblink_for_each(bid, link) \
 	for (bid = (link)->top; bid != BID_NULL; bid = bid_to_ipbuf(bid)->p->next)
+
+#endif /* __PLAT_OMAP_DSP_IPBUF_H */
diff --git a/arch/arm/plat-omap/dsp/mblog.c b/arch/arm/plat-omap/dsp/mblog.c
index 53ac4ae..2b1e113 100644
--- a/arch/arm/plat-omap/dsp/mblog.c
+++ b/arch/arm/plat-omap/dsp/mblog.c
@@ -48,7 +48,16 @@ char *subcmd_name(struct mbcmd *mb)
 		break;
 	case MBOX_CMD_DSP_KFUNC:
 		s = (cmd_l == KFUNC_FBCTL) ? "FBCTL":
-		    (cmd_l == KFUNC_POWER) ? "POWER":
+			(cmd_l == KFUNC_POWER) ?
+			((mb->data == AUDIO_PWR_UP)	? "PWR AUD /UP":
+			 (mb->data == AUDIO_PWR_DOWN)	? "PWR AUD /DOWN":
+			 (mb->data == AUDIO_PWR_DOWN2)	? "PWR AUD /DOWN(2)":
+			 (mb->data == DSP_PWR_UP)	? "PWR DSP /UP":
+			 (mb->data == DSP_PWR_DOWN)	? "PWR DSP /DOWN":
+			 (mb->data == DVFS_START)	? "PWR DVFS/START":
+			 (mb->data == DVFS_STOP)	? "PWR DVFS/STOP":
+			 NULL):
+
 		    NULL;
 		break;
 	case MBOX_CMD_DSP_DSPCFG:
@@ -138,22 +147,19 @@ static inline void mblog_print_cmd(struct mbcmd *mb, arm_dsp_dir_t dir)
 		subname = subcmd_name(mb);
 		if (unlikely(!subname))
 			subname = "Unknown";
-		printk(KERN_DEBUG
-		       "mbox: %s seq=%d, cmd=%02x:%02x(%s:%s), data=%04x\n",
-		       dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
-		       ci->name, subname, mb->data);
+		pr_debug("mbox: %s seq=%d, cmd=%02x:%02x(%s:%s), data=%04x\n",
+			 dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
+			 ci->name, subname, mb->data);
 		break;
 	case CMD_L_TYPE_TID:
-		printk(KERN_DEBUG
-		       "mbox: %s seq=%d, cmd=%02x:%02x(%s:task %d), data=%04x\n",
-		       dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
-		       ci->name, mb->cmd_l, mb->data);
+		pr_debug("mbox: %s seq=%d, cmd=%02x:%02x(%s:task %d), data=%04x\n",
+			 dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
+			 ci->name, mb->cmd_l, mb->data);
 		break;
 	case CMD_L_TYPE_NULL:
-		printk(KERN_DEBUG
-		       "mbox: %s seq=%d, cmd=%02x:%02x(%s), data=%04x\n",
-		       dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
-		       ci->name, mb->data);
+		pr_debug("mbox: %s seq=%d, cmd=%02x:%02x(%s), data=%04x\n",
+			 dir_str, mb->seq, mb->cmd_h, mb->cmd_l,
+			 ci->name, mb->data);
 		break;
 	}
 }
diff --git a/arch/arm/plat-omap/dsp/mmu.h b/arch/arm/plat-omap/dsp/mmu.h
index 822071c..1c2dd71 100644
--- a/arch/arm/plat-omap/dsp/mmu.h
+++ b/arch/arm/plat-omap/dsp/mmu.h
@@ -274,4 +274,20 @@ static void intmem_disable(void) { }
 static int dsp_mmu_itack(void) { return 0; }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP2
+static inline void dsp_mem_ipi_init(void)
+{
+	int i, dspmem_pg_count;
+	dspmem_pg_count = dspmem_size >> 12;
+	for (i = 0; i < dspmem_pg_count; i++) {
+		writel(i, DSP_IPI_INDEX);
+		writel(DSP_IPI_ENTRY_ELMSIZEVALUE_16, DSP_IPI_ENTRY);
+	}
+	writel(1, DSP_IPI_ENABLE);
+	writel(IOMAP_VAL, DSP_IPI_IOMAP);
+}
+#else
+static inline void dsp_mem_ipi_init(void) { }
+#endif
+
 #endif /* __PLAT_OMAP_DSP_MMU_H */
diff --git a/arch/arm/plat-omap/dsp/proclist.h b/arch/arm/plat-omap/dsp/proclist.h
index cc5c3e0..666ca4d 100644
--- a/arch/arm/plat-omap/dsp/proclist.h
+++ b/arch/arm/plat-omap/dsp/proclist.h
@@ -21,26 +21,33 @@
  *
  */
 
+#ifndef __PLAT_OMAP_DSP_PROCLIST_H
+#define __PLAT_OMAP_DSP_PROCLIST_H
+
 struct proc_list {
 	struct list_head list_head;
 	pid_t pid;
 	struct file *file;
 };
 
-static __inline__ void proc_list_add(spinlock_t *lock, struct list_head *list,
+static inline int proc_list_add(spinlock_t *lock, struct list_head *list,
 				     struct task_struct *tsk, struct file *file)
 {
 	struct proc_list *new;
 
 	new = kmalloc(sizeof(struct proc_list), GFP_KERNEL);
+	if (new == NULL)
+		return -ENOMEM;
 	new->pid = tsk->pid;
 	new->file = file;
 	spin_lock(lock);
 	list_add_tail(&new->list_head, list);
 	spin_unlock(lock);
+
+	return 0;
 }
 
-static __inline__ void proc_list_del(spinlock_t *lock, struct list_head *list,
+static inline void proc_list_del(spinlock_t *lock, struct list_head *list,
 				     struct task_struct *tsk, struct file *file)
 {
 	struct proc_list *pl;
@@ -64,7 +71,7 @@ static __inline__ void proc_list_del(spinlock_t *lock, struct list_head *list,
 	spin_unlock(lock);
 }
 
-static __inline__ void proc_list_flush(spinlock_t *lock, struct list_head *list)
+static inline void proc_list_flush(spinlock_t *lock, struct list_head *list)
 {
 	struct proc_list *pl;
 
@@ -76,3 +83,5 @@ static __inline__ void proc_list_flush(spinlock_t *lock, struct list_head *list)
 	}
 	spin_unlock(lock);
 }
+
+#endif /* __PLAT_OMAP_DSP_PROCLIST_H */
diff --git a/arch/arm/plat-omap/dsp/task.c b/arch/arm/plat-omap/dsp/task.c
index 25c69ef..f2ccbdf 100644
--- a/arch/arm/plat-omap/dsp/task.c
+++ b/arch/arm/plat-omap/dsp/task.c
@@ -73,7 +73,7 @@
 #define TASKDEV_ST_STATE_MASK	0x7fffffff
 #define TASKDEV_ST_STALE	0x80000000
 
-struct {
+static struct {
 	long state;
 	char *name;
 } devstate_desc[] = {
@@ -90,7 +90,8 @@ struct {
 	{ TASKDEV_ST_KILLING,  "killing" },
 };
 
-static char *devstate_name(long state) {
+static char *devstate_name(long state)
+{
 	int i;
 	int max = ARRAY_SIZE(devstate_desc);
 
@@ -183,7 +184,7 @@ struct dsptask {
 #define rcvtyp_pvt(ttyp)	((ttyp) & TTYP_PVMD)
 #define rcvtyp_gbl(ttyp)	(!((ttyp) & TTYP_PVMD))
 
-static __inline__ int has_taskdev_lock(struct taskdev *dev);
+static inline int has_taskdev_lock(struct taskdev *dev);
 static int dsp_rmdev_minor(unsigned char minor);
 static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor);
 static void taskdev_delete(unsigned char minor);
@@ -254,100 +255,58 @@ static struct device_attribute dev_attr_ipblink   = __ATTR_RO(ipblink);
 static struct device_attribute dev_attr_wsz       = __ATTR_RO(wsz);
 static struct device_attribute dev_attr_mmap      = __ATTR_RO(mmap);
 
+static inline void set_taskdev_state(struct taskdev *dev, int state)
+{
+	pr_debug("omapdsp: devstate: CHANGE %s[%d]:\"%s\"->\"%s\"\n",
+		 dev->name,
+		 (dev->task ? dev->task->tid : -1),
+		 devstate_name(dev->state),
+		 devstate_name(state));
+	dev->state = state;
+}
+
 /*
  * devstate_read_lock_timeout()
  * devstate_write_lock_timeout():
  * timeout != 0: dev->state can be diffeent from what you want.
  * timeout == 0: no timeout
  */
-static int devstate_read_lock_timeout(struct taskdev *dev, long devstate,
-				      int timeout)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	long current_state = current->state;
-	int ret = 0;
-
-	down_read(&dev->state_sem);
-	if (dev->state & devstate)
-		return 0;
-
-	add_wait_queue(&dev->state_wait_q, &wait);
-	do {
-		set_current_state(TASK_INTERRUPTIBLE);
-		up_read(&dev->state_sem);
-		if (timeout) {
-			if ((timeout = schedule_timeout(timeout)) == 0) {
-				/* timeout */
-				down_read(&dev->state_sem);
-				break;
-			}
-		} else
-			schedule();
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-		down_read(&dev->state_sem);
-	} while (!(dev->state & devstate));
-	remove_wait_queue(&dev->state_wait_q, &wait);
-	set_current_state(current_state);
-	return ret;
-}
-
-static int devstate_read_lock_and_test(struct taskdev *dev, long devstate)
-{
-	down_read(&dev->state_sem);
-	if (dev->state & devstate)
-		return 1;	/* success */
-	/* failure */
-	up_read(&dev->state_sem);
-	return 0;
-}
-
-static int devstate_write_lock_timeout(struct taskdev *dev, long devstate,
-				       int timeout)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	long current_state = current->state;
-	int ret = 0;
-
-	down_write(&dev->state_sem);
-	if (dev->state & devstate)
-		return 0;
-
-	add_wait_queue(&dev->state_wait_q, &wait);
-	do {
-		set_current_state(TASK_INTERRUPTIBLE);
-		up_write(&dev->state_sem);
-		if (timeout) {
-			if ((timeout = schedule_timeout(timeout)) == 0) {
-				/* timeout */
-				down_write(&dev->state_sem);
-				break;
-			}
-		} else
-			schedule();
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-		down_write(&dev->state_sem);
-	} while (!(dev->state & devstate));
-	remove_wait_queue(&dev->state_wait_q, &wait);
-	set_current_state(current_state);
-	return ret;
-}
-
-static int devstate_write_lock_and_test(struct taskdev *dev, long devstate)
-{
-	down_write(&dev->state_sem);
-	if (dev->state & devstate)	/* success */
-		return 1;
-
-	/* failure */
-	up_write(&dev->state_sem);
-	return -1;
-}
+#define BUILD_DEVSTATE_LOCK_TIMEOUT(rw)						\
+static int devstate_##rw##_lock_timeout(struct taskdev *dev, long devstate,     \
+				      int timeout)				\
+{										\
+	DEFINE_WAIT(wait);							\
+	down_##rw(&dev->state_sem);						\
+	while (!(dev->state & devstate)) {					\
+		up_##rw(&dev->state_sem);					\
+		prepare_to_wait(&dev->state_wait_q, &wait, TASK_INTERRUPTIBLE);	\
+		if (!timeout)							\
+			timeout = MAX_SCHEDULE_TIMEOUT;				\
+		timeout = schedule_timeout(timeout);				\
+		finish_wait(&dev->state_wait_q, &wait);				\
+		if (timeout == 0)						\
+			return -ETIME;						\
+		if (signal_pending(current))					\
+			return -EINTR;						\
+		down_##rw(&dev->state_sem);					\
+	}									\
+	return 0;                                                               \
+}
+BUILD_DEVSTATE_LOCK_TIMEOUT(read)
+BUILD_DEVSTATE_LOCK_TIMEOUT(write)
+
+#define BUILD_DEVSTATE_LOCK_AND_TEST(rw)					\
+static int devstate_##rw##_lock_and_test(struct taskdev *dev, long devstate)	\
+{										\
+	down_##rw(&dev->state_sem);						\
+	if (dev->state & devstate)						\
+		return 1;	/* success */					\
+	/* failure */								\
+	up_##rw(&dev->state_sem);						\
+	return 0;								\
+}
+BUILD_DEVSTATE_LOCK_AND_TEST(read)
+BUILD_DEVSTATE_LOCK_AND_TEST(write)
 
 static int taskdev_lock_interruptible(struct taskdev *dev,
 				      struct mutex *lock)
@@ -380,7 +339,7 @@ static int taskdev_lock_and_statelock_attached(struct taskdev *dev,
 	return ret;
 }
 
-static __inline__ void taskdev_unlock_and_stateunlock(struct taskdev *dev,
+static inline void taskdev_unlock_and_stateunlock(struct taskdev *dev,
 						      struct mutex *lock)
 {
 	mutex_unlock(lock);
@@ -448,7 +407,7 @@ static int taskdev_set_fifosz(struct taskdev *dev, unsigned long sz)
 	return 0;
 }
 
-static __inline__ int has_taskdev_lock(struct taskdev *dev)
+static inline int has_taskdev_lock(struct taskdev *dev)
 {
 	return (dev->lock_pid == current->pid);
 }
@@ -501,7 +460,7 @@ static int dsp_task_config(struct dsptask *task, u8 tid)
 
 	if (strlen(task->name) <= 1)
 		sprintf(task->name, "%d", tid);
-	printk(KERN_INFO "omapdsp: task %d: name %s\n", tid, task->name);
+	pr_info("omapdsp: task %d: name %s\n", tid, task->name);
 
 	ttyp = task->ttyp;
 
@@ -563,7 +522,7 @@ int dsp_task_config_all(u8 n)
 	struct dsptask *taskheap;
 	size_t devheapsz, taskheapsz;
 
-	printk(KERN_INFO "omapdsp: found %d task(s)\n", n);
+	pr_info("omapdsp: found %d task(s)\n", n);
 	if (n == 0)
 		return 0;
 
@@ -590,7 +549,7 @@ int dsp_task_config_all(u8 n)
 		if ((ret = taskdev_attach_task(dev, task)) < 0)
 			return ret;
 		dsp_task_init(task);
-		printk(KERN_INFO "omapdsp: taskdev %s enabled.\n", dev->name);
+		pr_info("omapdsp: taskdev %s enabled.\n", dev->name);
 	}
 
 	return 0;
@@ -696,6 +655,7 @@ static ssize_t dsp_task_read_wd_acv(struct file *file, char __user *buf,
 	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
 	struct taskdev *dev = taskdev[minor];
 	int ret = 0;
+	DEFINE_WAIT(wait);
 
 	if (count == 0) {
 		return 0;
@@ -708,27 +668,22 @@ static ssize_t dsp_task_read_wd_acv(struct file *file, char __user *buf,
 	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
 		return -ENODEV;
 
+
+	prepare_to_wait(&dev->read_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (fifo_empty(&dev->rcvdt.fifo))
+		schedule();
+	finish_wait(&dev->read_wait_q, &wait);
 	if (fifo_empty(&dev->rcvdt.fifo)) {
-		long current_state = current->state;
-		DECLARE_WAITQUEUE(wait, current);
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&dev->read_wait_q, &wait);
-		if (fifo_empty(&dev->rcvdt.fifo))	/* last check */
-			schedule();
-		set_current_state(current_state);
-		remove_wait_queue(&dev->read_wait_q, &wait);
-		if (fifo_empty(&dev->rcvdt.fifo)) {
-			/* failure */
-			if (signal_pending(current))
-				ret = -EINTR;
-			goto up_out;
-		}
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
 	}
 
+
 	ret = copy_to_user_fm_fifo(buf, &dev->rcvdt.fifo, count);
 
-up_out:
+ up_out:
 	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
 	return ret;
 }
@@ -740,6 +695,7 @@ static ssize_t dsp_task_read_bk_acv(struct file *file, char __user *buf,
 	struct taskdev *dev = taskdev[minor];
 	struct rcvdt_bk_struct *rcvdt = &dev->rcvdt.bk;
 	ssize_t ret = 0;
+	DEFINE_WAIT(wait);
 
 	if (count == 0) {
 		return 0;
@@ -757,23 +713,15 @@ static ssize_t dsp_task_read_bk_acv(struct file *file, char __user *buf,
 	if (taskdev_lock_and_statelock_attached(dev, &dev->read_mutex))
 		return -ENODEV;
 
+	prepare_to_wait(&dev->read_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (ipblink_empty(&rcvdt->link))
+		schedule();
+	finish_wait(&dev->read_wait_q, &wait);
 	if (ipblink_empty(&rcvdt->link)) {
-		long current_state;
-		DECLARE_WAITQUEUE(wait, current);
-
-		add_wait_queue(&dev->read_wait_q, &wait);
-		current_state = current->state;
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (ipblink_empty(&rcvdt->link))	/* last check */
-			schedule();
-		set_current_state(current_state);
-		remove_wait_queue(&dev->read_wait_q, &wait);
-		if (ipblink_empty(&rcvdt->link)) {
-			/* failure */
-			if (signal_pending(current))
-				ret = -EINTR;
-			goto up_out;
-		}
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
 	}
 
 	/* copy from delayed IPBUF */
@@ -818,9 +766,9 @@ static ssize_t dsp_task_read_bk_acv(struct file *file, char __user *buf,
 				release_ipbuf_pvt(ipbp);
 				rcvdt->rp = 0;
 			}
-pv_out2:
+		pv_out2:
 			dsp_mem_disable(src);
-pv_out1:
+		pv_out1:
 			dsp_mem_disable(ipbp);
 		}
 	} else {
@@ -857,11 +805,11 @@ pv_out1:
 				rcvdt->rp = 0;
 			}
 		}
-gb_out:
+	gb_out:
 		dsp_mem_disable_ipbuf();
 	}
 
-up_out:
+ up_out:
 	taskdev_unlock_and_stateunlock(dev, &dev->read_mutex);
 	return ret;
 }
@@ -1009,6 +957,7 @@ static ssize_t dsp_task_write_wd(struct file *file, const char __user *buf,
 	struct taskdev *dev = taskdev[minor];
 	u16 wd;
 	int ret = 0;
+	DEFINE_WAIT(wait);
 
 	if (count == 0) {
 		return 0;
@@ -1024,23 +973,15 @@ static ssize_t dsp_task_write_wd(struct file *file, const char __user *buf,
 	if (taskdev_lock_and_statelock_attached(dev, &dev->write_mutex))
 		return -ENODEV;
 
+	prepare_to_wait(&dev->write_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (dev->wsz == 0)
+		schedule();
+	finish_wait(&dev->write_wait_q, &wait);
 	if (dev->wsz == 0) {
-		long current_state;
-		DECLARE_WAITQUEUE(wait, current);
-
-		add_wait_queue(&dev->write_wait_q, &wait);
-		current_state = current->state;
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (dev->wsz == 0)	/* last check */
-			schedule();
-		set_current_state(current_state);
-		remove_wait_queue(&dev->write_wait_q, &wait);
-		if (dev->wsz == 0) {
-			/* failure */
-			if (signal_pending(current))
-				ret = -EINTR;
-			goto up_out;
-		}
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
 	}
 
 	if (copy_from_user(&wd, buf, count)) {
@@ -1058,7 +999,7 @@ static ssize_t dsp_task_write_wd(struct file *file, const char __user *buf,
 		dev->wsz = 0;
 	spin_unlock(&dev->wsz_lock);
 
-up_out:
+ up_out:
 	taskdev_unlock_and_stateunlock(dev, &dev->write_mutex);
 	return ret;
 }
@@ -1069,6 +1010,7 @@ static ssize_t dsp_task_write_bk(struct file *file, const char __user *buf,
 	unsigned int minor = MINOR(file->f_dentry->d_inode->i_rdev);
 	struct taskdev *dev = taskdev[minor];
 	int ret = 0;
+	DEFINE_WAIT(wait);
 
 	if (count == 0) {
 		return 0;
@@ -1086,23 +1028,15 @@ static ssize_t dsp_task_write_bk(struct file *file, const char __user *buf,
 	if (taskdev_lock_and_statelock_attached(dev, &dev->write_mutex))
 		return -ENODEV;
 
+	prepare_to_wait(&dev->write_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (dev->wsz == 0)
+		schedule();
+	finish_wait(&dev->write_wait_q, &wait);
 	if (dev->wsz == 0) {
-		long current_state;
-		DECLARE_WAITQUEUE(wait, current);
-
-		add_wait_queue(&dev->write_wait_q, &wait);
-		current_state = current->state;
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (dev->wsz == 0)	/* last check */
-			schedule();
-		set_current_state(current_state);
-		remove_wait_queue(&dev->write_wait_q, &wait);
-		if (dev->wsz == 0) {
-			/* failure */
-			if (signal_pending(current))
-				ret = -EINTR;
-			goto up_out;
-		}
+		/* failure */
+		if (signal_pending(current))
+			ret = -EINTR;
+		goto up_out;
 	}
 
 	if (count > dev->wsz)
@@ -1140,9 +1074,9 @@ static ssize_t dsp_task_write_bk(struct file *file, const char __user *buf,
 			ret = count;
 		}
 		spin_unlock(&dev->wsz_lock);
-pv_out2:
+	pv_out2:
 		dsp_mem_disable(dst);
-pv_out1:
+	pv_out1:
 		dsp_mem_disable(ipbp);
 	} else {
 		/* global */
@@ -1170,11 +1104,11 @@ pv_out1:
 		} else
 			release_ipbuf(ipb_h);
 		spin_unlock(&dev->wsz_lock);
-gb_out:
+	gb_out:
 		dsp_mem_disable_ipbuf();
 	}
 
-up_out:
+ up_out:
 	taskdev_unlock_and_stateunlock(dev, &dev->write_mutex);
 	return ret;
 }
@@ -1428,10 +1362,9 @@ static int dsp_task_mmap(struct file *filp, struct vm_area_struct *vma)
 		if (tmp_len > req_len)
 			tmp_len = req_len;
 
-		printk(KERN_DEBUG
-		       "omapdsp: mmap info: "
-		       "vmadr = %08lx, padr = %08lx, len = %x\n",
-		       tmp_vmadr, tmp_padr, tmp_len);
+		pr_debug("omapdsp: mmap info: "
+			 "vmadr = %08lx, padr = %08lx, len = %x\n",
+			 tmp_vmadr, tmp_padr, tmp_len);
 		if (remap_pfn_range(vma, tmp_vmadr, tmp_padr >> PAGE_SHIFT,
 				    tmp_len, vma->vm_page_prot) != 0) {
 			printk(KERN_ERR
@@ -1465,49 +1398,49 @@ static int dsp_task_open(struct inode *inode, struct file *file)
 	if ((minor >= TASKDEV_MAX) || ((dev = taskdev[minor]) == NULL))
 		return -ENODEV;
 
-restart:
+ restart:
 	mutex_lock(&dev->usecount_lock);
 	down_write(&dev->state_sem);
 
 	/* state can be NOTASK, ATTACHED/FREEZED, KILLING, GARBAGE or INVALID here. */
 	switch (dev->state & TASKDEV_ST_STATE_MASK) {
-		case TASKDEV_ST_NOTASK:
-			break;
-		case TASKDEV_ST_ATTACHED:
-			goto attached;
+	case TASKDEV_ST_NOTASK:
+		break;
+	case TASKDEV_ST_ATTACHED:
+		goto attached;
 
-		case TASKDEV_ST_INVALID:
-			up_write(&dev->state_sem);
-			mutex_unlock(&dev->usecount_lock);
-			return -ENODEV;
+	case TASKDEV_ST_INVALID:
+		up_write(&dev->state_sem);
+		mutex_unlock(&dev->usecount_lock);
+		return -ENODEV;
 
-		case TASKDEV_ST_FREEZED:
-		case TASKDEV_ST_KILLING:
-		case TASKDEV_ST_GARBAGE:
-		case TASKDEV_ST_DELREQ:
-			/* on the kill process. wait until it becomes NOTASK. */
-			up_write(&dev->state_sem);
-			mutex_unlock(&dev->usecount_lock);
-			if (devstate_write_lock(dev, TASKDEV_ST_NOTASK) < 0)
-				return -EINTR;
-			devstate_write_unlock(dev);
-			goto restart;
+	case TASKDEV_ST_FREEZED:
+	case TASKDEV_ST_KILLING:
+	case TASKDEV_ST_GARBAGE:
+	case TASKDEV_ST_DELREQ:
+		/* on the kill process. wait until it becomes NOTASK. */
+		up_write(&dev->state_sem);
+		mutex_unlock(&dev->usecount_lock);
+		if (devstate_write_lock(dev, TASKDEV_ST_NOTASK) < 0)
+			return -EINTR;
+		devstate_write_unlock(dev);
+		goto restart;
 	}
 
 	/* NOTASK */
-	dev->state = TASKDEV_ST_ADDREQ;
+	set_taskdev_state(dev, TASKDEV_ST_ADDREQ);
 	/* wake up twch daemon for tadd */
 	dsp_twch_touch();
 	up_write(&dev->state_sem);
 	if (devstate_write_lock(dev, TASKDEV_ST_ATTACHED |
-				     TASKDEV_ST_ADDFAIL) < 0) {
+				TASKDEV_ST_ADDFAIL) < 0) {
 		/* cancelled */
 		if (!devstate_write_lock_and_test(dev, TASKDEV_ST_ADDREQ)) {
 			mutex_unlock(&dev->usecount_lock);
 			/* out of control ??? */
 			return -EINTR;
 		}
-		dev->state = TASKDEV_ST_NOTASK;
+		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
 		ret = -EINTR;
 		goto change_out;
 	}
@@ -1515,11 +1448,11 @@ restart:
 		printk(KERN_ERR "omapdsp: task attach failed for %s!\n",
 		       dev->name);
 		ret = -EBUSY;
-		dev->state = TASKDEV_ST_NOTASK;
+		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
 		goto change_out;
 	}
 
-attached:
+ attached:
 	/* ATTACHED */
 #ifndef CONFIG_OMAP_DSP_TASK_MULTIOPEN
 	if (dev->usecount > 0) {
@@ -1527,8 +1460,12 @@ attached:
 		return -EBUSY;
 	}
 #endif
+	ret = proc_list_add(&dev->proc_list_lock,
+			    &dev->proc_list, current, file);
+	if (ret)
+		goto out;
+
 	dev->usecount++;
-	proc_list_add(&dev->proc_list_lock, &dev->proc_list, current, file);
 	file->f_op = &dev->fops;
 	up_write(&dev->state_sem);
 	mutex_unlock(&dev->usecount_lock);
@@ -1539,8 +1476,9 @@ attached:
 #endif /* DSP_PTE_FREE */
 	return 0;
 
-change_out:
+ change_out:
 	wake_up_interruptible_all(&dev->state_wait_q);
+ out:
 	up_write(&dev->state_sem);
 	mutex_unlock(&dev->usecount_lock);
 	return ret;
@@ -1576,14 +1514,14 @@ static int dsp_task_release(struct inode *inode, struct file *file)
 		break;
 
 	case TASKDEV_ST_GARBAGE:
-		dev->state = TASKDEV_ST_NOTASK;
+		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
 		wake_up_interruptible_all(&dev->state_wait_q);
 		break;
 
 	case TASKDEV_ST_ATTACHED:
 	case TASKDEV_ST_FREEZED:
 		if (is_dynamic_task(minor)) {
-			dev->state = TASKDEV_ST_DELREQ;
+			set_taskdev_state(dev, TASKDEV_ST_DELREQ);
 			/* wake up twch daemon for tdel */
 			dsp_twch_touch();
 		}
@@ -1706,7 +1644,7 @@ static int dsp_rmdev_minor(unsigned char minor)
 			 * ATTACHED -> FREEZED can be changed under
 			 * down_read of state_sem..
 			 */
-			dev->state = TASKDEV_ST_FREEZED;
+			set_taskdev_state(dev, TASKDEV_ST_FREEZED);
 			wake_up_interruptible_all(&dev->read_wait_q);
 			wake_up_interruptible_all(&dev->write_wait_q);
 			wake_up_interruptible_all(&dev->tctl_wait_q);
@@ -1718,26 +1656,27 @@ static int dsp_rmdev_minor(unsigned char minor)
 	switch (dev->state & TASKDEV_ST_STATE_MASK) {
 
 	case TASKDEV_ST_NOTASK:
+	case TASKDEV_ST_INVALID:
 		/* fine */
 		goto notask;
 
 	case TASKDEV_ST_ATTACHED:
 	case TASKDEV_ST_FREEZED:
 		/* task is working. kill it. */
-		dev->state = TASKDEV_ST_KILLING;
+		set_taskdev_state(dev, TASKDEV_ST_KILLING);
 		up_write(&dev->state_sem);
 		dsp_tdel_bh(dev, TDEL_KILL);
 		goto invalidate;
 
 	case TASKDEV_ST_ADDREQ:
 		/* open() is waiting. drain it. */
-		dev->state = TASKDEV_ST_ADDFAIL;
+		set_taskdev_state(dev, TASKDEV_ST_ADDFAIL);
 		wake_up_interruptible_all(&dev->state_wait_q);
 		break;
 
 	case TASKDEV_ST_DELREQ:
 		/* nobody is waiting. */
-		dev->state = TASKDEV_ST_NOTASK;
+		set_taskdev_state(dev, TASKDEV_ST_NOTASK);
 		wake_up_interruptible_all(&dev->state_wait_q);
 		break;
 
@@ -1762,7 +1701,7 @@ invalidate:
 		       devstate_name(dev->state), dev->name);
 	}
 notask:
-	dev->state = TASKDEV_ST_INVALID;
+	set_taskdev_state(dev, TASKDEV_ST_INVALID);
 	devstate_read_unlock(dev);
 
 	taskdev_delete(minor);
@@ -1771,7 +1710,7 @@ notask:
 	return 0;
 }
 
-struct file_operations dsp_task_fops = {
+static struct file_operations dsp_task_fops = {
 	.owner   = THIS_MODULE,
 	.poll    = dsp_task_poll,
 	.ioctl   = dsp_task_ioctl,
@@ -1786,6 +1725,7 @@ static void dsptask_dev_release(struct device *dev)
 static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor)
 {
 	int ret;
+	struct device *task_dev;
 
 	taskdev[minor] = dev;
 
@@ -1804,7 +1744,7 @@ static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor)
 
 	strncpy(dev->name, name, TNM_LEN);
 	dev->name[TNM_LEN-1] = '\0';
-	dev->state = (minor < n_task) ? TASKDEV_ST_ATTACHED : TASKDEV_ST_NOTASK;
+	set_taskdev_state(dev, (minor < n_task) ? TASKDEV_ST_ATTACHED : TASKDEV_ST_NOTASK);
 	dev->usecount = 0;
 	mutex_init(&dev->usecount_lock);
 	memcpy(&dev->fops, &dsp_task_fops, sizeof(struct file_operations));
@@ -1814,21 +1754,43 @@ static int taskdev_init(struct taskdev *dev, char *name, unsigned char minor)
 	sprintf(dev->dev.bus_id, "dsptask%d", minor);
 	dev->dev.release = dsptask_dev_release;
 	ret = device_register(&dev->dev);
-	if (ret)
+	if (ret) {
 		printk(KERN_ERR "device_register failed: %d\n", ret);
+		return ret;
+	}
 	ret = device_create_file(&dev->dev, &dev_attr_devname);
-	ret |= device_create_file(&dev->dev, &dev_attr_devstate);
-	ret |= device_create_file(&dev->dev, &dev_attr_proc_list);
 	if (ret)
-		printk(KERN_ERR "device_create_file failed: %d\n", ret);
-	device_create(dsp_task_class, NULL,
-			MKDEV(OMAP_DSP_TASK_MAJOR, minor),
-			"dsptask%d", minor);
+		goto fail_create_devname;
+	ret = device_create_file(&dev->dev, &dev_attr_devstate);
+	if (ret)
+		goto fail_create_devstate;
+	ret = device_create_file(&dev->dev, &dev_attr_proc_list);
+	if (ret)
+		goto fail_create_proclist;
+
+	task_dev = device_create(dsp_task_class, NULL,
+				 MKDEV(OMAP_DSP_TASK_MAJOR, minor),
+				 "dsptask%d", (int)minor);
+	
+	if (unlikely(IS_ERR(task_dev))) {
+		ret = -EINVAL;
+		goto fail_create_taskclass;
+	}
 
 	init_waitqueue_head(&dev->state_wait_q);
 	init_rwsem(&dev->state_sem);
 
 	return 0;
+
+ fail_create_taskclass:
+	device_remove_file(&dev->dev, &dev_attr_proc_list);
+ fail_create_proclist:
+	device_remove_file(&dev->dev, &dev_attr_devstate);
+ fail_create_devstate:
+	device_remove_file(&dev->dev, &dev_attr_devname);
+ fail_create_devname:
+	device_unregister(&dev->dev);
+	return ret;
 }
 
 static void taskdev_delete(unsigned char minor)
@@ -1853,17 +1815,17 @@ static int taskdev_attach_task(struct taskdev *dev, struct dsptask *task)
 
 	dev->fops.read =
 		sndtyp_acv(ttyp) ?
-			sndtyp_wd(ttyp) ? dsp_task_read_wd_acv:
-			/* sndtyp_bk */   dsp_task_read_bk_acv:
+		sndtyp_wd(ttyp) ? dsp_task_read_wd_acv:
+		/* sndtyp_bk */   dsp_task_read_bk_acv:
 		/* sndtyp_psv */
-			sndtyp_wd(ttyp) ? dsp_task_read_wd_psv:
-			/* sndtyp_bk */   dsp_task_read_bk_psv;
+		sndtyp_wd(ttyp) ? dsp_task_read_wd_psv:
+		/* sndtyp_bk */   dsp_task_read_bk_psv;
 	if (sndtyp_wd(ttyp)) {
 		/* word */
 		size_t fifosz;
 
 		fifosz = sndtyp_psv(ttyp) ? 2 :	/* passive */
-					    32;	/* active */
+			32;	/* active */
 		if (init_fifo(&dev->rcvdt.fifo, fifosz) < 0) {
 			printk(KERN_ERR
 			       "omapdsp: unable to allocate receive buffer. "
@@ -1880,29 +1842,72 @@ static int taskdev_attach_task(struct taskdev *dev, struct dsptask *task)
 		rcvtyp_wd(ttyp) ? dsp_task_write_wd:
 		/* rcvbyp_bk */	  dsp_task_write_bk;
 	dev->wsz = rcvtyp_acv(ttyp) ? 0 :		/* active */
-		   rcvtyp_wd(ttyp)  ? 2 :		/* passive word */
-				      ipbcfg.lsz*2;	/* passive block */
+		rcvtyp_wd(ttyp)  ? 2 :		/* passive word */
+		ipbcfg.lsz*2;	/* passive block */
 
 	if (task->map_length)
 		dev->fops.mmap = dsp_task_mmap;
 
 	ret = device_create_file(&dev->dev, &dev_attr_taskname);
-	ret |= device_create_file(&dev->dev, &dev_attr_ttyp);
+	if (unlikely(ret))
+		goto fail_create_taskname;
+	ret = device_create_file(&dev->dev, &dev_attr_ttyp);
+	if (unlikely(ret))
+		goto fail_create_ttyp;
+	ret = device_create_file(&dev->dev, &dev_attr_wsz);
+	if (unlikely(ret))
+		goto fail_create_wsz;
+	if (task->map_length) {
+		ret = device_create_file(&dev->dev, &dev_attr_mmap);
+		if (unlikely(ret))
+			goto fail_create_mmap;
+	}
 	if (sndtyp_wd(ttyp)) {
-		ret |= device_create_file(&dev->dev, &dev_attr_fifosz);
-		ret |= device_create_file(&dev->dev, &dev_attr_fifocnt);
-	} else
-		ret |= device_create_file(&dev->dev, &dev_attr_ipblink);
-	ret |= device_create_file(&dev->dev, &dev_attr_wsz);
-	if (task->map_length)
-		ret |= device_create_file(&dev->dev, &dev_attr_mmap);
-	if (ret)
-		printk(KERN_ERR "device_create_file failed: %d\n", ret);
+		ret = device_create_file(&dev->dev, &dev_attr_fifosz);
+		if (unlikely(ret))
+			goto fail_create_fifosz;
+		ret = device_create_file(&dev->dev, &dev_attr_fifocnt);
+		if (unlikely(ret))
+			goto fail_create_fifocnt;
+	} else {
+		ret = device_create_file(&dev->dev, &dev_attr_ipblink);
+		if (unlikely(ret))
+			goto fail_create_ipblink;
+	}
 
 	dev->task = task;
 	task->dev = dev;
 
 	return 0;
+
+ fail_create_fifocnt:
+	device_remove_file(&dev->dev, &dev_attr_fifosz);
+ fail_create_ipblink:
+ fail_create_fifosz:
+	if (task->map_length)
+		device_remove_file(&dev->dev, &dev_attr_mmap);
+ fail_create_mmap:
+	device_remove_file(&dev->dev, &dev_attr_wsz);
+ fail_create_wsz:
+	device_remove_file(&dev->dev, &dev_attr_ttyp);
+ fail_create_ttyp:
+	device_remove_file(&dev->dev, &dev_attr_taskname);
+ fail_create_taskname:
+	if (task->map_length)
+		dev->fops.mmap = NULL;
+
+	dev->fops.write = NULL;
+	dev->wsz = 0;
+
+	dev->fops.read = NULL;
+	taskdev_flush_buf(dev);
+
+	if (sndtyp_wd(ttyp))
+		free_fifo(&dev->rcvdt.fifo);
+
+	dev->task = NULL;
+
+	return ret;
 }
 
 static void taskdev_detach_task(struct taskdev *dev)
@@ -1917,8 +1922,10 @@ static void taskdev_detach_task(struct taskdev *dev)
 	} else
 		device_remove_file(&dev->dev, &dev_attr_ipblink);
 	device_remove_file(&dev->dev, &dev_attr_wsz);
-	if (dev->task->map_length)
+	if (dev->task->map_length) {
 		device_remove_file(&dev->dev, &dev_attr_mmap);
+		dev->fops.mmap = NULL;
+	}
 
 	dev->fops.read = NULL;
 	taskdev_flush_buf(dev);
@@ -1928,7 +1935,7 @@ static void taskdev_detach_task(struct taskdev *dev)
 	dev->fops.write = NULL;
 	dev->wsz = 0;
 
-	printk(KERN_INFO "omapdsp: taskdev %s disabled.\n", dev->name);
+	pr_info("omapdsp: taskdev %s disabled.\n", dev->name);
 	dev->task = NULL;
 }
 
@@ -1949,12 +1956,12 @@ static int dsp_tadd(struct taskdev *dev, dsp_long_t adr)
 		       "(state is %s)\n", dev->name, devstate_name(dev->state));
 		return -EINVAL;
 	}
-	dev->state = TASKDEV_ST_ADDING;
+	set_taskdev_state(dev, TASKDEV_ST_ADDING);
 	devstate_write_unlock(dev);
 
 	if (adr == TADD_ABORTADR) {
 		/* aborting tadd intentionally */
-		printk(KERN_INFO "omapdsp: tadd address is ABORTADR.\n");
+		pr_info("omapdsp: tadd address is ABORTADR.\n");
 		goto fail_out;
 	}
 	if (adr >= DSPSPACE_SIZE) {
@@ -2020,8 +2027,8 @@ static int dsp_tadd(struct taskdev *dev, dsp_long_t adr)
 		goto free_out;
 
 	dsp_task_init(task);
-	printk(KERN_INFO "omapdsp: taskdev %s enabled.\n", dev->name);
-	dev->state = TASKDEV_ST_ATTACHED;
+	pr_info("omapdsp: taskdev %s enabled.\n", dev->name);
+	set_taskdev_state(dev, TASKDEV_ST_ATTACHED);
 	wake_up_interruptible_all(&dev->state_wait_q);
 	return 0;
 
@@ -2031,7 +2038,7 @@ free_out:
 del_out:
 	printk(KERN_ERR "omapdsp: deleting the task...\n");
 
-	dev->state = TASKDEV_ST_DELING;
+	set_taskdev_state(dev, TASKDEV_ST_DELING);
 
 	if (mutex_lock_interruptible(&cfg_lock)) {
 		printk(KERN_ERR "omapdsp: aborting tdel process. "
@@ -2051,7 +2058,7 @@ del_out:
 				"DSP side could be corrupted.\n");
 
 fail_out:
-	dev->state = TASKDEV_ST_ADDFAIL;
+	set_taskdev_state(dev, TASKDEV_ST_ADDFAIL);
 	wake_up_interruptible_all(&dev->state_wait_q);
 	return ret;
 }
@@ -2088,7 +2095,7 @@ static int dsp_tdel(struct taskdev *dev)
 		       "(state is %s)\n", dev->name, devstate_name(dev->state));
 		return -EINVAL;
 	}
-	dev->state = TASKDEV_ST_DELING;
+	set_taskdev_state(dev, TASKDEV_ST_DELING);
 	devstate_write_unlock(dev);
 
 	return dsp_tdel_bh(dev, TDEL_SAFE);
@@ -2130,7 +2137,7 @@ static int dsp_tkill(struct taskdev *dev)
 			return -EINVAL;
 		}
 		/* ATTACHED -> FREEZED can be changed under read semaphore. */
-		dev->state = TASKDEV_ST_FREEZED;
+		set_taskdev_state(dev, TASKDEV_ST_FREEZED);
 		wake_up_interruptible_all(&dev->read_wait_q);
 		wake_up_interruptible_all(&dev->write_wait_q);
 		wake_up_interruptible_all(&dev->tctl_wait_q);
@@ -2152,7 +2159,7 @@ static int dsp_tkill(struct taskdev *dev)
 		devstate_write_unlock(dev);
 		return -EINVAL;
 	}
-	dev->state = TASKDEV_ST_KILLING;
+	set_taskdev_state(dev, TASKDEV_ST_KILLING);
 	devstate_write_unlock(dev);
 
 	return dsp_tdel_bh(dev, TDEL_KILL);
@@ -2193,7 +2200,7 @@ static int dsp_tdel_bh(struct taskdev *dev, u16 type)
 	tid = task->tid;
 	if (mutex_lock_interruptible(&cfg_lock)) {
 		if (type == TDEL_SAFE) {
-			dev->state = TASKDEV_ST_DELREQ;
+			set_taskdev_state(dev, TASKDEV_ST_DELREQ);
 			return -EINTR;
 		} else {
 			tid_response = TID_ANON;
@@ -2220,8 +2227,8 @@ detach_out:
 		ret = -EINVAL;
 	}
 	down_write(&dev->state_sem);
-	dev->state = (dev->usecount > 0) ? TASKDEV_ST_GARBAGE :
-					   TASKDEV_ST_NOTASK;
+	set_taskdev_state(dev, (dev->usecount > 0) ? TASKDEV_ST_GARBAGE :
+					   TASKDEV_ST_NOTASK);
 	wake_up_interruptible_all(&dev->state_wait_q);
 	up_write(&dev->state_sem);
 
@@ -2443,7 +2450,7 @@ void mbox_bksndp(struct mbcmd *mb)
 		printk(KERN_ERR "mbox: BKSNDP - IPBUF sync failed!\n");
 		return;
 	}
-	printk(KERN_DEBUG "mbox: ipbuf_pvt_r->a = 0x%08lx\n",
+	pr_debug("mbox: ipbuf_pvt_r->a = 0x%08lx\n",
 	       MKLONG(ipbp->ah, ipbp->al));
 	ipblink_add_pvt(&task->dev->rcvdt.bk.link);
 	wake_up_interruptible(&task->dev->read_wait_q);
@@ -2481,7 +2488,7 @@ void mbox_bkreqp(struct mbcmd *mb)
 		printk(KERN_ERR "mbox: BKREQP - IPBUF sync failed!\n");
 		return;
 	}
-	printk(KERN_DEBUG "mbox: ipbuf_pvt_w->a = 0x%08lx\n",
+	pr_debug("mbox: ipbuf_pvt_w->a = 0x%08lx\n",
 	       MKLONG(ipbp->ah, ipbp->al));
 	dev = task->dev;
 	spin_lock(&dev->wsz_lock);
@@ -2701,20 +2708,20 @@ void mbox_dbg(struct mbcmd *mb)
 		*(p++) = tmp & 0xff;
 		if (*(p-1) == '\n') {
 			*p = '\0';
-			printk(KERN_INFO "%s", s);
+			pr_info("%s", s);
 			p = s;
 			continue;
 		}
 		if (p == s_end) {
 			*p = '\0';
-			printk(KERN_INFO "%s\n", s);
+			pr_info("%s\n", s);
 			p = s;
 			continue;
 		}
 	}
 	if (p > s) {
 		*p = '\0';
-		printk(KERN_INFO "%s\n", s);
+		pr_info("%s\n", s);
 	}
 	if ((dbg_rp += cnt + 1) > dbg_buf_sz - dbg_line_sz)
 		dbg_rp = 0;
@@ -2769,20 +2776,20 @@ static void mbox_dbg_old(struct mbcmd *mb)
 		*(p++) = tmp & 0xff;
 		if (*(p-1) == '\n') {
 			*p = '\0';
-			printk(KERN_INFO "%s", s);
+			pr_info("%s", s);
 			p = s;
 			continue;
 		}
 		if (p == s_end) {
 			*p = '\0';
-			printk(KERN_INFO "%s\n", s);
+			pr_info("%s\n", s);
 			p = s;
 			continue;
 		}
 	}
 	if (p > s) {
 		*p = '\0';
-		printk(KERN_INFO "%s\n", s);
+		pr_info("%s\n", s);
 	}
 
 	dsp_mem_disable(src);
@@ -2909,7 +2916,7 @@ static ssize_t fifocnt_show(struct device *d, struct device_attribute *attr,
 }
 
 /* ipblink */
-static __inline__ char *bid_name(u16 bid)
+static inline char *bid_name(u16 bid)
 {
 	static char s[6];
 
@@ -3012,6 +3019,13 @@ int __init dsp_taskmod_init(void)
 		return -EINVAL;
 	}
 	dsp_task_class = class_create(THIS_MODULE, "dsptask");
+	if (IS_ERR(dsp_task_class)) {
+		printk(KERN_ERR "omapdsp: failed to create DSP task class\n");
+		driver_unregister(&dsptask_driver);
+		bus_unregister(&dsptask_bus);
+		unregister_chrdev(OMAP_DSP_TASK_MAJOR, "dsptask");
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/dsp/taskwatch.c b/arch/arm/plat-omap/dsp/taskwatch.c
index 0a5781d..4297b51 100644
--- a/arch/arm/plat-omap/dsp/taskwatch.c
+++ b/arch/arm/plat-omap/dsp/taskwatch.c
@@ -48,28 +48,21 @@ static ssize_t dsp_twch_read(struct file *file, char __user *buf, size_t count,
 	long taskstat[TASKDEV_MAX];
 	int devcount = count / sizeof(long);
 	int i;
+	DEFINE_WAIT(wait);
 
 	if (dsp_cfgstat_get_stat() != CFGSTAT_READY) {
 		printk(KERN_ERR "omapdsp: dsp has not been configured.\n");
 		return -EINVAL;
 	}
 
-	if (change_cnt == 0) {
-		long current_state;
-		DECLARE_WAITQUEUE(wait, current);
-
-		add_wait_queue(&read_wait_q, &wait);
-		current_state = current->state;
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (change_cnt == 0)	/* last check */
-			schedule();
-		set_current_state(current_state);
-		remove_wait_queue(&read_wait_q, &wait);
-
-		/* unconfigured while waiting ;-( */
-		if (dsp_cfgstat_get_stat() != CFGSTAT_READY)
-			return -EINVAL;
-	}
+	prepare_to_wait(&read_wait_q, &wait, TASK_INTERRUPTIBLE);
+	if (change_cnt == 0)	/* last check */
+		schedule();
+	finish_wait(&read_wait_q, &wait);
+
+	/* unconfigured while waiting ;-( */
+	if ((change_cnt == 0) && (dsp_cfgstat_get_stat() != CFGSTAT_READY))
+		return -EINVAL;
 
 	if (devcount > TASKDEV_MAX)
 		devcount = TASKDEV_MAX;
diff --git a/arch/arm/plat-omap/dsp/uaccess_dsp.h b/arch/arm/plat-omap/dsp/uaccess_dsp.h
index a2ac7b6..9291930 100644
--- a/arch/arm/plat-omap/dsp/uaccess_dsp.h
+++ b/arch/arm/plat-omap/dsp/uaccess_dsp.h
@@ -37,7 +37,7 @@ extern unsigned long __copy_to_user_dsp_2b(void __user *to,
 #endif
 
 #ifndef HAVE_ASM_COPY_FROM_USER_DSP_2B
-static __inline__ unsigned long copy_from_user_dsp_2b(void *to,
+static inline unsigned long copy_from_user_dsp_2b(void *to,
 						      const void *from)
 {
 	unsigned short tmp;
@@ -53,7 +53,7 @@ static __inline__ unsigned long copy_from_user_dsp_2b(void *to,
 /*
  * @n must be multiple of 2
  */
-static __inline__ unsigned long copy_from_user_dsp(void *to, const void *from,
+static inline unsigned long copy_from_user_dsp(void *to, const void *from,
 						   unsigned long n)
 {
 	if (access_ok(VERIFY_READ, from, n)) {
@@ -108,7 +108,7 @@ static __inline__ unsigned long copy_from_user_dsp(void *to, const void *from,
 }
 
 #ifndef HAVE_ASM_COPY_FROM_USER_DSP_2B
-static __inline__ unsigned long copy_to_user_dsp_2b(void *to, const void *from)
+static inline unsigned long copy_to_user_dsp_2b(void *to, const void *from)
 {
 	/* expecting compiler to generate "strh" instruction */
 	unsigned short tmp = *(unsigned short *)from;
@@ -120,7 +120,7 @@ static __inline__ unsigned long copy_to_user_dsp_2b(void *to, const void *from)
 /*
  * @n must be multiple of 2
  */
-static __inline__ unsigned long copy_to_user_dsp(void *to, const void *from,
+static inline unsigned long copy_to_user_dsp(void *to, const void *from,
 						 unsigned long n)
 {
 	if (access_ok(VERIFY_WRITE, to, n)) {
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index a7c0642..6b5868e 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -1239,13 +1239,13 @@ static ssize_t mempool_show(struct class *class, char *buf)
 
 static CLASS_ATTR(mempool, S_IRUGO, mempool_show, NULL);
 
-static void omap_mmu_class_dev_release(struct class_device *cd)
+static void omap_mmu_class_dev_release(struct device *dev)
 {
 }
 
 static struct class omap_mmu_class = {
 	.name		= "mmu",
-	.release	= omap_mmu_class_dev_release,
+	.dev_release	= omap_mmu_class_dev_release,
 };
 
 int omap_mmu_register(struct omap_mmu *mmu)
-- 
1.5.0.3.271.g5ced
