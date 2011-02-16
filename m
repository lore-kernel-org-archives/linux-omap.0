From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/11] OMAP2+: clock: disable autoidle on all clocks during
	clock init
Date: Tue, 15 Feb 2011 23:52:43 -0700
Message-ID: <20110216065239.22089.24784.stgit@twilight.localdomain>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47505 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab1BPGyD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 01:54:03 -0500
In-Reply-To: <20110216065030.22089.61217.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Disable autoidle on all clocks during clock framework initialization.
(If CONFIG_PM is set, autoidle is re-enabled for all clocks later in
the boot process.)

The principle behind this patch, and some similar patches, is that the
kernel should start with all power management features disabled.
Later in the boot process, the PM code, if compiled in with CONFIG_PM,
enables or re-enables power management features.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    3 +++
 arch/arm/mach-omap2/clock2430_data.c |    3 +++
 arch/arm/mach-omap2/clock3xxx.c      |    3 ---
 arch/arm/mach-omap2/clock3xxx_data.c |    6 +++++-
 arch/arm/mach-omap2/clock44xx_data.c |    3 +++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 0a992bc..ee73e14 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1913,6 +1913,9 @@ int __init omap2420_clk_init(void)
 		omap2_init_clk_clkdm(c->lk.clk);
 	}
 
+	/* Disable autoidle on all clocks; let the PM code enable it later */
+	omap_clk_disable_autoidle_all();
+
 	/* Check the MPU rate set by bootloader */
 	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index c047dcd..a1298e5 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -2028,6 +2028,9 @@ int __init omap2430_clk_init(void)
 		omap2_init_clk_clkdm(c->lk.clk);
 	}
 
+	/* Disable autoidle on all clocks; let the PM code enable it later */
+	omap_clk_disable_autoidle_all();
+
 	/* Check the MPU rate set by bootloader */
 	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index e9f66b6..952c3e0 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -65,9 +65,6 @@ void __init omap3_clk_lock_dpll5(void)
 	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
 	clk_enable(dpll5_clk);
 
-	/* Enable autoidle to allow it to enter low power bypass */
-	omap3_dpll_allow_idle(dpll5_clk);
-
 	/* Program dpll5_m2_clk divider for no division */
 	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
 	clk_enable(dpll5_m2_clk);
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 7cf89f8..0021559 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3535,6 +3535,9 @@ int __init omap3xxx_clk_init(void)
 			omap2_init_clk_clkdm(c->lk.clk);
 		}
 
+	/* Disable autoidle on all clocks; let the PM code enable it later */
+	omap_clk_disable_autoidle_all();
+
 	recalculate_root_clocks();
 
 	pr_info("Clocking rate (Crystal/Core/MPU): %ld.%01ld/%ld/%ld MHz\n",
@@ -3548,7 +3551,8 @@ int __init omap3xxx_clk_init(void)
 	clk_enable_init_clocks();
 
 	/*
-	 * Lock DPLL5 and put it in autoidle.
+	 * Lock DPLL5 -- here only until other device init code can
+	 * handle this
 	 */
 	if (omap_rev() >= OMAP3430_REV_ES2_0)
 		omap3_clk_lock_dpll5();
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index dcbe105..2795342 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3309,6 +3309,9 @@ int __init omap4xxx_clk_init(void)
 			omap2_init_clk_clkdm(c->lk.clk);
 		}
 
+	/* Disable autoidle on all clocks; let the PM code enable it later */
+	omap_clk_disable_autoidle_all();
+
 	recalculate_root_clocks();
 
 	/*


