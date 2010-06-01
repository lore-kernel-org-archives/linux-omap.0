From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [omap1] omap7xx clocks, mux, serial fixes
Date: Tue,  1 Jun 2010 15:32:49 -0700
Message-ID: <1275431571-28547-2-git-send-email-darkstar6262@gmail.com>
References: <1275431571-28547-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43243 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657Ab0FAWdH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 18:33:07 -0400
Received: by gwaa12 with SMTP id a12so4065064gwa.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Jun 2010 15:33:06 -0700 (PDT)
In-Reply-To: <1275431571-28547-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linwizard-devel@lists.sf.net, Cory Maccarrone <darkstar6262@gmail.com>

This change adds in the necessary clocks and mux pins for UART
control on omap7xx devices.  I also made a change in the serial
code to only try and initialize two UARTs in omap_serial_init, as
these devices don't have three.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/clock_data.c      |   20 ++++++++++++++++++++
 arch/arm/mach-omap1/mux.c             |    4 ++++
 arch/arm/mach-omap1/serial.c          |    7 +++++++
 arch/arm/plat-omap/include/plat/mux.h |    4 ++++
 4 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index aa8558a..9240bc1 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -478,6 +478,24 @@ static struct clk usb_dc_ck7xx = {
 	.enable_bit	= 8,
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
@@ -620,7 +638,9 @@ static struct omap_clk omap_clks[] = {
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
index 8434137..6a9b42f 100644
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
index c7472a2..82c374c 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -191,6 +191,10 @@ enum omap7xx_index {
 	SPI_7XX_4,
 	SPI_7XX_5,
 	SPI_7XX_6,
+
+	/* UART */
+	UART_7XX_1,
+	UART_7XX_2,
 };
 
 enum omap1xxx_index {
-- 
1.6.0.4

