From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH] Fix omap 1-wire driver compilation
Date: Mon, 22 Mar 2010 14:40:11 +0200
Message-ID: <20100322124011.GD8553@matterhorn.verdurent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:53752 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab0CVMkR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 08:40:17 -0400
Received: by fxm23 with SMTP id 23so654299fxm.21
        for <linux-omap@vger.kernel.org>; Mon, 22 Mar 2010 05:40:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: List Linux Omap <linux-omap@vger.kernel.org>

Patch from the Ubuntu omap tree[1] follows.

Regards,
Amit

[1].
http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-lucid.git;a=shortlog;h=refs/heads/ti-omap

>From 2f101ae458745c1787869cf6907d459c3bc9425e Mon Sep 17 00:00:00 2001
Message-Id: <2f101ae458745c1787869cf6907d459c3bc9425e.1269261108.git.amit.kucheria@verdurent.com>
From: Amit Kucheria <amit.kucheria@canonical.com>
Date: Wed, 10 Mar 2010 14:10:54 +0200
Subject: [PATCH] UBUNTU: [Upstream] Fix omap 1-wire driver compilation

This fixes the following error message:

drivers/w1/masters/omap_hdq.c: In function 'hdq_wait_for_flag':
drivers/w1/masters/omap_hdq.c:137: error: implicit declaration of function
'schedule_timeout_uninterruptible'
drivers/w1/masters/omap_hdq.c: In function 'hdq_write_byte':
drivers/w1/masters/omap_hdq.c:177: error: 'TASK_UNINTERRUPTIBLE' undeclared
(first use in this function)
drivers/w1/masters/omap_hdq.c:177: error: (Each undeclared identifier is
reported only once
drivers/w1/masters/omap_hdq.c:177: error: for each function it appears in.)
drivers/w1/masters/omap_hdq.c:177: error: implicit declaration of function
'schedule_timeout'
drivers/w1/masters/omap_hdq.c: In function 'hdq_isr':
drivers/w1/masters/omap_hdq.c:221: error: 'TASK_NORMAL' undeclared (first use
in this function)
drivers/w1/masters/omap_hdq.c: In function 'omap_hdq_break':
drivers/w1/masters/omap_hdq.c:316: error: 'TASK_UNINTERRUPTIBLE' undeclared
(first use in this function)

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 drivers/w1/masters/omap_hdq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 0d92969..2c2bd35 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/sched.h>
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
-- 
1.6.3.3

-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
