From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 5/6] ARM: OMAP4: CLKDM: Update supported transition modes
Date: Wed, 9 May 2012 16:36:04 -0500
Message-ID: <1336599364-11024-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49129 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213Ab2EIVgI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 17:36:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

For OMAP3+ devices, the clock domains (CLKDMs) support one or more of the
following transition modes ...

NO_SLEEP (0x0) - A clock domain sleep transition is never initiated,
		 irrespective of the hardware conditions.
SW_SLEEP (0x1) - A software-forced sleep transition. The transition is initiated
		 when the associated hardware conditions are satisfied
SW_WKUP  (0x2) - A software-forced clock domain wake-up transition is initiated,
		 irrespective of the hardware conditions.
HW_AUTO  (0x3) - Hardware-controlled automatic sleep and wake-up transition is
		 initiated by the PRCM module when the associated hardware
		 conditions are satisfied.

For OMAP4 devices, SW_SLEEP is equivalent to HW_AUTO and NO_SLEEP is equivalent
to SW_WKUP. For OMAP4 devices, all CLKDMs support HW_AUTO and therefore we can
place the CLKDMs in the HW_AUTO state instead of the SW_SLEEP mode. Hence, we
do not need to use the SW_SLEEP mode. With regard to NO_SLEEP and SW_WKUP it is
preferred to use SW_WKUP mode if the CLKDM supports it and so use this mode
instead of NO_SLEEP where possible.

For a software perspective the above 4 modes are represented by the following
flags to indicate what modes are supported by each of the CLKDMs.

CLKDM_CAN_DISABLE_AUTO	--> NO_SLEEP
CLKDM_CAN_ENABLE_AUTO	--> HW_AUTO
CLKDM_CAN_FORCE_SLEEP	--> SW_SLEEP
CLKDM_CAN_FORCE_WAKEUP	--> SW_WKUP

By eliminating the SW_SLEEP mode the the mapping of the flags for OMAP4 devices
can becomes ...

CLKDM_CAN_DISABLE_AUTO	--> NO_SLEEP
CLKDM_CAN_ENABLE_AUTO	--> HW_AUTO
CLKDM_CAN_FORCE_SLEEP	--> HW_AUTO
CLKDM_CAN_FORCE_WAKEUP	--> SW_WKUP

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clockdomain44xx.c |    7 +++++--
 arch/arm/mach-omap2/cminst44xx.c      |   14 --------------
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index 4f04dd1..99ce556 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -70,7 +70,7 @@ static int omap4_clkdm_clear_all_wkup_sleep_deps(struct clockdomain *clkdm)
 
 static int omap4_clkdm_sleep(struct clockdomain *clkdm)
 {
-	omap4_cminst_clkdm_force_sleep(clkdm->prcm_partition,
+	omap4_cminst_clkdm_enable_hwsup(clkdm->prcm_partition,
 					clkdm->cm_inst, clkdm->clkdm_offs);
 	return 0;
 }
@@ -90,7 +90,10 @@ static void omap4_clkdm_allow_idle(struct clockdomain *clkdm)
 
 static void omap4_clkdm_deny_idle(struct clockdomain *clkdm)
 {
-	omap4_cminst_clkdm_disable_hwsup(clkdm->prcm_partition,
+	if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+		omap4_clkdm_wakeup(clkdm);
+	else
+		omap4_cminst_clkdm_disable_hwsup(clkdm->prcm_partition,
 					clkdm->cm_inst, clkdm->clkdm_offs);
 }
 
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index bd8810c..a44456c 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -227,20 +227,6 @@ void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs)
 }
 
 /**
- * omap4_cminst_clkdm_force_sleep - try to put a clockdomain into idle
- * @part: PRCM partition ID that the clockdomain registers exist in
- * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
- *
- * Put a clockdomain referred to by (@part, @inst, @cdoffs) into idle
- * No return value.
- */
-void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs)
-{
-	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, part, inst, cdoffs);
-}
-
-/**
  * omap4_cminst_clkdm_force_sleep - try to take a clockdomain out of idle
  * @part: PRCM partition ID that the clockdomain registers exist in
  * @inst: CM instance register offset (*_INST macro)
-- 
1.7.5.4

