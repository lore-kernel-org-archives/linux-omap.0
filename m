From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/8] ARM: OMAP2+: hwmod: Cleanup sidle/mstandby programming
Date: Wed, 20 Feb 2013 15:27:46 +0530
Message-ID: <1361354272-18089-3-git-send-email-santosh.shilimkar@ti.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34980 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933984Ab3BTJ5U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 04:57:20 -0500
In-Reply-To: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

_enable_wakeup() and _disable_wakeup() are expected to program the
OCP_SYSCONFIG.ENAWAKEUP bit. Get rid of the additional sidle/mstandby
programming in them, as its confusing (this is expected to be handled
elsewhere as part of _enable_sysc()/__idle_sysc()) and unnecessary.

Well, the _enable_sysc()/_idle_sysc() handled only the mstandby modes
correctly. So fix them so they also handle the midle modes correctly
and program HWMOD_IDLEMODE_SMART_WKUP and HWMOD_IDLEMODE_SMART
respectively.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   48 ++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b45c8fb..fdd55cd 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -588,9 +588,7 @@ static void _set_idle_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
 static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 {
 	if (!oh->class->sysc ||
-	    !((oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP) ||
-	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP) ||
-	      (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)))
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
 	if (!oh->class->sysc->sysc_fields) {
@@ -601,11 +599,6 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 	if (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)
 		*v |= 0x1 << oh->class->sysc->sysc_fields->enwkup_shift;
 
-	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
-		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
-	if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
-		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
-
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
 	return 0;
@@ -621,9 +614,7 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 {
 	if (!oh->class->sysc ||
-	    !((oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP) ||
-	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP) ||
-	      (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)))
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
 	if (!oh->class->sysc->sysc_fields) {
@@ -634,11 +625,6 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 	if (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)
 		*v &= ~(0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
 
-	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
-		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART, v);
-	if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
-		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART, v);
-
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
 	return 0;
@@ -1351,13 +1337,24 @@ static void _enable_sysc(struct omap_hwmod *oh)
 
 	clkdm = _get_clkdm(oh);
 	if (sf & SYSC_HAS_SIDLEMODE) {
+		if (oh->flags & HWMOD_SWSUP_SIDLE) {
+			idlemode = HWMOD_IDLEMODE_NO;
+		} else {
+			if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
+				idlemode = HWMOD_IDLEMODE_SMART_WKUP;
+			else
+				idlemode = HWMOD_IDLEMODE_SMART;
+		}
+
+		/*
+		 * This is special handling for some IPs like
+		 * 32k sync timer. Force them to idle!
+		 */
 		clkdm_act = (clkdm && clkdm->flags & CLKDM_ACTIVE_WITH_MPU);
 		if (clkdm_act && !(oh->class->sysc->idlemodes &
 				   (SIDLE_SMART | SIDLE_SMART_WKUP)))
 			idlemode = HWMOD_IDLEMODE_FORCE;
-		else
-			idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
-				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
+
 		_set_slave_idlemode(oh, idlemode, &v);
 	}
 
@@ -1423,13 +1420,14 @@ static void _idle_sysc(struct omap_hwmod *oh)
 	sf = oh->class->sysc->sysc_flags;
 
 	if (sf & SYSC_HAS_SIDLEMODE) {
-		/* XXX What about HWMOD_IDLEMODE_SMART_WKUP? */
-		if (oh->flags & HWMOD_SWSUP_SIDLE ||
-		    !(oh->class->sysc->idlemodes &
-		      (SIDLE_SMART | SIDLE_SMART_WKUP)))
+		if (oh->flags & HWMOD_SWSUP_SIDLE) {
 			idlemode = HWMOD_IDLEMODE_FORCE;
-		else
-			idlemode = HWMOD_IDLEMODE_SMART;
+		} else {
+			if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
+				idlemode = HWMOD_IDLEMODE_SMART_WKUP;
+			else
+				idlemode = HWMOD_IDLEMODE_SMART;
+		}
 		_set_slave_idlemode(oh, idlemode, &v);
 	}
 
-- 
1.7.9.5

