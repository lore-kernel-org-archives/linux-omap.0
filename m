From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/19] OMAP2: serial.c: Fix number of uarts in early_init
Date: Thu, 11 Mar 2010 15:48:21 -0800
Message-ID: <20100311234821.4500.90023.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53191 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab0CKXq6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:46:58 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

From: Thomas Weber <swirl@gmx.li>

The omap_serial_early_init prints the following errors:

Could not get uart4_ick
Could not get uart4_fck

because all the uarts available in omap_uart[] will be initialized.
Only omap4430 and omap3630 have 4 uarts at the moment.
This patch reduces the number of uarts when cpu is not omap4430 or
omap3630.

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b79bc89..da77930 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -644,16 +644,21 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
 }
 void __init omap_serial_early_init(void)
 {
-	int i;
+	int i, nr_ports;
 	char name[16];
 
+	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
+		nr_ports = 3;
+	else
+		nr_ports = ARRAY_SIZE(omap_uart);
+
 	/*
 	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on
 	 * if not needed.
 	 */
 
-	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
+	for (i = 0; i < nr_ports; i++) {
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
@@ -669,17 +674,17 @@ void __init omap_serial_early_init(void)
 			continue;
 		}
 
-		sprintf(name, "uart%d_ick", i+1);
+		sprintf(name, "uart%d_ick", i + 1);
 		uart->ick = clk_get(NULL, name);
 		if (IS_ERR(uart->ick)) {
-			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
+			printk(KERN_ERR "Could not get uart%d_ick\n", i + 1);
 			uart->ick = NULL;
 		}
 
 		sprintf(name, "uart%d_fck", i+1);
 		uart->fck = clk_get(NULL, name);
 		if (IS_ERR(uart->fck)) {
-			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
+			printk(KERN_ERR "Could not get uart%d_fck\n", i + 1);
 			uart->fck = NULL;
 		}
 

