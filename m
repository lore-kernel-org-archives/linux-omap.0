From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 04/29] ARM: omap: clk: use clk_prepare_enable and clk_disable_unprepare
Date: Thu, 14 Jun 2012 18:16:53 +0530
Message-ID: <1339678038-23082-5-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39624 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755876Ab2FNMrj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:47:39 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

As we move to Common clk framework use clk_prepare_enable()
instead of clk_enable() and similarly clk_disable_unprepare()
instead of clk_disable()

Based on initial changes from Mike turquette.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-apollon.c     |    4 ++--
 arch/arm/mach-omap2/board-h4.c          |    6 +++---
 arch/arm/mach-omap2/board-omap4panda.c  |    2 +-
 arch/arm/mach-omap2/clock3xxx.c         |    8 ++++----
 arch/arm/mach-omap2/display.c           |    4 ++--
 arch/arm/mach-omap2/gpmc.c              |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c        |   14 +++++++-------
 arch/arm/mach-omap2/omap_phy_internal.c |   12 ++++++------
 arch/arm/mach-omap2/pm24xx.c            |    4 ++--
 arch/arm/mach-omap2/usb-fs.c            |    4 ++--
 10 files changed, 30 insertions(+), 30 deletions(-)

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
index bf86f7e..b46ae17 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -693,7 +693,7 @@ static int _enable_clocks(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
 
 	if (oh->_clk)
-		clk_enable(oh->_clk);
+		clk_prepare_enable(oh->_clk);
 
 	p = oh->slave_ports.next;
 
@@ -701,7 +701,7 @@ static int _enable_clocks(struct omap_hwmod *oh)
 		os = _fetch_next_ocp_if(&p, &i);
 
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
-			clk_enable(os->_clk);
+			clk_prepare_enable(os->_clk);
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -724,7 +724,7 @@ static int _disable_clocks(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
 
 	if (oh->_clk)
-		clk_disable(oh->_clk);
+		clk_disable_unprepare(oh->_clk);
 
 	p = oh->slave_ports.next;
 
@@ -732,7 +732,7 @@ static int _disable_clocks(struct omap_hwmod *oh)
 		os = _fetch_next_ocp_if(&p, &i);
 
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
-			clk_disable(os->_clk);
+			clk_disable_unprepare(os->_clk);
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -751,7 +751,7 @@ static void _enable_optional_clocks(struct omap_hwmod *oh)
 		if (oc->_clk) {
 			pr_debug("omap_hwmod: enable %s:%s\n", oc->role,
 				 oc->_clk->name);
-			clk_enable(oc->_clk);
+			clk_prepare_enable(oc->_clk);
 		}
 }
 
@@ -766,7 +766,7 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 		if (oc->_clk) {
 			pr_debug("omap_hwmod: disable %s:%s\n", oc->role,
 				 oc->_clk->name);
-			clk_disable(oc->_clk);
+			clk_disable_unprepare(oc->_clk);
 		}
 }
 
@@ -2095,7 +2095,7 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 			/* XXX omap_iclk_deny_idle(c); */
 		} else {
 			/* XXX omap_iclk_allow_idle(c); */
-			clk_enable(os->_clk);
+			clk_prepare_enable(os->_clk);
 		}
 	}
 
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 4c90477..7d69f8e 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -93,15 +93,15 @@ int omap4430_phy_set_clk(struct device *dev, int on)
 
 	if (on && !state) {
 		/* Enable the phy clocks */
-		clk_enable(phyclk);
-		clk_enable(clk48m);
-		clk_enable(clk32k);
+		clk_prepare_enable(phyclk);
+		clk_prepare_enable(clk48m);
+		clk_prepare_enable(clk32k);
 		state = 1;
 	} else if (state) {
 		/* Disable the phy clocks */
-		clk_disable(phyclk);
-		clk_disable(clk48m);
-		clk_disable(clk32k);
+		clk_disable_unprepare(phyclk);
+		clk_disable_unprepare(clk48m);
+		clk_disable_unprepare(clk32k);
 		state = 0;
 	}
 	return 0;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2edeffc..be50b88 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -81,7 +81,7 @@ static int omap2_enter_full_retention(void)
 	 * oscillator itself it will be disabled if/when we enter retention
 	 * mode.
 	 */
-	clk_disable(osc_ck);
+	clk_disable_unprepare(osc_ck);
 
 	/* Clear old wake-up events */
 	/* REVISIT: These write to reserved bits? */
@@ -115,7 +115,7 @@ static int omap2_enter_full_retention(void)
 no_sleep:
 	omap2_gpio_resume_after_idle();
 
-	clk_enable(osc_ck);
+	clk_prepare_enable(osc_ck);
 
 	/* clear CORE wake-up events */
 	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
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

