From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v2 RESEND][PATCH 01/10] OMAP3: serial: Check for zero-based physical addr
Date: Mon,  8 Mar 2010 11:28:43 -0600
Message-ID: <1268069332-14082-2-git-send-email-saaguirre@ti.com>
References: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48841 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab0CHR15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:27:57 -0500
In-Reply-To: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>

This is for protecting a wrong mapping attempt of a zero-based
physical address.

The result is that, no serial port will be attempted to be mapped.

Also add an additional protection for NULL clocks before attempting
to enable them (if above condition applies)

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index da77930..1ca4330 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -664,6 +664,12 @@ void __init omap_serial_early_init(void)
 		struct device *dev = &pdev->dev;
 		struct plat_serial8250_port *p = dev->platform_data;
 
+		/* Don't map zero-based physical address */
+		if (p->mapbase == 0) {
+			printk(KERN_WARNING "omap serial: No physical address"
+			       " for uart#%d, so skipping early_init...\n", i);
+			continue;
+		}
 		/*
 		 * Module 4KB + L4 interconnect 4KB
 		 * Static mapping, never released
@@ -727,6 +733,10 @@ void __init omap_serial_init_port(int port)
 	pdev = &uart->pdev;
 	dev = &pdev->dev;
 
+	/* Don't proceed if there's no clocks available */
+	if (!uart->ick || !uart->fck)
+		return;
+
 	omap_uart_enable_clocks(uart);
 
 	omap_uart_reset(uart);
-- 
1.6.3.3

