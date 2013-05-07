From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH] ARM: OMAP2+: omap_device: use late_initcall_sync
Date: Tue,  7 May 2013 14:39:25 -0700
Message-ID: <1367962765-13912-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:52502 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759421Ab3EGVj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 May 2013 17:39:29 -0400
Received: by mail-pb0-f41.google.com with SMTP id mc17so719044pbc.14
        for <linux-omap@vger.kernel.org>; Tue, 07 May 2013 14:39:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

If DEBUG_LL and earlyprintk are enabled, and omap-serial.c is compiled
as a module, the kernel boot hangs early as the clocks for serial port
are cut while earlyprintk still uses the port.

The problem is a race between the late_initcall for omap_device (which
idles devices that have no drivers) and the late_initcall in
kernel/printk.c which turns off the earlyconsole.   Any printks
that happen between this omap_device late initcall and the earlyconsole
late initcall will crash when accessing the UART.

The fix is to ensure the omap_device initcall happens after the
earlyconsole initcall.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Based on v3.9-rc8

 arch/arm/mach-omap2/omap_device.c | 2 +-
 arch/arm/mach-omap2/soc.h         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 381be7a..2d20d69 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -879,4 +879,4 @@ static int __init omap_device_late_init(void)
 	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
 	return 0;
 }
-omap_late_initcall(omap_device_late_init);
+omap_late_initcall_sync(omap_device_late_init);
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index c62116b..de88611 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -494,6 +494,7 @@ level(__##fn);
 #define omap_subsys_initcall(fn)	omap_initcall(subsys_initcall, fn)
 #define omap_device_initcall(fn)	omap_initcall(device_initcall, fn)
 #define omap_late_initcall(fn)		omap_initcall(late_initcall, fn)
+#define omap_late_initcall_sync(fn)	omap_initcall(late_initcall_sync, fn)
 
 #endif	/* __ASSEMBLY__ */
 
-- 
1.8.2

