From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 2/3] serial: omap: fix omap lock crap
Date: Thu, 1 Aug 2013 15:12:44 +0300
Message-ID: <1375359165-8411-3-git-send-email-balbi@ti.com>
References: <1375359165-8411-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51360 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754903Ab3HAMOM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 08:14:12 -0400
In-Reply-To: <1375359165-8411-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <balbi@ti.com>

From: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b6d1728..7882d25 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1170,13 +1170,10 @@ serial_omap_console_write(struct console *co, const char *s,
 
 	pm_runtime_get_sync(up->dev);
 
-	local_irq_save(flags);
-	if (up->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = spin_trylock(&up->port.lock);
+	if (up->port.sysrq || oops_in_progress)
+		locked = spin_trylock_irqsave(&up->port.lock, flags);
 	else
-		spin_lock(&up->port.lock);
+		spin_lock_irqsave(&up->port.lock, flags);
 
 	/*
 	 * First save the IER then disable the interrupts
@@ -1205,8 +1202,7 @@ serial_omap_console_write(struct console *co, const char *s,
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 	if (locked)
-		spin_unlock(&up->port.lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static int __init
-- 
1.8.3.4.840.g6a90778

