From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v6 10/16] OMAP2+: UART: Modify omap_uart_can_sleep function
Date: Fri, 30 Sep 2011 16:32:35 +0530
Message-ID: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46253 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518Ab1I3LCx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 07:02:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Modify the omap_uart_can_sleep function to check uart is active
or not to be used by pm code to enter low power states.

Removing this check can cause console response little sluggish.
However no characters will be lost until uart clocks are gated
and woken up using rx-pad. UART interface clocks can be auto gated
this can make response on uart slower. This behaviour was observed
only on some of OMAP3 boards(beagleboard xm rev c).

Reported-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 6725caf..ccf3550 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -156,23 +156,20 @@ static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
 
 int omap_uart_can_sleep(void)
 {
-	struct omap_uart_state *uart;
-	int can_sleep = 1;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (!uart->clocked)
-			continue;
+	struct omap_hwmod *oh;
+	u8 i, ret = true;
 
-		if (!uart->can_sleep) {
-			can_sleep = 0;
+	for (i = 0; i < num_uarts; i++) {
+		oh = omap_uart_hwmod_lookup(i);
+		if (!oh)
 			continue;
-		}
 
-		/* This UART can now safely sleep. */
-		omap_uart_allow_sleep(uart);
+		if (oh->od && oh->od->pdev &&
+				!pm_runtime_suspended(&oh->od->pdev->dev))
+			return false;
 	}
 
-	return can_sleep;
+	return ret;
 }
 
 #ifdef CONFIG_OMAP_MUX
-- 
1.7.4.1

