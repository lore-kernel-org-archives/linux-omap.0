From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 6/7] OMAP2+: omap_hwmod: fix wakeup enable/disable for consistency
Date: Wed, 15 Dec 2010 14:51:42 +0100
Message-ID: <1292421103-19282-7-git-send-email-b-cousson@ti.com>
References: <1292421103-19282-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47296 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab0LONxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 08:53:33 -0500
In-Reply-To: <1292421103-19282-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

In the omap_hwmod core, most of the SYSCONFIG register helper
functions do not directly write the register, but instead just modify
a value passed in.

This patch converts the _enable_wakeup() and _disable_wakeup() helper
functions to take a value argument and only modify it instead of
actually writing the register.  This makes the wakeup helpers
consistent with the other helper functions and avoids unintentional
problems like the following.

This problem was found after discovering that GPIO wakeups were no
longer functional.  The root cause was that the ENAWAKEUP bit of the
SYSCONFIG register was being unintentionaly overwritten, leaving
wakeups disabled after the following two commits were combined:

commit: 9980ce53c97392a3dbdc9d1ac3e455d79b4167ed
        OMAP: hwmod: Enable module wakeup if in smartidle

commit: 78f26e872f77b6312273216de1a8f836c6f2e143
        OMAP: hwmod: Set autoidle after smartidle during _sysc_enable

There resulting in code in _enable_sysc() was this:

	/*
	 * XXX The clock framework should handle this, by
	 * calling into this code.  But this must wait until the
	 * clock structures are tagged with omap_hwmod entries
	 */
	if ((oh->flags & HWMOD_SET_DEFAULT_CLOCKACT) &&
	    (sf & SYSC_HAS_CLOCKACTIVITY))
		_set_clockactivity(oh, oh->class->sysc->clockact, &v);

	_write_sysconfig(v, oh);

so here, 'v' has wakeups disabled.

	/* If slave is in SMARTIDLE, also enable wakeup */
	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
		_enable_wakeup(oh);

Here wakeup is enabled in the SYSCONFIG register (but 'v' is not updated)

	/*
	 * Set the autoidle bit only after setting the smartidle bit
	 * Setting this will not have any impact on the other modules.
	 */
	if (sf & SYSC_HAS_AUTOIDLE) {
		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
			0 : 1;
		_set_module_autoidle(oh, idlemode, &v);
		_write_sysconfig(v, oh);
	}

And here, SYSCONFIG is updated again using 'v', which does not have
wakeups enabled, resulting in ENAWAKEUP being cleared.

Special thanks to Benoit Cousson for pointing out that wakeups were
supposed to be automatically enabled when a hwmod is enabled, and thus
helping target the root cause of this problem.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 12856eb..81c1097 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -390,9 +390,9 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
  * Allow the hardware module @oh to send wakeups.  Returns -EINVAL
  * upon error or 0 upon success.
  */
-static int _enable_wakeup(struct omap_hwmod *oh)
+static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 {
-	u32 v, wakeup_mask;
+	u32 wakeup_mask;
 
 	if (!oh->class->sysc ||
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
@@ -405,9 +405,7 @@ static int _enable_wakeup(struct omap_hwmod *oh)
 
 	wakeup_mask = (0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
 
-	v = oh->_sysc_cache;
-	v |= wakeup_mask;
-	_write_sysconfig(v, oh);
+	*v |= wakeup_mask;
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
@@ -423,9 +421,9 @@ static int _enable_wakeup(struct omap_hwmod *oh)
  * Prevent the hardware module @oh to send wakeups.  Returns -EINVAL
  * upon error or 0 upon success.
  */
-static int _disable_wakeup(struct omap_hwmod *oh)
+static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 {
-	u32 v, wakeup_mask;
+	u32 wakeup_mask;
 
 	if (!oh->class->sysc ||
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
@@ -438,9 +436,7 @@ static int _disable_wakeup(struct omap_hwmod *oh)
 
 	wakeup_mask = (0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
 
-	v = oh->_sysc_cache;
-	v &= ~wakeup_mask;
-	_write_sysconfig(v, oh);
+	*v &= ~wakeup_mask;
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
@@ -788,11 +784,11 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	    (sf & SYSC_HAS_CLOCKACTIVITY))
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
 
-	_write_sysconfig(v, oh);
-
 	/* If slave is in SMARTIDLE, also enable wakeup */
 	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
-		_enable_wakeup(oh);
+		_enable_wakeup(oh, &v);
+
+	_write_sysconfig(v, oh);
 
 	/*
 	 * Set the autoidle bit only after setting the smartidle bit
@@ -2011,13 +2007,16 @@ int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 {
 	unsigned long flags;
+	u32 v;
 
 	if (!oh->class->sysc ||
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
 	spin_lock_irqsave(&oh->_lock, flags);
-	_enable_wakeup(oh);
+	v = oh->_sysc_cache;
+	_enable_wakeup(oh, &v);
+	_write_sysconfig(v, oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
@@ -2038,13 +2037,16 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 {
 	unsigned long flags;
+	u32 v;
 
 	if (!oh->class->sysc ||
 	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
 	spin_lock_irqsave(&oh->_lock, flags);
-	_disable_wakeup(oh);
+	v = oh->_sysc_cache;
+	_disable_wakeup(oh, &v);
+	_write_sysconfig(v, oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
-- 
1.7.0.4

