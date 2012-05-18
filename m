From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Fri, 18 May 2012 13:18:41 -0500
Message-ID: <1337365122-702-1-git-send-email-nm@ti.com>
References: <[PATCH] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:53815 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932790Ab2ERSSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 14:18:47 -0400
Received: by ggcs5 with SMTP id s5so3603186ggc.36
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 11:18:46 -0700 (PDT)
In-Reply-To: <[PATCH] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Wenbiao Wang <wwang@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

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
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

[nm@ti.com: port from android]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Wenbiao Wang <wwang@ti.com>
---
V2: fix commit message - picked up redundant info from get_maintainer.pl
Apologies on the spam

V1: http://marc.info/?l=linux-omap&m=133736493721977&w=2

 arch/arm/mach-omap2/vp.c |   15 +++++++++++++--
 arch/arm/mach-omap2/vp.h |    2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

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
index 7c155d2..0abf895 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -31,7 +31,7 @@ struct voltagedomain;
 #define OMAP4_VP_VDD_MPU_ID 2
 
 /* XXX document */
-#define VP_IDLE_TIMEOUT		200
+#define VP_IDLE_TIMEOUT		500
 #define VP_TRANXDONE_TIMEOUT	300
 
 /**
-- 
1.7.9.5

