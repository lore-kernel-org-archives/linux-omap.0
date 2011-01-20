From: Ari Kauppi <kauppi@papupata.org>
Subject: [PATCH v2 1/3] oprofile: Use CONFIG_HW_PERF_EVENTS for oprofile_perf_init and friends
Date: Thu, 20 Jan 2011 20:57:18 +0200
Message-ID: <1295549840-17809-2-git-send-email-kauppi@papupata.org>
References: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:49217 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296Ab1ATS6r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 13:58:47 -0500
In-Reply-To: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robert Richter <robert.richter@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Matt Fleming <matt@console-pimps.org>, Ari Kauppi <kauppi@papupata.org>

The implementations are flagged in Makefile with CONFIG_HW_PERF_EVENTS
instead of CONFIG_PERF_EVENTS.

Signed-off-by: Ari Kauppi <kauppi@papupata.org>
---
 include/linux/oprofile.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/oprofile.h b/include/linux/oprofile.h
index 32fb812..54c8382 100644
--- a/include/linux/oprofile.h
+++ b/include/linux/oprofile.h
@@ -186,10 +186,10 @@ int oprofile_add_data(struct op_entry *entry, unsigned long val);
 int oprofile_add_data64(struct op_entry *entry, u64 val);
 int oprofile_write_commit(struct op_entry *entry);
 
-#ifdef CONFIG_PERF_EVENTS
+#ifdef CONFIG_HW_PERF_EVENTS
 int __init oprofile_perf_init(struct oprofile_operations *ops);
 void oprofile_perf_exit(void);
 char *op_name_from_perf_id(void);
-#endif /* CONFIG_PERF_EVENTS */
+#endif /* CONFIG_HW_PERF_EVENTS */
 
 #endif /* OPROFILE_H */
-- 
1.7.4.rc2.3.g60a2e

