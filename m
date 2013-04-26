From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/6] ARM: OMAP2+: hwmod: Fix sidle programming in _enable_sysc()/_idle_sysc()
Date: Fri, 26 Apr 2013 16:24:50 +0530
Message-ID: <1366973695-2088-2-git-send-email-rnayak@ti.com>
References: <1366973695-2088-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60856 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275Ab3DZKzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 06:55:41 -0400
In-Reply-To: <1366973695-2088-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: santosh.shilimkar@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

_enable_sysc() and _idle_sysc() handle the midle mode programming correctly
and program HWMOD_IDLEMODE_SMART or HWMOD_IDLEMODE_SMART_WKUP respectively
for supported IPs (The ones which support hardware controlled midle modes)

However the same programming logic is missing when it comes to sidle mode
programming. Here they seem to just set HWMOD_IDLEMODE_SMART (Again for the
ones which support hardware controlled sidle modes)

This problem was hidden due to the fact that a call to _enable_wakeup()
in those same functions would overwrite the idlemodes and program them
correctly (to HWMOD_IDLEMODE_SMART_WKUP in the supported cases)

So fix the sidlemode handling correctly in these functions and handle the
_enable_wakeup() for SIDLEMODE supported IPs same as the way its handled
for MIDLEMODE supported ones.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   42 +++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e5cafed..bf84686 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1353,13 +1353,26 @@ static void _enable_sysc(struct omap_hwmod *oh)
 
 	clkdm = _get_clkdm(oh);
 	if (sf & SYSC_HAS_SIDLEMODE) {
+		if (oh->flags & HWMOD_SWSUP_SIDLE) {
+			idlemode = HWMOD_IDLEMODE_NO;
+		} else {
+			if (sf & SYSC_HAS_ENAWAKEUP)
+				_enable_wakeup(oh, &v);
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
 
@@ -1386,10 +1399,6 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	    (sf & SYSC_HAS_CLOCKACTIVITY))
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
 
-	/* If slave is in SMARTIDLE, also enable wakeup */
-	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
-		_enable_wakeup(oh, &v);
-
 	_write_sysconfig(v, oh);
 
 	/*
@@ -1425,13 +1434,16 @@ static void _idle_sysc(struct omap_hwmod *oh)
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
+			if (sf & SYSC_HAS_ENAWAKEUP)
+				_enable_wakeup(oh, &v);
+			if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
+				idlemode = HWMOD_IDLEMODE_SMART_WKUP;
+			else
+				idlemode = HWMOD_IDLEMODE_SMART;
+		}
 		_set_slave_idlemode(oh, idlemode, &v);
 	}
 
@@ -1449,10 +1461,6 @@ static void _idle_sysc(struct omap_hwmod *oh)
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
-	/* If slave is in SMARTIDLE, also enable wakeup */
-	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
-		_enable_wakeup(oh, &v);
-
 	_write_sysconfig(v, oh);
 }
 
-- 
1.7.9.5

