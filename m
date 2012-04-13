From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP: serial: Fix the ocp smart idlemode handling bug
Date: Fri, 13 Apr 2012 23:25:04 +0530
Message-ID: <1334339704-4554-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48219 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab2DMRzS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 13:55:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

The current serial UART code, while fidling with ocp idlemode bits,
forget about the smart idle wakeup bit even if it is supported by
UART IP block. This will lead to missing the module wakeup on OMAP's
where the smart idle wakeup is supported.

This was the root cause of the console sluggishness issue, I have been
observing on OMAP4 devices and also can be potential reason for some
other UART wakeup issues.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/serial.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c9503a7..b28aae1 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -108,8 +108,14 @@ static void omap_uart_set_noidle(struct platform_device *pdev)
 static void omap_uart_set_smartidle(struct platform_device *pdev)
 {
 	struct omap_device *od = to_omap_device(pdev);
+	u8 idlemode;
 
-	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_SMART);
+	if (od->hwmods[0]->class->sysc->idlemodes & SIDLE_SMART_WKUP)
+		idlemode = HWMOD_IDLEMODE_SMART_WKUP;
+	else
+		idlemode = HWMOD_IDLEMODE_SMART;
+
+	omap_hwmod_set_slave_idlemode(od->hwmods[0], idlemode);
 }
 
 #else
-- 
1.7.5.4

