From: Ari Kauppi <kauppi@papupata.org>
Subject: [PATCH v2 3/3] ARM: oprofile: Always allow backtraces
Date: Thu, 20 Jan 2011 20:57:20 +0200
Message-ID: <1295549840-17809-4-git-send-email-kauppi@papupata.org>
References: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:37976 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab1ATS6z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 13:58:55 -0500
In-Reply-To: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robert Richter <robert.richter@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Matt Fleming <matt@console-pimps.org>, Ari Kauppi <kauppi@papupata.org>

Always allow backtrace when using oprofile on ARM, even if a PMU
isn't present. Implemented by removing code and using stubs
provided by <linux/oprofile.h>.

Restores functionality originally introduced in commit
1b7b56982fdcd9d85effd76f3928cf5d6eb26155 ("oprofile: Always allow
backtraces on ARM") by Richard Purdie.

Signed-off-by: Ari Kauppi <kauppi@papupata.org>
---
 arch/arm/oprofile/common.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 8aa9744..2b66391 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -10,8 +10,6 @@
  */
 
 #include <linux/cpumask.h>
-#include <linux/err.h>
-#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/oprofile.h>
@@ -46,6 +44,7 @@ char *op_name_from_perf_id(void)
 		return NULL;
 	}
 }
+#endif
 
 static int report_trace(struct stackframe *frame, void *d)
 {
@@ -111,6 +110,7 @@ static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
 
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
+	/* provide backtrace support also in timer mode: */
 	ops->backtrace		= arm_backtrace;
 
 	return oprofile_perf_init(ops);
@@ -120,11 +120,3 @@ void __exit oprofile_arch_exit(void)
 {
 	oprofile_perf_exit();
 }
-#else
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	pr_info("oprofile: hardware counters not available\n");
-	return -ENODEV;
-}
-void __exit oprofile_arch_exit(void) {}
-#endif /* CONFIG_HW_PERF_EVENTS */
-- 
1.7.4.rc2.3.g60a2e

