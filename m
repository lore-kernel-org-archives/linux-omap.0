From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 4/4] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Thu, 31 May 2012 20:41:39 -0500
Message-ID: <1338514899-3560-5-git-send-email-nm@ti.com>
References: <1338514899-3560-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:38559 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755910Ab2FABmC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 21:42:02 -0400
Received: by obcni5 with SMTP id ni5so2445104obc.41
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 18:41:57 -0700 (PDT)
In-Reply-To: <1338514899-3560-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wenbiao Wang <wwang@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

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
remains the same 3-100uSec depending on when we caught VP).

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>

[nm@ti.com: port from android]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Wenbiao Wang <wwang@ti.com>
---
 arch/arm/mach-omap2/vp.c |    4 ++++
 arch/arm/mach-omap2/vp.h |    5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 2a8a085..9a72deb 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -308,6 +308,10 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 		return;
 	}
 
+	if (_vp_wait_for_idle(voltdm, vp)) {
+		pr_warn_ratelimited("%s: vdd_%s timedout!Ignore and try\n",
+				    __func__, voltdm->name);
+	}
 	/* Disable VP */
 	vpconfig = voltdm->read(vp->vpconfig);
 	vpconfig &= ~vp->common->vpconfig_vpenable;
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 4655b39..4b4eeb6 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -33,9 +33,10 @@ struct voltagedomain;
 /*
  * Time out for Voltage processor in micro seconds. Typical latency is < 2uS,
  * but worst case latencies could be around 3-200uS depending on where we
- * interrupted VP's operation.
+ * interrupted VP's operation. Use an improbable timeout value to be
+ * sure that timeout events are beyond doubt.
  */
-#define VP_IDLE_TIMEOUT		200
+#define VP_IDLE_TIMEOUT		500
 #define VP_TRANXDONE_TIMEOUT	300
 
 /**
-- 
1.7.9.5

