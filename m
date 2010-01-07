From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] omap: serial: fix coding style indentaion
Date: Thu,  7 Jan 2010 12:49:19 -0600
Message-ID: <1262890159-22878-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50807 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504Ab0AGSpj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 13:45:39 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o07Ijcpq017668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 12:45:39 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Just fix coding style indentaion as per checkpatch
No logical code change.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/serial.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 8c964be..467e5de 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -694,15 +694,15 @@ void __init omap_serial_init_port(int port)
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
+	/* omap44xx: Never read empty UART fifo
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
-- 
1.6.6.rc0.66.ge160d

