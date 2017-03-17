From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+ hwmod: Allow modules to disable HW_AUTO
Date: Fri, 17 Mar 2017 10:39:48 +0200
Message-ID: <50d0d89e-83d4-386b-971d-fa50684db259@ti.com>
References: <1489405996-10718-1-git-send-email-rogerq@ti.com>
 <1489405996-10718-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489405996-10718-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: bcousson@baylibre.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Introduce HWMOD_CLKDM_NOAUTO flag that allows the hwmod's
clockdomain to be prevented from HW_AUTO while the hwmod is active.

This is needed to workaround some modules which don't function
correctly with HW_AUTO. e.g. DCAN on DRA7.

Signed-off-by: Roger Quadros <rogerq@ti.com>
[nsekhar@ti.com: rebased to v4.9 kernel]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
v2:
- add comment explaining why we don't call clkdm_deny_idle() in _idle()
if HWMOD_CLKDM_NOAUTO flag is set.

 arch/arm/mach-omap2/omap_hwmod.c | 9 +++++++--
 arch/arm/mach-omap2/omap_hwmod.h | 5 +++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 0da4f2e..360fded 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2092,7 +2092,7 @@ static int _enable(struct omap_hwmod *oh)
 
 	r = (soc_ops.wait_target_ready) ? soc_ops.wait_target_ready(oh) :
 		-EINVAL;
-	if (oh->clkdm)
+	if (oh->clkdm && !(oh->flags & HWMOD_CLKDM_NOAUTO))
 		clkdm_allow_idle(oh->clkdm);
 
 	if (!r) {
@@ -2149,7 +2149,12 @@ static int _idle(struct omap_hwmod *oh)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 
-	if (oh->clkdm)
+	/*
+	 * If HWMOD_CLKDM_NOAUTO is set then we don't
+	 * deny idle the clkdm again since idle was already denied
+	 * in _enable()
+	 */
+	if (oh->clkdm && !(oh->flags & HWMOD_CLKDM_NOAUTO))
 		clkdm_deny_idle(oh->clkdm);
 
 	if (oh->flags & HWMOD_BLOCK_WFI)
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 9e1c4ed..cda553a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -531,6 +531,10 @@ struct omap_hwmod_omap4_prcm {
  *     operate and they need to be handled at the same time as the main_clk.
  * HWMOD_NO_IDLE: Do not idle the hwmod at all. Useful to handle certain
  *     IPs like CPSW on DRA7, where clocks to this module cannot be disabled.
+ * HWMOD_CLKDM_NOAUTO: Allows the hwmod's clockdomain to be prevented from
+ *     entering HW_AUTO while hwmod is active. This is needed to workaround
+ *     some modules which don't function correctly with HW_AUTO. For example,
+ *     DCAN on DRA7x SoC needs this to workaround errata i893.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -548,6 +552,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_RECONFIG_IO_CHAIN			(1 << 13)
 #define HWMOD_OPT_CLKS_NEEDED			(1 << 14)
 #define HWMOD_NO_IDLE				(1 << 15)
+#define HWMOD_CLKDM_NOAUTO			(1 << 16)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
2.7.4
