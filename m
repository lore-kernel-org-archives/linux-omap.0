From: Kalle Valo <kalle.valo@iki.fi>
Subject: [PATCH 1/2] OMAP: remove OMAP_TAG_SERIAL_CONSOLE
Date: Fri, 07 Aug 2009 08:16:44 +0300
Message-ID: <20090807051643.4787.85971.stgit@tikku>
References: <20090807051516.4787.36125.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:47790 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbZHGF0O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 01:26:14 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 3552EC7BF3
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2009 08:16:45 +0300 (EEST)
Received: from [127.0.1.1] (a91-155-131-184.elisa-laajakaista.fi [91.155.131.184])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 2160A4047
	for <linux-omap@vger.kernel.org>; Fri,  7 Aug 2009 08:16:44 +0300 (EEST)
In-Reply-To: <20090807051516.4787.36125.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Omap tags are deprecated and remove OMAP_TAG_SERIAL_CONSOLE. Console must be
enabled with the console boot parameter instead.

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
---

 arch/arm/plat-omap/common.c             |   44 -------------------------------
 arch/arm/plat-omap/include/mach/board.h |    1 -
 2 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index ebcf006..f37a29a 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -127,50 +127,6 @@ const void *omap_get_var_config(u16 tag, size_t *len)
 }
 EXPORT_SYMBOL(omap_get_var_config);
 
-static int __init omap_add_serial_console(void)
-{
-	const struct omap_serial_console_config *con_info;
-	const struct omap_uart_config *uart_info;
-	static char speed[11], *opt = NULL;
-	int line, i, uart_idx;
-
-	uart_info = omap_get_config(OMAP_TAG_UART, struct omap_uart_config);
-	con_info = omap_get_config(OMAP_TAG_SERIAL_CONSOLE,
-					struct omap_serial_console_config);
-	if (uart_info == NULL || con_info == NULL)
-		return 0;
-
-	if (con_info->console_uart == 0)
-		return 0;
-
-	if (con_info->console_speed) {
-		snprintf(speed, sizeof(speed), "%u", con_info->console_speed);
-		opt = speed;
-	}
-
-	uart_idx = con_info->console_uart - 1;
-	if (uart_idx >= OMAP_MAX_NR_PORTS) {
-		printk(KERN_INFO "Console: external UART#%d. "
-			"Not adding it as console this time.\n",
-			uart_idx + 1);
-		return 0;
-	}
-	if (!(uart_info->enabled_uarts & (1 << uart_idx))) {
-		printk(KERN_ERR "Console: Selected UART#%d is "
-			"not enabled for this platform\n",
-			uart_idx + 1);
-		return -1;
-	}
-	line = 0;
-	for (i = 0; i < uart_idx; i++) {
-		if (uart_info->enabled_uarts & (1 << i))
-			line++;
-	}
-	return add_preferred_console("ttyS", line, opt);
-}
-console_initcall(omap_add_serial_console);
-
-
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
  * OMAP 730 and 1510.  Other timers could be used as clocksources, with
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 50ea79a..0d12586 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -16,7 +16,6 @@
 
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
-#define OMAP_TAG_SERIAL_CONSOLE 0x4f03
 #define OMAP_TAG_LCD		0x4f05
 #define OMAP_TAG_GPIO_SWITCH	0x4f06
 #define OMAP_TAG_UART		0x4f07

