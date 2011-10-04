From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: clock data: Remove redundant timer clkdev
Date: Tue, 4 Oct 2011 23:20:40 +0200
Message-ID: <1317763241-21422-2-git-send-email-b-cousson@ti.com>
References: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34856 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932558Ab1JDVVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 17:21:01 -0400
In-Reply-To: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: khilman@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tarun.kanti@ti.com, Benoit Cousson <b-cousson@ti.com>

The commit 318c3e15cd55c73a26ae22a65a8183655b3003f9
added some "fck" clock alias to timer devices that are
not needed anymore since hwmod framework will create
them automatically.

A warning was added to highlight and thus fix the redundancy.

[    0.616424]  omap_timer.1: alias fck already exists
[    0.621948]  omap_timer.2: alias fck already exists
[    0.627380]  omap_timer.3: alias fck already exists
[    0.632781]  omap_timer.4: alias fck already exists
[    0.638214]  omap_timer.5: alias fck already exists
[    0.643615]  omap_timer.6: alias fck already exists
[    0.649078]  omap_timer.7: alias fck already exists
[    0.654479]  omap_timer.8: alias fck already exists
[    0.659881]  omap_timer.9: alias fck already exists
[    0.665283]  omap_timer.10: alias fck already exists
[    0.670776]  omap_timer.11: alias fck already exists

Remove all the clkdev entries for timer fck alias.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   12 ------------
 arch/arm/mach-omap2/clock2430_data.c |   12 ------------
 arch/arm/mach-omap2/clock3xxx_data.c |   12 ------------
 arch/arm/mach-omap2/clock44xx_data.c |   11 -----------
 4 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 14a6277..61ad385 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1898,18 +1898,6 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
 	CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
-	CLK("omap_timer.1",	"fck",	&gpt1_fck,	CK_242X),
-	CLK("omap_timer.2",	"fck",	&gpt2_fck,	CK_242X),
-	CLK("omap_timer.3",	"fck",	&gpt3_fck,	CK_242X),
-	CLK("omap_timer.4",	"fck",	&gpt4_fck,	CK_242X),
-	CLK("omap_timer.5",	"fck",	&gpt5_fck,	CK_242X),
-	CLK("omap_timer.6",	"fck",	&gpt6_fck,	CK_242X),
-	CLK("omap_timer.7",	"fck",	&gpt7_fck,	CK_242X),
-	CLK("omap_timer.8",	"fck",	&gpt8_fck,	CK_242X),
-	CLK("omap_timer.9",	"fck",	&gpt9_fck,	CK_242X),
-	CLK("omap_timer.10",	"fck",	&gpt10_fck,	CK_242X),
-	CLK("omap_timer.11",	"fck",	&gpt11_fck,	CK_242X),
-	CLK("omap_timer.12",	"fck",	&gpt12_fck,	CK_242X),
 	CLK("omap_timer.1",	"32k_ck",	&func_32k_ck,	CK_243X),
 	CLK("omap_timer.2",	"32k_ck",	&func_32k_ck,	CK_243X),
 	CLK("omap_timer.3",	"32k_ck",	&func_32k_ck,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index ea6717c..0cc1287 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1998,18 +1998,6 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
 	CLK("omap_hsmmc.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
 	CLK("omap_hsmmc.1", "mmchsdb_fck",	&mmchsdb2_fck,	CK_243X),
-	CLK("omap_timer.1",     "fck",  &gpt1_fck,      CK_243X),
-	CLK("omap_timer.2",     "fck",  &gpt2_fck,      CK_243X),
-	CLK("omap_timer.3",     "fck",  &gpt3_fck,      CK_243X),
-	CLK("omap_timer.4",     "fck",  &gpt4_fck,      CK_243X),
-	CLK("omap_timer.5",     "fck",  &gpt5_fck,      CK_243X),
-	CLK("omap_timer.6",     "fck",  &gpt6_fck,      CK_243X),
-	CLK("omap_timer.7",     "fck",  &gpt7_fck,      CK_243X),
-	CLK("omap_timer.8",     "fck",  &gpt8_fck,      CK_243X),
-	CLK("omap_timer.9",     "fck",  &gpt9_fck,      CK_243X),
-	CLK("omap_timer.10",    "fck",  &gpt10_fck,     CK_243X),
-	CLK("omap_timer.11",    "fck",  &gpt11_fck,     CK_243X),
-	CLK("omap_timer.12",    "fck",  &gpt12_fck,     CK_243X),
 	CLK("omap_timer.1",	"32k_ck",  &func_32k_ck,   CK_243X),
 	CLK("omap_timer.2",	"32k_ck",  &func_32k_ck,   CK_243X),
 	CLK("omap_timer.3",	"32k_ck",  &func_32k_ck,   CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 65dd363..5d0064a 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3464,18 +3464,6 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("musb-am35x",	"fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
 	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
-	CLK("omap_timer.1",	"fck",	&gpt1_fck,	CK_3XXX),
-	CLK("omap_timer.2",	"fck",	&gpt2_fck,	CK_3XXX),
-	CLK("omap_timer.3",	"fck",	&gpt3_fck,	CK_3XXX),
-	CLK("omap_timer.4",	"fck",	&gpt4_fck,	CK_3XXX),
-	CLK("omap_timer.5",	"fck",	&gpt5_fck,	CK_3XXX),
-	CLK("omap_timer.6",	"fck",	&gpt6_fck,	CK_3XXX),
-	CLK("omap_timer.7",	"fck",	&gpt7_fck,	CK_3XXX),
-	CLK("omap_timer.8",	"fck",	&gpt8_fck,	CK_3XXX),
-	CLK("omap_timer.9",	"fck",	&gpt9_fck,	CK_3XXX),
-	CLK("omap_timer.10",    "fck",  &gpt10_fck,     CK_3XXX),
-	CLK("omap_timer.11",    "fck",  &gpt11_fck,     CK_3XXX),
-	CLK("omap_timer.12",    "fck",  &gpt12_fck,     CK_3XXX),
 	CLK("omap_timer.1",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
 	CLK("omap_timer.2",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
 	CLK("omap_timer.3",	"32k_ck",	&omap_32k_fck,  CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 946bf04..f9c6425 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3363,17 +3363,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
 	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap_timer.1",	"fck",			&timer1_fck,	CK_443X),
-	CLK("omap_timer.2",	"fck",			&timer2_fck,	CK_443X),
-	CLK("omap_timer.3",	"fck",			&timer3_fck,	CK_443X),
-	CLK("omap_timer.4",	"fck",			&timer4_fck,	CK_443X),
-	CLK("omap_timer.5",	"fck",			&timer5_fck,	CK_443X),
-	CLK("omap_timer.6",	"fck",			&timer6_fck,	CK_443X),
-	CLK("omap_timer.7",	"fck",			&timer7_fck,	CK_443X),
-	CLK("omap_timer.8",	"fck",			&timer8_fck,	CK_443X),
-	CLK("omap_timer.9",	"fck",			&timer9_fck,	CK_443X),
-	CLK("omap_timer.10",	"fck",			&timer10_fck,	CK_443X),
-	CLK("omap_timer.11",	"fck",			&timer11_fck,	CK_443X),
 	CLK("omap_timer.1",	"32k_ck",	&sys_32k_ck,	CK_443X),
 	CLK("omap_timer.2",	"32k_ck",	&sys_32k_ck,	CK_443X),
 	CLK("omap_timer.3",	"32k_ck",	&sys_32k_ck,	CK_443X),
-- 
1.7.0.4

