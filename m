From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 09/10] lowmem: Fix split of ptrace
Date: Thu, 11 Sep 2008 19:20:41 +0300
Message-ID: <1221150042-10873-10-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-4-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-5-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-6-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-7-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-8-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-9-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49363 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbYIKQLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:43 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGBajC015404
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:41 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOs012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:31 +0300
In-Reply-To: <1221150042-10873-9-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

A previous commit split the ptrace member into two. Thus we need to update the
lowmem module accordingly.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index 56f1f6e..b986070 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -324,7 +324,8 @@ enough_memory:
 
 static struct security_operations lowmem_security_ops = {
 	/* Use the capability functions for some of the hooks */
-	.ptrace = cap_ptrace,
+	.ptrace_may_access = cap_ptrace_may_access,
+	.ptrace_traceme = cap_ptrace_traceme,
 	.capget = cap_capget,
 	.capset_check = cap_capset_check,
 	.capset_set = cap_capset_set,
-- 
1.5.6.3

