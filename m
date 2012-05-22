From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 3/5] ARM: OMAP2+: Simplify dmtimer clock aliases
Date: Tue, 22 May 2012 15:17:42 -0500
Message-ID: <1337717862-20643-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37553 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440Ab2EVURo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 16:17:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tarun Kanti <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

The OMAP dmtimer driver allows you to dynamically configure the functional
clock that drives the timer logic. The dmtimer driver uses the device name and
a "con-id" string to search for the appropriate functional clock.

Currently, we define a clock alias for each functional clock source each timer
supports. Some functional clock sources are common to all of the timers on a
device and so for these clock sources we can use a single alias with a unique
con-id string.

The possible functional clock sources for an OMAP device are a 32kHz clock,
a system (MHz range) clock and (for OMAP2 only) an external clock. By defining
a unique con-id name for each of these (timer_32k_ck, timer_sys_ck and
timer_ext_ck) we can eliminate a lot of the clock aliases for timers. This
reduces code, speeds-up searches and clock initialisation time.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   39 +++-------------------------------
 arch/arm/mach-omap2/clock2430_data.c |   39 +++-------------------------------
 arch/arm/mach-omap2/clock3xxx_data.c |   26 ++---------------------
 arch/arm/mach-omap2/clock44xx_data.c |   34 +++++++++++------------------
 arch/arm/mach-omap2/timer.c          |    6 +++---
 5 files changed, 23 insertions(+), 121 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index dbae064..84dfde7 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1901,42 +1901,9 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
 	CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
-	CLK("omap_timer.1",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.2",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.3",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.4",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.5",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.6",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.7",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.8",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.9",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.10",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.11",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.12",	"32k_ck",	&func_32k_ck,	CK_243X),
-	CLK("omap_timer.1",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.2",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.3",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.4",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.5",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.6",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.7",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.8",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.9",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.10",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.11",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.12",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.1",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.2",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.3",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.4",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.5",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.6",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.7",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.8",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.9",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.10",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.11",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.12",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK(NULL,	"timer_32k_ck",	&func_32k_ck,	CK_243X),
+	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_243X),
+	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_243X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index b8c3869..7c1f83d 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -2000,42 +2000,9 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
 	CLK("omap_hsmmc.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
 	CLK("omap_hsmmc.1", "mmchsdb_fck",	&mmchsdb2_fck,	CK_243X),
-	CLK("omap_timer.1",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.2",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.3",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.4",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.5",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.6",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.7",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.8",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.9",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.10",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.11",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.12",	"32k_ck",  &func_32k_ck,   CK_243X),
-	CLK("omap_timer.1",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.2",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.3",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.4",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.5",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.6",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.7",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.8",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.9",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.10",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.11",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.12",	"sys_ck",	&sys_ck,	CK_243X),
-	CLK("omap_timer.1",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.2",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.3",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.4",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.5",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.6",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.7",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.8",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.9",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.10",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.11",	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap_timer.12",	"alt_ck",	&alt_ck,	CK_243X),
+	CLK(NULL,	"timer_32k_ck",  &func_32k_ck,   CK_243X),
+	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_243X),
+	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_243X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 1ff81d3..d97701d 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3482,30 +3482,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("musb-am35x",	"fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
 	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
-	CLK("omap_timer.1",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.2",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.3",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.4",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.5",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.6",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.7",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.8",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.9",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.10",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.11",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.12",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK("omap_timer.1",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.2",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.3",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.4",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.5",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.6",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.7",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.8",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.9",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.10",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.11",	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK("omap_timer.12",	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
+	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
 };
 
 
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index c0a0ebc..7a3ba6f 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3380,28 +3380,18 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("usbhs_omap",	"usbhost_ick",		&dummy_ck,		CK_443X),
 	CLK("usbhs_omap",	"usbtll_fck",		&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_timer.1",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.2",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.3",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.4",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.5",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.6",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.7",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.8",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.9",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.10",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.11",	"32k_ck",	&sys_32k_ck,	CK_443X),
-	CLK("omap_timer.1",	"sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.2",	"sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.3",	"sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.4",	"sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.9",	"sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.10",	"sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.11",	"sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.5",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("omap_timer.6",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("omap_timer.7",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("omap_timer.8",	"sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK(NULL,	"timer_32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK("omap_timer.1",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.2",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.3",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.4",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.9",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.10",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.11",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
+	CLK("omap_timer.5",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("omap_timer.6",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("omap_timer.7",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("omap_timer.8",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 840929b..f1d8453 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -414,16 +414,16 @@ static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
 
 	switch (source) {
 	case OMAP_TIMER_SRC_SYS_CLK:
-		parent_name = "sys_ck";
+		parent_name = "timer_sys_ck";
 		break;
 
 	case OMAP_TIMER_SRC_32_KHZ:
-		parent_name = "32k_ck";
+		parent_name = "timer_32k_ck";
 		break;
 
 	case OMAP_TIMER_SRC_EXT_CLK:
 		if (pdata->timer_ip_version == OMAP_TIMER_IP_VERSION_1) {
-			parent_name = "alt_ck";
+			parent_name = "timer_ext_ck";
 			break;
 		}
 		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
-- 
1.7.9.5

