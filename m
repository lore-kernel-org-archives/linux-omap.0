From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/9] omap: Disable serial port autoidle by default
Date: Tue, 02 Feb 2010 18:26:18 -0800
Message-ID: <20100203022618.26347.51428.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59454 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab0BCCZu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 21:25:50 -0500
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

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
---
 arch/arm/mach-omap2/serial.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 8c964be..fa852f3 100644
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

