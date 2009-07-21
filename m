From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/14] OMAP4: UART: cleanup special case IRQ handling
Date: Tue, 21 Jul 2009 15:08:33 -0700
Message-ID: <1248214120-18886-8-git-send-email-khilman@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-2-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-4-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-5-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-6-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:42991 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343AbZGUWI7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:08:59 -0400
Received: by mail-pz0-f204.google.com with SMTP id 42so701151pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:09:00 -0700 (PDT)
In-Reply-To: <1248214120-18886-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Streamline the OMAP4 special IRQ assignments by putting inside
normal init loop instead of having a separate loop.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b094c15..c82ec95 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -496,10 +496,6 @@ void __init omap_serial_init(void)
 
 	if (info == NULL)
 		return;
-	if (cpu_is_omap44xx()) {
-		for (i = 0; i < OMAP_MAX_NR_PORTS; i++)
-			serial_platform_data[i].irq += 32;
-	}
 
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		struct plat_serial8250_port *p = serial_platform_data + i;
@@ -533,6 +529,9 @@ void __init omap_serial_init(void)
 		uart->p = p;
 		list_add(&uart->node, &uart_list);
 
+		if (cpu_is_omap44xx())
+			p->irq += 32;
+
 		omap_uart_enable_clocks(uart);
 		omap_uart_reset(uart);
 		omap_uart_idle_init(uart);
-- 
1.6.3.3

