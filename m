From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] retu-user: sem2mutex conversion
Date: Fri, 24 Mar 2006 05:42:23 -0800 (PST)
Message-ID: <20060324134224.45119.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1345821566-1143207743=:39490"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-1345821566-1143207743=:39490
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
--0-1345821566-1143207743=:39490
Content-Type: text/plain; name="0005-OMAP-retu-user-sem2mutex-conversion.txt"
Content-Description: 2774699579-0005-OMAP-retu-user-sem2mutex-conversion.txt
Content-Disposition: inline;
	filename="0005-OMAP-retu-user-sem2mutex-conversion.txt"

Subject: [PATCH] OMAP: retu-user: sem2mutex conversion

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/cbus/retu-user.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

6d9e7f718ff520bfb7a7d6a31252a048a80b4c27
diff --git a/drivers/cbus/retu-user.c b/drivers/cbus/retu-user.c
index 69d1be9..3245945 100644
--- a/drivers/cbus/retu-user.c
+++ b/drivers/cbus/retu-user.c
@@ -31,6 +31,7 @@
 #include <linux/poll.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 
@@ -64,7 +65,7 @@ static LIST_HEAD(retu_irqs_reserve);
 DECLARE_WAIT_QUEUE_HEAD(retu_user_waitqueue);
 
 /* Semaphore to protect irq subscription sequence */
-static struct semaphore retu_sem;
+static struct mutex retu_mutex;
 
 /* This array specifies RETU register types (read/write/toggle) */
 static const u8 retu_access_bits[] = {
@@ -135,14 +136,14 @@ static int retu_user_subscribe_to_irq(in
 {
 	int ret;
 
-	down(&retu_sem);
+	mutex_lock(&retu_mutex);
 	if ((retu_irq_subscr != NULL) && (retu_irq_subscr != filp)) {
-		up(&retu_sem);
+		mutex_unlock(&retu_mutex);
 		return -EBUSY;
 	}
 	/* Store the file pointer of the first user process registering IRQs */
 	retu_irq_subscr = filp;
-	up(&retu_sem);
+	mutex_unlock(&retu_mutex);
 
 	if (retu_irq_bits & (1 << id))
 		return 0;
@@ -384,7 +385,7 @@ int retu_user_init(void)
 	retu_irq_block = irq;
 
 	spin_lock_init(&retu_irqs_lock);
-	sema_init(&retu_sem, 1);
+	mutex_init(&retu_mutex);
 
 	/* Request a misc device */
 	res = misc_register(&retu_device);
-- 
1.1.6

--0-1345821566-1143207743=:39490
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1345821566-1143207743=:39490--
