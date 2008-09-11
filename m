From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 06/10] lowmem: update memory management functions for the new kernel
Date: Thu, 11 Sep 2008 19:20:38 +0300
Message-ID: <1221150042-10873-7-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-4-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-5-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-6-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49364 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbYIKQLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:44 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGBajE015404
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:42 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOp012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:27 +0300
In-Reply-To: <1221150042-10873-6-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

These functions now require an additional argument, so let's add it.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index a5b6088..939901c 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -152,7 +152,7 @@ static void high_watermark_state(int new_state)
 	}
 }
 
-static int low_vm_enough_memory(long pages)
+static int low_vm_enough_memory(struct mm_struct *mm, long pages)
 {
 	unsigned long free, allowed;
 	int cap_sys_admin = 0, notify;
@@ -166,7 +166,7 @@ static int low_vm_enough_memory(long pages)
 	/* We activate ourselves only after both parameters have been
 	 * configured. */
 	if (deny_pages == 0 || notify_low_pages == 0 || notify_high_pages == 0)
-		return  __vm_enough_memory(pages, cap_sys_admin);
+		return  __vm_enough_memory(mm, pages, cap_sys_admin);
 
 	vm_acct_memory(pages);
 
-- 
1.5.6.3

