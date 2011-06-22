From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 6/6] OMAP3: Serial tty: Added resume_idle calls to critical points
Date: Wed, 22 Jun 2011 19:42:14 +0300
Message-ID: <1308760934-9757-7-git-send-email-t-kristo@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60483 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab1FVQmm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 12:42:42 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5MGgfrb010217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:41 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5MGgfaJ000759
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:41 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5MGgd7c012136
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:41 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Any tty access should enable UART port first if it is idle.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/tty/serial/omap-serial.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

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
 

