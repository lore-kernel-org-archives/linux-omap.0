From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/14] OMAP2/3/4: UART: allow in-order port traversal
Date: Tue, 21 Jul 2009 15:08:36 -0700
Message-ID: <1248214120-18886-11-git-send-email-khilman@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-2-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-4-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-5-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-6-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-7-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-8-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-9-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-10-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:7329 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbZGUWJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:09:07 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1009646wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:09:08 -0700 (PDT)
In-Reply-To: <1248214120-18886-10-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Use list_add_tail() when adding discovered UART ports.  This is so
traversal using list_for_each_entry() will traverse the list in the
order they were found.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 6f35a7e..a7421a5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -601,7 +601,7 @@ void __init omap_serial_init(void)
 		uart->num = i;
 		p->private_data = uart;
 		uart->p = p;
-		list_add(&uart->node, &uart_list);
+		list_add_tail(&uart->node, &uart_list);
 
 		if (cpu_is_omap44xx())
 			p->irq += 32;
-- 
1.6.3.3

