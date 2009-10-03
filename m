From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [OMAP7XX] Add missing clocks for MMC
Date: Sat, 3 Oct 2009 14:58:41 -0700
Message-ID: <6cb013310910031458x666606cagdd1c5f9d4fb26dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:44139 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbZJCV7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Oct 2009 17:59:37 -0400
Received: by ywh6 with SMTP id 6so1498344ywh.4
        for <linux-omap@vger.kernel.org>; Sat, 03 Oct 2009 14:59:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The omap730 and omap850 both use a different clock for the "fck"
clock of the MMC interface than other omap processors based on the
SOFT_REQ_REG, pin 12.  The "ick" clock is the same as that used
by other omap processors.

* Added the missing clock definition as mmc3_ck to clock.h
* Added the clock definition to omap_clks in clock.c
* Added CK_7XX to the mmci-omap.0 "ick" clock already in clock.c

With this change, it is now possible to initialize and use MMC
cards with omap730 and omap850 devices.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/clock.c |    3 ++-
 arch/arm/mach-omap1/clock.h |   12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 5f77b83..8ff0a07 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -125,7 +125,8 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
 	CLK(NULL,	"bclk",		&bclk_16xx,	CK_16XX),
 	CLK("mmci-omap.0", "fck",	&mmc1_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK("mmci-omap.0", "ick",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK("mmci-omap.0", "fck",	&mmc3_ck,	CK_7XX),
+	CLK("mmci-omap.0", "ick",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310
| CK_7XX),
 	CLK("mmci-omap.1", "fck",	&mmc2_ck,	CK_16XX),
 	CLK("mmci-omap.1", "ick",	&armper_ck.clk,	CK_16XX),
 	/* Virtual clocks */
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 17f8742..fac921c 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -637,6 +637,18 @@ static struct clk mmc2_ck = {
 	.enable_bit	= 20,
 };

+static struct clk mmc3_ck = {
+	.name		= "mmc_ck",
+	.id		= 2,
+	.ops		= &clkops_generic,
+	/* Functional clock is direct from ULPD, interface clock is ARMPER */
+	.parent		= &armper_ck.clk,
+	.rate		= 48000000,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 12,
+};
+
 static struct clk virtual_ck_mpu = {
 	.name		= "mpu",
 	.ops		= &clkops_null,
-- 
1.5.6.3
