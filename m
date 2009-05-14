From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/8] ARM: OMAP2/3: Add name for musb clocks
Date: Thu, 14 May 2009 10:48:36 -0700
Message-ID: <20090514174836.12080.753.stgit@localhost>
References: <20090514174100.12080.9736.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57529 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZENRsn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:48:43 -0400
In-Reply-To: <20090514174100.12080.9736.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

With the clkdev, musb_core.c needs to register clock with name "ick".

Once all the platforms using the musb driver have been converted
to use clockdev, the clock name does not need to be passed
from the low-level init code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.c |    2 +-
 arch/arm/mach-omap2/clock34xx.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index efc59c4..ff9b4c0 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -206,7 +206,7 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"usbhs_ick",	&usbhs_ick,	CK_243X),
+	CLK("musb_hdrc",	"ick",	&usbhs_ick,	CK_243X),
 	CLK("mmci-omap-hs.0", "ick",	&mmchs1_ick,	CK_243X),
 	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
 	CLK("mmci-omap-hs.1", "ick",	&mmchs2_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 0a14dca..a057539 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -157,7 +157,7 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck,	CK_343X),
 	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck,	CK_343X),
 	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_343X),
-	CLK(NULL,	"hsotgusb_ick",	&hsotgusb_ick,	CK_343X),
+	CLK("musb_hdrc",	"ick",	&hsotgusb_ick,	CK_343X),
 	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_343X),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_343X),
 	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_343X),

