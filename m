From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] Drivers: w1: omap_hdq: Fix missing include sched.h
Date: Mon, 19 Apr 2010 16:10:36 +0000
Message-ID: <1271693436-14950-1-git-send-email-weber@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org, johnpol@2ka.mipt.ru
List-Id: linux-omap@vger.kernel.org

In commit f6a570333e554b48ad589e7137c77c57809eee81 #include <sched.h> was
removed from module.h and not added in omap_hdq.c .

The definition for TASK_UNINTERRUPTIBLE and
schedule_timeout_uninterruptible are missing.
This patch fixes the missing definition.

Signed-off-by: Thomas Weber <weber@corscience.de>
---

 drivers/w1/masters/omap_hdq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index ef36fca..3a7e9ff 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/sched.h>
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
-- 
1.6.4.4
