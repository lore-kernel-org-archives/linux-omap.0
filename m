From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v4 1/3] ARM: omap: clk: add clk_prepare and clk_unprepare
Date: Wed, 29 Aug 2012 14:26:14 +0530
Message-ID: <1346230576-20004-2-git-send-email-rnayak@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50856 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab2H2I4p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 04:56:45 -0400
In-Reply-To: <1346230576-20004-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

As part of Common Clk Framework (CCF) the clk_enable() operation
was split into a clk_prepare() which could sleep, and a clk_enable()
which should never sleep. Similarly the clk_disable() was
split into clk_disable() and clk_unprepare(). This was
needed to handle complex cases where in a clk gate/ungate
would require a slow and a fast part to be implemented.
None of the clocks below seem to be in the 'complex' clocks
category and are just simple clocks which are enabled/disabled
through simple register writes.
Most of the instances also seem to be called in non-atomic
context which means its safe to move all of those from
using a clk_enable() to clk_prepare_enable() and clk_disable() to
clk_disable_unprepare().

For some others, mainly the ones handled through the hwmod framework
there is a possibility that they get called in either an atomic
or a non-atomic context.

The way these get handled below work only as long as clk_prepare
is implemented as a no-op (which is the case today) since this gets
called very early at boot while most subsystems are unavailable.
Hence these are marked with a *HACK* comment, which says we need
to re-visit these once we start doing something meaningful with
clk_prepare/clk_unprepare like doing voltage scaling or something
that involves i2c.

This is in preparation of OMAP moving to CCF.

Based on initial changes from Mike turquette.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-apollon.c    |    4 ++--
 arch/arm/mach-omap2/board-h4.c         |    6 +++---
 arch/arm/mach-omap2/board-omap4panda.c |    2 +-
 arch/arm/mach-omap2/clock3xxx.c        |    8 ++++----
 arch/arm/mach-omap2/display.c          |    4 ++--
 arch/arm/mach-omap2/gpmc.c             |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c       |   27 +++++++++++++++++++++++++++
 7 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index e5fa46b..25e8f2f 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -204,7 +204,7 @@ static inline void __init apollon_init_smc91x(void)
 		return;
 	}
 
-	clk_enable(gpmc_fck);
+	clk_prepare_enable(gpmc_fck);
 	rate = clk_get_rate(gpmc_fck);
 
 	eth_cs = APOLLON_ETH_CS;
@@ -248,7 +248,7 @@ static inline void __init apollon_init_smc91x(void)
 		gpmc_cs_free(APOLLON_ETH_CS);
 	}
 out:
-	clk_disable(gpmc_fck);
+	clk_disable_unprepare(gpmc_fck);
 	clk_put(gpmc_fck);
 }
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index ace2048..bd08bef 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -266,9 +266,9 @@ static inline void __init h4_init_debug(void)
 		return;
 	}
 
-	clk_enable(gpmc_fck);
+	clk_prepare_enable(gpmc_fck);
 	rate = clk_get_rate(gpmc_fck);
-	clk_disable(gpmc_fck);
+	clk_disable_unprepare(gpmc_fck);
 	clk_put(gpmc_fck);
 
 	if (is_gpmc_muxed())
@@ -312,7 +312,7 @@ static inline void __init h4_init_debug(void)
 		gpmc_cs_free(eth_cs);
 
 out:
-	clk_disable(gpmc_fck);
+	clk_disable_unprepare(gpmc_fck);
 	clk_put(gpmc_fck);
 }
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 70f6d1d..86c2201 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -172,7 +172,7 @@ static void __init omap4_ehci_init(void)
 		return;
 	}
 	clk_set_rate(phy_ref_clk, 19200000);
-	clk_enable(phy_ref_clk);
+	clk_prepare_enable(phy_ref_clk);
 
 	/* disable the power to the usb hub prior to init and reset phy+hub */
 	ret = gpio_request_array(panda_ehci_gpios,
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 794d827..4c1591a 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -64,15 +64,15 @@ void __init omap3_clk_lock_dpll5(void)
 
 	dpll5_clk = clk_get(NULL, "dpll5_ck");
 	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
-	clk_enable(dpll5_clk);
+	clk_prepare_enable(dpll5_clk);
 
 	/* Program dpll5_m2_clk divider for no division */
 	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
-	clk_enable(dpll5_m2_clk);
+	clk_prepare_enable(dpll5_m2_clk);
 	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
 
-	clk_disable(dpll5_m2_clk);
-	clk_disable(dpll5_clk);
+	clk_disable_unprepare(dpll5_m2_clk);
+	clk_disable_unprepare(dpll5_clk);
 	return;
 }
 
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index af1ed7d..5a3afd2 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -488,7 +488,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
 		if (oc->_clk)
-			clk_enable(oc->_clk);
+			clk_prepare_enable(oc->_clk);
 
 	dispc_disable_outputs();
 
@@ -515,7 +515,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
 		if (oc->_clk)
-			clk_disable(oc->_clk);
+			clk_disable_unprepare(oc->_clk);
 
 	r = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index b2b5759..a14d650c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -750,7 +750,7 @@ static int __init gpmc_init(void)
 		BUG();
 	}
 
-	clk_enable(gpmc_l3_clk);
+	clk_prepare_enable(gpmc_l3_clk);
 
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6ca8e51..fb3e110 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -683,6 +683,15 @@ static int _init_main_clk(struct omap_hwmod *oh)
 			   oh->name, oh->main_clk);
 		return -EINVAL;
 	}
+	/*
+	 * HACK: This needs a re-visit once clk_prepare() is implemented
+	 * to do something meaningful. Today its just a no-op.
+	 * If clk_prepare() is used at some point to do things like
+	 * voltage scaling etc, then this would have to be moved to
+	 * some point where subsystems like i2c and pmic become
+	 * available.
+	 */
+	clk_prepare(oh->_clk);
 
 	if (!oh->_clk->clkdm)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
@@ -720,6 +729,15 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 			ret = -EINVAL;
 		}
 		os->_clk = c;
+		/*
+		 * HACK: This needs a re-visit once clk_prepare() is implemented
+		 * to do something meaningful. Today its just a no-op.
+		 * If clk_prepare() is used at some point to do things like
+		 * voltage scaling etc, then this would have to be moved to
+		 * some point where subsystems like i2c and pmic become
+		 * available.
+		 */
+		clk_prepare(os->_clk);
 	}
 
 	return ret;
@@ -747,6 +765,15 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 			ret = -EINVAL;
 		}
 		oc->_clk = c;
+		/*
+		 * HACK: This needs a re-visit once clk_prepare() is implemented
+		 * to do something meaningful. Today its just a no-op.
+		 * If clk_prepare() is used at some point to do things like
+		 * voltage scaling etc, then this would have to be moved to
+		 * some point where subsystems like i2c and pmic become
+		 * available.
+		 */
+		clk_prepare(oc->_clk);
 	}
 
 	return ret;
-- 
1.7.9.5

