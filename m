From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 03/10] OMAP4: hwmod & CM: Implement the omap4_cm_wait_module_ready function
Date: Fri,  7 May 2010 17:44:08 +0200
Message-ID: <1273247055-15165-4-git-send-email-b-cousson@ti.com>
References: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab0EGPoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 11:44:23 -0400
In-Reply-To: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

The return of the omap4_cm_wait_module_ready function is checked
in order to avoid accessing the sysconfig register if the module is
not in the correct state.
In that case the _setup will exit without trying to reset
using sysconfig.
For the moment a warning is printed. A proper management of fclk
and module reset will have to be done in order to init correctly
the problematic IPs listed below.

  <4>omap_hwmod: ivahd: cannot be enabled (3)
  <4>omap_hwmod: iss: cannot be enabled (3)
  <4>omap_hwmod: tesla: cannot be enabled (3)
  <4>omap_hwmod: sdma: cannot be enabled (3)
  <4>omap_hwmod: sl2: cannot be enabled (3)
  <4>omap_hwmod: sad2d: cannot be enabled (3)
  <4>omap_hwmod: ducati: cannot be enabled (3)

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm.h         |    2 +-
 arch/arm/mach-omap2/cm4xxx.c     |   36 +++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod.c |   33 ++++++++++++++++++++-------------
 3 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index cd34036..b74ad98 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -112,7 +112,7 @@ extern u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 
 extern int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
 				      u8 idlest_shift);
-extern int omap4_cm_wait_module_ready(u32 prcm_mod, u8 prcm_dev_offs);
+extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);
 
 static inline u32 cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
diff --git a/arch/arm/mach-omap2/cm4xxx.c b/arch/arm/mach-omap2/cm4xxx.c
index af32a45..b101091 100644
--- a/arch/arm/mach-omap2/cm4xxx.c
+++ b/arch/arm/mach-omap2/cm4xxx.c
@@ -21,19 +21,41 @@
 
 #include <asm/atomic.h>
 
+#include <plat/common.h>
+
 #include "cm.h"
 #include "cm-regbits-44xx.h"
 
 /**
- * omap4_cm_wait_idlest_ready - wait for a module to leave idle or standby
- * @prcm_mod: PRCM module offset (XXX example)
- * @prcm_dev_offs: PRCM device offset (e.g. MCASP XXX example)
+ * omap4_cm_wait_module_ready - wait for a module to be in 'func' state
+ * @clkctrl_reg: CLKCTRL module address
+ *
+ * Wait for the module IDLEST to be functional. If the idle state is in any
+ * the non functional state (trans, idle or disabled), module and thus the
+ * sysconfig cannot be accessed and will probably lead to an "imprecise
+ * external abort"
+ *
+ * Module idle state:
+ *   0x0 func:     Module is fully functional, including OCP
+ *   0x1 trans:    Module is performing transition: wakeup, or sleep, or sleep
+ *                 abortion
+ *   0x2 idle:     Module is in Idle mode (only OCP part). It is functional if
+ *                 using separate functional clock
+ *   0x3 disabled: Module is disabled and cannot be accessed
  *
- * XXX document
+ * TODO: Need to handle module accessible in idle state
  */
-int omap4_cm_wait_idlest_ready(u32 prcm_mod, u8 prcm_dev_offs)
+int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
 {
-	/* FIXME: Add clock manager related code */
-	return 0;
+	int i = 0;
+
+	if (!clkctrl_reg)
+		return 0;
+
+	omap_test_timeout(((__raw_readl(clkctrl_reg) &
+			    OMAP4430_IDLEST_MASK) == 0),
+			  MAX_MODULE_READY_TIME, i);
+
+	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e436dcb..4a134c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -819,11 +819,8 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
 						 oh->prcm.omap2.idlest_reg_id,
 						 oh->prcm.omap2.idlest_idle_bit);
-#if 0
 	} else if (cpu_is_omap44xx()) {
-		ret = omap4_cm_wait_module_ready(oh->prcm.omap4.module_offs,
-						 oh->prcm.omap4.device_offs);
-#endif
+		ret = omap4_cm_wait_module_ready(oh->prcm.omap4.clkctrl_reg);
 	} else {
 		BUG();
 	};
@@ -912,16 +909,21 @@ static int _enable(struct omap_hwmod *oh)
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
 
-	if (oh->class->sysc) {
-		if (!(oh->_int_flags & _HWMOD_SYSCONFIG_LOADED))
-			_update_sysc_cache(oh);
-		_sysc_enable(oh);
-	}
-
 	r = _wait_target_ready(oh);
-	if (!r)
+	if (!r) {
 		oh->_state = _HWMOD_STATE_ENABLED;
 
+		/* Access the sysconfig only if the target is ready */
+		if (oh->class->sysc) {
+			if (!(oh->_int_flags & _HWMOD_SYSCONFIG_LOADED))
+				_update_sysc_cache(oh);
+			_sysc_enable(oh);
+		}
+	} else {
+		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
+			 oh->name, r);
+	}
+
 	return r;
 }
 
@@ -999,7 +1001,7 @@ static int _shutdown(struct omap_hwmod *oh)
 static int _setup(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
-	int i;
+	int i, r;
 
 	if (!oh)
 		return -EINVAL;
@@ -1023,7 +1025,12 @@ static int _setup(struct omap_hwmod *oh)
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
-	_enable(oh);
+	r = _enable(oh);
+	if (r) {
+		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
+			   oh->name, oh->_state);
+		return 0;
+	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
 		/*
-- 
1.6.1.3

