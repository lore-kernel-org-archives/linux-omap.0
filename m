From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCHv2] ARM: omap2+: omap_hwmod: Set unique lock_class_key per hwmod
Date: Tue, 10 Feb 2015 14:23:14 +0200
Message-ID: <1423570994-20507-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, peterz@infradead.org
Cc: linux-omap@vger.kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add struct lock_class_key to omap_hwmod struct and use it to set unique
lockdep class per hwmod.
This will ensure that lockdep will know that each omap_hwmod->_lock should
be treated as separate class and will not give false warning about deadlock
or other issues due to nested use of hwmods.
DRA7x's ATL hwmod is one example for this since McASP can select ATL clock
as functional clock, which will trigger nested oh->_lock usage. This will
trigger false warning from lockdep validator as it is dealing with classes
and for it all hwmod clocks are the same class.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 1 +
 arch/arm/mach-omap2/omap_hwmod.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 92afb723dcfc..2db380420b6f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2698,6 +2698,7 @@ static int __init _register(struct omap_hwmod *oh)
 	INIT_LIST_HEAD(&oh->master_ports);
 	INIT_LIST_HEAD(&oh->slave_ports);
 	spin_lock_init(&oh->_lock);
+	lockdep_set_class(&oh->_lock, &oh->hwmod_key);
 
 	oh->_state = _HWMOD_STATE_REGISTERED;
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 9d4bec6ee742..9611c91d9b82 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -674,6 +674,7 @@ struct omap_hwmod {
 	u32				_sysc_cache;
 	void __iomem			*_mpu_rt_va;
 	spinlock_t			_lock;
+	struct lock_class_key		hwmod_key; /* unique lock class */
 	struct list_head		node;
 	struct omap_hwmod_ocp_if	*_mpu_port;
 	unsigned int			(*xlate_irq)(unsigned int);
-- 
2.3.0
