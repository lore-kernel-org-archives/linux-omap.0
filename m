From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2] ARM: davinci: Add the clock for the CPPI 4.1 DMA engine
Date: Wed,  5 Apr 2017 19:17:50 +0200
Message-ID: <20170405171750.16821-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org
Cc: khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The CPPI 4.1 DMA is sharing its clock with the USB OTG,
and most of the time, the clock will be enabled by USB.
But during the init of the DMA, USB is not enabled (waiting for DMA),
and then we must enable the clock before doing anything.
Add the clock for the CPPI 4.1 DMA engine.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 arch/arm/mach-davinci/da830.c | 6 ++++++
 arch/arm/mach-davinci/da850.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 073c458..bd88470 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -304,6 +304,11 @@ static struct clk usb20_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk cppi41_clk = {
+	.name		= "cppi41",
+	.parent		= &usb20_clk,
+};
+
 static struct clk aemif_clk = {
 	.name		= "aemif",
 	.parent		= &pll0_sysclk3,
@@ -413,6 +418,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
 	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index ccad2f9..07d6f0e 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -401,6 +401,11 @@ static struct clk usb20_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk cppi41_clk = {
+	.name		= "cppi41",
+	.parent		= &usb20_clk,
+};
+
 static struct clk spi0_clk = {
 	.name		= "spi0",
 	.parent		= &pll0_sysclk2,
@@ -560,6 +565,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("davinci-nand.0",	"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
