From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] Fix broken NAND on Amstrad Delta
Date: Wed, 21 Oct 2009 02:39:53 +0200
Message-ID: <200910210239.55194.jkrzyszt@tis.icnet.pl>
Reply-To: Discussion of the Amstrad E3 emailer hardware/software
	<e3-hacking@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e3-hacking-bounces@earth.li>
Content-Disposition: inline
List-Unsubscribe: <http://www.earth.li/cgi-bin/mailman/options/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=unsubscribe>
List-Archive: <http://www.earth.li/pipermail/e3-hacking>
List-Post: <mailto:e3-hacking@earth.li>
List-Help: <mailto:e3-hacking-request@earth.li?subject=help>
List-Subscribe: <http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=subscribe>
Sender: e3-hacking-bounces@earth.li
Errors-To: e3-hacking-bounces@earth.li
To: jkrzyszt@tis.icnet.pl, Tony Lindgren <tony@atomide.com>
Cc: e3-hacking@earth.li, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,
I found that with commit 15ac408ee5a509053a765b816e9179515329369f, "OMAP:
UART: drop OMAP_TAG_UART, enable all UARTs, auto-disabled on idle", NAND got
not accessible on Amstrad Delta (E3). That seems to be caused by unnecessary
omap_cfg_reg() calls for UART ports 2 and 3, that were never used on that
machine before and now are initilalized and supposed to be auto-disabled.

I can suspect that similiar problems may exist for other OMAP1510 based
boards. Furthermore, since mux code is going to be reorganized, the right
solution would probably be to remove those cpu_is_omap1510() specific bits
completely from arch/arm/mach-omap1/serial.c and push them into board specific
files where applicable. However, not being familiar with any OMAP hardware
other that my amsdelta, I provide a patch that solves the problem for that
machine only. I have locked out the bits for UART1 as well as those look not
really required, as far as I can understand
http://focus.ti.com/lit/ds/symlink/omap5910.pdf.

Created and tested against linux-2.6.32-r5.

Thanks,
Janusz

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
--- linux-2.6.32-rc5/arch/arm/mach-omap1/serial.c.orig	2009-10-20 22:38:38.000000000 +0200
+++ linux-2.6.32-rc5/arch/arm/mach-omap1/serial.c	2009-10-21 01:26:51.000000000 +0200
@@ -143,7 +143,7 @@ void __init omap_serial_init(void)
 				if (cpu_is_omap15xx())
 					clk_set_rate(uart1_ck, 12000000);
 			}
-			if (cpu_is_omap15xx()) {
+			if (cpu_is_omap15xx() && !(machine_is_ams_delta())) {
 				omap_cfg_reg(UART1_TX);
 				omap_cfg_reg(UART1_RTS);
 				if (machine_is_omap_innovator()) {
@@ -165,7 +165,7 @@ void __init omap_serial_init(void)
 				else
 					clk_set_rate(uart2_ck, 48000000);
 			}
-			if (cpu_is_omap15xx()) {
+			if (cpu_is_omap15xx() && !(machine_is_ams_delta())) {
 				omap_cfg_reg(UART2_TX);
 				omap_cfg_reg(UART2_RTS);
 				if (machine_is_omap_innovator()) {
@@ -185,7 +185,7 @@ void __init omap_serial_init(void)
 				if (cpu_is_omap15xx())
 					clk_set_rate(uart3_ck, 12000000);
 			}
-			if (cpu_is_omap15xx()) {
+			if (cpu_is_omap15xx() && !(machine_is_ams_delta())) {
 				omap_cfg_reg(UART3_TX);
 				omap_cfg_reg(UART3_RX);
 			}
