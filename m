From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 14/14] omap: mailbox: reorganize headers
Date: Sat, 22 May 2010 20:14:25 +0300
Message-ID: <1274548465-20208-15-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55289 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab0EVRPE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:15:04 -0400
Received: by mail-bw0-f46.google.com with SMTP id 7so383709bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:15:02 -0700 (PDT)
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c             |    3 ---
 arch/arm/mach-omap2/mailbox.c             |    1 -
 arch/arm/plat-omap/include/plat/mailbox.h |    3 ++-
 arch/arm/plat-omap/mailbox.c              |    5 ++---
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index e50b3c2..fdd6cc9 100644
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
index 66d366d..d46e439 100644
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

