From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/17] serial/8250: Limit the omap workarounds to omap1
Date: Mon, 10 Sep 2012 22:31:04 -0700
Message-ID: <20120911053104.29637.95283.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48050 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753982Ab2IKFbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:31:06 -0400
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

These workarounds do not apply for CONFIG_ARCH_OMAP2PLUS at all,
so let's make it just CONFIG_ARCH_OMAP1.

This is needed to for ARM common zImage changes for
omap2+ to avoid including plat and mach headers.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 8123f78..5b3f2fe 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -2336,7 +2336,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 			serial_port_out(port, UART_EFR, efr);
 	}
 
-#ifdef CONFIG_ARCH_OMAP
+#ifdef CONFIG_ARCH_OMAP1
 	/* Workaround to enable 115200 baud on OMAP1510 internal ports */
 	if (cpu_is_omap1510() && is_omap_port(up)) {
 		if (baud == 115200) {
@@ -2426,7 +2426,7 @@ static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
 	if (pt->port.iotype == UPIO_AU)
 		return 0x1000;
-#ifdef CONFIG_ARCH_OMAP
+#ifdef CONFIG_ARCH_OMAP1
 	if (is_omap_port(pt))
 		return 0x16 << pt->port.regshift;
 #endif

