From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/9] OMAP: remove OMAP_TAG_SERIAL_CONSOLE
Date: Tue, 11 Aug 2009 12:46:31 +0300
Message-ID: <20090811094631.32577.24255.stgit@localhost>
References: <20090811094348.32577.81307.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090811094348.32577.81307.stgit@localhost>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kalle Valo <kalle.valo@iki.fi>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Kalle Valo <kalle.valo@iki.fi>

Omap tags are deprecated and remove OMAP_TAG_SERIAL_CONSOLE. Console must be
enabled with the console boot parameter instead.

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
