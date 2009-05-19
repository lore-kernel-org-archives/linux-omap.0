From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP: PM: UART: zero sleep_timeout will disable timeout feature
Date: Tue, 19 May 2009 10:14:23 -0700
Message-ID: <1242753264-12600-2-git-send-email-khilman@deeprootsystems.com>
References: <1242753264-12600-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:46562 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbZESROe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 13:14:34 -0400
Received: by mail-px0-f191.google.com with SMTP id 29so2526560pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 10:14:36 -0700 (PDT)
In-Reply-To: <1242753264-12600-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Writing zero to /sys/devices/platform/serial8250.<uart>/sleep_timeout
will disable the timeout feature and prevent UART clocks from being
disabled.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0762165..c9059fd 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -235,7 +235,10 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 
 	omap_uart_smart_idle_enable(uart, 0);
 	uart->can_sleep = 0;
-	mod_timer(&uart->timer, jiffies + uart->timeout);
+	if (uart->timeout)
+		mod_timer(&uart->timer, jiffies + uart->timeout);
+	else
+		del_timer(&uart->timer);
 }
 
 static void omap_uart_allow_sleep(struct omap_uart_state *uart)
@@ -465,8 +468,14 @@ static ssize_t sleep_timeout_store(struct kobject *kobj,
 		return -EINVAL;
 	}
 	sleep_timeout = value * HZ;
-	list_for_each_entry(uart, &uart_list, node)
+	list_for_each_entry(uart, &uart_list, node) {
 		uart->timeout = sleep_timeout;
+		if (uart->timeout)
+			mod_timer(&uart->timer, jiffies + uart->timeout);
+		else
+			/* A zero value means disable timeout feature */
+			omap_uart_block_sleep(uart);
+	}
 	return n;
 }
 
-- 
1.6.2.2

