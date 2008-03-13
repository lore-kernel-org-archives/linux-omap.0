From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] ARM: OMAP: Fix clockevent support for hrtimers
Date: Thu, 13 Mar 2008 17:45:14 +0200
Message-ID: <1205423119-22292-2-git-send-email-tony@atomide.com>
References: omap-fixes-2008-03-13
 <1205423119-22292-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60452 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbYCMPpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 11:45:38 -0400
In-Reply-To: <1205423119-22292-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>, Tim Bird <tim.bird@am.sony.com>, Tony Lindgren <tony@atomide.com>

From: Kevin Hilman <khilman@mvista.com>

One-shot mode was broken in MPU-timer support for OMAP1 due to a typo.

Also, ensure timer is stopped before changing the auto-reload flag.
The TRM says changing the AR flag when timer is running is undefined.

Also set GENERIC_CLOCKEVENTS for all omaps.

Signed-off-by: Tim Bird <tim.bird@am.sony.com>
Signed-off-by: Kevin Hilman <khilman@mvista.com.
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig           |    1 +
 arch/arm/mach-omap1/time.c |   10 +++++++++-
 arch/arm/plat-omap/Kconfig |    1 -
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 955fc53..4039a13 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -469,6 +469,7 @@ config ARCH_OMAP
 	bool "TI OMAP"
 	select GENERIC_GPIO
 	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 237651e..572a2db 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -132,13 +132,20 @@ static inline void omap_mpu_timer_start(int nr, unsigned long load_val,
 	timer->cntl = timerflags;
 }
 
+static inline void omap_mpu_timer_stop(int nr)
+{
+	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+
+	timer->cntl &= ~MPU_TIMER_ST;
+}
+
 /*
  * ---------------------------------------------------------------------------
  * MPU timer 1 ... count down to zero, interrupt, reload
  * ---------------------------------------------------------------------------
  */
 static int omap_mpu_set_next_event(unsigned long cycles,
-				    struct clock_event_device *evt)
+				   struct clock_event_device *evt)
 {
 	omap_mpu_timer_start(0, cycles, 0);
 	return 0;
@@ -152,6 +159,7 @@ static void omap_mpu_set_mode(enum clock_event_mode mode,
 		omap_mpu_set_autoreset(0);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
+		omap_mpu_timer_stop(0);
 		omap_mpu_remove_autoreset(0);
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index c1f7e5a..b917206 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -11,7 +11,6 @@ choice
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
-	select GENERIC_CLOCKEVENTS
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
-- 
1.5.3.6

