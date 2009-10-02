From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/2] omap iovmm: fix incorrect spelling
Date: Fri,  2 Oct 2009 10:47:37 +0300
Message-ID: <1254469657-15086-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1254469657-15086-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32777 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554AbZJBHro (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 03:47:44 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n927lbU8001749
	for <linux-omap@vger.kernel.org>; Fri, 2 Oct 2009 10:47:46 +0300
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n927lbfj032500
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 2 Oct 2009 10:47:38 +0300
In-Reply-To: <1254469657-15086-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index d40f7c8..b1278ea 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -47,7 +47,7 @@
  *	'va':	mpu virtual address
  *
  *	'c':	contiguous memory area
- *	'd':	dicontiguous memory area
+ *	'd':	discontiguous memory area
  *	'a':	anonymous memory allocation
  *	'()':	optional feature
  *
@@ -397,7 +397,7 @@ static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
 {
 	/*
 	 * Actually this is not necessary at all, just exists for
-	 * consistency of the code readibility.
+	 * consistency of the code readability.
 	 */
 	BUG_ON(!sgt);
 }
@@ -431,7 +431,7 @@ static inline void sgtable_drain_kmalloc(struct sg_table *sgt)
 {
 	/*
 	 * Actually this is not necessary at all, just exists for
-	 * consistency of the code readibility
+	 * consistency of the code readability
 	 */
 	BUG_ON(!sgt);
 }
-- 
1.6.0.4

