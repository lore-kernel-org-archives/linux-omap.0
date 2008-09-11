From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 10/10] lowmem: Remove the possibility to stack the module
Date: Thu, 11 Sep 2008 19:20:42 +0300
Message-ID: <1221150042-10873-11-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-4-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-5-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-6-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-7-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-8-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-9-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-10-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63337 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbYIKQLw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:52 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGBT2b025845
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 11:11:50 -0500
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOt012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:32 +0300
In-Reply-To: <1221150042-10873-10-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The mod_reg_security() function that is used to stack modules has been removed:
"LSMs wishing to stack capability as a secondary module should do so
explicitly". Thus, let's remove the possibility to stack in the init function.
The functionality could probably be reintroduced later if somebody has time to
implement it.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index b986070..ae78a53 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -340,8 +340,6 @@ static struct security_operations lowmem_security_ops = {
 };
 
 static struct ctl_table_header *lowmem_table_header;
-/* flag to keep track of how we were registered */
-static int secondary;
 
 static struct attribute *lowmem_attrs[] = {
 	&low_watermark_attr.attr,
@@ -360,13 +358,7 @@ static int __init lowmem_init(void)
 	/* register ourselves with the security framework */
 	if (register_security(&lowmem_security_ops)) {
 		printk(KERN_ERR MY_NAME ": Failure registering with the kernel\n");
-		/* try registering with primary module */
-		if (mod_reg_security(MY_NAME, &lowmem_security_ops)) {
-			printk(KERN_ERR ": Failure registering with the primary"
-			       "security module.\n");
-			return -EINVAL;
-		}
-		secondary = 1;
+		return -EINVAL;
 	}
 
 	/* initialize the uids vector */
-- 
1.5.6.3

