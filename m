From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: Menelaus: sem2mutex conversion
Date: Fri, 24 Mar 2006 05:37:05 -0800 (PST)
Message-ID: <20060324133705.35012.qmail@web32912.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-981613896-1143207425=:31047"
Content-Transfer-Encoding: 8bit
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

--0-981613896-1143207425=:31047
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

 
 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-981613896-1143207425=:31047
Content-Type: text/plain; name="0002-OMAP-Menelaus-sem2mutex-conversion.txt"
Content-Description: 2719435515-0002-OMAP-Menelaus-sem2mutex-conversion.txt
Content-Disposition: inline;
	filename="0002-OMAP-Menelaus-sem2mutex-conversion.txt"

Subject: [PATCH] OMAP: Menelaus: sem2mutex conversion

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/i2c/chips/menelaus.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

ea50d76db43f835a43f9f31192d95406d2c7d647
diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index c3a750e..b305e7f 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -33,6 +33,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/mutex.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/irq.h>
@@ -133,7 +134,7 @@ I2C_CLIENT_INSMOD;
 
 struct menelaus_chip {
 	unsigned long		initialized;
-	struct semaphore	lock;
+	struct mutex		lock;
 	struct i2c_client	client;
 	struct work_struct	work;
 	int			irq;
@@ -193,10 +194,10 @@ static void menelaus_ack_irq(int irq)
 /* Adds a handler for an interrupt. Does not run in interrupt context */
 static int menelaus_add_irq_work(int irq, void * handler)
 {
-	down(&menelaus.lock);
+	mutex_lock(&menelaus.lock);
 	menelaus.handlers[irq] = handler;
 	menelaus_enable_irq(irq);
-	up(&menelaus.lock);
+	mutex_unlock(&menelaus.lock);
 
 	return 0;
 }
@@ -204,10 +205,10 @@ static int menelaus_add_irq_work(int irq
 /* Removes handler for an interrupt */
 static void menelaus_remove_irq_work(int irq)
 {
-	down(&menelaus.lock);
+	mutex_lock(&menelaus.lock);
 	menelaus_disable_irq(irq);
 	menelaus.handlers[irq] = NULL;
-	up(&menelaus.lock);
+	mutex_unlock(&menelaus.lock);
 }
 
 /*-----------------------------------------------------------------------*/
@@ -332,7 +333,7 @@ static void menelaus_work(void * _menela
 
 		for (i = 0; i < IH_MENELAUS_IRQS; i++) {
 			if (isr & (1 << i)) {
-				down(&menelaus->lock);
+				mutex_lock(&menelaus->lock);
 				menelaus_disable_irq(i);
 				menelaus_ack_irq(i);
 				if (menelaus->handlers[i]) {
@@ -340,7 +341,7 @@ static void menelaus_work(void * _menela
 					handler(menelaus);
 				}
 				menelaus_enable_irq(i);
-				up(&menelaus->lock);
+				mutex_unlock(&menelaus->lock);
 			}
 		}
 	}
@@ -405,7 +406,7 @@ static int menelaus_probe(struct i2c_ada
 	if (err)
 		printk(KERN_ERR "Could not get Menelaus IRQ\n");
 
-	init_MUTEX(&menelaus.lock);
+	mutex_init(&menelaus.lock);
 	INIT_WORK(&menelaus.work, menelaus_work, &menelaus);
 
 	if (kind < 0)
-- 
1.1.6

--0-981613896-1143207425=:31047
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-981613896-1143207425=:31047--
