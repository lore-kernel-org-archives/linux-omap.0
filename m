From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: fix suspend for twl4030
Date: Tue, 24 Jul 2007 16:47:16 -0700
Message-ID: <20070724234716.488413681@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Use competions instead of manually setting scheduler state.
daemonize kernel thread and set PF_NOFREEZE.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 drivers/i2c/chips/twl4030_core.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

Index: linux-2.6.21/drivers/i2c/chips/twl4030_core.c
===================================================================
--- linux-2.6.21.orig/drivers/i2c/chips/twl4030_core.c
+++ linux-2.6.21/drivers/i2c/chips/twl4030_core.c
@@ -146,6 +146,7 @@ static void twl_init_irq(void);
 /**** Data Structures */
 /* To have info on T2 IRQ substem activated or not */
 static unsigned char twl_irq_used = FREE;
+static struct completion irq_event;
 
 /* Structure to define on TWL4030 Slave ID */
 struct twl4030_client {
@@ -459,11 +460,16 @@ static int twl4030_irq_thread(void *data
 	static unsigned i2c_errors;
 	const static unsigned max_i2c_errors = 100;
 
+	daemonize("twl4030-irq");
+	current->flags |= PF_NOFREEZE;
+
 	while (!kthread_should_stop()) {
 		int ret;
 		int module_irq;
 		u8 pih_isr;
 
+		wait_for_completion_interruptible(&irq_event);
+
 		ret = twl4030_i2c_read_u8(TWL4030_MODULE_PIH, &pih_isr,
 					  REG_PIH_ISR_P1);
 		if (ret) {
@@ -491,16 +497,9 @@ static int twl4030_irq_thread(void *data
 			}
 		}
 
-		local_irq_disable();
-
-		set_current_state(TASK_INTERRUPTIBLE);
 		desc->chip->unmask(irq);
-
-		local_irq_enable();
-
-		schedule();
 	}
-	set_current_state(TASK_RUNNING);
+
 	return 0;
 }
 
@@ -516,7 +515,7 @@ static int twl4030_irq_thread(void *data
 static void do_twl4030_irq(unsigned int irq, irq_desc_t *desc)
 {
 	const unsigned int cpu = smp_processor_id();
-	struct task_struct *thread = get_irq_data(irq);
+
 	/*
 	 * Earlier this was desc->triggered = 1;
 	 */
@@ -530,8 +529,7 @@ static void do_twl4030_irq(unsigned int 
 	if (!desc->depth) {
 		kstat_cpu(cpu).irqs[irq]++;
 
-		if (thread && thread->state != TASK_RUNNING)
-			wake_up_process(thread);
+		complete(&irq_event);
 	}
 }
 
@@ -637,8 +635,9 @@ struct task_struct *start_twl4030_irq_th
 {
 	struct task_struct *thread;
 
-	thread = kthread_create(twl4030_irq_thread, (void *)irq,
-				"twl4030 irq %d", irq);
+	init_completion(&irq_event);
+	thread = kthread_run(twl4030_irq_thread, (void *)irq,
+			     "twl4030 irq %d", irq);
 	if (!thread)
 		pr_err("%s: could not create twl4030 irq %d thread!\n",
 		       __FUNCTION__,irq);
--
