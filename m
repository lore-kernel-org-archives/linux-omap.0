From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 07/10] lowmem: Security modules can no longer be removed.
Date: Thu, 11 Sep 2008 19:20:39 +0300
Message-ID: <1221150042-10873-8-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-4-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-5-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-6-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-7-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17870 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbYIKQLd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:33 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGBET2012096
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:30 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOq012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:28 +0300
In-Reply-To: <1221150042-10873-7-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The unregister_security() and mod_unreg_security() functions were removed
because the upstream developers believe that it should not be possible to remove
security modules, "It is used only by out-of-tree modules, which are often
binary-only, illegal, abusive of the API and dangerous, e.g.  silently
re-vectoring SELinux."

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index 939901c..87f6cec 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -291,29 +291,7 @@ static int __init lowmem_init(void)
 	return 0;
 }
 
-static void __exit lowmem_exit(void)
-{
-	/* remove ourselves from the security framework */
-	if (secondary) {
-		if (mod_unreg_security(MY_NAME, &lowmem_security_ops))
-			printk(KERN_ERR MY_NAME ": Failure unregistering "
-			       "with the primary security module.\n");
-	} else {
-		if (unregister_security(&lowmem_security_ops)) {
-			printk(KERN_ERR MY_NAME ": Failure unregistering "
-			       "with the kernel.\n");
-		}
-	}
-
-	unregister_sysctl_table(lowmem_table_header);
-
-	sysfs_remove_group(kernel_kobj, &lowmem_attr_group);
-
-	printk(KERN_INFO MY_NAME ": Module removed.\n");
-}
-
 module_init(lowmem_init);
-module_exit(lowmem_exit);
 
 MODULE_DESCRIPTION("Low watermark LSM module");
 MODULE_LICENSE("GPL");
-- 
1.5.6.3

