From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/14] omap: Change low-level serial init to use ioremap
Date: Fri, 16 Oct 2009 16:40:17 -0700
Message-ID: <20091016234017.2463.89842.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59633 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZJPXkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:40:16 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Change low-level serial init to use ioremap

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/serial.c |   11 ++++++++---
 arch/arm/mach-omap2/serial.c |   15 ++++++++++-----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index ed07af1..cab4171 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -64,7 +64,6 @@ static void __init omap_serial_reset(struct plat_serial8250_port *p)
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.membase	= OMAP1_IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= OMAP_UART1_BASE,
 		.irq		= INT_UART1,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -73,7 +72,6 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.uartclk	= OMAP16XX_BASE_BAUD * 16,
 	},
 	{
-		.membase	= OMAP1_IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= OMAP_UART2_BASE,
 		.irq		= INT_UART2,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -82,7 +80,6 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.uartclk	= OMAP16XX_BASE_BAUD * 16,
 	},
 	{
-		.membase	= OMAP1_IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= OMAP_UART3_BASE,
 		.irq		= INT_UART3,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -126,6 +123,14 @@ void __init omap_serial_init(void)
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		unsigned char reg;
 
+		/* Static mapping, never released */
+		serial_platform_data[i].membase =
+			ioremap(serial_platform_data[i].mapbase, SZ_2K);
+		if (!serial_platform_data[i].membase) {
+			printk(KERN_ERR "Could not ioremap uart%i\n", i);
+			continue;
+		}
+
 		switch (i) {
 		case 0:
 			uart1_ck = clk_get(NULL, "uart1_ck");
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ae21868..9b6c403 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -73,7 +73,6 @@ static LIST_HEAD(uart_list);
 
 static struct plat_serial8250_port serial_platform_data0[] = {
 	{
-		.membase	= OMAP2_IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= OMAP_UART1_BASE,
 		.irq		= 72,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -87,7 +86,6 @@ static struct plat_serial8250_port serial_platform_data0[] = {
 
 static struct plat_serial8250_port serial_platform_data1[] = {
 	{
-		.membase	= OMAP2_IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= OMAP_UART2_BASE,
 		.irq		= 73,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -101,7 +99,6 @@ static struct plat_serial8250_port serial_platform_data1[] = {
 
 static struct plat_serial8250_port serial_platform_data2[] = {
 	{
-		.membase	= OMAP2_IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= OMAP_UART3_BASE,
 		.irq		= 74,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -110,7 +107,6 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
 #ifdef CONFIG_ARCH_OMAP4
-		.membase	= OMAP2_IO_ADDRESS(OMAP_UART4_BASE),
 		.mapbase	= OMAP_UART4_BASE,
 		.irq		= 70,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -126,7 +122,6 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 #ifdef CONFIG_ARCH_OMAP4
 static struct plat_serial8250_port serial_platform_data3[] = {
 	{
-		.membase	= OMAP2_IO_ADDRESS(OMAP_UART4_BASE),
 		.mapbase	= OMAP_UART4_BASE,
 		.irq		= 70,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -605,6 +600,16 @@ void __init omap_serial_early_init(void)
 		struct device *dev = &pdev->dev;
 		struct plat_serial8250_port *p = dev->platform_data;
 
+		/*
+		 * Module 4KB + L4 interconnect 4KB
+		 * Static mapping, never released
+		 */
+		p->membase = ioremap(p->mapbase, SZ_8K);
+		if (!p->membase) {
+			printk(KERN_ERR "ioremap failed for uart%i\n", i + 1);
+			continue;
+		}
+
 		sprintf(name, "uart%d_ick", i+1);
 		uart->ick = clk_get(NULL, name);
 		if (IS_ERR(uart->ick)) {

