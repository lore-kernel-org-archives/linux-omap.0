From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 5/6] OMAP3: Serial: Made serial to work properly with PRCM chain handler
Date: Wed, 22 Jun 2011 19:42:13 +0300
Message-ID: <1308760934-9757-6-git-send-email-t-kristo@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47916 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602Ab1FVQml convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 12:42:41 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5MGgfn6014117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:41 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5MGgfa2005642
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:41 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5MGgd7b012136
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:40 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 -------------------
 arch/arm/mach-omap2/serial.c |   40 +++++++++++++++++++++-------------------
 2 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ff0811a..6fff894 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -340,18 +340,9 @@ void omap_sram_idle(void)
 		omap3_enable_io_chain();
 	}
 
-	/* Block console output in case it is on one of the OMAP UARTs */
-	if (!is_suspending())
-		if (per_next_state < PWRDM_POWER_ON ||
-		    core_next_state < PWRDM_POWER_ON)
-			if (!console_trylock())
-				goto console_still_active;
-
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
-		omap_uart_prepare_idle(2);
-		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_going_off);
 		if (per_next_state == PWRDM_POWER_OFF)
 				omap3_per_save_context();
@@ -359,8 +350,6 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(0);
-		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
@@ -407,8 +396,6 @@ void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		omap_uart_resume_idle(0);
-		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
 			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
@@ -422,14 +409,8 @@ void omap_sram_idle(void)
 		omap2_gpio_resume_after_idle();
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
-		omap_uart_resume_idle(2);
-		omap_uart_resume_idle(3);
 	}
 
-	if (!is_suspending())
-		console_unlock();
-
-console_still_active:
 	/* Disable IO-PAD and IO-CHAIN wakeup */
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 1ac361b..e4a5a8c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -39,6 +39,7 @@
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/prcm.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
@@ -280,24 +281,34 @@ static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
 
 static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 {
+	int locked;
+
 	if (uart->clocked)
 		return;
 
+	locked = console_trylock();
 	omap_device_enable(uart->pdev);
 	uart->clocked = 1;
 	omap_uart_restore_context(uart);
+	if (locked)
+		console_unlock();
 }
 
 #ifdef CONFIG_PM
 
 static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 {
+	int locked;
+
 	if (!uart->clocked)
 		return;
 
+	locked = console_trylock();
 	omap_uart_save_context(uart);
 	uart->clocked = 0;
 	omap_device_idle(uart->pdev);
+	if (locked)
+		console_unlock();
 }
 
 static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
@@ -380,6 +391,7 @@ static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 	omap_uart_smart_idle_enable(uart, 1);
 	uart->can_sleep = 1;
 	del_timer(&uart->timer);
+	omap_uart_disable_clocks(uart);
 }
 
 static void omap_uart_idle_timer(unsigned long data)
@@ -391,35 +403,23 @@ static void omap_uart_idle_timer(unsigned long data)
 
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
@@ -550,6 +550,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
 				   IRQF_SHARED, "serial idle", (void *)uart);
 	WARN_ON(ret);
+	ret = omap_prcm_register_pad_irq(uart->padconf, uart->irq);
+	WARN_ON(ret);
 }
 
 void omap_uart_enable_irqs(int enable)
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

