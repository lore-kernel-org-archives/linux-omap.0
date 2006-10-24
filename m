From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH 2/4] PalmZ71 - OMAP310 Serial
Date: Tue, 24 Oct 2006 17:21:45 +0200
Message-ID: <200610241721.45506.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J+iPFpAHJg49Cd9"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_J+iPFpAHJg49Cd9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
this makes serial usable also on omap310, not only 1510.
(changing 1510->15xx)

--Boundary-00=_J+iPFpAHJg49Cd9
Content-Type: text/x-diff; charset="us-ascii"; name="omap-serial-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="omap-serial-fix.patch"

diff -Naur linux-omap/arch/arm/mach-omap1/serial.c linux-omap-z71/arch/arm/mach-omap1/serial.c
--- linux-omap/arch/arm/mach-omap1/serial.c	2006-10-15 16:09:10.000000000 +0200
+++ linux-omap-z71/arch/arm/mach-omap1/serial.c	2006-10-20 21:56:49.000000000 +0200
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-omap1/id.c
+ * linux/arch/arm/mach-omap1/serial.c
  *
- * OMAP1 CPU identification code
+ * OMAP1 serial port driver
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -59,7 +59,7 @@
 	omap_serial_outp(p, UART_OMAP_SCR, 0x08);	/* TX watermark */
 	omap_serial_outp(p, UART_OMAP_MDR1, 0x00);	/* enable UART */
 
-	if (!cpu_is_omap1510()) {
+	if (!cpu_is_omap15xx()) {
 		omap_serial_outp(p, UART_OMAP_SYSC, 0x01);
 		while (!(omap_serial_in(p, UART_OMAP_SYSC) & 0x01));
 	}
@@ -121,7 +121,7 @@
 		serial_platform_data[1].irq = INT_730_UART_MODEM_IRDA_2;
 	}
 
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		serial_platform_data[0].uartclk = OMAP1510_BASE_BAUD * 16;
 		serial_platform_data[1].uartclk = OMAP1510_BASE_BAUD * 16;
 		serial_platform_data[2].uartclk = OMAP1510_BASE_BAUD * 16;
@@ -147,10 +147,10 @@
 				printk("Could not get uart1_ck\n");
 			else {
 				clk_enable(uart1_ck);
-				if (cpu_is_omap1510())
+				if (cpu_is_omap15xx())
 					clk_set_rate(uart1_ck, 12000000);
 			}
-			if (cpu_is_omap1510()) {
+			if (cpu_is_omap15xx()) {
 				omap_cfg_reg(UART1_TX);
 				omap_cfg_reg(UART1_RTS);
 				if (machine_is_omap_innovator()) {
@@ -167,12 +167,12 @@
 				printk("Could not get uart2_ck\n");
 			else {
 				clk_enable(uart2_ck);
-				if (cpu_is_omap1510())
+				if (cpu_is_omap15xx())
 					clk_set_rate(uart2_ck, 12000000);
 				else
 					clk_set_rate(uart2_ck, 48000000);
 			}
-			if (cpu_is_omap1510()) {
+			if (cpu_is_omap15xx()) {
 				omap_cfg_reg(UART2_TX);
 				omap_cfg_reg(UART2_RTS);
 				if (machine_is_omap_innovator()) {
@@ -189,10 +189,10 @@
 				printk("Could not get uart3_ck\n");
 			else {
 				clk_enable(uart3_ck);
-				if (cpu_is_omap1510())
+				if (cpu_is_omap15xx())
 					clk_set_rate(uart3_ck, 12000000);
 			}
-			if (cpu_is_omap1510()) {
+			if (cpu_is_omap15xx()) {
 				omap_cfg_reg(UART3_TX);
 				omap_cfg_reg(UART3_RX);
 			}

--Boundary-00=_J+iPFpAHJg49Cd9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_J+iPFpAHJg49Cd9--
