From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] ipt_IDLETIMER: worqueue fixes
Date: Mon, 08 Jan 2007 11:15:29 +0100
Message-ID: <85irfhese6.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

This patch fixes the build of ipt_ILDETIMER with current omap -git

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=idle_timer_workqueue.patch

---
 net/ipv4/netfilter/ipt_IDLETIMER.c |    7 	4 +	3 -	0 !
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-omap-2.6/net/ipv4/netfilter/ipt_IDLETIMER.c
===================================================================
--- linux-omap-2.6.orig/net/ipv4/netfilter/ipt_IDLETIMER.c	2007-01-07 14:10:28.000000000 +0100
+++ linux-omap-2.6/net/ipv4/netfilter/ipt_IDLETIMER.c	2007-01-07 14:12:25.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_IDLETIMER.h>
 #include <linux/kobject.h>
+#include <linux/workqueue.h>
 
 #if 0
 #define DEBUGP(format, args...) printk("%s:%s:" format, \
@@ -68,9 +69,9 @@ static void utimer_delete(struct utimer_
 	kfree(timer);
 }
 
-static void utimer_work(void * data)
+static void utimer_work(struct work_struct *work)
 {
-	struct utimer_t *timer = (struct utimer_t *) data;
+	struct utimer_t *timer = container_of(work, struct utimer_t, work);
 	struct net_device *netdev;
 
 	netdev = dev_get_by_name(timer->name);
@@ -110,7 +111,7 @@ static struct utimer_t *utimer_create(co
 	timer->timer.function = utimer_expired;
 	timer->timer.data = (unsigned long) timer;
 
-	INIT_WORK(&timer->work, utimer_work, timer);
+	INIT_WORK(&timer->work, utimer_work);
 
 	DEBUGP("Created timer '%s'\n", timer->name);
 

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
