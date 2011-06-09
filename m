From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/3] HACK: OMAP: Serial: use PRCM wakeup events to enable clocks
Date: Thu, 9 Jun 2011 16:25:04 +0300
Message-ID: <1307625904-18629-4-git-send-email-t-kristo@ti.com>
References: <1307625904-18629-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47087 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757837Ab1FINZP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:25:15 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p59DPF2F015257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 9 Jun 2011 08:25:15 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p59DPFbb018839
	for <linux-omap@vger.kernel.org>; Thu, 9 Jun 2011 08:25:15 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p59DP2Dj020707
	for <linux-omap@vger.kernel.org>; Thu, 9 Jun 2011 08:25:14 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1307625904-18629-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch is just to test that the idea works generally, proper implementation
should be done for the OMAP UART driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c     |    4 ----
 arch/arm/mach-omap2/serial.c     |    3 +++
 drivers/tty/serial/omap-serial.c |    7 +++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index f70a9ad..ac6aa77 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -103,10 +103,6 @@ void omap4_enter_sleep(unsigned int cpu, unsigned int power_state)
 
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap2_gpio_resume_after_idle();
-		omap_uart_resume_idle(0);
-		omap_uart_resume_idle(1);
-		omap_uart_resume_idle(2);
-		omap_uart_resume_idle(3);
 	}
 
 	return;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 6959d65..4cf8c4a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -39,6 +39,7 @@
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/prcm.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
@@ -574,6 +575,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
 				   IRQF_SHARED, "serial idle", (void *)uart);
 	WARN_ON(ret);
+	ret = omap_prcm_register_pad_irq(uart->padconf, uart->irq);
+	WARN_ON(ret);
 }
 
 void omap_uart_enable_irqs(int enable)
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0275c28..cfe2e7c 100644
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
@@ -1303,6 +1309,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 		goto do_release_region;
 
 	platform_set_drvdata(pdev, up);
+	pr_info("OMAP UART %d is up\n", pdev->id);
 	return 0;
 err:
 	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

