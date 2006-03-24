From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: tahvo_user: sem2mutex conversion
Date: Fri, 24 Mar 2006 05:44:53 -0800 (PST)
Message-ID: <20060324134453.36625.qmail@web32902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2102290844-1143207893=:32207"
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

--0-2102290844-1143207893=:32207
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
--0-2102290844-1143207893=:32207
Content-Type: text/plain; name="0007-OMAP-tahvo_user-sem2mutex-conversion.txt"
Content-Description: 845821678-0007-OMAP-tahvo_user-sem2mutex-conversion.txt
Content-Disposition: inline;
	filename="0007-OMAP-tahvo_user-sem2mutex-conversion.txt"

Subject: [PATCH] OMAP: tahvo_user: sem2mutex conversion

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/cbus/tahvo-user.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

af64f384cd40d9577360abdc37e5148df7463f42
diff --git a/drivers/cbus/tahvo-user.c b/drivers/cbus/tahvo-user.c
index 7e6f770..972c7ef 100644
--- a/drivers/cbus/tahvo-user.c
+++ b/drivers/cbus/tahvo-user.c
@@ -31,6 +31,7 @@
 #include <linux/poll.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 
@@ -64,7 +65,7 @@ static LIST_HEAD(tahvo_irqs_reserve);
 DECLARE_WAIT_QUEUE_HEAD(tahvo_user_waitqueue);
 
 /* Semaphore to protect irq subscription sequence */
-static struct semaphore tahvo_sem;
+static struct mutex tahvo_mutex;
 
 /* This array specifies TAHVO register types (read/write/toggle) */
 static const u8 tahvo_access_bits[] = {
@@ -120,14 +121,14 @@ static int tahvo_user_subscribe_to_irq(i
 {
 	int ret;
 
-	down(&tahvo_sem);
+	mutex_lock(&tahvo_mutex);
 	if ((tahvo_irq_subscr != NULL) && (tahvo_irq_subscr != filp)) {
-		up(&tahvo_sem);
+		mutex_unlock(&tahvo_mutex);
 		return -EBUSY;
 	}
 	/* Store the file pointer of the first user process registering IRQs */
 	tahvo_irq_subscr = filp;
-	up(&tahvo_sem);
+	mutex_unlock(&tahvo_mutex);
 
 	if (tahvo_irq_bits & (1 << id))
 		return 0;
@@ -365,7 +366,7 @@ int tahvo_user_init(void)
 	tahvo_irq_block = irq;
 
 	spin_lock_init(&tahvo_irqs_lock);
-	sema_init(&tahvo_sem, 1);
+	mutex_init(&tahvo_mutex);
 
 	/* Request a misc device */
 	res = misc_register(&tahvo_device);
-- 
1.1.6

--0-2102290844-1143207893=:32207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-2102290844-1143207893=:32207--
