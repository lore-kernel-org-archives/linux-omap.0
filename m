From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/2] ARM: OMAP4: TWL6030: ensure sys_nirq1 is mux'd and wakeup enabled
Date: Thu, 28 Jun 2012 10:01:32 -0700
Message-ID: <1340902892-9542-3-git-send-email-khilman@ti.com>
References: <1340902892-9542-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44288 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755712Ab2F1RBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 13:01:45 -0400
Received: by dadz8 with SMTP id z8so3463891dad.7
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 10:01:39 -0700 (PDT)
In-Reply-To: <1340902892-9542-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The SYS_NIRQ1 pin is the interupt line for the PMIC part of the TWL6030
and interrupts from the PMIC are needed as wakeup sources.

Ensure this pin is mux'd as input and has wakeup enabled so PMIC
interupts (e.g. RTC) can be used as wakeup sources.

Tested on OMAP4430/Panda.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 119d5a9..43a9790 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -32,6 +32,7 @@
 #include "twl-common.h"
 #include "pm.h"
 #include "voltage.h"
+#include "mux.h"
 
 static struct i2c_board_info __initdata pmic_i2c_board_info = {
 	.addr		= 0x48,
@@ -77,6 +78,7 @@ void __init omap4_pmic_init(const char *pmic_type,
 		    struct twl6040_platform_data *twl6040_data, int twl6040_irq)
 {
 	/* PMIC part*/
+	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
 	strncpy(omap4_i2c1_board_info[0].type, pmic_type,
 		sizeof(omap4_i2c1_board_info[0].type));
 	omap4_i2c1_board_info[0].irq = OMAP44XX_IRQ_SYS_1N;
-- 
1.7.9.2

