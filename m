From: Paul Mundt <paul.mundt@nokia.com>
Subject: [PATCH] ARM: OMAP: dspgateway sem2mutex conversion.
Date: Wed, 3 May 2006 22:48:42 +0300
Message-ID: <20060503194842.GA31013@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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
List-Id: linux-omap@vger.kernel.org

This has been lagging behind a bit, primarily due to the fact that the
OMAP tree has gotten a bit out of sync with the DSP gateway updates
(we'll leave that for another patch).

This is a quick and simple sem2mutex conversion, after this dspgateway is
essentially down to a single rwsem for the exmap cases, and that will
remain as it is.

Against current git.

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>

---

 arch/arm/plat-omap/dsp/dsp_common.c |   44 ++++++++++---------
 arch/arm/plat-omap/dsp/dsp_core.c   |    9 ++--
 arch/arm/plat-omap/dsp/dsp_ctl.c    |   33 +++++++-------
 arch/arm/plat-omap/dsp/task.c       |   81 ++++++++++++++++++------------------
 arch/arm/plat-omap/dsp/taskwatch.c  |    7 +--
 5 files changed, 90 insertions(+), 84 deletions(-)

diff --git a/arch/arm/plat-omap/dsp/dsp_common.c b/arch/arm/plat-omap/dsp/dsp_common.c
index 9c70156..03f9134 100644
--- a/arch/arm/plat-omap/dsp/dsp_common.c
+++ b/arch/arm/plat-omap/dsp/dsp_common.c
@@ -31,6 +31,7 @@ #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/irq.h>
@@ -45,7 +46,7 @@ unsigned long dspmem_base, dspmem_size,
 	      saram_base, saram_size;
 
 struct cpustat {
-	struct semaphore sem;
+	struct mutex lock;
 	enum e_cpustat stat;
 	enum e_cpustat req;
 	unsigned short icrmask;
@@ -58,7 +59,7 @@ struct cpustat {
 	void (*mem_rel_cb)(void);
 };
 struct cpustat cpustat = {
-	.sem = __SEMAPHORE_INIT(cpustat.sem, 1),
+	.lock = __MUTEX_INITIALIZER(cpustat.lock),
 	.stat = CPUSTAT_RESET,
 	.icrmask = 0xffff,
 };
@@ -364,10 +365,10 @@ static void dsp_cpustat_update(void)
 
 void dsp_cpustat_request(enum e_cpustat req)
 {
-	down(&cpustat.sem);
+	mutex_lock(&cpustat.lock);
 	cpustat.req = req;
 	dsp_cpustat_update();
-	up(&cpustat.sem);
+	mutex_unlock(&cpustat.lock);
 }
 
 enum e_cpustat dsp_cpustat_get_stat(void)
@@ -382,23 +383,23 @@ unsigned short dsp_cpustat_get_icrmask(v
 
 void dsp_cpustat_set_icrmask(unsigned short mask)
 {
-	down(&cpustat.sem);
+	mutex_lock(&cpustat.lock);
 	cpustat.icrmask = mask;
 	dsp_cpustat_update();
-	up(&cpustat.sem);
+	mutex_unlock(&cpustat.lock);
 }
 
 void omap_dsp_request_mpui(void)
 {
-	down(&cpustat.sem);
+	mutex_lock(&cpustat.lock);
 	if (cpustat.usecount.mpui++ == 0)
 		dsp_cpustat_update();
-	up(&cpustat.sem);
+	mutex_unlock(&cpustat.lock);
 }
 
 void omap_dsp_release_mpui(void)
 {
-	down(&cpustat.sem);
+	mutex_lock(&cpustat.lock);
 	if (cpustat.usecount.mpui-- == 0) {
 		printk(KERN_ERR
 		       "omapdsp: unbalanced mpui request/release detected.\n"
@@ -408,14 +409,14 @@ void omap_dsp_release_mpui(void)
 	}
 	if (cpustat.usecount.mpui == 0)
 		dsp_cpustat_update();
-	up(&cpustat.sem);
+	mutex_unlock(&cpustat.lock);
 }
 
 int omap_dsp_request_mem(void)
 {
 	int ret = 0;
 
-	down(&cpustat.sem);
+	mutex_lock(&cpustat.lock);
 	if ((cpustat.usecount.mem++ == 0) &&
 	    (cpustat.usecount.mem_delayed == 0)) {
 		if (cpustat.mem_req_cb) {
@@ -427,7 +428,7 @@ int omap_dsp_request_mem(void)
 		dsp_cpustat_update();
 	}
 out:
-	up(&cpustat.sem);
+	mutex_unlock(&cpustat.lock);
 
 	return ret;
 }
@@ -435,22 +436,23 @@ out:
 /*
  * release_mem will be delayed.
  */
-static void do_release_mem(void) {
-	down(&cpustat.sem);
+static void do_release_mem(void)
+{
+	mutex_lock(&cpustat.lock);
 	cpustat.usecount.mem_delayed = 0;
 	if (cpustat.usecount.mem == 0) {
 		dsp_cpustat_update();
 		if (cpustat.mem_rel_cb)
 			cpustat.mem_rel_cb();
 	}
-	up(&cpustat.sem);
+	mutex_unlock(&cpustat.lock);
 }
 
 static DECLARE_WORK(mem_rel_work, (void (*)(void *))do_release_mem, NULL);
 
 int omap_dsp_release_mem(void)
 {
-	down(&cpustat.sem);
+	mutex_lock(&cpustat.lock);
 
 	/* cancel previous release work */
 	cancel_delayed_work(&mem_rel_work);
@@ -468,14 +470,14 @@ int omap_dsp_release_mem(void)
 		schedule_delayed_work(&mem_rel_work, HZ);
 	}
 
-	up(&cpustat.sem);
+	mutex_unlock(&cpustat.lock);
 
 	return 0;
 }
 
 void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void))
 {
-	down(&cpustat.sem);
+	mutex_lock(&cpustat.lock);
 
 	cpustat.mem_req_cb = req_cb;
 	cpustat.mem_rel_cb = rel_cb;
@@ -485,15 +487,15 @@ void dsp_register_mem_cb(int (*req_cb)(v
 	 */
 	BUG_ON(cpustat.usecount.mem == 0);
 
-	up(&cpustat.sem);
+	mutex_unlock(&cpustat.lock);
 }
 
 void dsp_unregister_mem_cb(void)
 {
-	down(&cpustat.sem);
+	mutex_lock(&cpustat.lock);
 	cpustat.mem_req_cb = NULL;
 	cpustat.mem_rel_cb = NULL;
-	up(&cpustat.sem);
+	mutex_unlock(&cpustat.lock);
 }
 
 /*
diff --git a/arch/arm/plat-omap/dsp/dsp_core.c b/arch/arm/plat-omap/dsp/dsp_core.c
index 4256577..65ce664 100644
--- a/arch/arm/plat-omap/dsp/dsp_core.c
+++ b/arch/arm/plat-omap/dsp/dsp_core.c
@@ -32,6 +32,7 @@ #include <linux/devfs_fs_kernel.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/signal.h>
@@ -248,7 +249,7 @@ int __mbcmd_send(struct mbcmd *mb)
  */
 int __dsp_mbcmd_send(struct mbcmd *mb, struct mb_exarg *arg, int recovery_flag)
 {
-	static DECLARE_MUTEX(mbsend_sem);
+	static DEFINE_MUTEX(mbsend_lock);
 	int ret = 0;
 
 	/*
@@ -260,14 +261,14 @@ int __dsp_mbcmd_send(struct mbcmd *mb, s
 		return -1;
 	}
 
-	if (down_interruptible(&mbsend_sem) < 0)
+	if (mutex_lock_interruptible(&mbsend_lock) < 0)
 		return -1;
 
 	if (arg) {	/* we have extra argument */
 		int i;
 
 		/*
-		 * even if ipbuf_sys_ad is in DSP internal memory, 
+		 * even if ipbuf_sys_ad is in DSP internal memory,
 		 * dsp_mem_enable() never cause to call PM mailbox command
 		 * because in that case DSP memory should be always enabled.
 		 * (see ipbuf_sys_hold_mem_active in ipbuf.c)
@@ -291,7 +292,7 @@ int __dsp_mbcmd_send(struct mbcmd *mb, s
 	ret = __mbcmd_send(mb);
 
 out:
-	up(&mbsend_sem);
+	mutex_unlock(&mbsend_lock);
 	return ret;
 }
 
diff --git a/arch/arm/plat-omap/dsp/dsp_ctl.c b/arch/arm/plat-omap/dsp/dsp_ctl.c
index fbe2f5c..3fab948 100644
--- a/arch/arm/plat-omap/dsp/dsp_ctl.c
+++ b/arch/arm/plat-omap/dsp/dsp_ctl.c
@@ -35,6 +35,7 @@ #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/ioctls.h>
@@ -56,7 +57,7 @@ static enum cfgstat {
 int mbx_revision;
 static DECLARE_WAIT_QUEUE_HEAD(ioctl_wait_q);
 static unsigned short ioctl_wait_cmd;
-static DECLARE_MUTEX(ioctl_sem);
+static DEFINE_MUTEX(ioctl_lock);
 
 static unsigned char n_stask;
 
@@ -71,7 +72,7 @@ static int dsp_regread(unsigned short cm
 	struct mbcmd mb;
 	int ret = 0;
 
-	if (down_interruptible(&ioctl_sem))
+	if (mutex_lock_interruptible(&ioctl_lock))
 		return -ERESTARTSYS;
 
 	ioctl_wait_cmd = MBCMD(REGRW);
@@ -87,7 +88,7 @@ static int dsp_regread(unsigned short cm
 	*val = varread_val[0];
 
 up_out:
-	up(&ioctl_sem);
+	mutex_unlock(&ioctl_lock);
 	return ret;
 }
 
@@ -111,7 +112,7 @@ static int dsp_getvar(unsigned char vari
 	struct mbcmd mb;
 	int ret = 0;
 
-	if (down_interruptible(&ioctl_sem))
+	if (mutex_lock_interruptible(&ioctl_lock))
 		return -ERESTARTSYS;
 
 	ioctl_wait_cmd = MBCMD(GETVAR);
@@ -127,7 +128,7 @@ static int dsp_getvar(unsigned char vari
 	memcpy(val, varread_val, sz * sizeof(short));
 
 up_out:
-	up(&ioctl_sem);
+	mutex_unlock(&ioctl_lock);
 	return ret;
 }
 
@@ -142,7 +143,7 @@ static int dspcfg(void)
 	struct mbcmd mb;
 	int ret = 0;
 
-	if (down_interruptible(&ioctl_sem))
+	if (mutex_lock_interruptible(&ioctl_lock))
 		return -ERESTARTSYS;
 
 	if (cfgstat != CFG_ERR) {
@@ -192,7 +193,7 @@ #ifdef OLD_BINARY_SUPPORT
 #endif
 
 	if ((ret = dsp_task_config_all(n_stask)) < 0) {
-		up(&ioctl_sem);
+		mutex_unlock(&ioctl_lock);
 		dspuncfg();
 		dsp_mem_disable((void *)dspmem_base);
 		return -EINVAL;
@@ -211,7 +212,7 @@ #endif
 
 up_out:
 	dsp_mem_disable((void *)dspmem_base);
-	up(&ioctl_sem);
+	mutex_unlock(&ioctl_lock);
 	return ret;
 }
 
@@ -222,7 +223,7 @@ int dspuncfg(void)
 		return -EBUSY;
 	}
 
-	if (down_interruptible(&ioctl_sem))
+	if (mutex_lock_interruptible(&ioctl_lock))
 		return -ERESTARTSYS;
 
 	/* FIXME: lock task module */
@@ -240,7 +241,7 @@ int dspuncfg(void)
 	ipbuf_stop();
 	cfgstat = CFG_ERR;
 
-	up(&ioctl_sem);
+	mutex_unlock(&ioctl_lock);
 	return 0;
 }
 
@@ -257,7 +258,7 @@ int dsp_poll(void)
 	struct mbcmd mb;
 	int ret = 0;
 
-	if (down_interruptible(&ioctl_sem))
+	if (mutex_lock_interruptible(&ioctl_lock))
 		return -ERESTARTSYS;
 
 	ioctl_wait_cmd = MBCMD(POLL);
@@ -271,7 +272,7 @@ int dsp_poll(void)
 	}
 
 up_out:
-	up(&ioctl_sem);
+	mutex_unlock(&ioctl_lock);
 	return ret;
 }
 
@@ -301,7 +302,7 @@ int dsp_suspend(void)
 		return -EINVAL;
 	}
 
-	if (down_interruptible(&ioctl_sem))
+	if (mutex_lock_interruptible(&ioctl_lock))
 		return -ERESTARTSYS;
 
 	cfgstat_save_suspend = cfgstat;
@@ -330,7 +331,7 @@ int dsp_suspend(void)
 transition:
 	cfgstat = CFG_SUSPEND;
 up_out:
-	up(&ioctl_sem);
+	mutex_unlock(&ioctl_lock);
 	return ret;
 }
 
@@ -356,7 +357,7 @@ static int dsp_fbctl_disable(void)
 	int ret = 0;
 	struct mbcmd mb;
 
-	if (down_interruptible(&ioctl_sem))
+	if (mutex_lock_interruptible(&ioctl_lock))
 		return -ERESTARTSYS;
 
 	ioctl_wait_cmd = MBCMD(KFUNC);
@@ -367,7 +368,7 @@ static int dsp_fbctl_disable(void)
 		printk(KERN_ERR "omapdsp: fb disable error!\n");
 		ret = -EINVAL;
 	}
