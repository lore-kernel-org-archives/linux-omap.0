From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 6/8] OMAP2+: hwmod: Follow the recomended PRCM clock enable sequence
Date: Thu, 9 Jun 2011 16:24:11 +0530
Message-ID: <1307616853-28395-7-git-send-email-rnayak@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
 <1307616853-28395-2-git-send-email-rnayak@ti.com>
 <1307616853-28395-3-git-send-email-rnayak@ti.com>
 <1307616853-28395-4-git-send-email-rnayak@ti.com>
 <1307616853-28395-5-git-send-email-rnayak@ti.com>
 <1307616853-28395-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49954 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757227Ab1FIKyd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jun 2011 06:54:33 -0400
In-Reply-To: <1307616853-28395-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On OMAP4, the PRCM recommended sequence for enabling
a module after power-on-reset is
-1- Force clkdm to SW_WKUP
-2- Configure desired module mode to "enable" or "auto"
-3- Wait for the desired module idle status to be FUNC
-4- Program clkdm in HW_AUTO(if supported)

This sequence applies to all older OMAPs' as well,
however since they use autodeps, it makes sure that
no clkdm is in IDLE, and hence not requiring a force
SW_WKUP when a module is being enabled.

OMAP4 does not need to support autodeps, because
of the dyanamic dependency feature, wherein
the HW takes care of waking up a clockdomain from
idle and hence the module, whenever an interconnect
access happens to the given module.

Implementing the sequence for OMAP4 requires
the clockdomain handling that is currently done in
clock framework to be done as part of hwmod framework
since the step -3- above to "Wait for the desired
module idle status to be FUNC" is done as part of
hwmod framework.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c           |   17 +----------------
 arch/arm/mach-omap2/clockdomain.c     |    7 ++++++-
 arch/arm/mach-omap2/clockdomain44xx.c |    9 +--------
 arch/arm/mach-omap2/omap_hwmod.c      |   20 +++++++++++++++++++-
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 180299e..2828d29 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -268,9 +268,6 @@ void omap2_clk_disable(struct clk *clk)
 		clk->ops->disable(clk);
 	}
 
-	if (clk->clkdm)
-		clkdm_clk_disable(clk->clkdm, clk);
-
 	if (clk->parent)
 		omap2_clk_disable(clk->parent);
 }
@@ -308,30 +305,18 @@ int omap2_clk_enable(struct clk *clk)
 		}
 	}
 
-	if (clk->clkdm) {
-		ret = clkdm_clk_enable(clk->clkdm, clk);
-		if (ret) {
-			WARN(1, "clock: %s: could not enable clockdomain %s: "
-			     "%d\n", clk->name, clk->clkdm->name, ret);
-			goto oce_err2;
-		}
-	}
-
 	if (clk->ops && clk->ops->enable) {
 		trace_clock_enable(clk->name, 1, smp_processor_id());
 		ret = clk->ops->enable(clk);
 		if (ret) {
 			WARN(1, "clock: %s: could not enable: %d\n",
 			     clk->name, ret);
-			goto oce_err3;
+			goto oce_err2;
 		}
 	}
 
 	return 0;
 
-oce_err3:
-	if (clk->clkdm)
-		clkdm_clk_disable(clk->clkdm, clk);
 oce_err2:
 	if (clk->parent)
 		omap2_clk_disable(clk->parent);
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 2ab3686..b98a972 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -846,7 +846,12 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	if (!arch_clkdm || !arch_clkdm->clkdm_clk_enable)
 		return -EINVAL;
 
-	if (atomic_inc_return(&clkdm->usecount) > 1)
+	/*
+	 * For arch's with no autodeps, clkcm_clk_enable
+	 * should be called for every clock instance that is
+	 * enabled, so the clkdm can be force woken up.
+	 */
+	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps)
 		return 0;
 
 	/* Clockdomain now has one enabled downstream clock */
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index 4b10727..e4b8e06 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -101,14 +101,7 @@ static int omap4_clkdm_is_idle(struct clockdomain *clkdm)
 
 static int omap4_clkdm_clk_enable(struct clockdomain *clkdm)
 {
-	bool hwsup = false;
-
-	hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
-					clkdm->cm_inst, clkdm->clkdm_offs);
-
-	if (!hwsup)
-		clkdm_wakeup(clkdm);
-
+	clkdm_wakeup(clkdm);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e034294..ef709a5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1223,6 +1223,7 @@ static int _reset(struct omap_hwmod *oh)
 static int _enable(struct omap_hwmod *oh)
 {
 	int r;
+	int hwsup = 0;
 
 	if (oh->_state != _HWMOD_STATE_INITIALIZED &&
 	    oh->_state != _HWMOD_STATE_IDLE &&
@@ -1250,10 +1251,21 @@ static int _enable(struct omap_hwmod *oh)
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 
 	_add_initiator_dep(oh, mpu_oh);
+	if (oh->_clk && oh->_clk->clkdm) {
+		hwsup = clkdm_is_idle(oh->_clk->clkdm);
+		r = clkdm_clk_enable(oh->_clk->clkdm, oh->_clk);
+		if (r) {
+			WARN(1, "clock: %s: could not enable clockdomain %s: "
+			     "%d\n", oh->_clk->name, oh->_clk->clkdm->name, r);
+			return r;
+		}
+	}
 	_enable_clocks(oh);
-
 	r = _wait_target_ready(oh);
 	if (!r) {
+		if (oh->_clk && oh->_clk->clkdm && hwsup)
+			clkdm_allow_idle(oh->_clk->clkdm);
+
 		oh->_state = _HWMOD_STATE_ENABLED;
 
 		/* Access the sysconfig only if the target is ready */
@@ -1264,6 +1276,8 @@ static int _enable(struct omap_hwmod *oh)
 		}
 	} else {
 		_disable_clocks(oh);
+		if (oh->_clk && oh->_clk->clkdm)
+			clkdm_clk_disable(oh->_clk->clkdm, oh->_clk);
 		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
 			 oh->name, r);
 	}
@@ -1293,6 +1307,8 @@ static int _idle(struct omap_hwmod *oh)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 	_disable_clocks(oh);
+	if (oh->_clk && oh->_clk->clkdm)
+		clkdm_clk_disable(oh->_clk->clkdm, oh->_clk);
 
 	/* Mux pins for device idle if populated */
 	if (oh->mux && oh->mux->pads_dynamic)
@@ -1389,6 +1405,8 @@ static int _shutdown(struct omap_hwmod *oh)
 		_del_initiator_dep(oh, mpu_oh);
 		/* XXX what about the other system initiators here? dma, dsp */
 		_disable_clocks(oh);
+		if (oh->_clk && oh->_clk->clkdm)
+			clkdm_clk_disable(oh->_clk->clkdm, oh->_clk);
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
-- 
1.7.0.4

