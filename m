From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 04/10] lowmem: remove an unecessary local variable
Date: Thu, 11 Sep 2008 19:20:36 +0300
Message-ID: <1221150042-10873-5-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-4-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17867 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbYIKQLa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:30 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGAxpg012024
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:27 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOn012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:24 +0300
In-Reply-To: <1221150042-10873-4-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This "changed" variable is kind of deprecated. We used to have a spinlock
[which was later deemed unecessary] around the first if clause in the
*_watermark_state() functions; the variable was needed in order to move the
operation in the second if clause out of the lock section.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index 2dc0c4a..183c57f 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -136,28 +136,18 @@ KERNEL_ATTR_RO(high_watermark);
 
 static void low_watermark_state(int new_state)
 {
-	int changed = 0;
-
 	if (low_watermark_reached != new_state) {
 		low_watermark_reached = new_state;
-		changed = 1;
-	}
-
-	if (changed)
 		sysfs_notify(&kernel_subsys.kset.kobj, NULL, "low_watermark");
+	}
 }
 
 static void high_watermark_state(int new_state)
 {
-	int changed = 0;
-
 	if (high_watermark_reached != new_state) {
 		high_watermark_reached = new_state;
-		changed = 1;
-	}
-
-	if (changed)
 		sysfs_notify(&kernel_subsys.kset.kobj, NULL, "high_watermark");
+	}
 }
 
 static int low_vm_enough_memory(long pages)
-- 
1.5.6.3

