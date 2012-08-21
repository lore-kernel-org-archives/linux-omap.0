From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 12/13] serial: omap: drop unnecessary check from remove
Date: Tue, 21 Aug 2012 12:15:54 +0300
Message-ID: <1345540555-24359-13-git-send-email-balbi@ti.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:34511 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755355Ab2HUJUf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 05:20:35 -0400
Received: by lagv3 with SMTP id v3so3466254lag.6
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 02:20:31 -0700 (PDT)
In-Reply-To: <1345540555-24359-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alan@linux.intel.com
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Felipe Balbi <balbi@ti.com>

if platform_get_drvdata() returns NULL, that's
quite a nasty bug on the driver which we want to
catch ASAP. Otherwise, that check is hugely
unneeded.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ba9cdf1..25d2055 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1334,13 +1334,10 @@ static int serial_omap_remove(struct platform_device *dev)
 {
 	struct uart_omap_port *up = platform_get_drvdata(dev);
 
-	if (up) {
-		pm_runtime_disable(up->dev);
-		uart_remove_one_port(&serial_omap_reg, &up->port);
-		pm_qos_remove_request(&up->pm_qos_request);
-	}
+	pm_runtime_disable(up->dev);
+	uart_remove_one_port(&serial_omap_reg, &up->port);
+	pm_qos_remove_request(&up->pm_qos_request);
 
-	platform_set_drvdata(dev, NULL);
 	return 0;
 }
 
-- 
1.7.12.rc3

