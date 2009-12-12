From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/14] omap: serial: fix non-empty uart fifo read abort
Date: Fri, 11 Dec 2009 16:09:19 -0800
Message-ID: <20091212000919.GF24013@atomide.com>
References: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56478 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758394AbZLLAJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 19:09:15 -0500
Content-Disposition: inline
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

From: vikram pandita <vikram.pandita@ti.com>
Date: Tue, 8 Dec 2009 10:17:28 -0800
Subject: [PATCH] omap: serial: fix non-empty uart fifo read abort

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

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 6278fe5..39b797b 100644
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
@@ -667,15 +685,15 @@ void __init omap_serial_init_port(int port)
 		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
 	}
 
-	/* omap44xx: Never read empty UART fifo
-	 * omap3xxx: Never read empty UART fifo on UARTs
-	 * with IP rev >=0x52
-	 */
-	if (cpu_is_omap44xx())
-		uart->p->serial_in = serial_in_override;
-	else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
-			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
-		uart->p->serial_in = serial_in_override;
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
 
 /**
