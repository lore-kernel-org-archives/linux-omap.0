From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap_hwmod: Allow io_ring wakeup configuration for all
 modules.
Date: Wed, 4 Apr 2012 09:39:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040937590.8000@utopia.booyaka.com>
References: <1331122775-761-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37610 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270Ab2DDPjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 11:39:03 -0400
In-Reply-To: <1331122775-761-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Wed, 7 Mar 2012, Govindraj.R wrote:

> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> Some modules doesn't have SYSC_HAS_ENAWAKEUP bit available
> (ex: usb host uhh module) in absence of this flag
> omap_hwmod_enable/disable_wakeup avoids configuring
> pad mux wakeup capability.
> 
> Configure sysc if SYSC_HAS_ENAWAKEUP is available and for other cases
> try enabling/disabling wakeup from mux_pad pins.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Thanks, queued for 3.4-rc.  The kerneldoc documentation on the functions 
has been updated to match reality; modified patch follows.


- Paul

From: "Govindraj.R" <govindraj.raja@ti.com>
Date: Wed, 4 Apr 2012 09:05:41 -0600
Subject: [PATCH] ARM: OMAP2+: omap_hwmod: Allow io_ring wakeup
 configuration for all modules

Some modules doesn't have SYSC_HAS_ENAWAKEUP bit available (ex: usb
host uhh module) in absence of this flag
omap_hwmod_enable/disable_wakeup avoids configuring pad mux wakeup
capability.

Configure sysc if SYSC_HAS_ENAWAKEUP is available and for other cases
try enabling/disabling wakeup from mux_pad pins.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
[paul@pwsan.com: updated function kerneldoc documentation]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   56 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index eba6cd3..5a68010 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2463,26 +2463,28 @@ int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
  * @oh: struct omap_hwmod *
  *
  * Sets the module OCP socket ENAWAKEUP bit to allow the module to
- * send wakeups to the PRCM.  Eventually this should sets PRCM wakeup
- * registers to cause the PRCM to receive wakeup events from the
- * module.  Does not set any wakeup routing registers beyond this
- * point - if the module is to wake up any other module or subsystem,
- * that must be set separately.  Called by omap_device code.  Returns
- * -EINVAL on error or 0 upon success.
+ * send wakeups to the PRCM, and enable I/O ring wakeup events for
+ * this IP block if it has dynamic mux entries.  Eventually this
+ * should set PRCM wakeup registers to cause the PRCM to receive
+ * wakeup events from the module.  Does not set any wakeup routing
+ * registers beyond this point - if the module is to wake up any other
+ * module or subsystem, that must be set separately.  Called by
+ * omap_device code.  Returns -EINVAL on error or 0 upon success.
  */
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 {
 	unsigned long flags;
 	u32 v;
 
-	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
-		return -EINVAL;
-
 	spin_lock_irqsave(&oh->_lock, flags);
-	v = oh->_sysc_cache;
-	_enable_wakeup(oh, &v);
-	_write_sysconfig(v, oh);
+
+	if (oh->class->sysc &&
+	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
+		v = oh->_sysc_cache;
+		_enable_wakeup(oh, &v);
+		_write_sysconfig(v, oh);
+	}
+
 	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -2494,26 +2496,28 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
  * @oh: struct omap_hwmod *
  *
  * Clears the module OCP socket ENAWAKEUP bit to prevent the module
- * from sending wakeups to the PRCM.  Eventually this should clear
- * PRCM wakeup registers to cause the PRCM to ignore wakeup events
- * from the module.  Does not set any wakeup routing registers beyond
- * this point - if the module is to wake up any other module or
- * subsystem, that must be set separately.  Called by omap_device
- * code.  Returns -EINVAL on error or 0 upon success.
+ * from sending wakeups to the PRCM, and disable I/O ring wakeup
+ * events for this IP block if it has dynamic mux entries.  Eventually
+ * this should clear PRCM wakeup registers to cause the PRCM to ignore
+ * wakeup events from the module.  Does not set any wakeup routing
+ * registers beyond this point - if the module is to wake up any other
+ * module or subsystem, that must be set separately.  Called by
+ * omap_device code.  Returns -EINVAL on error or 0 upon success.
  */
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 {
 	unsigned long flags;
 	u32 v;
 
-	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP))
-		return -EINVAL;
-
 	spin_lock_irqsave(&oh->_lock, flags);
-	v = oh->_sysc_cache;
-	_disable_wakeup(oh, &v);
-	_write_sysconfig(v, oh);
+
+	if (oh->class->sysc &&
+	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
+		v = oh->_sysc_cache;
+		_disable_wakeup(oh, &v);
+		_write_sysconfig(v, oh);
+	}
+
 	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
-- 
1.7.9.5

