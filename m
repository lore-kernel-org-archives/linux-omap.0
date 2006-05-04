From: Paul Mundt <paul.mundt@nokia.com>
Subject: [PATCH] ARM: OMAP: STI netlink sem2mutex conversion.
Date: Thu, 4 May 2006 16:36:21 +0300
Message-ID: <20060504133621.GA18545@nokia.com>
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

Simple update of the STI netlink interface for the mutex API.

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>

---

 arch/arm/plat-omap/sti/sti-netlink.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/sti/sti-netlink.c b/arch/arm/plat-omap/sti/sti-netlink.c
index 45b8085..5593aee 100644
--- a/arch/arm/plat-omap/sti/sti-netlink.c
+++ b/arch/arm/plat-omap/sti/sti-netlink.c
@@ -1,7 +1,7 @@
 /*
  * OMAP STI/XTI communications interface via netlink socket.
  *
- * Copyright (C) 2004, 2005 Nokia Corporation
+ * Copyright (C) 2004, 2005, 2006 Nokia Corporation
  * Written by: Paul Mundt <paul.mundt@nokia.com>
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -13,11 +13,12 @@ #include <linux/kernel.h>
 #include <linux/netlink.h>
 #include <linux/socket.h>
 #include <linux/skbuff.h>
+#include <linux/mutex.h>
 #include <net/sock.h>
 #include <asm/arch/sti.h>
 
 static struct sock *sti_sock;
-static DECLARE_MUTEX(sti_netlink_sem);
+static DEFINE_MUTEX(sti_netlink_mutex);
 
 enum {
 	STI_READ,
@@ -126,7 +127,7 @@ static void sti_netlink_receive(struct s
 {
 	struct sk_buff *skb;
 
-	if (down_trylock(&sti_netlink_sem))
+	if (!mutex_trylock(&sti_netlink_mutex))
 		return;
 
 	while ((skb = skb_dequeue(&sk->sk_receive_queue)))
@@ -135,7 +136,7 @@ static void sti_netlink_receive(struct s
 		else
 			kfree_skb(skb);
 
-	up(&sti_netlink_sem);
+	mutex_unlock(&sti_netlink_mutex);
 }
 
 static int __init sti_netlink_init(void)
