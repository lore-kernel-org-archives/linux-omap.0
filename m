From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2] ARM: OMAP2: UART: fix console UART mismatched runtime PM status
Date: Fri, 19 Oct 2012 15:24:30 -0700
Message-ID: <1350685470-3634-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49749 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab2JSWYe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 18:24:34 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so672922pad.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Oct 2012 15:24:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>

From: Kevin Hilman <khilman@ti.com>

The runtime PM framework assumes that the hardware state of devices
when initialized is disabled.  For all omap_devices, we idle/disable
device by default.  However, the console uart uses a "no idle" option
during omap_device init in order to allow earlyprintk usage to work
seamlessly during boot.

Because the hardware is left partially enabled after init (whatever
the bootloader settings were), the omap_device should later be fully
initialized (including mux) and the runtime PM framework should be
told that the device is active, and not disabled so that the hardware
state is in sync with runtime PM state.

To fix, after the device has been created/registered, call
omap_device_enable() to finialize init and use pm_runtime_set_active()
to tell the runtime PM core the device is enabled.

Tested on 2420/n810, 3530/Overo, 3530/Beagle, 3730/OveroSTORM,
3730/Beagle-xM, 4460/PandaES.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v3.7-rc1.
v2: call omap_device_enable() only after oh->mux has been initialized
    otherwise, IO ring wakeups not properly enabled.

 arch/arm/mach-omap2/serial.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0405c81..a507cd6 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -329,6 +329,11 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
+	if (console_uart_id == bdata->id) {
+		omap_device_enable(pdev);
+		pm_runtime_set_active(&pdev->dev);
+	}
+
 	oh->dev_attr = uart;
 
 	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
-- 
1.7.9.2

