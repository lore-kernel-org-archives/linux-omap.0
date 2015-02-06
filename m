From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ARM: omap2+: omap_hwmod: Use _nested version of spinlock for oh->_lock
Date: Fri, 6 Feb 2015 14:48:35 +0200
Message-ID: <1423226916-18804-2-git-send-email-peter.ujfalusi@ti.com>
References: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add lockdep_class member to struct omap_hwmod and use this number to
specify the subclass of the given hwmod's lock.
When defining the hwmods the lockdep_level can be initialized to indicate
that this lock might be used in a nested fashion.
DRA7x's ATL hwmod is one example for this since McASP can select ATL clock
as functional clock, which will trigger nested oh->_lock usage. This will
trigger false warning from lockdep validator since it is dealing with
classes and for it all hwmod clocks are the same class.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++--------
 arch/arm/mach-omap2/omap_hwmod.h |  5 +++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 92afb723dcfc..b5afde560054 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3334,7 +3334,7 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	spin_lock_irqsave(&oh->_lock, flags);
+	spin_lock_irqsave_nested(&oh->_lock, flags, oh->lockdep_class);
 	r = _enable(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -3355,7 +3355,7 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	spin_lock_irqsave(&oh->_lock, flags);
+	spin_lock_irqsave_nested(&oh->_lock, flags, oh->lockdep_class);
 	_idle(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -3377,7 +3377,7 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	spin_lock_irqsave(&oh->_lock, flags);
+	spin_lock_irqsave_nested(&oh->_lock, flags, oh->lockdep_class);
 	_shutdown(oh);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -3667,7 +3667,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	unsigned long flags;
 	u32 v;
 
-	spin_lock_irqsave(&oh->_lock, flags);
+	spin_lock_irqsave_nested(&oh->_lock, flags, oh->lockdep_class);
 
 	if (oh->class->sysc &&
 	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
@@ -3700,7 +3700,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 	unsigned long flags;
 	u32 v;
 
-	spin_lock_irqsave(&oh->_lock, flags);
+	spin_lock_irqsave_nested(&oh->_lock, flags, oh->lockdep_class);
 
 	if (oh->class->sysc &&
 	    (oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP)) {
@@ -3735,7 +3735,7 @@ int omap_hwmod_assert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (!oh)
 		return -EINVAL;
 
-	spin_lock_irqsave(&oh->_lock, flags);
+	spin_lock_irqsave_nested(&oh->_lock, flags, oh->lockdep_class);
 	ret = _assert_hardreset(oh, name);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -3762,7 +3762,7 @@ int omap_hwmod_deassert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (!oh)
 		return -EINVAL;
 
-	spin_lock_irqsave(&oh->_lock, flags);
+	spin_lock_irqsave_nested(&oh->_lock, flags, oh->lockdep_class);
 	ret = _deassert_hardreset(oh, name);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -3836,7 +3836,7 @@ int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
 	    state != _HWMOD_STATE_IDLE)
 		return -EINVAL;
 
-	spin_lock_irqsave(&oh->_lock, flags);
+	spin_lock_irqsave_nested(&oh->_lock, flags, oh->lockdep_class);
 
 	if (oh->_state != _HWMOD_STATE_REGISTERED) {
 		ret = -EINVAL;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 9d4bec6ee742..260d3e9c9f6d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -606,6 +606,9 @@ struct omap_hwmod_link {
 	struct list_head		node;
 };
 
+#define HWMOD_LOCKDEP_SUBCLASS_NORMAL	0
+#define HWMOD_LOCKDEP_SUBCLASS_CLASS1	1	/* might be used as nested */
+
 /**
  * struct omap_hwmod - integration data for OMAP hardware "modules" (IP blocks)
  * @name: name of the hwmod
@@ -632,6 +635,7 @@ struct omap_hwmod_link {
  * @_postsetup_state: internal-use state to leave the hwmod in after _setup()
  * @flags: hwmod flags (documented below)
  * @_lock: spinlock serializing operations on this hwmod
+ * @lockdep_class: subclass to use with spin_lock_irqsave_nested()
  * @node: list node for hwmod list (internal use)
  * @parent_hwmod: (temporary) a pointer to the hierarchical parent of this hwmod
  *
@@ -674,6 +678,7 @@ struct omap_hwmod {
 	u32				_sysc_cache;
 	void __iomem			*_mpu_rt_va;
 	spinlock_t			_lock;
+	unsigned int			lockdep_class;
 	struct list_head		node;
 	struct omap_hwmod_ocp_if	*_mpu_port;
 	unsigned int			(*xlate_irq)(unsigned int);
-- 
2.2.2
