From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 4/4] OMAP: PM: disable idle on suspend for GPIO and UART
Date: Mon, 11 Jul 2011 16:29:29 -0700
Message-ID: <1310426969-30306-5-git-send-email-khilman@ti.com>
References: <1310426969-30306-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:46635 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758556Ab1GKX3q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 19:29:46 -0400
Received: by mail-iw0-f178.google.com with SMTP id 10so5756840iwc.23
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 16:29:45 -0700 (PDT)
In-Reply-To: <1310426969-30306-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org

Until these drivers are runtime PM converted, their device power
states are managed by calling custom driver hooks late in the
idle/suspend path.  Therefore, do not let the suspend/resume core code
automatically idle these devices since they will be managed manually
by the OMAP PM core very late in the idle/suspend path.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/gpio.c   |    2 ++
 arch/arm/mach-omap2/serial.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9529842..48e5ece 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -87,6 +87,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return PTR_ERR(od);
 	}
 
+	omap_device_disable_idle_on_suspend(od);
+
 	gpio_bank_count++;
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 1ac361b..466fc722 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -805,6 +805,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
 	     name, oh->name);
 
+	omap_device_disable_idle_on_suspend(od);
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
 	uart->irq = oh->mpu_irqs[0].irq;
-- 
1.7.6

