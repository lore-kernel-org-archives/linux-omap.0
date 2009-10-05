From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 1/4] [OMAP] Clocks: Add omap7xx-specific USB clock
	configuration
Date: Mon, 5 Oct 2009 07:49:49 -0700
Message-ID: <6cb013310910050749n19c493day7d2fa2faba73a19e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:65482 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbZJEOup (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 10:50:45 -0400
Received: by yxe37 with SMTP id 37so3032397yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 07:50:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The l3_ocpi_ck clock is needed on omap7xx processors for USB.
Additionally, bit 8 of the SOFT_REQ_REG needs to be enabled for
the usb_dc_ck on omap7xx, which is a different bit than that
of the omap16xx-defined clock of the same name.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/clock.c |    3 ++-
 arch/arm/mach-omap1/clock.h |   10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 5f77b83..10c4a7a 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -99,7 +99,7 @@ static struct omap_clk omap_clks[] = {
 	/* CK_GEN3 clocks */
 	CLK(NULL,	"tc_ck",	&tc_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK(NULL,	"tipb_ck",	&tipb_ck,	CK_1510 | CK_310),
-	CLK(NULL,	"l3_ocpi_ck",	&l3_ocpi_ck,	CK_16XX),
+	CLK(NULL,	"l3_ocpi_ck",	&l3_ocpi_ck,	CK_16XX | CK_7XX),
 	CLK(NULL,	"tc1_ck",	&tc1_ck,	CK_16XX),
 	CLK(NULL,	"tc2_ck",	&tc2_ck,	CK_16XX),
 	CLK(NULL,	"dma_ck",	&dma_ck,	CK_16XX | CK_1510 | CK_310),
@@ -120,6 +120,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck1510, CK_1510 | CK_310),
 	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck16xx, CK_16XX),
 	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck,	CK_16XX),
+	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck7xx,	CK_7XX),
 	CLK(NULL,	"mclk",		&mclk_1510,	CK_1510 | CK_310),
 	CLK(NULL,	"mclk",		&mclk_16xx,	CK_16XX),
 	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 17f8742..584a764 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -574,6 +574,16 @@ static struct clk usb_dc_ck = {
 	.enable_bit	= 4,
 };

+static struct clk usb_dc_ck7xx = {
+	.name		= "usb_dc_ck",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent */
+	.rate		= 48000000,
+	.flags		= RATE_FIXED,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 8,
+};
+
 static struct clk mclk_1510 = {
 	.name		= "mclk",
 	.ops		= &clkops_generic,
-- 
1.5.6.3
