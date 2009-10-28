From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 2/3] OMAP UART: Add platform data for omap-serial driver.
Date: Wed, 28 Oct 2009 10:49:58 -0700
Message-ID: <87aazb5ry1.fsf@deeprootsystems.com>
References: <36298.192.168.10.88.1256714022.squirrel@dbdmail.itg.ti.com>
	<87ljiv5ved.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:45839 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbZJ1Rtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 13:49:55 -0400
Received: by pxi10 with SMTP id 10so735375pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 10:50:00 -0700 (PDT)
In-Reply-To: <87ljiv5ved.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 28 Oct 2009 09\:35\:22 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From 0f017ffac2990876331a2378e7845d91b2e0088c Mon Sep 17 00:00:00 2001
>> From: Govindraj R <govindraj.raja@ti.com>
>> Date: Wed, 28 Oct 2009 12:23:02 +0530
>> Subject: [PATCHv2 2/3] OMAP UART: Add platform data for omap-serial driver.
>>
>> This patch adds platform data support for omap-serial driver.
>>
>> Signed-off-by: Govindraj R <govindraj.raja@ti.com>

[...]

>> +#endif
>> +
>> +#ifdef CONFIG_SERIAL_OMAP
>
> Can you do this without the #ifdefs?
>
> Instead, we should drop the 8250 specifics from omap_uart_state.
>
> At first glance, the plat_serial8250_port pointer is passed around
> mainly so it can be passed to serial_read|write_reg().  If you changed
> that function to take an omap_uart_state instead, and add the base and
> regshift values to omap_uart_state you could get rid of the 8250
> pointer from omap_uart_state.
>
> Looks like omap_uart_state should also grow an irq field so
> omap_uart_idle_init() could work for both drivers.

Here's a quick first pass that shows that the plat_serial8250_port
pointer can easily be removed from omap_uart_state.

Next would be to cleanup the users of this pointer and move those
fields into omap_uart_state so that either 8250 or omap-serial init
could use them.

Kevin

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2e17b57..b082988 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -52,7 +52,6 @@ struct omap_uart_state {
 	struct clk *fck;
 	int clocked;
 
-	struct plat_serial8250_port *p;
 	struct list_head node;
 	struct platform_device pdev;
 
@@ -145,7 +144,7 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
  */
 static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 {
-	struct plat_serial8250_port *p = uart->p;
+	struct plat_serial8250_port *p = uart->pdev.dev.platform_data;
 
 	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
 	serial_write_reg(p, UART_OMAP_SCR, 0x08);
@@ -158,7 +157,7 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 static void omap_uart_save_context(struct omap_uart_state *uart)
 {
 	u16 lcr = 0;
-	struct plat_serial8250_port *p = uart->p;
+	struct plat_serial8250_port *p = uart->pdev.dev.platform_data;
 
 	if (!enable_off_mode)
 		return;
@@ -179,7 +178,7 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
 static void omap_uart_restore_context(struct omap_uart_state *uart)
 {
 	u16 efr = 0;
-	struct plat_serial8250_port *p = uart->p;
+	struct plat_serial8250_port *p = uart->pdev.dev.platform_data;
 
 	if (!enable_off_mode)
 		return;
@@ -275,7 +274,7 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
 					  int enable)
 {
-	struct plat_serial8250_port *p = uart->p;
+	struct plat_serial8250_port *p = uart->pdev.dev.platform_data;
 	u16 sysc;
 
 	sysc = serial_read_reg(p, UART_OMAP_SYSC) & 0x7;
@@ -407,7 +406,7 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
-	struct plat_serial8250_port *p = uart->p;
+	struct plat_serial8250_port *p = uart->pdev.dev.platform_data;
 	int ret;
 
 	uart->can_sleep = 0;
@@ -479,13 +478,15 @@ void omap_uart_enable_irqs(int enable)
 {
 	int ret;
 	struct omap_uart_state *uart;
+	struct plat_serial8250_port *p;
 
 	list_for_each_entry(uart, &uart_list, node) {
+		p = uart->pdev.dev.platform_data;
 		if (enable)
-			ret = request_irq(uart->p->irq, omap_uart_interrupt,
+			ret = request_irq(p->irq, omap_uart_interrupt,
 				IRQF_SHARED, "serial idle", (void *)uart);
 		else
-			free_irq(uart->p->irq, (void *)uart);
+			free_irq(p->irq, (void *)uart);
 	}
 }
 
@@ -621,7 +622,6 @@ void __init omap_serial_early_init(void)
 
 		uart->num = i;
 		p->private_data = uart;
-		uart->p = p;
 		list_add_tail(&uart->node, &uart_list);
 
 		if (cpu_is_omap44xx())
