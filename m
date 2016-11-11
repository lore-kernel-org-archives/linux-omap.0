From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/14] ARM: OMAP2+: Remove legacy hwmod mux code
Date: Fri, 11 Nov 2016 11:17:05 -0800
Message-ID: <20161111191711.5079-9-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is no longer needed when booted with device tree.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c    |   1 -
 arch/arm/mach-omap2/omap_hwmod.c | 107 +--------------------------------------
 2 files changed, 1 insertion(+), 107 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -30,7 +30,6 @@
 
 #include "soc.h"
 #include "common.h"
-#include "mux.h"
 #include "control.h"
 #include "display.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -160,7 +160,6 @@
 #include "prm44xx.h"
 #include "prm33xx.h"
 #include "prminst44xx.h"
-#include "mux.h"
 #include "pm.h"
 
 /* Name of the OMAP hwmod for the MPU */
@@ -217,9 +216,6 @@ static LIST_HEAD(omap_hwmod_list);
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
 
-/* io_chain_lock: used to serialize reconfigurations of the I/O chain */
-static DEFINE_SPINLOCK(io_chain_lock);
-
 /*
  * linkspace: ptr to a buffer that struct omap_hwmod_link records are
  * allocated from - used to reduce the number of small memory
@@ -594,51 +590,6 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 }
 
 /**
- * _set_idle_ioring_wakeup - enable/disable IO pad wakeup on hwmod idle for mux
- * @oh: struct omap_hwmod *
- * @set_wake: bool value indicating to set (true) or clear (false) wakeup enable
- *
- * Set or clear the I/O pad wakeup flag in the mux entries for the
- * hwmod @oh.  This function changes the @oh->mux->pads_dynamic array
- * in memory.  If the hwmod is currently idled, and the new idle
- * values don't match the previous ones, this function will also
- * update the SCM PADCTRL registers.  Otherwise, if the hwmod is not
- * currently idled, this function won't touch the hardware: the new
- * mux settings are written to the SCM PADCTRL registers when the
- * hwmod is idled.  No return value.
- */
-static void _set_idle_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
-{
-	struct omap_device_pad *pad;
-	bool change = false;
-	u16 prev_idle;
-	int j;
-
-	if (!oh->mux || !oh->mux->enabled)
-		return;
-
-	for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
-		pad = oh->mux->pads_dynamic[j];
-
-		if (!(pad->flags & OMAP_DEVICE_PAD_WAKEUP))
-			continue;
-
-		prev_idle = pad->idle;
-
-		if (set_wake)
-			pad->idle |= OMAP_WAKEUP_EN;
-		else
-			pad->idle &= ~OMAP_WAKEUP_EN;
-
-		if (prev_idle != pad->idle)
-			change = true;
-	}
-
-	if (change && oh->_state == _HWMOD_STATE_IDLE)
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
-}
-
-/**
  * _enable_wakeup: set OCP_SYSCONFIG.ENAWAKEUP bit in the hardware
  * @oh: struct omap_hwmod *
  *
@@ -2018,29 +1969,6 @@ static int _reset(struct omap_hwmod *oh)
 }
 
 /**
- * _reconfigure_io_chain - clear any I/O chain wakeups and reconfigure chain
- *
- * Call the appropriate PRM function to clear any logged I/O chain
- * wakeups and to reconfigure the chain.  This apparently needs to be
- * done upon every mux change.  Since hwmods can be concurrently
- * enabled and idled, hold a spinlock around the I/O chain
- * reconfiguration sequence.  No return value.
- *
- * XXX When the PRM code is moved to drivers, this function can be removed,
- * as the PRM infrastructure should abstract this.
- */
-static void _reconfigure_io_chain(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&io_chain_lock, flags);
-
-	omap_prm_reconfigure_io_chain();
-
-	spin_unlock_irqrestore(&io_chain_lock, flags);
-}
-
-/**
  * _omap4_update_context_lost - increment hwmod context loss counter if
  * hwmod context was lost, and clear hardware context loss reg
  * @oh: hwmod to check for context loss
@@ -2109,18 +2037,9 @@ static int _enable(struct omap_hwmod *oh)
 
 	/*
 	 * hwmods with HWMOD_INIT_NO_IDLE flag set are left in enabled
-	 * state at init.  Now that someone is really trying to enable
-	 * them, just ensure that the hwmod mux is set.
+	 * state at init.
 	 */
 	if (oh->_int_flags & _HWMOD_SKIP_ENABLE) {
-		/*
-		 * If the caller has mux data populated, do the mux'ing
-		 * which wouldn't have been done as part of the _enable()
-		 * done during setup.
-		 */
-		if (oh->mux)
-			omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
-
 		oh->_int_flags &= ~_HWMOD_SKIP_ENABLE;
 		return 0;
 	}
@@ -2145,16 +2064,6 @@ static int _enable(struct omap_hwmod *oh)
 	if (_are_all_hardreset_lines_asserted(oh))
 		return 0;
 
-	/* Mux pins for device runtime if populated */
-	if (oh->mux && (!oh->mux->enabled ||
-			((oh->_state == _HWMOD_STATE_IDLE) &&
-			 oh->mux->pads_dynamic))) {
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
-		_reconfigure_io_chain();
-	} else if (oh->flags & HWMOD_RECONFIG_IO_CHAIN) {
-		_reconfigure_io_chain();
-	}
-
 	_add_initiator_dep(oh, mpu_oh);
 
 	if (oh->clkdm) {
@@ -2260,14 +2169,6 @@ static int _idle(struct omap_hwmod *oh)
 		clkdm_hwmod_disable(oh->clkdm, oh);
 	}
 
-	/* Mux pins for device idle if populated */
-	if (oh->mux && oh->mux->pads_dynamic) {
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
-		_reconfigure_io_chain();
-	} else if (oh->flags & HWMOD_RECONFIG_IO_CHAIN) {
-		_reconfigure_io_chain();
-	}
-
 	oh->_state = _HWMOD_STATE_IDLE;
 
 	return 0;
@@ -2334,10 +2235,6 @@ static int _shutdown(struct omap_hwmod *oh)
 	for (i = 0; i < oh->rst_lines_cnt; i++)
 		_assert_hardreset(oh, oh->rst_lines[i].name);
 
-	/* Mux pins to safe mode or use populated off mode values */
-	if (oh->mux)
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_DISABLED);
-
 	oh->_state = _HWMOD_STATE_DISABLED;
 
 	return 0;
@@ -3729,7 +3626,6 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
-	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
@@ -3762,7 +3658,6 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
-	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
-- 
2.10.2
