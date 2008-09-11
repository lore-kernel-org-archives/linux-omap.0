From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 02/10] lowmem: remove unecessary usage of proc_dointvec_minmax()
Date: Thu, 11 Sep 2008 19:20:34 +0300
Message-ID: <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17861 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYIKQL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:27 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGBESs012096
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:24 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOl012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:22 +0300
In-Reply-To: <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

As far as I can understand, using proc_dointvec_minmax() instead of
proc_dointvec only makes sense if you supply the min and/or max values in the
extra1 and extra2 fields of the struct.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index 113be75..a965676 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -69,7 +69,7 @@ static ctl_table lowmem_table[] = {
 		.maxlen = sizeof(unsigned int),
 		.mode = 0644,
 		.child = NULL,
-		.proc_handler = &proc_dointvec_minmax,
+		.proc_handler = &proc_dointvec,
 		.strategy = &sysctl_intvec,
 	}, {
 		.ctl_name = VM_LOWMEM_ALLOWED_UIDS,
@@ -89,7 +89,7 @@ static ctl_table lowmem_table[] = {
 		.maxlen = sizeof(unsigned long),
 		.mode = 0444,
 		.child = NULL,
-		.proc_handler = &proc_dointvec_minmax,
+		.proc_handler = &proc_dointvec,
 		.strategy = &sysctl_intvec,
 	}, {
 		.ctl_name = VM_LOWMEM_USED_PAGES,
@@ -98,7 +98,7 @@ static ctl_table lowmem_table[] = {
 		.maxlen = sizeof(long),
 		.mode = 0444,
 		.child = NULL,
-		.proc_handler = &proc_dointvec_minmax,
+		.proc_handler = &proc_dointvec,
 		.strategy = &sysctl_intvec,
 	}, {
 		.ctl_name = 0
-- 
1.5.6.3

