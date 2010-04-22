From: "Arce, Abraham" <x0066660@ti.com>
Subject: [PATCH 1/4] OMAP4: Clocks: Change SPI Instance Names
Date: Thu, 22 Apr 2010 09:42:15 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DC15EB2@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49998 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964Ab0DVOmc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 10:42:32 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>


Change the name for the spi instances on omap44xx_clks to match
the names omap2 spi driver gives:

omap-mcspi.1 -> omap2_mcspi.1
omap-mcspi.2 -> omap2_mcspi.2
omap-mcspi.3 -> omap2_mcspi.3
omap-mcspi.4 -> omap2_mcspi.4

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 28b1079..a5c0c9c 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2671,10 +2671,10 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap-mcbsp.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.3",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcspi.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcspi.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcspi.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcspi.4",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.1",	"ick",			&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.2",	"ick",			&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.3",	"ick",			&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.4",	"ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
-- 
1.5.4.3

