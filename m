From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 08/17] OMAP2/3: GPTIMER: Clear pending interrupts when entering suspend
Date: Fri, 16 Oct 2009 13:49:01 +0300
Message-ID: <1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32271 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756905AbZJPLEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:25 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2f4c011809
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:56 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2fa2022261
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:51 +0300
In-Reply-To: <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

OMAP GP timers keep running for a few cycles after they are stopped,
which can cause the timer to expire and generate an interrupt. The pending
interrupt will prevent OMAP from entering suspend, thus we ack it manually.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/timer-gp.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 9c056ff..c9d47bb 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -92,9 +92,21 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_ONESHOT:
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
 	case CLOCK_EVT_MODE_RESUME:
 		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		/*
+		 * Wait for min period x 2 to make sure that timer is
+		 * stopped
+		 */
+		udelay(evt->min_delta_ns / 500);
+		/*
+		 * Clear possibly pending interrupt, this will occasionally
+		 * generate spurious timer IRQs during suspend but this
+		 * is okay, as another option is not to enter suspend at all
+		 */
+		omap_dm_timer_write_status(gptimer, OMAP_TIMER_INT_OVERFLOW);
+		break;
 	}
 }
 
-- 
1.5.4.3

