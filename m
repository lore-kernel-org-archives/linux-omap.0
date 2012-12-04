From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 21/23] ARM: OMAP3: clock data: get rid of unused USB host clock aliases and dummies
Date: Tue, 4 Dec 2012 16:31:52 +0200
Message-ID: <1354631514-24815-6-git-send-email-rogerq@ti.com>
References: <1354631514-24815-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44045 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084Ab2LDOcQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Dec 2012 09:32:16 -0500
In-Reply-To: <1354631514-24815-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

We don't need multiple aliases for the OMAP USB host clocks and neither
the dummy clocks so remove them.

CC: Paul Walmsley <paul@pwsan.com>
CC: Rajendra Nayak <rnayak@ti.com>
CC: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 5655414..8b9d109 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3289,8 +3289,6 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_omap",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_tll",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
 	CLK(NULL,	"mmchs3_fck",	&mmchs3_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"mmchs2_fck",	&mmchs2_fck,	CK_3XXX),
@@ -3327,8 +3325,6 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_3XXX),
 	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_omap",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_tll",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("omap_hsmmc.2",	"ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"mmchs3_ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_34XX | CK_36XX),
@@ -3391,15 +3387,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_omap",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"xclk60mhsp1_ck",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"xclk60mhsp2_ck",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_tll",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_tll",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"init_60m_fclk",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
-- 
1.7.4.1

