From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 5/5] arm:omap1/2/3: Change dev name for sync_32k_ick clk to omap-counter-32k
Date: Wed, 18 Jan 2012 16:58:06 +0530
Message-ID: <1326886086-27313-6-git-send-email-hvaibhav@ti.com>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50692 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607Ab2ARL2i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 06:28:38 -0500
In-Reply-To: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: johnstul@us.ibm.com, tglx@linutronix.de, balbi@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, b-cousson@ti.com, khilman@ti.com, paul@pwsan.com, Vaibhav Hiremath <hvaibhav@ti.com>

Device name for the sync_32k_ick clock has been set to
"omap-counter-32k". This change is required, since 32k counter
clocksource driver has been migrated to standard platform_driver.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 61ad385..1cb8803 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1861,7 +1861,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
 	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck,	CK_242X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
+	CLK("omap-counter-32k",	"ick",	&sync_32k_ick,	CK_242X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_242X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_242X),
 	CLK("omap24xxcam", "fck",	&cam_fck,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0cc1287..353a97c 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1959,7 +1959,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X),
 	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck,	CK_243X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X),
+	CLK("omap-counter-32k",	"ick",	&sync_32k_ick,	CK_243X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 7dbb218..8e255e8 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3402,7 +3402,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
 	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
-	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
+	CLK("omap-counter-32k",	"ick",	&omap_32ksync_ick,	CK_3XXX),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
 	CLK("omap-mcbsp.2",	"prcm_fck",	&per_96m_fck,	CK_3XXX),
--
1.7.0.4

