From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 7/7] OMAP2+: hwmod: Follow the recommended PRCM module enable sequence
Date: Fri, 24 Jun 2011 14:06:33 +0200
Message-ID: <1308917193-16912-8-git-send-email-b-cousson@ti.com>
References: <1308917193-16912-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54282 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768Ab1FXMIo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 08:08:44 -0400
In-Reply-To: <1308917193-16912-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

From: Nayak, Rajendra <rnayak@ti.com>

On OMAP4, the PRCM recommended sequence for enabling
a module after power-on-reset is:
-1- Force clkdm to SW_WKUP
-2- Enabling the clocks
-3- Configure desired module mode to "enable" or "auto"
-4- Wait for the desired module idle status to be FUNC
-5- Program clkdm in HW_AUTO(if supported)

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
since the step -4- above to "Wait for the desired
module idle status to be FUNC" is done as part of
hwmod framework.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[b-cousson@ti.com: Adapt it to the new clkdm hwmod attribute and API]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c           |   17 +----------------
 arch/arm/mach-omap2/clockdomain44xx.c |    9 +--------
 arch/arm/mach-omap2/omap_hwmod.c      |   28 ++++++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 26 deletions(-)

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
index 6b144c4..cb85f65 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1360,6 +1360,7 @@ static int _reset(struct omap_hwmod *oh)
 static int _enable(struct omap_hwmod *oh)
 {
 	int r;
+	int hwsup = 0;
 
 	if (oh->_state != _HWMOD_STATE_INITIALIZED &&
 	    oh->_state != _HWMOD_STATE_IDLE &&
@@ -1378,6 +1379,19 @@ static int _enable(struct omap_hwmod *oh)
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 
 	_add_initiator_dep(oh, mpu_oh);
+
+	/*
+	 * A clockdomain must be in SW_SUP before enabling completely the
+	 * module. The clockdomain can be set in HW_AUTO only when the module
+	 * become ready.
+	 */
+	hwsup = clkdm_is_idle(oh->clkdm);
+	r = clkdm_hwmod_enable(oh->clkdm, oh);
+	if (r) {
+		WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
+		     oh->name, oh->clkdm->name, r);
+		return r;
+	}
 	_enable_clocks(oh);
 	_enable_module(oh);
 
@@ -1392,6 +1406,13 @@ static int _enable(struct omap_hwmod *oh)
 
 	r = _wait_target_ready(oh);
 	if (!r) {
+		/*
+		 * Set the clockdomain to HW_AUTO only if the target is ready,
+		 * assuming that the previous state was HW_AUTO
+		 */
+		if (hwsup)
+			clkdm_allow_idle(oh->clkdm);
+
 		oh->_state = _HWMOD_STATE_ENABLED;
 
 		/* Access the sysconfig only if the target is ready */
@@ -1402,8 +1423,9 @@ static int _enable(struct omap_hwmod *oh)
 		}
 	} else {
 		_disable_clocks(oh);
-		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
-			 oh->name, r);
+		clkdm_hwmod_disable(oh->clkdm, oh);
+		pr_warning("omap_hwmod: %s: _wait_target_ready failed: %d\n",
+			   oh->name, r);
 	}
 
 	return r;
@@ -1444,6 +1466,7 @@ static int _idle(struct omap_hwmod *oh)
 	 * transition to complete properly.
 	 */
 	_disable_clocks(oh);
+	clkdm_hwmod_disable(oh->clkdm, oh);
 
 	/* Mux pins for device idle if populated */
 	if (oh->mux && oh->mux->pads_dynamic)
@@ -1541,6 +1564,7 @@ static int _shutdown(struct omap_hwmod *oh)
 			pr_warning("omap_hwmod: %s: _wait_target_disable failed\n",
 				   oh->name);
 		_disable_clocks(oh);
+		clkdm_hwmod_disable(oh->clkdm, oh);
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
-- 
1.7.0.4

