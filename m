From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/6] ARM: OMAP2+: hwmod: use init-time function pointer
 for wait_target_ready
Date: Mon, 30 Apr 2012 08:33:27 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204300829310.10308@utopia.booyaka.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com> <1335557140-10854-5-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46983 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862Ab2D3Od2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 10:33:28 -0400
In-Reply-To: <1335557140-10854-5-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Fri, 27 Apr 2012, Kevin Hilman wrote:

> Rather than using cpu_is* checking at runtime, initialize an SoC specific
> function pointer for wait_target_ready().
> 
> While here, downgrade the BUG() to a WARN_ON() so it gives a noisy
> warning instead of causing a kernel panic.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

I've added some kerneldoc for each of these functions.  I'm trying to 
ensure that kerneldoc is present for all of the functions and structures 
that are added to code that I have to deal with, so it would be really 
great to have kerneldoc added on future patches :-)

Also the function pointers added here have been moved to the soc_ops 
structure created by earlier patches, and the wait_module_disable code has 
been integrated with the calling function and renamed to 
*_wait_target_disable(), which is slightly more descriptive in this case.
Please let me know if you have any comments.


- Paul

From: Kevin Hilman <khilman@ti.com>
Date: Fri, 27 Apr 2012 13:05:38 -0700
Subject: [PATCH 4/6] ARM: OMAP2+: hwmod: use init-time function pointer for
 wait_target_ready

Rather than using cpu_is* checking at runtime, initialize an SoC specific
function pointer for wait_target_ready().

While here, downgrade the BUG() to a WARN_ON() so it gives a noisy
warning instead of causing a kernel panic.

Signed-off-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: convert to use soc_ops function pointers; add kerneldoc;
 move soc_ops functions to their own section in the code; integrated
 the _wait_target_ready() function with the OMAP2/OMAP4 variants;
 renamed the wait_module_ready field to wait_target_ready]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  115 ++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2b84583..d1f784c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -178,6 +178,7 @@
 struct omap_hwmod_soc_ops {
 	void (*enable_module)(struct omap_hwmod *oh);
 	int (*disable_module)(struct omap_hwmod *oh);
+	int (*wait_target_ready)(struct omap_hwmod *oh);
 };
 
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -1362,53 +1363,6 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 }
 
 /**
- * _wait_target_ready - wait for a module to leave slave idle
- * @oh: struct omap_hwmod *
- *
- * Wait for a module @oh to leave slave idle.  Returns 0 if the module
- * does not have an IDLEST bit or if the module successfully leaves
- * slave idle; otherwise, pass along the return value of the
- * appropriate *_cm*_wait_module_ready() function.
- */
-static int _wait_target_ready(struct omap_hwmod *oh)
-{
-	struct omap_hwmod_ocp_if *os;
-	int ret;
-
-	if (!oh)
-		return -EINVAL;
-
-	if (oh->flags & HWMOD_NO_IDLEST)
-		return 0;
-
-	os = _find_mpu_rt_port(oh);
-	if (!os)
-		return 0;
-
-	/* XXX check module SIDLEMODE */
-
-	/* XXX check clock enable states */
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-						 oh->prcm.omap2.idlest_reg_id,
-						 oh->prcm.omap2.idlest_idle_bit);
-	} else if (cpu_is_omap44xx()) {
-		if (!oh->clkdm)
-			return -EINVAL;
-
-		ret = omap4_cminst_wait_module_ready(oh->clkdm->prcm_partition,
-						     oh->clkdm->cm_inst,
-						     oh->clkdm->clkdm_offs,
-						     oh->prcm.omap4.clkctrl_offs);
-	} else {
-		BUG();
-	};
-
-	return ret;
-}
-
-/**
  * _lookup_hardreset - fill register bit info for this hwmod/reset line
  * @oh: struct omap_hwmod *
  * @name: name of the reset line in the context of this hwmod
@@ -1826,7 +1780,8 @@ static int _enable(struct omap_hwmod *oh)
 	if (soc_ops.enable_module)
 		soc_ops.enable_module(oh);
 
-	r = _wait_target_ready(oh);
+	r = (soc_ops.wait_target_ready) ? soc_ops.wait_target_ready(oh) :
+		-EINVAL;
 	if (!r) {
 		/*
 		 * Set the clockdomain to HW_AUTO only if the target is ready,
@@ -2443,6 +2398,63 @@ static int __init _alloc_linkspace(struct omap_hwmod_ocp_if **ois)
 	return 0;
 }
 
+/* Static functions intended only for use in soc_ops field function pointers */
+
+/**
+ * _omap2_wait_target_ready - wait for a module to leave slave idle
+ * @oh: struct omap_hwmod *
+ *
+ * Wait for a module @oh to leave slave idle.  Returns 0 if the module
+ * does not have an IDLEST bit or if the module successfully leaves
+ * slave idle; otherwise, pass along the return value of the
+ * appropriate *_cm*_wait_module_ready() function.
+ */
+static int _omap2_wait_target_ready(struct omap_hwmod *oh)
+{
+	if (!oh)
+		return -EINVAL;
+
+	if (oh->flags & HWMOD_NO_IDLEST)
+		return 0;
+
+	if (!_find_mpu_rt_port(oh))
+		return 0;
+
+	/* XXX check module SIDLEMODE, hardreset status, enabled clocks */
+
+	return omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
+					  oh->prcm.omap2.idlest_reg_id,
+					  oh->prcm.omap2.idlest_idle_bit);
+}
+
+/**
+ * _omap4_wait_target_ready - wait for a module to leave slave idle
+ * @oh: struct omap_hwmod *
+ *
+ * Wait for a module @oh to leave slave idle.  Returns 0 if the module
+ * does not have an IDLEST bit or if the module successfully leaves
+ * slave idle; otherwise, pass along the return value of the
+ * appropriate *_cm*_wait_module_ready() function.
+ */
+static int _omap4_wait_target_ready(struct omap_hwmod *oh)
+{
+	if (!oh || !oh->clkdm)
+		return -EINVAL;
+
+	if (oh->flags & HWMOD_NO_IDLEST)
+		return 0;
+
+	if (!_find_mpu_rt_port(oh))
+		return 0;
+
+	/* XXX check module SIDLEMODE, hardreset status */
+
+	return omap4_cminst_wait_module_ready(oh->clkdm->prcm_partition,
+					      oh->clkdm->cm_inst,
+					      oh->clkdm->clkdm_offs,
+					      oh->prcm.omap4.clkctrl_offs);
+}
+
 /* Public functions */
 
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
@@ -3429,9 +3441,14 @@ int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx)
  */
 void __init omap_hwmod_init(void)
 {
-	if (cpu_is_omap44xx()) {
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		soc_ops.wait_target_ready = _omap2_wait_target_ready;
+	} else if (cpu_is_omap44xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
+		soc_ops.wait_target_ready = _omap4_wait_target_ready;
+	} else {
+		WARN(1, "omap_hwmod: unknown SoC type\n");
 	}
 
 	inited = true;
-- 
1.7.10


- Paul
