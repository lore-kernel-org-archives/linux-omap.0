From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 4/9] TEMP: OMAP3: Serial: Made serial to work properly with PRCM chain handler
Date: Wed, 29 Jun 2011 12:04:58 +0300
Message-ID: <1309338303-2086-5-git-send-email-t-kristo@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45691 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822Ab1F2JFS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 05:05:18 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5T95H7i031283
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:17 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5T95HKw004553
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:17 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5T95GCP009169
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:17 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch is just a temporary hack to allow serial to work properly with
the PRCM chain handler. Should be replaced with a proper implementation.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/serial.c     |   28 +++++++++-------------------
 drivers/tty/serial/omap-serial.c |    8 ++++++++
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 1ac361b..067a86b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -39,6 +39,7 @@
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/prcm.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
@@ -380,6 +381,7 @@ static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 	omap_uart_smart_idle_enable(uart, 1);
 	uart->can_sleep = 1;
 	del_timer(&uart->timer);
+	omap_uart_disable_clocks(uart);
 }
 
 static void omap_uart_idle_timer(unsigned long data)
@@ -391,35 +393,23 @@ static void omap_uart_idle_timer(unsigned long data)
 
 void omap_uart_prepare_idle(int num)
 {
-	struct omap_uart_state *uart;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
-			return;
-		}
-	}
 }
 
 void omap_uart_resume_idle(int num)
 {
 	struct omap_uart_state *uart;
+	u32 wkst;
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (num == uart->num && uart->can_sleep) {
-			omap_uart_enable_clocks(uart);
+			omap_uart_block_sleep(uart);
 
-			/* Check for IO pad wakeup */
-			if (cpu_is_omap34xx() && uart->padconf) {
-				u16 p = omap_ctrl_readw(uart->padconf);
-
-				if (p & OMAP3_PADCONF_WAKEUPEVENT0)
-					omap_uart_block_sleep(uart);
+			/* Check for normal UART wakeup (and clear it) */
+			if (uart->wk_st && uart->wk_mask) {
+				wkst = __raw_readl(uart->wk_st) & uart->wk_mask;
+				if (wkst)
+					__raw_writel(wkst, uart->wk_st);
 			}
-
-			/* Check for normal UART wakeup */
-			if (__raw_readl(uart->wk_st) & uart->wk_mask)
-				omap_uart_block_sleep(uart);
 			return;
 		}
 	}
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 47cadf4..bd6ae02 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -261,6 +261,8 @@ static void serial_omap_start_tx(struct uart_port *port)
 	unsigned int start;
 	int ret = 0;
 
+	omap_uart_resume_idle(up->pdev->id);
+
 	if (!up->use_dma) {
 		serial_omap_enable_ier_thri(up);
 		return;
@@ -354,6 +356,8 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	unsigned int iir, lsr;
 	unsigned long flags;
 
+	omap_uart_resume_idle(up->pdev->id);
+
 	iir = serial_in(up, UART_IIR);
 	if (iir & UART_IIR_NO_INT)
 		return IRQ_NONE;
@@ -641,6 +645,8 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long flags = 0;
 	unsigned int baud, quot;
 
+	omap_uart_resume_idle(up->pdev->id);
+
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
 		cval = UART_LCR_WLEN5;
@@ -947,6 +953,8 @@ serial_omap_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
+	omap_uart_resume_idle(up->pdev->id);
+
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

