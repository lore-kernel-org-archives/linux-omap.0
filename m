From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 05/16] OMAP4: clock data: Remove usb_host_fs clkdev with NULL dev
Date: Thu, 23 Jun 2011 19:43:34 +0200
Message-ID: <1308851025-26313-6-git-send-email-b-cousson@ti.com>
References: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60143 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934007Ab1FWRoV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 13:44:21 -0400
In-Reply-To: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

usb_host_fs_fck does have a clkdev mapping with "usbhs-omap.0"
and "fs_fck" alias used by the driver.
The entry with NULL dev is thus not needed anymore.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 227befb..52f3e39 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3204,7 +3204,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
 	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
 	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_443X),
-	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK("usbhs-omap.0",	"fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk,	CK_443X),
@@ -3216,7 +3215,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",	&usb_host_hs_hsic60m_p2_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck,	CK_443X),
 	CLK("usbhs-omap.0",	"hs_fck",		&usb_host_hs_fck,	CK_443X),
 	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
 	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_443X),
@@ -3226,7 +3224,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_443X),
 	CLK("usbhs-omap.0",	"usbtll_ick",		&usb_tll_hs_ick,	CK_443X),
 	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
 	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
-- 
1.7.0.4

