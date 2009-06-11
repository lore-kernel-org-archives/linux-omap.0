From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch 3/3] sti: netlink: convert to register to new bus
Date: Thu, 11 Jun 2009 11:46:59 +0300
Message-ID: <1244710019-14564-4-git-send-email-felipe.balbi@nokia.com>
References: <1244710019-14564-1-git-send-email-felipe.balbi@nokia.com>
 <1244710019-14564-2-git-send-email-felipe.balbi@nokia.com>
 <1244710019-14564-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27950 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309AbZFKIuR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 04:50:17 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n5B8ndcG023739
	for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 03:50:21 -0500
In-Reply-To: <1244710019-14564-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

make sti-netlink register to sti bus.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/misc/sti/sti-netlink.c |   70 +++++++++++++++++++++++++++++++++------
 1 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/sti/sti-netlink.c b/drivers/misc/sti/sti-netlink.c
index dbd6a03..0a41e7d 100644
--- a/drivers/misc/sti/sti-netlink.c
+++ b/drivers/misc/sti/sti-netlink.c
@@ -17,8 +17,12 @@
 #include <net/sock.h>
 #include <mach/sti.h>
 
-static struct sock *sti_sock;
-static DEFINE_MUTEX(sti_netlink_mutex);
+struct sti_netlink {
+	struct sock *sock;
+	struct mutex mutex;
+};
+
+static struct sti_netlink *the_link;
 
 enum {
 	STI_READ,
@@ -44,7 +48,7 @@ static int sti_netlink_read(int pid, int seq, void *payload, int size)
 	memcpy(NLMSG_DATA(nlh), payload, size);
 	nlh->nlmsg_len = skb->tail - tail;
 
-	ret = netlink_unicast(sti_sock, skb, pid, MSG_DONTWAIT);
+	ret = netlink_unicast(the_link->sock, skb, pid, MSG_DONTWAIT);
 	if (ret > 0)
 		ret = 0;
 
@@ -69,7 +73,7 @@ static int sti_netlink_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	void *data;
 	u8 chan, id;
 	int size;
-	int ret = 0, len = 0;
+	int ret = 0;
 
 	data	= NLMSG_DATA(nlh);
 	chan	= (nlh->nlmsg_flags >> 8) & 0xff;
@@ -130,28 +134,72 @@ static int sti_netlink_receive_skb(struct sk_buff *skb)
 
 static void sti_netlink_receive(struct sk_buff *skb)
 {
-	if (!mutex_trylock(&sti_netlink_mutex))
+	if (!mutex_trylock(&the_link->mutex))
 		return;
 
 	sti_netlink_receive_skb(skb);
-	mutex_unlock(&sti_netlink_mutex);
+	mutex_unlock(&the_link->mutex);
 }
 
-static int __init sti_netlink_init(void)
+static int __init sti_netlink_probe(struct sti_client *client)
 {
-	sti_sock = netlink_kernel_create(&init_net, NETLINK_USERSOCK, 0,
+	struct sti_netlink	*link;
+	int			status;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link) {
+		status = -ENOMEM;
+		goto fail1;
+	}
+
+	link->sock = netlink_kernel_create(&init_net, NETLINK_USERSOCK, 0,
 					 sti_netlink_receive, NULL,
 					 THIS_MODULE);
-	if (!sti_sock) {
-		printk(KERN_ERR "STI: Failed to create netlink socket\n");
-		return -ENODEV;
+	if (!link->sock) {
+		dev_dbg(&client->dev, "STI: Failed to create netlink socket\n");
+		status = -ENOMEM;
+		goto fail2;
 	}
 
+	sti_set_clientdata(client, link);
+
+	the_link = link;
+
+	return 0;
+
+fail2:
+	kfree(link);
+
+fail1:
+	return status;
+}
+
+static int __exit sti_netlink_remove(struct sti_client *client)
+{
+	struct sti_netlink	*link = sti_get_clientdata(client);
+
+	kfree(link);
+	the_link = NULL;
+
 	return 0;
 }
 
+static struct sti_driver sti_netlink_driver = {
+	.probe		= sti_netlink_probe,
+	.remove		= __exit_p(sti_netlink_remove),
+	.driver		= {
+		.name	= "sti_netlink",
+	},
+};
+
+static int __init sti_netlink_init(void)
+{
+	return sti_add_driver(&sti_netlink_driver);
+}
+
 module_init(sti_netlink_init);
 
 MODULE_AUTHOR("Paul Mundt");
+MODULE_AUTHOR("Felipe Balbi");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("STI netlink-driven communications interface");
-- 
1.6.3.1.244.gf9275

