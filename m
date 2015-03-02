From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 1/3] ARM: OMAP2: hwmod: AM43XX: Add hwmod support for HDQ-1W
Date: Mon, 2 Mar 2015 16:19:32 +0530
Message-ID: <1425293374-30878-2-git-send-email-vigneshr@ti.com>
References: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57017 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbbCBKuh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Mar 2015 05:50:37 -0500
In-Reply-To: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Evgeniy Polyakov <zbr@ioremap.net>, Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, NeilBrown <neilb@suse.de>, Benoit Cousson <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: "Poddar, Sourav" <sourav.poddar@ti.com>

These adds hwmod data for hdq/1w driver on AM43xx.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
Change log:
v2:
 * Add SYSC_HAS_AUTOIDLE flag.

 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 36 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |  1 +
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 8eb85925e444..e2223148ba4d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -20,6 +20,7 @@
 #include "omap_hwmod_33xx_43xx_common_data.h"
 #include "prcm43xx.h"
 #include "omap_hwmod_common_data.h"
+#include "hdq1w.h"
 
 
 /* IP blocks */
@@ -516,6 +517,33 @@ static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
 	.parent_hwmod	= &am43xx_dss_core_hwmod,
 };
 
+/* HDQ1W */
+static struct omap_hwmod_class_sysconfig am43xx_hdq1w_sysc = {
+	.rev_offs       = 0x0000,
+	.sysc_offs      = 0x0014,
+	.syss_offs      = 0x0018,
+	.sysc_flags     = (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class am43xx_hdq1w_hwmod_class = {
+	.name   = "hdq1w",
+	.sysc   = &am43xx_hdq1w_sysc,
+	.reset	= &omap_hdq1w_reset,
+};
+
+static struct omap_hwmod am43xx_hdq1w_hwmod = {
+	.name           = "hdq1w",
+	.class          = &am43xx_hdq1w_hwmod_class,
+	.clkdm_name     = "l4ls_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_HDQ1W_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /* Interfaces */
 static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
 	.master		= &am33xx_l3_main_hwmod,
@@ -790,6 +818,13 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_rfbi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if am43xx_l4_ls__hdq1w = {
+	.master         = &am33xx_l4_ls_hwmod,
+	.slave          = &am43xx_hdq1w_hwmod,
+	.clk            = "l4ls_gclk",
+	.user           = OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__synctimer,
 	&am43xx_l4_ls__timer8,
@@ -889,6 +924,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_ls__dss,
 	&am43xx_l4_ls__dss_dispc,
 	&am43xx_l4_ls__dss_rfbi,
+	&am43xx_l4_ls__hdq1w,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index ad7b3e9977f8..48df3b55057e 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -143,5 +143,6 @@
 #define AM43XX_CM_PER_USB_OTG_SS1_CLKCTRL_OFFSET        0x0268
 #define AM43XX_CM_PER_USBPHYOCP2SCP1_CLKCTRL_OFFSET	0x05C0
 #define AM43XX_CM_PER_DSS_CLKCTRL_OFFSET		0x0a20
+#define AM43XX_CM_PER_HDQ1W_CLKCTRL_OFFSET		0x04a0
 
 #endif
-- 
1.9.1

