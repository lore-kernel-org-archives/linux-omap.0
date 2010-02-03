From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 9/9] omap: Disable serial port autoidle by default
Date: Tue, 2 Feb 2010 19:43:22 -0800
Message-ID: <20100203034322.GZ22747@atomide.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
 <20100203022618.26347.51428.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FN+gV9K+162wdwwF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58550 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab0BCDm5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 22:42:57 -0500
Content-Disposition: inline
In-Reply-To: <20100203022618.26347.51428.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100202 18:23]:
> Currently the omap serial clocks are autoidled after 5 seconds.
> However, this causes lost characters on the serial ports. As this
> is considered non-standard behaviour for Linux, disable the timeout.
> 
> Note that this will also cause blocking of any deeper omap sleep
> states.
> 
> To enable the autoidling of the serial ports, do something like
> this for each serial port:
> 
> # echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout
> # echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout
> ...

Turns out we also need to disable the timer in init, otherwise
the very first character after boot can get corrupt.

Updated version below, Kevin can you take one more look and see
if your S-O-B is still valid? :)

Regards,

Tony

--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=fix-8250-timeout

>From ff7ce25ec59223bf987ad209c1eb183031811c07 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 1 Feb 2010 12:34:31 -0800
Subject: [PATCH] omap: Disable serial port autoidle by default

Currently the omap serial clocks are autoidled after 5 seconds.
However, this causes lost characters on the serial ports. As this
is considered non-standard behaviour for Linux, disable the timeout.

Note that this will also cause blocking of any deeper omap sleep
states.

To enable the autoidling of the serial ports, do something like
this for each serial port:

# echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout
# echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout
...

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 8c964be..e10a02d 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -36,7 +36,13 @@
 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
-#define DEFAULT_TIMEOUT (5 * HZ)
+/*
+ * NOTE: By default the serial timeout is disabled as it causes lost characters
+ * over the serial ports. This means that the UART clocks will stay on until
+ * disabled via sysfs. This also causes that any deeper omap sleep states are
+ * blocked. 
+ */
+#define DEFAULT_TIMEOUT 0
 
 struct omap_uart_state {
 	int num;
@@ -422,7 +428,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	uart->timeout = DEFAULT_TIMEOUT;
 	setup_timer(&uart->timer, omap_uart_idle_timer,
 		    (unsigned long) uart);
-	mod_timer(&uart->timer, jiffies + uart->timeout);
+	if (uart->timeout)
+		mod_timer(&uart->timer, jiffies + uart->timeout);
 	omap_uart_smart_idle_enable(uart, 0);
 
 	if (cpu_is_omap34xx()) {

--FN+gV9K+162wdwwF--
