From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP3: PM: fix UART handling when using no_console_suspend
Date: Fri, 16 Sep 2011 09:47:23 -0700
Message-ID: <1316191643-5692-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:57062 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752964Ab1IPQqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 12:46:32 -0400
Received: by ywf9 with SMTP id 9so4293663ywf.22
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 09:46:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhilash Koyamangalath <abhilash.kv@ti.com>

During the idle/suspend path, we expect the console lock to be held so
that no console output is done during/after the UARTs are idled.

However, when using the no_console_suspend argument on the
command-line, the console driver does not take the console lock.  This
allows the possibility of console activity after UARTs have been
disabled.

To fix, update the current is_suspending() to also check the
console_suspend_enabled flag.

Reported-by: Abhilash Koyamangalath <abhilash.kv@ti.com>
Tested-by: Abhilash Koyamangalath <abhilash.kv@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
This patch will be included in my PM cleanup series for v3.2
(branch: for_3.2/pm-cleanup)

 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..c8cbd00 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -55,7 +55,7 @@
 static suspend_state_t suspend_state = PM_SUSPEND_ON;
 static inline bool is_suspending(void)
 {
-	return (suspend_state != PM_SUSPEND_ON);
+	return (suspend_state != PM_SUSPEND_ON) && console_suspend_enabled;
 }
 #else
 static inline bool is_suspending(void)
-- 
1.7.6