-	up(&ioctl_sem);
+	mutex_unlock(&ioctl_lock);
 
 	return ret;
 }
diff --git a/arch/arm/plat-omap/dsp/task.c b/arch/arm/plat-omap/dsp/task.c
index 1abf4df..ca7e25c 100644
--- a/arch/arm/plat-omap/dsp/task.c
+++ b/arch/arm/plat-omap/dsp/task.c
@@ -36,6 +36,7 @@ #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/signal.h>
@@ -91,18 +92,18 @@ struct taskdev {
 
 	/* read stuff */
 	wait_queue_head_t read_wait_q;
-	struct semaphore read_sem;
+	struct mutex read_mutex;
 
 	/* write stuff */
 	wait_queue_head_t write_wait_q;
-	struct semaphore write_sem;
+	struct mutex write_mutex;
 
 	/* ioctl stuff */
 	wait_queue_head_t ioctl_wait_q;
-	struct semaphore ioctl_sem;
+	struct mutex ioctl_mutex;
 
 	/* device lock */
-	struct semaphore lock_sem;
+	struct mutex lock;
 	pid_t lock_pid;
 };
 
@@ -206,7 +207,7 @@ static struct bus_type dsptask_bus = {
 static struct class *dsp_task_class;
 static struct taskdev *taskdev[TASKDEV_MAX];
 static struct dsptask *dsptask[TASKDEV_MAX];
-static DECLARE_MUTEX(cfg_sem);
+static DEFINE_MUTEX(cfg_lock);
 static unsigned short cfg_cmd;
 static unsigned char cfg_tid;
 static DECLARE_WAIT_QUEUE_HEAD(cfg_wait_q);
@@ -256,19 +257,19 @@ static __inline__ void devstate_unlock(s
 	spin_unlock(&dev->state_lock);
 }
 
-static __inline__ int down_tasksem_interruptible(struct taskdev *dev,
-						 struct semaphore *sem)
+static inline int taskdev_lock_interruptible(struct taskdev *dev,
+					     struct mutex *lock)
 {
 	int ret;
 
 	if (dev->lock_pid == current->pid) {
 		/* this process has lock */
-		ret = down_interruptible(sem);
+		ret = mutex_lock_interruptible(lock);
 	} else {
-		if ((ret = down_interruptible(&dev->lock_sem)) != 0)
+		if ((ret = mutex_lock_interruptible(&dev->lock)) != 0)
 			return ret;
-		ret = down_interruptible(sem);
-		up(&dev->lock_sem);
+		ret = mutex_lock_interruptible(lock);
+		mutex_unlock(&dev->lock);
 	}
 	return ret;
 }
@@ -358,7 +359,7 @@ static int dsp_task_set_fifosz(struct ds
 
 static int taskdev_lock(struct taskdev *dev)
 {
-	if (down_interruptible(&dev->lock_sem))
+	if (mutex_lock_interruptible(&dev->lock))
 		return -ERESTARTSYS;
 	dev->lock_pid = current->pid;
 	return 0;
@@ -373,7 +374,7 @@ static int taskdev_unlock(struct taskdev
 		return -EINVAL;
 	}
 	dev->lock_pid = 0;
-	up(&dev->lock_sem);
+	mutex_unlock(&dev->lock);
 	return 0;
 }
 
@@ -388,7 +389,7 @@ static int dsp_task_config(struct dsptas
 
 	/* TCFG request */
 	task->state = TASK_STATE_CFGREQ;
-	if (down_interruptible(&cfg_sem)) {
+	if (mutex_lock_interruptible(&cfg_lock)) {
 		ret = -ERESTARTSYS;
 		goto fail_out;
 	}
@@ -396,7 +397,7 @@ static int dsp_task_config(struct dsptas
 	mbcmd_set(mb, MBCMD(TCFG), tid, 0);
 	dsp_mbcmd_send_and_wait(&mb, &cfg_wait_q);
 	cfg_cmd = 0;
-	up(&cfg_sem);
+	mutex_unlock(&cfg_lock);
 
 	if (task->state != TASK_STATE_READY) {
 		printk(KERN_ERR "omapdsp: task %d configuration error!\n", tid);
@@ -652,7 +653,7 @@ static ssize_t dsp_task_read_wd_acv(stru
 		return -EINVAL;
 	}
 
-	if (down_tasksem_interruptible(dev, &dev->read_sem))
+	if (taskdev_lock_interruptible(dev, &dev->read_mutex))
 		return -ERESTARTSYS;
 	if (devstate_lock(dev, OMAP_DSP_DEVSTATE_ATTACHED) < 0) {
 		ret = -ERESTARTSYS;
@@ -693,7 +694,7 @@ static ssize_t dsp_task_read_wd_acv(stru
 up_out:
 	if (have_devstate_lock)
 		devstate_unlock(dev);
-	up(&dev->read_sem);
+	mutex_unlock(&dev->read_mutex);
 	return ret;
 }
 
@@ -719,7 +720,7 @@ static ssize_t dsp_task_read_bk_acv(stru
 		return -EINVAL;
 	}
 
-	if (down_tasksem_interruptible(dev, &dev->read_sem))
+	if (taskdev_lock_interruptible(dev, &dev->read_mutex))
 		return -ERESTARTSYS;
 	if (devstate_lock(dev, OMAP_DSP_DEVSTATE_ATTACHED) < 0) {
 		ret = -ERESTARTSYS;
@@ -851,7 +852,7 @@ gb_out:
 up_out:
 	if (have_devstate_lock)
 		devstate_unlock(dev);
-	up(&dev->read_sem);
+	mutex_unlock(&dev->read_mutex);
 	return ret;
 }
 
@@ -875,7 +876,7 @@ static ssize_t dsp_task_read_wd_psv(stru
 		count = 2;
 	}
 
-	if (down_tasksem_interruptible(dev, &dev->read_sem))
+	if (taskdev_lock_interruptible(dev, &dev->read_mutex))
 		return -ERESTARTSYS;
 	if (devstate_lock(dev, OMAP_DSP_DEVSTATE_ATTACHED) < 0) {
 		ret = -ERESTARTSYS;
@@ -903,7 +904,7 @@ static ssize_t dsp_task_read_wd_psv(stru
 unlock_out:
 	devstate_unlock(dev);
 up_out:
-	up(&dev->read_sem);
+	mutex_unlock(&dev->read_mutex);
 	return ret;
 }
 
@@ -930,7 +931,7 @@ static ssize_t dsp_task_read_bk_psv(stru
 		return -EINVAL;
 	}
 
-	if (down_tasksem_interruptible(dev, &dev->read_sem))
+	if (taskdev_lock_interruptible(dev, &dev->read_mutex))
 		return -ERESTARTSYS;
 	if (devstate_lock(dev, OMAP_DSP_DEVSTATE_ATTACHED) < 0) {
 		ret = -ERESTARTSYS;
@@ -1023,7 +1024,7 @@ gb_out:
 unlock_out:
 	devstate_unlock(dev);
 up_out:
-	up(&dev->read_sem);
+	mutex_unlock(&dev->read_mutex);
 	return ret;
 }
 
@@ -1047,7 +1048,7 @@ static ssize_t dsp_task_write_wd(struct 
 		count = 2;
 	}
 
-	if (down_tasksem_interruptible(dev, &dev->write_sem))
+	if (taskdev_lock_interruptible(dev, &dev->write_mutex))
 		return -ERESTARTSYS;
 	if (devstate_lock(dev, OMAP_DSP_DEVSTATE_ATTACHED) < 0) {
 		ret = -ERESTARTSYS;
@@ -1102,7 +1103,7 @@ static ssize_t dsp_task_write_wd(struct 
 up_out:
 	if (have_devstate_lock)
 		devstate_unlock(dev);
-	up(&dev->write_sem);
+	mutex_unlock(&dev->write_mutex);
 	return ret;
 }
 
@@ -1127,7 +1128,7 @@ static ssize_t dsp_task_write_bk(struct 
 		return -EINVAL;
 	}
 
-	if (down_tasksem_interruptible(dev, &dev->write_sem))
+	if (taskdev_lock_interruptible(dev, &dev->write_mutex))
 		return -ERESTARTSYS;
 	if (devstate_lock(dev, OMAP_DSP_DEVSTATE_ATTACHED) < 0) {
 		ret = -ERESTARTSYS;
@@ -1239,7 +1240,7 @@ gb_out:
 up_out:
 	if (have_devstate_lock)
 		devstate_unlock(dev);
-	up(&dev->write_sem);
+	mutex_unlock(&dev->write_mutex);
 	return ret;
 }
 
@@ -1288,9 +1289,9 @@ static int dsp_task_ioctl(struct inode *
 
 	/*
 	 * actually only interractive commands need to lock
-	 * the semaphore, but here all commands do it for simplicity.
+	 * the mutex, but here all commands do it for simplicity.
 	 */
-	if (down_tasksem_interruptible(dev, &dev->ioctl_sem))
+	if (taskdev_lock_interruptible(dev, &dev->ioctl_mutex))
 		return -ERESTARTSYS;
 	if (devstate_lock(dev, OMAP_DSP_DEVSTATE_ATTACHED) < 0) {
 		ret = -ERESTARTSYS;
@@ -1417,7 +1418,7 @@ static int dsp_task_ioctl(struct inode *
 unlock_out:
 	devstate_unlock(dev);
 up_out:
-	up(&dev->ioctl_sem);
+	mutex_unlock(&dev->ioctl_mutex);
 	return ret;
 }
 
@@ -1755,10 +1756,10 @@ static int taskdev_init(struct taskdev *
 	init_waitqueue_head(&dev->read_wait_q);
 	init_waitqueue_head(&dev->write_wait_q);
 	init_waitqueue_head(&dev->ioctl_wait_q);
-	init_MUTEX(&dev->read_sem);
-	init_MUTEX(&dev->write_sem);
-	init_MUTEX(&dev->ioctl_sem);
-	init_MUTEX(&dev->lock_sem);
+	mutex_init(&dev->read_mutex);
+	mutex_init(&dev->write_mutex);
+	mutex_init(&dev->ioctl_mutex);
+	mutex_init(&dev->lock);
 	dev->lock_pid = 0;
 
 	strncpy(dev->name, name, OMAP_DSP_TNM_LEN);
@@ -1901,7 +1902,7 @@ int dsp_tadd(unsigned char minor, unsign
 	argv[0] = adr >> 16;	/* addrh */
 	argv[1] = adr & 0xffff;	/* addrl */
 
-	if (down_interruptible(&cfg_sem)) {
+	if (mutex_lock_interruptible(&cfg_lock)) {
 		ret = -ERESTARTSYS;
 		goto fail_out;
 	}
@@ -1918,7 +1919,7 @@ int dsp_tadd(unsigned char minor, unsign
 	tid = cfg_tid;
 	cfg_tid = OMAP_DSP_TID_ANON;
 	cfg_cmd = 0;
-	up(&cfg_sem);
+	mutex_unlock(&cfg_lock);
 
 	if (tid == OMAP_DSP_TID_ANON) {
 		printk(KERN_ERR "omapdsp: tadd failed!\n");
@@ -1962,7 +1963,7 @@ del_out:
 
 	dev->state = OMAP_DSP_DEVSTATE_DELING;
 
-	if (down_interruptible(&cfg_sem)) {
+	if (mutex_lock_interruptible(&cfg_lock)) {
 		printk(KERN_ERR "omapdsp: aborting tdel process. "
 				"DSP side could be corrupted.\n");
 		goto fail_out;
@@ -1974,7 +1975,7 @@ del_out:
 	tid_response = cfg_tid;
 	cfg_tid = OMAP_DSP_TID_ANON;
 	cfg_cmd = 0;
-	up(&cfg_sem);
+	mutex_unlock(&cfg_lock);
 
 	if (tid_response != tid)
 		printk(KERN_ERR "omapdsp: tdel failed. "
@@ -2043,7 +2044,7 @@ static int dsp_tdel_bh(unsigned char min
 
 	task = dev->task;
 	tid = task->tid;
-	if (down_interruptible(&cfg_sem)) {
+	if (mutex_lock_interruptible(&cfg_lock)) {
 		if (type == OMAP_DSP_MBCMD_TDEL_SAFE) {
 			dev->state = OMAP_DSP_DEVSTATE_DELREQ;
 			return -ERESTARTSYS;
@@ -2060,7 +2061,7 @@ static int dsp_tdel_bh(unsigned char min
 	tid_response = cfg_tid;
 	cfg_tid = OMAP_DSP_TID_ANON;
 	cfg_cmd = 0;
-	up(&cfg_sem);
+	mutex_unlock(&cfg_lock);
 
 detach_out:
 	taskdev_detach_task(dev);
diff --git a/arch/arm/plat-omap/dsp/taskwatch.c b/arch/arm/plat-omap/dsp/taskwatch.c
index b09c59d..cdd7182 100644
--- a/arch/arm/plat-omap/dsp/taskwatch.c
+++ b/arch/arm/plat-omap/dsp/taskwatch.c
@@ -31,6 +31,7 @@ #include <linux/fs.h>
 #include <linux/poll.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/arch/dsp.h>
@@ -111,10 +112,10 @@ static unsigned int dsp_twch_poll(struct
 static int dsp_twch_ioctl(struct inode *inode, struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
-	static DECLARE_MUTEX(ioctl_sem);
+	static DEFINE_MUTEX(ioctl_lock);
 	int ret;
 
-	if (down_interruptible(&ioctl_sem))
+	if (mutex_lock_interruptible(&ioctl_lock))
 		return -ERESTARTSYS;
 
 	switch (cmd) {
@@ -166,7 +167,7 @@ static int dsp_twch_ioctl(struct inode *
 	}
 
 up_out:
-	up(&ioctl_sem);
+	mutex_unlock(&ioctl_lock);
 	return ret;
 }
 
