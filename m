From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH 1/7] OMAP3: serial: Check for zero-based physical addr
Date: Mon, 15 Mar 2010 18:04:06 -0500
Message-ID: <1268694252-21985-2-git-send-email-saaguirre@ti.com>
References: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49259 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386Ab0COXC3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Mar 2010 19:02:29 -0400
In-Reply-To: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

This is for protecting a wrong mapping attempt of a zero-based
physical address.

The result is that, no serial port will be attempted to be mapped.

Also add an additional protection for NULL clocks before attempting
to enable them (if above condition applies)

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index da77930..ef91fc0 100644
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
@@ -727,6 +733,13 @@ void __init omap_serial_init_port(int port)
 	pdev = &uart->pdev;
 	dev = &pdev->dev;
 
+	/* Don't proceed if there's no clocks available */
+	if (unlikely(!uart->ick || !uart->fck)) {
+		WARN(1, "%s: can't init uart%d, no clocks available\n",
+		     kobject_name(&dev->kobj), port);
+		return;
+	}
+
 	omap_uart_enable_clocks(uart);
 
 	omap_uart_reset(uart);
-- 
1.6.3.3

