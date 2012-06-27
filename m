From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/3] ARM: omap: clk: add clk_prepare and clk_unprepare
Date: Wed, 27 Jun 2012 14:18:33 +0530
Message-ID: <1340786915-29507-2-git-send-email-rnayak@ti.com>
References: <1340786915-29507-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58056 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab2F0Iss (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 04:48:48 -0400
In-Reply-To: <1340786915-29507-1-git-send-email-rnayak@ti.com>
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
For a few others where there is a possibility they get called from
an interrupt or atomic context, there is an additonal clk_prepare()
done before a clk_enable() and a clk_unprepare()
after a clk_disable().
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
 arch/arm/mach-omap2/omap_hwmod.c       |    3 +++
 arch/arm/mach-omap2/pm24xx.c           |    2 ++
 arch/arm/mach-omap2/usb-fs.c           |    4 ++--
 9 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 502c31e..1d8c693 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -205,7 +205,7 @@ static inline void __init apollon_init_smc91x(void)
 		return;
 	}
 
-	clk_enable(gpmc_fck);
+	clk_prepare_enable(gpmc_fck);
 	rate = clk_get_rate(gpmc_fck);
 
 	eth_cs = APOLLON_ETH_CS;
@@ -249,7 +249,7 @@ static inline void __init apollon_init_smc91x(void)
 		gpmc_cs_free(APOLLON_ETH_CS);
 	}
 out:
-	clk_disable(gpmc_fck);
+	clk_disable_unprepare(gpmc_fck);
 	clk_put(gpmc_fck);
 }
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 876becf..a273af0 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -267,9 +267,9 @@ static inline void __init h4_init_debug(void)
 		return;
 	}
 
-	clk_enable(gpmc_fck);
+	clk_prepare_enable(gpmc_fck);
 	rate = clk_get_rate(gpmc_fck);
-	clk_disable(gpmc_fck);
+	clk_disable_unprepare(gpmc_fck);
 	clk_put(gpmc_fck);
 
 	if (is_gpmc_muxed())
@@ -313,7 +313,7 @@ static inline void __init h4_init_debug(void)
 		gpmc_cs_free(eth_cs);
 
 out:
-	clk_disable(gpmc_fck);
+	clk_disable_unprepare(gpmc_fck);
 	clk_put(gpmc_fck);
 }
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 982fb26..f0ea558 100644
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
index 5fb47a1..e5f8e48 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -471,7 +471,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
 		if (oc->_clk)
-			clk_enable(oc->_clk);
+			clk_prepare_enable(oc->_clk);
 
 	dispc_disable_outputs();
 
@@ -498,7 +498,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
 		if (oc->_clk)
-			clk_disable(oc->_clk);
+			clk_disable_unprepare(oc->_clk);
 
 	r = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2286410..a33f89d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -749,7 +749,7 @@ static int __init gpmc_init(void)
 		BUG();
 	}
 
-	clk_enable(gpmc_l3_clk);
+	clk_prepare_enable(gpmc_l3_clk);
 
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7731936..f904993 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -608,6 +608,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 			   oh->name, oh->main_clk);
 		return -EINVAL;
 	}
+	clk_prepare(oh->_clk);
 
 	if (!oh->_clk->clkdm)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
@@ -645,6 +646,7 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 			ret = -EINVAL;
 		}
 		os->_clk = c;
+		clk_prepare(os->_clk);
 	}
 
 	return ret;
@@ -672,6 +674,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 			ret = -EINVAL;
 		}
 		oc->_clk = c;
+		clk_prepare(oc->_clk);
 	}
 
 	return ret;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2edeffc..8eee8bc 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -340,11 +340,13 @@ int __init omap2_pm_init(void)
 		printk(KERN_ERR "could not get osc_ck\n");
 		return -ENODEV;
 	}
+	clk_prepare(osc_ck);
 
 	if (cpu_is_omap242x()) {
 		emul_ck = clk_get(NULL, "emul_ck");
 		if (IS_ERR(emul_ck)) {
 			printk(KERN_ERR "could not get emul_ck\n");
+			clk_unprepare(osc_ck);
 			clk_put(osc_ck);
 			return -ENODEV;
 		}
diff --git a/arch/arm/mach-omap2/usb-fs.c b/arch/arm/mach-omap2/usb-fs.c
index 1481078..cff7d24 100644
--- a/arch/arm/mach-omap2/usb-fs.c
+++ b/arch/arm/mach-omap2/usb-fs.c
@@ -344,7 +344,7 @@ void __init omap2_usbfs_init(struct omap_usb_config *pdata)
 	if (IS_ERR(ick))
 		return;
 
-	clk_enable(ick);
+	clk_prepare_enable(ick);
 	pdata->usb0_init = omap2_usb0_init;
 	pdata->usb1_init = omap2_usb1_init;
 	pdata->usb2_init = omap2_usb2_init;
@@ -352,7 +352,7 @@ void __init omap2_usbfs_init(struct omap_usb_config *pdata)
 	ohci_device_init(pdata);
 	otg_device_init(pdata);
 	omap_otg_init(pdata);
-	clk_disable(ick);
+	clk_disable_unprepare(ick);
 	clk_put(ick);
 }
 
-- 
1.7.1

