From: "Dasgupta, Romit" <romit@ti.com>
Subject: [PATCH 1/1] PM: Thaws refrigerated and to be exited kernel threads
Date: Fri, 6 Nov 2009 15:06:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE31F934@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756431AbZKFJga@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, "pavel@ucw.cz" <pavel@ucw.cz>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Kicks out a frozen thread from the refrigerator when an active thread has
invoked kthread_stop on the frozen thread.

Signed-off-by: Romit Dasgupta <romit@ti.com>
---

diff --git a/kernel/freezer.c b/kernel/freezer.c
index bd1d42b..c28dbe8 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
+#include <linux/kthread.h>
 
 /*
  * freezing is complete, mark current process as frozen
@@ -49,7 +50,7 @@ void refrigerator(void)
 
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!frozen(current))
+		if (!frozen(current) || (!current->mm && kthread_should_stop()))
 			break;
 		schedule();
 	}
