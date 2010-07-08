From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/13] omap1: omap7xx clocks, mux, serial fixes
Date: Thu, 08 Jul 2010 16:54:32 +0300
Message-ID: <20100708135432.26276.91093.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55318 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757789Ab0GHNye (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:54:34 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>

From: Cory Maccarrone <darkstar6262@gmail.com>

This change adds in the necessary clocks and mux pins for UART
control on omap7xx devices.  I also made a change in the serial
code to only try and initialize two UARTs in omap_serial_init, as
these devices don't have three.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/clock_data.c      |   20 ++++++++++++++++++++
 arch/arm/mach-omap1/mux.c             |    4 ++++
 arch/arm/mach-omap1/serial.c          |    7 +++++++
 arch/arm/plat-omap/include/plat/mux.h |    4 ++++
 4 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index ca4bd86..af54114 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -551,6 +551,24 @@ static struct clk usb_dc_ck7xx = {
 	.enable_bit	= SOFT_USB_OTG_DPLL_REQ_SHIFT,
 };
 
+static struct clk uart1_7xx = {
+	.name		= "uart1_ck",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent */
+	.rate		= 12000000,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 9,
+};
+
+static struct clk uart2_7xx = {
+	.name		= "uart2_ck",
+	.ops		= &clkops_generic,
+	/* Direct from ULPD, no parent */
+	.rate		= 12000000,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 11,
+};
+
 static struct clk mclk_1510 = {
 	.name		= "mclk",
 	.ops		= &clkops_generic,
@@ -697,7 +715,9 @@ static struct omap_clk omap_clks[] = {
 	/* ULPD clocks */
 	CLK(NULL,	"uart1_ck",	&uart1_1510,	CK_1510 | CK_310),
 	CLK(NULL,	"uart1_ck",	&uart1_16xx.clk, CK_16XX),
+	CLK(NULL,	"uart1_ck",	&uart1_7xx,	CK_7XX),
 	CLK(NULL,	"uart2_ck",	&uart2_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"uart2_ck",	&uart2_7xx,	CK_7XX),
 	CLK(NULL,	"uart3_ck",	&uart3_1510,	CK_1510 | CK_310),
 	CLK(NULL,	"uart3_ck",	&uart3_16xx.clk, CK_16XX),
 	CLK(NULL,	"usb_clko",	&usb_clko,	CK_16XX | CK_1510 | CK_310),
diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 3e98835..7835add 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -70,6 +70,10 @@ MUX_CFG_7XX("SPI_7XX_3",           6,   13,    4,   12,   1, 0)
 MUX_CFG_7XX("SPI_7XX_4",           6,   17,    4,   16,   1, 0)
 MUX_CFG_7XX("SPI_7XX_5",           8,   25,    0,   24,   0, 0)
 MUX_CFG_7XX("SPI_7XX_6",           9,    5,    0,    4,   0, 0)
+
+/* UART pins */
+MUX_CFG_7XX("UART_7XX_1",          3,   21,    0,   20,   0, 0)
+MUX_CFG_7XX("UART_7XX_2",          8,    1,    6,    0,   0, 0)
 };
 #define OMAP7XX_PINS_SZ		ARRAY_SIZE(omap7xx_pins)
 #else
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 349de90..b78d074 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -122,6 +122,13 @@ void __init omap_serial_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(serial_platform_data) - 1; i++) {
 
+		/* Don't look at UARTs higher than 2 for omap7xx */
+		if (cpu_is_omap7xx() && i > 1) {
+			serial_platform_data[i].membase = NULL;
+			serial_platform_data[i].mapbase = 0;
+			continue;
+		}
+
 		/* Static mapping, never released */
 		serial_platform_data[i].membase =
 			ioremap(serial_platform_data[i].mapbase, SZ_2K);
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index e1da7b1..aeba717 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -173,6 +173,10 @@ enum omap7xx_index {
 	SPI_7XX_4,
 	SPI_7XX_5,
 	SPI_7XX_6,
+
+	/* UART */
+	UART_7XX_1,
+	UART_7XX_2,
 };
 
 enum omap1xxx_index {

