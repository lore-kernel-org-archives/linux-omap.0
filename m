From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 8/8] ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis
Date: Wed, 20 Feb 2013 15:31:24 +0530
Message-ID: <1361354484-18314-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45543 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932440Ab3BTKAH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 05:00:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

With the OMAP serial driver sysc cleanup patches in this series, we can
now remove the hwmod external apis for sysc fiddling.

While at this, also remove unused sysc auto idle api from hwmod code.

Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Rajendra nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   68 --------------------------------------
 arch/arm/mach-omap2/omap_hwmod.h |    3 --
 2 files changed, 71 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9e1e8c8..811c2b4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2207,42 +2207,6 @@ static int _idle(struct omap_hwmod *oh)
 }
 
 /**
- * omap_hwmod_set_ocp_autoidle - set the hwmod's OCP autoidle bit
- * @oh: struct omap_hwmod *
- * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
- *
- * Sets the IP block's OCP autoidle bit in hardware, and updates our
- * local copy. Intended to be used by drivers that require
- * direct manipulation of the AUTOIDLE bits.
- * Returns -EINVAL if @oh is null or is not in the ENABLED state, or passes
- * along the return value from _set_module_autoidle().
- *
- * Any users of this function should be scrutinized carefully.
- */
-int omap_hwmod_set_ocp_autoidle(struct omap_hwmod *oh, u8 autoidle)
-{
-	u32 v;
-	int retval = 0;
-	unsigned long flags;
-
-	if (!oh || oh->_state != _HWMOD_STATE_ENABLED)
-		return -EINVAL;
-
-	spin_lock_irqsave(&oh->_lock, flags);
-
-	v = oh->_sysc_cache;
-
-	retval = _set_module_autoidle(oh, autoidle, &v);
-
-	if (!retval)
-		_write_sysconfig(v, oh);
-
-	spin_unlock_irqrestore(&oh->_lock, flags);
-
-	return retval;
-}
-
-/**
  * _shutdown - shutdown an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -3104,38 +3068,6 @@ error:
 }
 
 /**
- * omap_hwmod_set_slave_idlemode - set the hwmod's OCP slave idlemode
- * @oh: struct omap_hwmod *
- * @idlemode: SIDLEMODE field bits (shifted to bit 0)
- *
- * Sets the IP block's OCP slave idlemode in hardware, and updates our
- * local copy.  Intended to be used by drivers that have some erratum
- * that requires direct manipulation of the SIDLEMODE bits.  Returns
- * -EINVAL if @oh is null, or passes along the return value from
- * _set_slave_idlemode().
- *
- * XXX Does this function have any current users?  If not, we should
- * remove it; it is better to let the rest of the hwmod code handle this.
- * Any users of this function should be scrutinized carefully.
- */
-int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
-{
-	u32 v;
-	int retval = 0;
-
-	if (!oh)
-		return -EINVAL;
-
-	v = oh->_sysc_cache;
-
-	retval = _set_slave_idlemode(oh, idlemode, &v);
-	if (!retval)
-		_write_sysconfig(v, oh);
-
-	return retval;
-}
-
-/**
  * omap_hwmod_lookup - look up a registered omap_hwmod by name
  * @name: name of the omap_hwmod to look up
  *
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index c191035..0fd4dcf 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -629,9 +629,6 @@ int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name);
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
-int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
-int omap_hwmod_set_ocp_autoidle(struct omap_hwmod *oh, u8 autoidle);
-
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
 
-- 
1.7.9.5

