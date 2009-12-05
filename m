From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v3] omap: serial: fix non-empty uart fifo read abort
Date: Fri,  4 Dec 2009 18:20:04 -0600
Message-ID: <1259972404-28784-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59962 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932561AbZLEATB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Dec 2009 19:19:01 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nB50J76r024087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Dec 2009 18:19:07 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

OMAP3xxx and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
Empty RX fifo read causes an abort.

OMAP3xxx:
	UART IP revision >= 0x52 have this issue
	MVR register format is:
	Bits  Field Name  Description  				Type  Reset
	31:8   RESERVED 					RO  	0x0
	7:4    MAJOR  	Major revision number of the module.  	RO  	0x--  
	3:0    MINOR  	Minor revision number of the module.  	RO  	0x--

OMAP4xxx: 
	All revisions have this issue
	Revision id check is not used as the format of MVR resigster has changed
	For omap4 MVR register reads as: 0x50410602 => Revision id = 0x0602
	Format of MVR register on omap4 is: (Courtesy: Cousson, Benoit)
	Bits  Field Name  Description  				Type  Reset
	31:30 SCHEME  	Scheme revision number of module  	RO  	0x1
	29:28 RESERVED   					RO  	0x1  
	27:16 FUNC  	Function revision number of module  	RO  	0x041  
	15:11 RTL  		Rtl revision number of module  	RO  	0x00  
	10:8  MAJOR 	Major revision number of the module.  	RO  	0x6  
	7:6   CUSTOM  	Custom revision number of the module.  	RO  	0x0  
	5:0   MINOR  	Minor revision number of the module.  	RO  	0x02

Override the default 8250 read handler: mem_serial_in()
by a custom handler: serial_in_8250()
which makes sure that RX fifo is not read when empty

tested on zoom3(3630) board

Cc: Cousson, Benoit <b-cousson@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
History of Patch:
V1:
	http://patchwork.kernel.org/patch/61671/
	http://patchwork.kernel.org/patch/61672/

V2: Incorporate approach suggested by Tony L
	Introduce IP version check in mach-omap2/serial.c file	

V3: Change #ifdef OMAP4 to cpu_is_omap44xx()

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2e17b57..e853115 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -33,6 +33,7 @@
 #include "pm.h"
 #include "prm-regbits-34xx.h"
 
+#define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
 #define DEFAULT_TIMEOUT (5 * HZ)
@@ -572,6 +573,23 @@ static struct omap_uart_state omap_uart[] = {
 #endif
 };
 
+/*
+ * Override the default 8250 read handler: mem_serial_in()
+ * Empty RX fifo read causes an abort on omap3630 and omap4
+ * This function makes sure that an empty rx fifo is not read on these silicons
+ * (OMAP1/2/3430 are not affected)
+ */
+static unsigned int serial_in_override(struct uart_port *up, int offset)
+{
+	if (UART_RX == offset) {
+		unsigned int lsr;
+		lsr = serial_read_reg(omap_uart[up->line].p, UART_LSR);
+		if (!(lsr & UART_LSR_DR))
+			return -EPERM;
+	}
+	return serial_read_reg(omap_uart[up->line].p, offset);
+}
+
 void __init omap_serial_early_init(void)
 {
 	int i;
@@ -650,5 +668,15 @@ void __init omap_serial_init(void)
 			device_init_wakeup(dev, true);
 			DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
 		}
+
+		/* omap44xx: Never read empty UART fifo
+		 * omap3xxx: Never read empty UART fifo on UARTs
+		 * with IP rev >=0x52
+		 */
+		if (cpu_is_omap44xx())
+			uart->p->serial_in = serial_in_override;
+		else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
+				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+			uart->p->serial_in = serial_in_override;
 	}
 }
-- 
1.6.6.rc0.66.ge160d

