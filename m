From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 1/3] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Tue, 22 May 2012 08:31:44 -0500
Message-ID: <1337693504-4442-1-git-send-email-nm@ti.com>
References: <[PATCH 1/3] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:60240 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753032Ab2EVNbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 09:31:52 -0400
Received: by yhoo21 with SMTP id o21so7167407yho.18
        for <linux-omap@vger.kernel.org>; Tue, 22 May 2012 06:31:51 -0700 (PDT)
In-Reply-To: <[PATCH 1/3] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Wenbiao Wang <wwang@ti.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

From: Wenbiao Wang <wwang@ti.com>

Voltage Processor state machine transition to disable need to
occur from IDLE state. When we transition OPP in a functioning
system, the call sequence for an OPP transition is as follows:
omap_sr_disable
      -> sr class 3 disable
           -> vp disable
           -> sr disable
forceupdate to voltage/frequency scale depending on which OPP
we are transitioning to.

If we hit a critical timing window where SR had commanded VP
for a voltage transition and VP is in the middle of operating
on that command, it needs to go through a few states before
going to update state(where it actually sends the command to
VC). Initial view of h/w owners is that the state disable of VP
is expected to be sampled for the next transition.

Instead, to be on a safer side, we ensure that the valid states
of the VP state machine is diligently followed by software. This
can be done by waiting for VP to be in idle  prior to disabling
VP. Existing prints have been updated to ensure context is
available on error messages.

As part of this change, increase timeout for VP idle check to
improbable 500uSec to be certain that system is indeed unable
to continue before crashing out with error(worst case expectancy
remains the same 3-100uSec depending on when we caught VP). Update
macro documentation as well

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

[nm@ti.com: port from android]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Wenbiao Wang <wwang@ti.com>
---
V3: updated documenation for VP_IDLE_TIMEOUT macro
V2: http://marc.info/?t=133736542500001&r=1&w=2
 arch/arm/mach-omap2/vp.c |   15 +++++++++++++--
 arch/arm/mach-omap2/vp.h |    9 +++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index f95c1ba..925d869 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -262,6 +262,17 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 		return;
 	}
 
+	/*
+	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
+	 * Depending on if we catch VP in the middle of an SR operation.
+	 */
+	omap_test_timeout((voltdm->read(vp->vstatus)),
+			  VP_IDLE_TIMEOUT, timeout);
+
+	if (timeout >= VP_IDLE_TIMEOUT)
+		pr_warning("%s: vdd_%s idle timedout before disable\n",
+			   __func__, voltdm->name);
+
 	/* Disable VP */
 	vpconfig = voltdm->read(vp->vpconfig);
 	vpconfig &= ~vp->common->vpconfig_vpenable;
@@ -274,8 +285,8 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 			  VP_IDLE_TIMEOUT, timeout);
 
 	if (timeout >= VP_IDLE_TIMEOUT)
-		pr_warning("%s: vdd_%s idle timedout\n",
-			__func__, voltdm->name);
+		pr_warning("%s: vdd_%s idle timedout after disable\n",
+			   __func__, voltdm->name);
 
 	vp->enabled = false;
 
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 7c155d2..79b159f 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -30,8 +30,13 @@ struct voltagedomain;
 #define OMAP4_VP_VDD_IVA_ID 1
 #define OMAP4_VP_VDD_MPU_ID 2
 
-/* XXX document */
-#define VP_IDLE_TIMEOUT		200
+/*
+ * Maximum time for Voltage Processor to enter or exit idle
+ * worst case is around 100uSec depending on when we intercepted VP
+ * we use 5 times worst case value to be sure that the system flags
+ * invalid condition
+ */
+#define VP_IDLE_TIMEOUT		500
 #define VP_TRANXDONE_TIMEOUT	300
 
 /**
-- 
1.7.9.5

