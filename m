From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Drop unused enable_wakeup and disable_wakeup
Date: Wed, 16 Oct 2019 10:29:08 -0700
Message-ID: <20191016172909.7115-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We're only using static _enable_wakeup(), the others have no callers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 97 --------------------------------
 arch/arm/mach-omap2/omap_hwmod.h |  3 -
 2 files changed, 100 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -623,39 +623,6 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 	return 0;
 }
 
-/**
- * _disable_wakeup: clear OCP_SYSCONFIG.ENAWAKEUP bit in the hardware
- * @oh: struct omap_hwmod *
- *
- * Prevent the hardware module @oh to send wakeups.  Returns -EINVAL
- * upon error or 0 upon success.
- */
-static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
-{
-	if (!oh->class->sysc ||
-	    !((oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP) ||
-	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP) ||
-	      (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)))
-		return -EINVAL;
-
-	if (!oh->class->sysc->sysc_fields) {
-		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not provided in class\n", oh->name);
-		return -EINVAL;
-	}
-
-	if (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)
-		*v &= ~(0x1 << oh->class->sysc->sysc_fields->enwkup_shift);
-
-	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
-		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART, v);
-	if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
-		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART, v);
-
-	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
-
-	return 0;
-}
-
 static struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
 {
 	struct clk_hw_omap *clk;
@@ -3867,70 +3834,6 @@ void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh)
  * for context save/restore operations?
  */
 
-/**
- * omap_hwmod_enable_wakeup - allow device to wake up the system
- * @oh: struct omap_hwmod *
- *
- * Sets the module OCP socket ENAWAKEUP bit to allow the module to
- * send wakeups to the PRCM, and enable I/O ring wakeup events for
- * this IP block if it has dynamic mux entries.  Eventually this
- * should set PRCM wakeup registers to cause the PRCM to receive
- * wakeup events from the module.  Does not set any wakeup routing
- * registers beyond this point - if the module is to wake up any other
- * module or subsystem, that must be set separately.  Called by
- * omap_device code.  Returns -EINVAL on error or 0 upon success.
- */
-int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
-{
-	unsigned long flags;
-	u32 v;
-
-	spin_lock_irqsave(&oh->_lock, flags);
-
-	if (oh->class->sysc &&
-	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
-		v = oh->_sysc_cache;
-		_enable_wakeup(oh, &v);
-		_write_sysconfig(v, oh);
-	}
-
-	spin_unlock_irqrestore(&oh->_lock, flags);
-
-	return 0;
-}
-
-/**
- * omap_hwmod_disable_wakeup - prevent device from waking the system
- * @oh: struct omap_hwmod *
- *
- * Clears the module OCP socket ENAWAKEUP bit to prevent the module
- * from sending wakeups to the PRCM, and disable I/O ring wakeup
- * events for this IP block if it has dynamic mux entries.  Eventually
- * this should clear PRCM wakeup registers to cause the PRCM to ignore
- * wakeup events from the module.  Does not set any wakeup routing
- * registers beyond this point - if the module is to wake up any other
- * module or subsystem, that must be set separately.  Called by
- * omap_device code.  Returns -EINVAL on error or 0 upon success.
- */
-int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
-{
-	unsigned long flags;
-	u32 v;
-
-	spin_lock_irqsave(&oh->_lock, flags);
-
-	if (oh->class->sysc &&
-	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
-		v = oh->_sysc_cache;
-		_disable_wakeup(oh, &v);
-		_write_sysconfig(v, oh);
-	}
-
-	spin_unlock_irqrestore(&oh->_lock, flags);
-
-	return 0;
-}
-
 /**
  * omap_hwmod_assert_hardreset - assert the HW reset line of submodules
  * contained in the hwmod module.
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -646,9 +646,6 @@ int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
 struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh);
 void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh);
 
-int omap_hwmod_enable_wakeup(struct omap_hwmod *oh);
-int omap_hwmod_disable_wakeup(struct omap_hwmod *oh);
-
 int omap_hwmod_for_each_by_class(const char *classname,
 				 int (*fn)(struct omap_hwmod *oh,
 					   void *user),
-- 
2.23.0
