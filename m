From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 01/10] Security: Kernel OOM-killer and allocation denial use different rules
Date: Thu, 11 Sep 2008 19:20:33 +0300
Message-ID: <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49361 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbYIKQLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:42 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGBajA015404
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:39 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOk012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:20 +0300
In-Reply-To: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Henrik Saari <henrik.saari@nokia.com>

Security: Kernel OOM-killer and allocation denial use different rules

Original patch created by Leonid Moiseichuk <leonid.moiseichuk@nokia.com>

Fixes the issue with the oom killer and lowmem module being inconsistent;
processes that are important enough to be protected from the oom killer should
not be denied memory either.

Signed-off-by: Henrik Saari <henrik.saari@nokia.com>
Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index a627d51..113be75 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -9,6 +9,7 @@
 #include <linux/pagemap.h>
 #include <linux/hugetlb.h>
 #include <linux/sysfs.h>
+#include <linux/oom.h>
 
 #define MY_NAME "lowmem"
 
@@ -207,6 +208,10 @@ static int low_vm_enough_memory(long pages)
 		if (cap_sys_admin)
 			return 0;
 
+		/* OOM unkillable process is allowed to consume memory */
+		if (current->oomkilladj == OOM_DISABLE)
+			return 0;
+
 		/* uids from allowed_uids vector are also allowed no matter what */
 		for (i = 0; i < LOWMEM_MAX_UIDS && allowed_uids[i]; i++)
 			if (current->uid == allowed_uids[i])
-- 
1.5.6.3

