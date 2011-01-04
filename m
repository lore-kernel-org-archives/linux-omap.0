From: jean.pihet@newoldbits.com
Subject: [PATCH 1/3] perf: add calls to suspend trace point
Date: Tue,  4 Jan 2011 11:17:41 +0100
Message-ID: <1294136263-24020-2-git-send-email-j-pihet@ti.com>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294136263-24020-1-git-send-email-j-pihet@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@elte.hu, linux-kernel@vger.kernel.org, trenn@suse.de
Cc: linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Uses the machine_suspend trace point, called from the
generic kernel suspend_enter function.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
CC: Thomas Renninger <trenn@suse.de>
---
 kernel/power/suspend.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index ecf7705..0650596 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <trace/events/power.h>
 
 #include "power.h"
 
@@ -164,7 +165,9 @@ static int suspend_enter(suspend_state_t state)
 	error = sysdev_suspend(PMSG_SUSPEND);
 	if (!error) {
 		if (!suspend_test(TEST_CORE) && pm_check_wakeup_events()) {
+			trace_machine_suspend(state);
 			error = suspend_ops->enter(state);
+			trace_machine_suspend(PWR_EVENT_EXIT);
 			events_check_enabled = false;
 		}
 		sysdev_resume();
-- 
1.7.2.3
