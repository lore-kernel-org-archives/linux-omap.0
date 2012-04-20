From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/19] ARM: OMAP4: PM: powerdomain: Add HWSAR flag to L3INIT
Date: Fri, 20 Apr 2012 12:33:36 +0300
Message-ID: <1334914432-26456-4-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51368 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453Ab2DTJe2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:34:28 -0400
In-Reply-To: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

L3INIT powerdomain has USB HOST and USB TLL modules which support
hardware save-and-restore (HW SAR) mechanism.
This patch updates the L3INIT power domain to mark them as capable
of doing H/w save and restore and provides functions to do them
explicitly.

Note: Eventually, these custom function implementation will be
abstracted and might be done in hwmod or in other layer.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/powerdomain44xx.c       |   41 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains44xx_data.c |    2 +-
 2 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 601325b..9bfb8a0 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -23,6 +23,10 @@
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
+#include "cm-regbits-44xx.h"
+#include "prcm44xx.h"
+#include "cm2_44xx.h"
+#include "cminst44xx.h"
 
 static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
@@ -208,6 +212,41 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
+static int omap4_pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
+{
+	/*
+	 * FIXME: This should be fixed right way by moving it into HWMOD
+	 * or clock framework since sar control is moved to module level
+	 */
+	omap4_cminst_rmw_inst_reg_bits(OMAP4430_SAR_MODE_MASK,
+		1 << OMAP4430_SAR_MODE_SHIFT, OMAP4430_CM2_PARTITION,
+		OMAP4430_CM2_L3INIT_INST,
+		OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET);
+	omap4_cminst_rmw_inst_reg_bits(OMAP4430_SAR_MODE_MASK,
+		1 << OMAP4430_SAR_MODE_SHIFT, OMAP4430_CM2_PARTITION,
+		OMAP4430_CM2_L3INIT_INST,
+		OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET);
+	return 0;
+}
+
+static int omap4_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
+{
+	/*
+	 * FIXME: This should be fixed right way by moving it into HWMOD
+	 * or clock framework since sar control is moved to module level
+	 */
+	omap4_cminst_rmw_inst_reg_bits(OMAP4430_SAR_MODE_MASK,
+		0 << OMAP4430_SAR_MODE_SHIFT, OMAP4430_CM2_PARTITION,
+		OMAP4430_CM2_L3INIT_INST,
+		OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET);
+	omap4_cminst_rmw_inst_reg_bits(OMAP4430_SAR_MODE_MASK,
+		0 << OMAP4430_SAR_MODE_SHIFT, OMAP4430_CM2_PARTITION,
+		OMAP4430_CM2_L3INIT_INST,
+		OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET);
+
+	return 0;
+}
+
 struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
@@ -223,4 +262,6 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_set_mem_onst	= omap4_pwrdm_set_mem_onst,
 	.pwrdm_set_mem_retst	= omap4_pwrdm_set_mem_retst,
 	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
+	.pwrdm_enable_hdwr_sar	= omap4_pwrdm_enable_hdwr_sar,
+	.pwrdm_disable_hdwr_sar	= omap4_pwrdm_disable_hdwr_sar,
 };
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 704664c..d8701ce 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -276,7 +276,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* l3init_bank1 */
 	},
-	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE | PWRDM_HAS_HDWR_SAR,
 };
 
 /* l4per_44xx_pwrdm: Target peripherals power domain */
-- 
1.7.4.1

