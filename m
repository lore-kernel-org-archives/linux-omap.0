From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 2/5] RT: wrap BUILD_CHECK_IRQ_FLAGS
Date: Tue, 20 May 2008 15:45:46 -0700
Message-ID: <1211323550-5318-2-git-send-email-khilman@mvista.com>
References: <1211323550-5318-1-git-send-email-khilman@mvista.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:36945 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762362AbYETW4z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2008 18:56:55 -0400
In-Reply-To: <1211323550-5318-1-git-send-email-khilman@mvista.com>
In-Reply-To: <483353F0.6090902@mvista.com>
References: <483353F0.6090902@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>

The macros used by BUILD_CHECK_IRQ_FLAGS() are defined in kernel.h,
but this file is sometimes included before kernel.h (or even by
kernel.h)

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 include/linux/irqflags.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 6ada2b9..e3bf9d0 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -11,11 +11,15 @@
 #ifndef _LINUX_TRACE_IRQFLAGS_H
 #define _LINUX_TRACE_IRQFLAGS_H
 
+#if defined(BUILD_CHECK_IRQ_FLAGS) && defined(typecheck)
 #define BUILD_CHECK_IRQ_FLAGS(flags)					\
 	do {								\
 		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
 		typecheck(unsigned long, flags);			\
 	} while (0)
+#else
+#define BUILD_CHECK_IRQ_FLAGS(flags)
+#endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_softirqs_on(unsigned long ip);
-- 
1.5.4.1.166.g6706d

