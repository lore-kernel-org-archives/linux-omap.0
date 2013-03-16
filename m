From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 5/8] memory: emif: use restart if power_off not present when out of spec
Date: Sat, 16 Mar 2013 11:46:45 +0530
Message-ID: <1363414608-7448-6-git-send-email-lokeshvutla@ti.com>
References: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lokeshvutla@ti.com, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

Some machine or kernel variants might have missed implementation
of power off handlers. We DONOT want to let the system be in
"out of spec" state in this condition. So, WARN and attempt
a machine restart in the hopes of clearing the out-of-spec
temperature condition.

NOTE: This is not the safest option, but safer than leaving the
system in unstable conditions.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Changes since V1:
	Added a new extra line before if condition.

 drivers/memory/emif.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 827eb3b..8db74e4 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/pm.h>
 #include <memory/jedec_ddr.h>
 #include "emif.h"
 #include "of_memory.h"
@@ -1015,7 +1016,14 @@ static irqreturn_t emif_threaded_isr(int irq, void *dev_id)
 
 	if (emif->temperature_level == SDRAM_TEMP_VERY_HIGH_SHUTDOWN) {
 		dev_emerg(emif->dev, "SDRAM temperature exceeds operating limit.. Needs shut down!!!\n");
-		kernel_power_off();
+
+		/* If we have Power OFF ability, use it, else try restarting */
+		if (pm_power_off) {
+			kernel_power_off();
+		} else {
+			WARN(1, "FIXME: NO pm_power_off!!! trying restart\n");
+			kernel_restart("SDRAM Over-temp Emergency restart");
+		}
 		return IRQ_HANDLED;
 	}
 
-- 
1.7.9.5
