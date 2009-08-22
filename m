From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2 v2] ARM: OMAP4: Bypass the clock check.
Date: Sat, 22 Aug 2009 13:30:12 +0530
Message-ID: <1250928012-5233-2-git-send-email-santosh.shilimkar@ti.com>
References: <1250928012-5233-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51962 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301AbZHVIAu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Aug 2009 04:00:50 -0400
In-Reply-To: <1250928012-5233-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com, rmk@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>

Second reason of OMAP4 boot failure on 2.6.31.rc6, the UART
platform data is not getting registered to kernel.
Registration was failing because of clock check failure in
omap_serial_init().
Below patch fix the same.

OMAP4 clock framework patches are still getting discussed on mailing
list so till then we need this.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index e1be77b..6bbdfe0 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -620,8 +620,11 @@ void __init omap_serial_init(void)
 			uart->fck = NULL;
 		}
 
-		if (!uart->ick || !uart->fck)
-			continue;
+		/* FIXME: Remove this once the clkdev is ready */
+		if (!cpu_is_omap44xx()) {
+			if (!uart->ick || !uart->fck)
+				continue;
+		}
 
 		uart->num = i;
 		p->private_data = uart;
-- 
1.5.4.7

