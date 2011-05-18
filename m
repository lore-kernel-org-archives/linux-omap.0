From: jean.pihet@newoldbits.com
Subject: [PATCH 01/13] perf: export power_start and power_end tracepoints
Date: Wed, 18 May 2011 19:32:18 +0200
Message-ID: <1305739950-11695-2-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62820 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab1ERRco (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:44 -0400
Received: by yxs7 with SMTP id 7so624062yxs.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:43 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

If used in a module both tracepoints need to be exported by the
kernel.
Fixed a typo in CONFIG_EVENT_POWER_TRACING_DEPRECATED to really
export the tracepoints.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Renninger <trenn@suse.de>
---
 kernel/trace/power-traces.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index f55fcf6..29b60f2 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -13,8 +13,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/power.h>
 
-#ifdef EVENT_POWER_TRACING_DEPRECATED
+#ifdef CONFIG_EVENT_POWER_TRACING_DEPRECATED
 EXPORT_TRACEPOINT_SYMBOL_GPL(power_start);
+EXPORT_TRACEPOINT_SYMBOL_GPL(power_end);
 #endif
 EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
 
-- 
1.7.4.1

