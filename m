From: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Subject: Re: [PATCHv2 1/3] OMAP UART: Add omap-serial driver support.
Date: Wed, 28 Oct 2009 14:56:16 +0200
Message-ID: <1256734576.31092.23.camel@kauppi-desktop>
References: <35817.192.168.10.88.1256713979.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27650 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbZJ1M4T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 08:56:19 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9SCuLnm028850
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 07:56:24 -0500
Received: from [172.23.119.51] (ouped11951.nmp.nokia.com [172.23.119.51])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9SCuGtx032667
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 14:56:17 +0200
In-Reply-To: <35817.192.168.10.88.1256713979.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Wed, 2009-10-28 at 08:12 +0100, ext Govindraj.R wrote:
> From a3f0e5a13c1bc5046110cae513878183df2215c6 Mon Sep 17 00:00:00 2001
> From: Govindraj R <govindraj.raja@ti.com>
> Date: Wed, 28 Oct 2009 12:21:03 +0530
> Subject: [PATCHv2 1/3] OMAP UART: Add omap-serial driver support.
> 
> This patch adds support for OMAP3430-HIGH SPEED UART Controller.

On OMAP3630 a patch is needed for proper operation. Most probably this
does not break compatibility, at least similar fix to 8250.c worked fine
on OMAP3430 ES3.1.

-- clip --
>From f6d31ecfd74e0369c9162bdbcfb40b56aedd2a2b Mon Sep 17 00:00:00 2001
From: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
Date: Wed, 28 Oct 2009 12:02:47 +0200
Subject: [PATCH] omap-serial: Do not read UART_RX if UART_LSR_DR is not
set.

Causes external abort on non-linefetch with 3630 if the bit is not
checked.
---
 drivers/serial/omap-serial.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-serial.c
index 0239209..2a65a36 100644
--- a/drivers/serial/omap-serial.c
+++ b/drivers/serial/omap-serial.c
@@ -483,8 +483,8 @@ static int serial_omap_startup(struct uart_port
*port)
 	/*
 	 * Clear the interrupt registers.
 	 */
-	(void) serial_in(up, UART_LSR);
-	(void) serial_in(up, UART_RX);
+	if (serial_in(up, UART_LSR) & UART_LSR_DR)
+		(void) serial_in(up, UART_RX);
 	(void) serial_in(up, UART_IIR);
 	(void) serial_in(up, UART_MSR);
 
@@ -570,7 +570,8 @@ static void serial_omap_shutdown(struct uart_port
*port)
 	/*
 	 * Read data port to reset things, and then free the irq
 	 */
-	(void) serial_in(up, UART_RX);
+	if (serial_in(up, UART_LSR) & UART_LSR_DR)
+		(void) serial_in(up, UART_RX);
 	if (up->use_dma) {
 		int tmp;
 		if (up->is_buf_dma_alloced) {
-- 
1.6.4.2

-- clip --

--
Ari

