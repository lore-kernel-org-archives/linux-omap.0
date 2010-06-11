From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 14/14] omap: mailbox: reorganize headers
Date: Fri, 11 Jun 2010 18:51:49 +0300
Message-ID: <1276271509-11983-15-git-send-email-felipe.contreras@gmail.com>
References: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49298 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758184Ab0FKPw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:52:56 -0400
Received: by fxm8 with SMTP id 8so794379fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 08:52:55 -0700 (PDT)
In-Reply-To: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Remove kernel.h and module.h since they are not used correctly anyway.

Also, remove device.h since it comes along with platform_device.h
(always will I guess).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c             |    3 ---
 arch/arm/mach-omap2/mailbox.c             |    1 -
 arch/arm/plat-omap/include/plat/mailbox.h |    3 ++-
 arch/arm/plat-omap/mailbox.c              |    5 ++---
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index afc3963..1a85a42 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -9,13 +9,10 @@
  * for more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/resource.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <plat/mailbox.h>
-#include <mach/irqs.h>
 
 #define MAILBOX_ARM2DSP1		0x00
 #define MAILBOX_ARM2DSP1b		0x04
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 62d5ffe..42dbfa4 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -10,7 +10,6 @@
  * for more details.
  */
 
-#include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index c44fde3..9976565 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -3,9 +3,10 @@
 #ifndef MAILBOX_H
 #define MAILBOX_H
 
-#include <linux/wait.h>
+#include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include <linux/kfifo.h>
 
 typedef u32 mbox_msg_t;
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index a8e22e1..8d4c7be 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -21,10 +21,9 @@
  *
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/kfifo.h>
-- 
1.7.1

