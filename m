From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Sat, 18 Sep 2010 00:10:16 +0200
Message-ID: <201009180010.17380.trenn@suse.de>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com> <201009171508.46471.trenn@suse.de> <AANLkTi=W_Lo2m=hkA2F48oUziqGzt4Tr8y6KhfgqRnbz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=W_Lo2m=hkA2F48oUziqGzt4Tr8y6KhfgqRnbz@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

power-trace: Add x86 ACPI S- (machine sleep) state events.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/sleep.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6.35-master/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.35-master.orig/drivers/acpi/sleep.c
+++ linux-2.6.35-master/drivers/acpi/sleep.c
@@ -17,6 +17,8 @@
 #include <linux/suspend.h>
 #include <linux/reboot.h>
 
+#include <trace/events/power.h>
+
 #include <asm/io.h>
 
 #include <acpi/acpi_bus.h>
@@ -249,14 +251,19 @@ static int acpi_suspend_enter(suspend_st
 	unsigned long flags = 0;
 	u32 acpi_state = acpi_target_sleep_state;
 
+	trace_power_switch_state(POWER_SSTATE, acpi_state, 0);
+
 	ACPI_FLUSH_CPU_CACHE();
 
 	/* Do arch specific saving of state. */
 	if (acpi_state == ACPI_STATE_S3) {
 		int error = acpi_save_state_mem();
 
-		if (error)
+		if (error) {
+			trace_power_switch_state(POWER_SSTATE,
+						 ACPI_STATE_S0, 0);
 			return error;
+		}
 	}
 
 	local_irq_save(flags);
@@ -309,6 +316,8 @@ static int acpi_suspend_enter(suspend_st
 
 	suspend_nvs_restore();
 
+	trace_power_switch_state(POWER_SSTATE, ACPI_STATE_S0, 0);
+
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
