From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] omap1: omap_udc: Add clocking and disable vbus sense
	for omap7xx
Date: Wed, 11 Nov 2009 19:02:42 -0800
Message-ID: <20091112030241.5159.94413.stgit@localhost>
References: <20091112025802.5159.97598.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58767 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760047AbZKLDCh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 22:02:37 -0500
In-Reply-To: <20091112025802.5159.97598.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

From: Cory Maccarrone <darkstar6262@gmail.com>

The l3_ocpi_ck clock is needed on omap7xx processors for USB.
Additionally, bit 8 of the SOFT_REQ_REG needs to be enabled for
the usb_dc_ck on omap7xx, which is a different bit than that
of the omap16xx-defined clock of the same name.

I added a provision for the usb_dc_ck and l3_ocpi_ck clocks as
dc_clk and hhc_clk, respectively, for omap7xx CPUs.  Additionally,
I added a check in machine_without_vbus_sense for all omap7xx
devices, as presently I know of no omap7xx-based devices that
have vbus sense, and it made more sense to me to use a cpu check
here than to spell out each machine one at a time.  Finally, DMA
is disabled for omap7xx, as it causes problems with these chips.

Cc: linux-usb@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Kconfig   |    1 +
 arch/arm/mach-omap1/clock.c   |    3 ++-
 arch/arm/mach-omap1/clock.h   |   10 ++++++++++
 arch/arm/plat-omap/usb.c      |   20 ++++++++++++++------
 drivers/usb/gadget/omap_udc.c |   19 +++++++++++++++++--
 5 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 55ecc01..3232726 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -11,6 +11,7 @@ config ARCH_OMAP850
 	depends on ARCH_OMAP1
 	bool "OMAP850 Based System"
 	select CPU_ARM926T
+	select ARCH_OMAP_OTG
 
 config ARCH_OMAP15XX
 	depends on ARCH_OMAP1
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 7b146c0..42cbe20 100644
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
index fac921c..29ffa97 100644
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
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 0ea1e0b..51033a4 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -159,11 +159,14 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 		 *  - OTG support on this port not yet written
 		 */
 
-		l = omap_readl(USB_TRANSCEIVER_CTRL);
-		l &= ~(7 << 4);
-		if (!is_device)
-			l |= (3 << 1);
-		omap_writel(l, USB_TRANSCEIVER_CTRL);
+		/* Don't do this for omap7xx -- it causes USB to not work correctly */
+		if (!cpu_is_omap7xx()) {
+			l = omap_readl(USB_TRANSCEIVER_CTRL);
+			l &= ~(7 << 4);
+			if (!is_device)
+				l |= (3 << 1);
+			omap_writel(l, USB_TRANSCEIVER_CTRL);
+		}
 
 		return 3 << 16;
 	}
@@ -603,7 +606,12 @@ omap_otg_init(struct omap_usb_config *config)
 	if (config->otg || config->register_dev) {
 		syscon &= ~DEV_IDLE_EN;
 		udc_device.dev.platform_data = config;
-		/* FIXME patch IRQ numbers for omap730 */
+		/* IRQ numbers for omap7xx */
+		if(cpu_is_omap7xx()) {
+			udc_resources[1].start = INT_7XX_USB_GENI;
+			udc_resources[2].start = INT_7XX_USB_NON_ISO;
+			udc_resources[3].start = INT_7XX_USB_ISO;
+		}
 		status = platform_device_register(&udc_device);
 		if (status)
 			pr_debug("can't register UDC device, %d\n", status);
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index b836efe..f81e4f0 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2098,6 +2098,7 @@ static inline int machine_without_vbus_sense(void)
 		|| machine_is_omap_h4()
 #endif
 		|| machine_is_sx1()
+		|| cpu_is_omap7xx() /* No known omap7xx boards with vbus sense */
 		);
 }
 
@@ -2838,6 +2839,16 @@ static int __init omap_udc_probe(struct platform_device *pdev)
 		udelay(100);
 	}
 
+	if (cpu_is_omap7xx()) {
+		dc_clk = clk_get(&pdev->dev, "usb_dc_ck");
+		hhc_clk = clk_get(&pdev->dev, "l3_ocpi_ck");
+		BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
+		/* can't use omap_udc_enable_clock yet */
+		clk_enable(dc_clk);
+		clk_enable(hhc_clk);
+		udelay(100);
+	}
+
 	INFO("OMAP UDC rev %d.%d%s\n",
 		omap_readw(UDC_REV) >> 4, omap_readw(UDC_REV) & 0xf,
 		config->otg ? ", Mini-AB" : "");
@@ -2970,7 +2981,7 @@ known:
 		goto cleanup3;
 	}
 #endif
-	if (cpu_is_omap16xx()) {
+	if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
 		udc->dc_clk = dc_clk;
 		udc->hhc_clk = hhc_clk;
 		clk_disable(hhc_clk);
@@ -3008,7 +3019,7 @@ cleanup0:
 	if (xceiv)
 		otg_put_transceiver(xceiv);
 
-	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	if (cpu_is_omap16xx() || cpu_is_omap24xx() || cpu_is_omap7xx()) {
 		clk_disable(hhc_clk);
 		clk_disable(dc_clk);
 		clk_put(hhc_clk);
@@ -3115,6 +3126,10 @@ static struct platform_driver udc_driver = {
 
 static int __init udc_init(void)
 {
+	/* Disable DMA for omap7xx -- it doesn't work right. */
+	if (cpu_is_omap7xx())
+		use_dma = 0;
+
 	INFO("%s, version: " DRIVER_VERSION
 #ifdef	USE_ISO
 		" (iso)"

