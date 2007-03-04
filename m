From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH] ARM: OMAP2: Update N800 defconfig
Date: Sun, 04 Mar 2007 13:21:35 +0100
Message-ID: <85y7mdgpww.fsf@orfeo.duckcorp.org>
References: <45EA9F87.6090300@googlemail.com>
	<85649hjnnp.fsf@orfeo.duckcorp.org> <45EAB2E7.1000607@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45EAB2E7.1000607@googlemail.com> (Dirk Behme's message of "Sun,
	04 Mar 2007 12:52:07 +0100")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--=-=-=

Dirk Behme <dirk.behme@googlemail.com> writes:

> Arnaud Patard (Rtp) wrote:
>>>Update N800 defconfig, mainly to disable netfilter which
>>>doesn't compile:
>>  Fixing the build may be a better idea than disabling it.
>
> Yes, your are right ;) But this is something we can't do here on OMAP
> list.

I disagree. This driver afaik can only be found in the omap tree and
it's only a matter of taking few minutes to update the driver to follow
upstream changes. So, unless the original author of the driver fixes it
(which I doubt), it's up to us to fix it.

As I said, I have a patch for it. I'm attaching it to this mail for
reference because I'm now thinking that I won't be able to test it on my
n770.

Arnaud


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=IDLETIMER_fix.patch

---
 net/ipv4/netfilter/ipt_IDLETIMER.c |   45 	20 +	25 -	0 !
 1 file changed, 20 insertions(+), 25 deletions(-)

Index: linux-omap-2.6/net/ipv4/netfilter/ipt_IDLETIMER.c
===================================================================
--- linux-omap-2.6.orig/net/ipv4/netfilter/ipt_IDLETIMER.c	2007-03-02 00:40:19.000000000 +0100
+++ linux-omap-2.6/net/ipv4/netfilter/ipt_IDLETIMER.c	2007-03-02 00:58:07.000000000 +0100
@@ -30,7 +30,7 @@
 #include <linux/notifier.h>
 #include <linux/netfilter.h>
 #include <linux/rtnetlink.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ipt_IDLETIMER.h>
 #include <linux/kobject.h>
 #include <linux/workqueue.h>
@@ -45,8 +45,8 @@
 /*
  * Internal timer management.
  */
-static ssize_t utimer_attr_show(struct class_device *, char *buf);
-static ssize_t utimer_attr_store(struct class_device *,
+static ssize_t utimer_attr_show(struct device *, struct device_attribute *attr, char *buf);
+static ssize_t utimer_attr_store(struct device *, struct device_attribute *attr,
 				 const char *buf, size_t count);
 
 struct utimer_t {
@@ -58,7 +58,7 @@ struct utimer_t {
 
 static LIST_HEAD(active_utimer_head);
 static DEFINE_SPINLOCK(list_lock);
-static CLASS_DEVICE_ATTR(idletimer, 0644, utimer_attr_show, utimer_attr_store);
+static DEVICE_ATTR(idletimer, 0644, utimer_attr_show, utimer_attr_store);
 
 static void utimer_delete(struct utimer_t *timer)
 {
@@ -77,7 +77,7 @@ static void utimer_work(struct work_stru
 	netdev = dev_get_by_name(timer->name);
 
 	if (netdev != NULL) {
-		sysfs_notify(&netdev->class_dev.kobj, NULL,
+		sysfs_notify(&netdev->dev.kobj, NULL,
 			     "idletimer");
 		dev_put(netdev);
 	}
@@ -145,13 +145,14 @@ static void utimer_modify(const char *na
 	spin_unlock_bh(&list_lock);
 }
 
-static ssize_t utimer_attr_show(struct class_device *dev, char *buf)
+static ssize_t utimer_attr_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct utimer_t *timer;
 	unsigned long expires = 0;
+	struct net_device *netdev = container_of(dev, struct net_device, dev);
 
 	spin_lock_bh(&list_lock);
-	timer = __utimer_find(dev->class_id);
+	timer = __utimer_find(netdev->name);
 	if (timer)
 		expires = timer->timer.expires;
 	spin_unlock_bh(&list_lock);
@@ -162,14 +163,15 @@ static ssize_t utimer_attr_show(struct c
 	return sprintf(buf, "0\n");
 }
 
-static ssize_t utimer_attr_store(struct class_device *dev,
+static ssize_t utimer_attr_store(struct device *dev, struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
 	int expires;
+	struct net_device *netdev = container_of(dev, struct net_device, dev);
 
 	if (sscanf(buf, "%d", &expires) == 1) {
 		if (expires > 0)
-			utimer_modify(dev->class_id,
+			utimer_modify(netdev->name,
 				      jiffies+HZ*(unsigned long)expires);
 	}
 
@@ -184,13 +186,13 @@ static int utimer_notifier_call(struct n
 	switch (event) {
 	case NETDEV_UP:
 		DEBUGP("NETDEV_UP: %s\n", dev->name);
-		class_device_create_file(&dev->class_dev,
-					 &class_device_attr_idletimer);
+		device_create_file(&dev->dev,
+					 &dev_attr_idletimer);
 		break;
 	case NETDEV_DOWN:
 		DEBUGP("NETDEV_DOWN: %s\n", dev->name);
-		class_device_remove_file(&dev->class_dev,
-					 &class_device_attr_idletimer);
+		device_remove_file(&dev->dev,
+					 &dev_attr_idletimer);
 		break;
 	}
 
@@ -231,8 +233,7 @@ static unsigned int ipt_idletimer_target
 					 const struct net_device *out,
 					 unsigned int hooknum,
 					 const struct xt_target *xttarget,
-					 const void *targinfo,
-					 void *userinfo)
+					 const void *targinfo)
 {
 	struct ipt_idletimer_info *target = (struct ipt_idletimer_info*) targinfo;
 	unsigned long expires;
@@ -245,24 +246,18 @@ static unsigned int ipt_idletimer_target
 	if (out != NULL)
 		utimer_modify(out->name, expires);
 
-	return IPT_CONTINUE;
+	return XT_CONTINUE;
 }
 
 static int ipt_idletimer_checkentry(const char *tablename,
 				    const void *e,
 				    const struct xt_target *target,
 				    void *targinfo,
-				    unsigned int targinfosize,
 				    unsigned int hookmask)
 {
 	struct ipt_idletimer_info *info =
 		(struct ipt_idletimer_info *) targinfo;
 
-	if (targinfosize != IPT_ALIGN(sizeof(struct ipt_idletimer_info))) {
-		DEBUGP("targinfosize %u != 0\n", targinfosize);
-		return 0;
-	}
-
 	if (info->timeout == 0) {
 		DEBUGP("timeout value is zero\n");
 		return 0;
@@ -271,7 +266,7 @@ static int ipt_idletimer_checkentry(cons
 	return 1;
 }
 
-static struct ipt_target ipt_idletimer = {
+static struct xt_target ipt_idletimer = {
 	.name		= "IDLETIMER",
 	.target		= ipt_idletimer_target,
 	.checkentry	= ipt_idletimer_checkentry,
@@ -287,7 +282,7 @@ static int __init init(void)
 	if (ret)
 		return ret;
 
-	if (ipt_register_target(&ipt_idletimer)) {
+	if (xt_register_target(&ipt_idletimer)) {
 		utimer_fini();
 		return -EINVAL;
 	}
@@ -297,7 +292,7 @@ static int __init init(void)
 
 static void __exit fini(void)
 {
-	ipt_unregister_target(&ipt_idletimer);
+	xt_unregister_target(&ipt_idletimer);
 	utimer_fini();
 }
 

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
