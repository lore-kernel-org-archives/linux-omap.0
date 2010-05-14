From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/17] omap: mailbox: reorganize headers
Date: Fri, 14 May 2010 18:01:47 +0300
Message-ID: <1273849310-32169-15-git-send-email-felipe.contreras@gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33360 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915Ab0ENPCb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:02:31 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so902601ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 08:02:30 -0700 (PDT)
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c             |    3 ---
 arch/arm/mach-omap2/mailbox.c             |    1 -
 arch/arm/plat-omap/include/plat/mailbox.h |    3 ++-
 arch/arm/plat-omap/mailbox.c              |    5 ++---
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index f29ba8e..f6376b9 100644
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
index a54898a..c1a732e 100644
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
index b68fdc3..cbde52a 100644
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
index 6b2f3b3..c7d28fa 100644
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

