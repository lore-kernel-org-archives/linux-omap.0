From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 7/7] OMAP2+: hwmod: Follow the recommended PRCM module
 enable sequence
Date: Sat, 9 Jul 2011 02:15:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107090150040.15984@utopia.booyaka.com>
References: <1309555626-22608-1-git-send-email-b-cousson@ti.com> <1309555626-22608-8-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55272 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab1GIIPe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 04:15:34 -0400
In-Reply-To: <1309555626-22608-8-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> On OMAP4, the PRCM recommended sequence for enabling
> a module after power-on-reset is:
> -1- Force clkdm to SW_WKUP
> -2- Enabling the clocks
> -3- Configure desired module mode to "enable" or "auto"
> -4- Wait for the desired module idle status to be FUNC
> -5- Program clkdm in HW_AUTO(if supported)
> 
> This sequence applies to all older OMAPs' as well,
> however since they use autodeps, it makes sure that
> no clkdm is in IDLE, and hence not requiring a force
> SW_WKUP when a module is being enabled.
> 
> OMAP4 does not need to support autodeps, because
> of the dyanamic dependency feature, wherein
> the HW takes care of waking up a clockdomain from
> idle and hence the module, whenever an interconnect
> access happens to the given module.
> 
> Implementing the sequence for OMAP4 requires
> the clockdomain handling that is currently done in
> clock framework to be done as part of hwmod framework
> since the step -4- above to "Wait for the desired
> module idle status to be FUNC" is done as part of
> hwmod framework.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [b-cousson@ti.com: Adapt it to the new clkdm hwmod attribute and API]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

This patch breaks OMAP2/3.  It appears this version wasn't tested on 
either of those.  I'm not even sure it's 100% right for OMAP4 either, 
since we know that some of the "optional" clocks do factor into whether a 
clockdomain can go idle or not.  The current example we've been using is 
the GPIO debounce clock, but there are probably others too.  The 
impression I get from talking with people working on OMAP4, however, is 
that this approach to handling clockdomains fixes some big problems on 
OMAP4.  

So the clock framework part of this patch has been reimplemented as a 
separate patch.  The default is to preserve the OMAP2/3 behavior. The 
OMAP4 clock init code will be able to disable this during init.  This 
patch will be posted separately.

Then the remaining hwmod changes in this patch also need to be made 
conditional on whether oh->clkdm is non-null, otherwise the kernel won't 
work on OMAP2/3.  The updated patch is below.

Although I've chosen to clean up this patch this time to try to deal with 
some of the recent uncertainty, in the future, I'm not going to spend 
any time fixing series with patches that break OMAP2/3 boards.


- Paul


From: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 1 Jul 2011 23:27:06 +0200
Subject: [PATCH] OMAP2+: hwmod: Follow the recommended PRCM module enable
 sequence

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
[paul@pwsan.com: dropped mach-omap2/clock.c changes; modified to only
 call the clockdomain code if oh->clkdm is set; disable clock->clockdomain
 interaction on OMAP4]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod.c     |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..28b5de1 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3296,6 +3296,7 @@ int __init omap4xxx_clk_init(void)
 	}
 
 	clk_init(&omap2_clk_functions);
+	omap2_clk_disable_clkdm_control();
 
 	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
 									  c++)
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 293fa6c..e74b9c7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1223,6 +1223,7 @@ static int _reset(struct omap_hwmod *oh)
 static int _enable(struct omap_hwmod *oh)
 {
 	int r;
+	int hwsup = 0;
 
 	if (oh->_state != _HWMOD_STATE_INITIALIZED &&
 	    oh->_state != _HWMOD_STATE_IDLE &&
@@ -1250,10 +1251,33 @@ static int _enable(struct omap_hwmod *oh)
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
 
 	_add_initiator_dep(oh, mpu_oh);
+
+	if (oh->clkdm) {
+		/*
+		 * A clockdomain must be in SW_SUP before enabling
+		 * completely the module. The clockdomain can be set
+		 * in HW_AUTO only when the module become ready.
+		 */
+		hwsup = clkdm_in_hwsup(oh->clkdm);
+		r = clkdm_hwmod_enable(oh->clkdm, oh);
+		if (r) {
+			WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
+			     oh->name, oh->clkdm->name, r);
+			return r;
+		}
+	}
+
 	_enable_clocks(oh);
 
 	r = _wait_target_ready(oh);
 	if (!r) {
+		/*
+		 * Set the clockdomain to HW_AUTO only if the target is ready,
+		 * assuming that the previous state was HW_AUTO
+		 */
+		if (oh->clkdm && hwsup)
+			clkdm_allow_idle(oh->clkdm);
+
 		oh->_state = _HWMOD_STATE_ENABLED;
 
 		/* Access the sysconfig only if the target is ready */
@@ -1266,6 +1290,9 @@ static int _enable(struct omap_hwmod *oh)
 		_disable_clocks(oh);
 		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
 			 oh->name, r);
+
+		if (oh->clkdm)
+			clkdm_hwmod_disable(oh->clkdm, oh);
 	}
 
 	return r;
@@ -1293,6 +1320,8 @@ static int _idle(struct omap_hwmod *oh)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 	_disable_clocks(oh);
+	if (oh->clkdm)
+		clkdm_hwmod_disable(oh->clkdm, oh);
 
 	/* Mux pins for device idle if populated */
 	if (oh->mux && oh->mux->pads_dynamic)
@@ -1389,6 +1418,8 @@ static int _shutdown(struct omap_hwmod *oh)
 		_del_initiator_dep(oh, mpu_oh);
 		/* XXX what about the other system initiators here? dma, dsp */
 		_disable_clocks(oh);
+		if (oh->clkdm)
+			clkdm_hwmod_disable(oh->clkdm, oh);
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
-- 
1.7.5.4

