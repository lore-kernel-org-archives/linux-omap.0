From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: fix USB host on 1710
Date: Fri, 25 Jan 2013 00:24:55 +0200
Message-ID: <1359066295-20382-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:51342 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932Ab3AXWZF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 17:25:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

There is a long-standing bug that OHCI USB host controller does
not respond on 1710, because of wrong clock definitions. See e.g.
http://marc.info/?l=linux-omap&m=119634441229321&w=2. All register reads
return just zeroes:

[    1.896606] ohci ohci: OMAP OHCI
[    1.912597] ohci ohci: new USB bus registered, assigned bus number 1
[    1.933776] ohci ohci: irq 38, io mem 0xfffba000
[    2.012573] ohci ohci: init err (00000000 0000)
[    2.030334] ohci ohci: can't start
[    2.046661] ohci ohci: startup error -75
[    2.063201] ohci ohci: USB bus 1 deregistered

After some experiments, it seems that when changing the usb_dc_ck /
SOFT_REQ enable bit from USB_REQ_EN_SHIFT to SOFT_USB_OTG_DPLL_REQ_SHIFT
(like done also on 7XX), the USB appears to work:

[    2.183959] ohci ohci: OMAP OHCI
[    2.198242] ohci ohci: new USB bus registered, assigned bus number 1
[    2.215820] ohci ohci: irq 38, io mem 0xfffba000
[    2.324798] hub 1-0:1.0: USB hub found
[    2.361267] hub 1-0:1.0: 3 ports detected

The patch is tested on Nokia 770.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/clock_data.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index cb7c6ae..6c4f766 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -543,15 +543,6 @@ static struct clk usb_dc_ck = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= USB_REQ_EN_SHIFT,
-};
-
-static struct clk usb_dc_ck7xx = {
-	.name		= "usb_dc_ck",
-	.ops		= &clkops_generic,
-	/* Direct from ULPD, no parent */
-	.rate		= 48000000,
-	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
 	.enable_bit	= SOFT_USB_OTG_DPLL_REQ_SHIFT,
 };
 
@@ -727,8 +718,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"usb_clko",	&usb_clko,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck1510, CK_1510 | CK_310),
 	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck16xx, CK_16XX),
-	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck,	CK_16XX),
-	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck7xx,	CK_7XX),
+	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck,	CK_16XX | CK_7XX),
 	CLK(NULL,	"mclk",		&mclk_1510,	CK_1510 | CK_310),
 	CLK(NULL,	"mclk",		&mclk_16xx,	CK_16XX),
 	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
-- 
1.7.10.4

