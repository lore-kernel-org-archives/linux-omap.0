From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 3/3] OMAP: serial: use chained interrupt handler for IO pad wakeup
Date: Fri, 17 Jun 2011 15:06:28 +0300
Message-ID: <1308312388-3952-4-git-send-email-t-kristo@ti.com>
References: <1308312388-3952-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54380 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799Ab1FQMHv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 08:07:51 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5HC7p8I009190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:07:51 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5HC7pcU024328
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:07:51 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5HC7Enc012126
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:07:50 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1308312388-3952-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/serial.c     |   30 +++++++++++-------------------
 drivers/tty/serial/omap-serial.c |    6 ++++++
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 1ac361b..4c76bca 100644
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
-
-			/* Check for IO pad wakeup */
-			if (cpu_is_omap34xx() && uart->padconf) {
-				u16 p = omap_ctrl_readw(uart->padconf);
+			omap_uart_block_sleep(uart);
 
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
@@ -550,6 +540,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
 				   IRQF_SHARED, "serial idle", (void *)uart);
 	WARN_ON(ret);
+	ret = omap_prcm_register_pad_irq(uart->padconf, uart->irq);
+	WARN_ON(ret);
 }
 
 void omap_uart_enable_irqs(int enable)
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 47cadf4..26af330 100644
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
@@ -947,6 +951,8 @@ serial_omap_console_write(struct console *co, const char *s,
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
 

