From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP2+: omap_hwmod: fix wakeup enable/disable for consistency
Date: Thu,  9 Dec 2010 15:10:47 -0800
Message-ID: <1291936247-17955-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:45083 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab0LIXKw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 18:10:52 -0500
Received: by gxk19 with SMTP id 19so1841793gxk.11
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 15:10:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

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

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies on top of Paul's hwmod_a_2.6.38 branch.

 arch/arm/mach-omap2/omap_hwmod.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a039b37..84a03eb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -388,9 +388,9 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
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
@@ -403,9 +403,7 @@ static int _enable_wakeup(struct omap_hwmod *oh)
 
 	wakeup_mask = (0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
 
-	v = oh->_sysc_cache;
-	v |= wakeup_mask;
-	_write_sysconfig(v, oh);
+	*v |= wakeup_mask;
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
@@ -421,9 +419,9 @@ static int _enable_wakeup(struct omap_hwmod *oh)
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
@@ -436,9 +434,7 @@ static int _disable_wakeup(struct omap_hwmod *oh)
 
 	wakeup_mask = (0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
 
-	v = oh->_sysc_cache;
-	v &= ~wakeup_mask;
-	_write_sysconfig(v, oh);
+	*v &= ~wakeup_mask;
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
@@ -786,11 +782,11 @@ static void _enable_sysc(struct omap_hwmod *oh)
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
@@ -2009,13 +2005,16 @@ int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
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
@@ -2036,13 +2035,16 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
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
1.7.2.1

