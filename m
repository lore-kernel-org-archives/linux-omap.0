From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: omap1: board-ams-delta: fix cast
Date: Thu, 18 Nov 2010 19:59:50 +0200
Message-ID: <1290103191-360-6-git-send-email-aaro.koskinen@nokia.com>
References: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:44809 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759984Ab0KRR7u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 12:59:50 -0500
In-Reply-To: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Use IOMEM() macro to get rid of the following sparse warning:

	arch/arm/mach-omap1/board-ams-delta.c:319:36: warning: incorrect type in initializer (different address spaces)
	arch/arm/mach-omap1/board-ams-delta.c:319:36:    expected void [noderef] <asn:2>*membase
	arch/arm/mach-omap1/board-ams-delta.c:319:36:    got void *<noident>

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 1d4163b..1948cd3 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -28,6 +28,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/io.h>
 #include <plat/board-ams-delta.h>
 #include <mach/gpio.h>
 #include <plat/keypad.h>
@@ -316,7 +317,7 @@ static void __init ams_delta_init(void)
 
 static struct plat_serial8250_port ams_delta_modem_ports[] = {
 	{
-		.membase	= (void *) AMS_DELTA_MODEM_VIRT,
+		.membase	= IOMEM(AMS_DELTA_MODEM_VIRT),
 		.mapbase	= AMS_DELTA_MODEM_PHYS,
 		.irq		= -EINVAL, /* changed later */
 		.flags		= UPF_BOOT_AUTOCONF,
-- 
1.5.6.5

