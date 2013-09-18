From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH] ARM: DRA7: realtime_counter: Add ratio registers for 20MHZ sys-clk frequency
Date: Wed, 18 Sep 2013 16:50:11 +0530
Message-ID: <1379503211-26229-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43825 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab3IRLU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Sep 2013 07:20:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: r.sricharan@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com, tony@atomide.com

The real time counter also called master counter, is a free-running
counter. It produces the count used by the CPU local timer peripherals
in the MPU cluster. The timer counts at a rate of 6.144 MHz.

The ratio registers are missing for a sys-clk of 20MHZ which is used
by DRA7 socs. So because of this, the counter was getting wrongly
programmed for a sys-clk of 38.4Mhz(default). So adding the ratio
registers for 20MHZ sys-clk.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/timer.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e1528a0..fd9238d 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -515,6 +515,10 @@ static void __init realtime_counter_init(void)
 		num = 8;
 		den = 25;
 		break;
+	case 20000000:
+		num = 192;
+		den = 625;
+		break;
 	case 2600000:
 		num = 384;
 		den = 1625;
-- 
1.7.9.5

