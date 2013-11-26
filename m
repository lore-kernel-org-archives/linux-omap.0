From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/12] ARM: OMAP2+: Remove legacy hwmod mux code
Date: Mon, 25 Nov 2013 16:14:25 -0800
Message-ID: <1385424867-27243-11-git-send-email-tony@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30297 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753634Ab3KZAOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 19:14:39 -0500
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

This is no longer needed when booted with device tree.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c    |   2 -
 arch/arm/mach-omap2/omap_hwmod.c | 160 +--------------------------------------
 2 files changed, 1 insertion(+), 161 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 0dd6398..8e85fa0 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -33,7 +33,6 @@
 
 #include "soc.h"
 #include "common.h"
-#include "mux.h"
 #include "control.h"
 #include "devices.h"
 #include "display.h"
@@ -278,7 +277,6 @@ int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 						name, oh->name);
 		return PTR_ERR(pdev);
 	}
-	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ee655da..b21449f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -160,7 +160,6 @@
 #include "prm44xx.h"
 #include "prm33xx.h"
 #include "prminst44xx.h"
-#include "mux.h"
 #include "pm.h"
 
 /* Name of the OMAP hwmod for the MPU */
@@ -205,9 +204,6 @@ static LIST_HEAD(omap_hwmod_list);
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
 
-/* io_chain_lock: used to serialize reconfigurations of the I/O chain */
-static DEFINE_SPINLOCK(io_chain_lock);
-
 /*
  * linkspace: ptr to a buffer that struct omap_hwmod_link records are
  * allocated from - used to reduce the number of small memory
@@ -539,51 +535,6 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
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
@@ -2006,32 +1957,6 @@ static int _reset(struct omap_hwmod *oh)
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
-	if (cpu_is_omap34xx() && omap3_has_io_chain_ctrl())
-		omap3xxx_prm_reconfigure_io_chain();
-	else if (cpu_is_omap44xx())
-		omap44xx_prm_reconfigure_io_chain();
-
-	spin_unlock_irqrestore(&io_chain_lock, flags);
-}
-
-/**
  * _omap4_update_context_lost - increment hwmod context loss counter if
  * hwmod context was lost, and clear hardware context loss reg
  * @oh: hwmod to check for context loss
@@ -2101,18 +2026,9 @@ static int _enable(struct omap_hwmod *oh)
 
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
@@ -2137,14 +2053,6 @@ static int _enable(struct omap_hwmod *oh)
 	if (_are_all_hardreset_lines_asserted(oh))
 		return 0;
 
-	/* Mux pins for device runtime if populated */
-	if (oh->mux && (!oh->mux->enabled ||
-			((oh->_state == _HWMOD_STATE_IDLE) &&
-			 oh->mux->pads_dynamic))) {
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
-		_reconfigure_io_chain();
-	}
-
 	_add_initiator_dep(oh, mpu_oh);
 
 	if (oh->clkdm) {
@@ -2245,12 +2153,6 @@ static int _idle(struct omap_hwmod *oh)
 	if (oh->clkdm)
 		clkdm_hwmod_disable(oh->clkdm, oh);
 
-	/* Mux pins for device idle if populated */
-	if (oh->mux && oh->mux->pads_dynamic) {
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
-		_reconfigure_io_chain();
-	}
-
 	oh->_state = _HWMOD_STATE_IDLE;
 
 	return 0;
@@ -2317,10 +2219,6 @@ static int _shutdown(struct omap_hwmod *oh)
 	for (i = 0; i < oh->rst_lines_cnt; i++)
 		_assert_hardreset(oh, oh->rst_lines[i].name);
 
-	/* Mux pins to safe mode or use populated off mode values */
-	if (oh->mux)
-		omap_hwmod_mux(oh->mux, _HWMOD_STATE_DISABLED);
-
 	oh->_state = _HWMOD_STATE_DISABLED;
 
 	return 0;
@@ -3864,7 +3762,6 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
-	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
@@ -3897,7 +3794,6 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
-	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
@@ -4120,60 +4016,6 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
 }
 
 /**
- * omap_hwmod_pad_route_irq - route an I/O pad wakeup to a particular MPU IRQ
- * @oh: struct omap_hwmod * containing hwmod mux entries
- * @pad_idx: array index in oh->mux of the hwmod mux entry to route wakeup
- * @irq_idx: the hwmod mpu_irqs array index of the IRQ to trigger on wakeup
- *
- * When an I/O pad wakeup arrives for the dynamic or wakeup hwmod mux
- * entry number @pad_idx for the hwmod @oh, trigger the interrupt
- * service routine for the hwmod's mpu_irqs array index @irq_idx.  If
- * this function is not called for a given pad_idx, then the ISR
- * associated with @oh's first MPU IRQ will be triggered when an I/O
- * pad wakeup occurs on that pad.  Note that @pad_idx is the index of
- * the _dynamic or wakeup_ entry: if there are other entries not
- * marked with OMAP_DEVICE_PAD_WAKEUP or OMAP_DEVICE_PAD_REMUX, these
- * entries are NOT COUNTED in the dynamic pad index.  This function
- * must be called separately for each pad that requires its interrupt
- * to be re-routed this way.  Returns -EINVAL if there is an argument
- * problem or if @oh does not have hwmod mux entries or MPU IRQs;
- * returns -ENOMEM if memory cannot be allocated; or 0 upon success.
- *
- * XXX This function interface is fragile.  Rather than using array
- * indexes, which are subject to unpredictable change, it should be
- * using hwmod IRQ names, and some other stable key for the hwmod mux
- * pad records.
- */
-int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx)
-{
-	int nr_irqs;
-
-	might_sleep();
-
-	if (!oh || !oh->mux || !oh->mpu_irqs || pad_idx < 0 ||
-	    pad_idx >= oh->mux->nr_pads_dynamic)
-		return -EINVAL;
-
-	/* Check the number of available mpu_irqs */
-	for (nr_irqs = 0; oh->mpu_irqs[nr_irqs].irq >= 0; nr_irqs++)
-		;
-
-	if (irq_idx >= nr_irqs)
-		return -EINVAL;
-
-	if (!oh->mux->irqs) {
-		/* XXX What frees this? */
-		oh->mux->irqs = kzalloc(sizeof(int) * oh->mux->nr_pads_dynamic,
-			GFP_KERNEL);
-		if (!oh->mux->irqs)
-			return -ENOMEM;
-	}
-	oh->mux->irqs[pad_idx] = irq_idx;
-
-	return 0;
-}
-
-/**
  * omap_hwmod_init - initialize the hwmod code
  *
  * Sets up some function pointers needed by the hwmod code to operate on the
-- 
1.8.1.1

