From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge][PATCH 01/10] OMAP3: serial: Check for zero-based physical addr
Date: Wed,  3 Mar 2010 08:18:36 -0600
Message-ID: <1267625925-22616-2-git-send-email-saaguirre@ti.com>
References: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301Ab0CCOSd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Mar 2010 09:18:33 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o23EIXgr009661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Mar 2010 08:18:33 -0600
In-Reply-To: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

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

