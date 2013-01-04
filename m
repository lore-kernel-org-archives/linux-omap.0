From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2+: hwmod: rename flag to prevent hwmod code from touching IP block during init
Date: Fri, 4 Jan 2013 14:02:04 +0100
Message-ID: <1357304526-21557-2-git-send-email-s-guiriec@ti.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53946 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729Ab3ADNCQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 08:02:16 -0500
In-Reply-To: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

Rename HWMOD_EXT_OPT_MAIN_CLK flag to indicate that this IP block is
dependent on an off-chip functional clock that is not guaranteed to
be present during initialization. Same flag can be use for IP with
additional HW registers to control Auto IDLE mode.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c           |    2 +-
 arch/arm/mach-omap2/omap_hwmod.h           |   10 ++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4653efb..640c179 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2447,7 +2447,7 @@ static int __init _setup_reset(struct omap_hwmod *oh)
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return -EINVAL;
 
-	if (oh->flags & HWMOD_EXT_OPT_MAIN_CLK)
+	if (oh->flags & HWMOD_NO_SETUP_RESET)
 		return -EPERM;
 
 	if (oh->rst_lines_cnt == 0) {
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 3ae852a..ce4bed4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -446,11 +446,17 @@ struct omap_hwmod_omap4_prcm {
  *     in order to complete the reset. Optional clocks will be disabled
  *     again after the reset.
  * HWMOD_16BIT_REG: Module has 16bit registers
- * HWMOD_EXT_OPT_MAIN_CLK: The only main functional clock source for
+ * HWMOD_NO_SETUP_RESET: This flag can be used for 2 problems:
+ *     1) The only main functional clock source for
  *     this IP block comes from an off-chip source and is not always
  *     enabled.  This prevents the hwmod code from being able to
  *     enable and reset the IP block early.  XXX Eventually it should
  *     be possible to query the clock framework for this information.
+ *     2) IP with additional registers for auto gatting control like AESS
+ *     For some IPs we need to set AUTO_GATTING_ENABLE bit. This bit is set
+ *     only when the associated driver is probed. If hwmod is enabling and
+ *     reseting the IP early without setting auto idle bit then clocks are
+ *     not gated.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -461,7 +467,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_NO_IDLEST				(1 << 6)
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
 #define HWMOD_16BIT_REG				(1 << 8)
-#define HWMOD_EXT_OPT_MAIN_CLK			(1 << 9)
+#define HWMOD_NO_SETUP_RESET			(1 << 9)
 
 /*
  * omap_hwmod._int_flags definitions
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 129d508..b340a4e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2133,7 +2133,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	 * available, so it doesn't seem that we have any choice in
 	 * the kernel other than to avoid resetting it.
 	 */
-	.flags		= HWMOD_EXT_OPT_MAIN_CLK,
+	.flags		= HWMOD_NO_SETUP_RESET,
 	.mpu_irqs	= omap44xx_mcpdm_irqs,
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
 	.main_clk	= "mcpdm_fck",
-- 
1.7.10.4

