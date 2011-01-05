From: jean.pihet@newoldbits.com
Subject: [PATCH 1/2] perf: add calls to suspend trace point
Date: Wed,  5 Jan 2011 19:49:01 +0100
Message-ID: <1294253342-29056-2-git-send-email-j-pihet@ti.com>
References: <1294253342-29056-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294253342-29056-1-git-send-email-j-pihet@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@elte.hu, trenn@suse.de, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Uses the machine_suspend trace point, called from the
generic kernel suspend_devices_and_enter function.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
CC: Thomas Renninger <trenn@suse.de>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/suspend.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index ecf7705..031d5e3 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <trace/events/power.h>
 
 #include "power.h"
 
@@ -201,6 +202,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 	if (!suspend_ops)
 		return -ENOSYS;
 
+	trace_machine_suspend(state);
 	if (suspend_ops->begin) {
 		error = suspend_ops->begin(state);
 		if (error)
@@ -229,6 +231,7 @@ int suspend_devices_and_enter(suspend_state_t state)
  Close:
 	if (suspend_ops->end)
 		suspend_ops->end();
+	trace_machine_suspend(PWR_EVENT_EXIT);
 	return error;
 
  Recover_platform:
-- 
1.7.2.3
