From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/8] ARM: OMAP2+: hwmod: Always have OCP_SYSCONFIG.ENAWAKEUP enabled
Date: Wed, 20 Feb 2013 15:27:47 +0530
Message-ID: <1361354272-18089-4-git-send-email-santosh.shilimkar@ti.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34995 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933984Ab3BTJ50 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 04:57:26 -0500
In-Reply-To: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Get rid of all complexities around when to enable OCP_SYSCONFIG.ENAWAKEUP.
It should be safe to have this set *always* for all IP blocks which
have this control. It should be a *dont care* when the IP is in
NO/FORCE modes of sidle/mstandby. As for the SMART/SMART_WKUP modes
of sidle/mstandby the framework anyway sets this always.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index fdd55cd..932d5e6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1362,8 +1362,6 @@ static void _enable_sysc(struct omap_hwmod *oh)
 		if (oh->flags & HWMOD_SWSUP_MSTANDBY) {
 			idlemode = HWMOD_IDLEMODE_NO;
 		} else {
-			if (sf & SYSC_HAS_ENAWAKEUP)
-				_enable_wakeup(oh, &v);
 			if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
 				idlemode = HWMOD_IDLEMODE_SMART_WKUP;
 			else
@@ -1381,9 +1379,7 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	    (sf & SYSC_HAS_CLOCKACTIVITY))
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
 
-	/* If slave is in SMARTIDLE, also enable wakeup */
-	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
-		_enable_wakeup(oh, &v);
+	_enable_wakeup(oh, &v);
 
 	_write_sysconfig(v, oh);
 
@@ -1435,8 +1431,6 @@ static void _idle_sysc(struct omap_hwmod *oh)
 		if (oh->flags & HWMOD_SWSUP_MSTANDBY) {
 			idlemode = HWMOD_IDLEMODE_FORCE;
 		} else {
-			if (sf & SYSC_HAS_ENAWAKEUP)
-				_enable_wakeup(oh, &v);
 			if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
 				idlemode = HWMOD_IDLEMODE_SMART_WKUP;
 			else
@@ -1445,9 +1439,7 @@ static void _idle_sysc(struct omap_hwmod *oh)
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
-	/* If slave is in SMARTIDLE, also enable wakeup */
-	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
-		_enable_wakeup(oh, &v);
+	_enable_wakeup(oh, &v);
 
 	_write_sysconfig(v, oh);
 }
@@ -3767,14 +3759,6 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	u32 v;
 
 	spin_lock_irqsave(&oh->_lock, flags);
-
-	if (oh->class->sysc &&
-	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
-		v = oh->_sysc_cache;
-		_enable_wakeup(oh, &v);
-		_write_sysconfig(v, oh);
-	}
-
 	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
-- 
1.7.9.5

