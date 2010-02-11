From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/17] omap2/3/4: serial: fix coding style indentaion
Date: Wed, 10 Feb 2010 19:45:02 -0800
Message-ID: <20100211034502.GB21755@atomide.com>
References: <20100211033310.1624.80025.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64120 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab0BKDoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 22:44:23 -0500
Content-Disposition: inline
In-Reply-To: <20100211033310.1624.80025.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

>From 8f4ec0907030d94a66572017e86d82cd1b8cf7aa Mon Sep 17 00:00:00 2001
From: vikram pandita <vikram.pandita@ti.com>
Date: Wed, 10 Feb 2010 18:22:54 -0800
Subject: [PATCH] omap2/3/4: serial: fix coding style indentaion

No logical code change

Fix coding style indentaion as per checkpatch.pl
Fix multi-line comment style reported by Nishanth Menon

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2b78400..5f3035e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -716,15 +716,16 @@ void __init omap_serial_init_port(int port)
 		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
 	}
 
-		/* omap44xx: Never read empty UART fifo
-		 * omap3xxx: Never read empty UART fifo on UARTs
-		 * with IP rev >=0x52
-		 */
-		if (cpu_is_omap44xx())
-			uart->p->serial_in = serial_in_override;
-		else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
-				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
-			uart->p->serial_in = serial_in_override;
+	/*
+	 * omap44xx: Never read empty UART fifo
+	 * omap3xxx: Never read empty UART fifo on UARTs
+	 * with IP rev >=0x52
+	 */
+	if (cpu_is_omap44xx())
+		uart->p->serial_in = serial_in_override;
+	else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
+			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+		uart->p->serial_in = serial_in_override;
 }
 
 /**
