From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2] ARM: OMAP4: Bypass the clock check.
Date: Thu, 20 Aug 2009 22:04:26 +0530
Message-ID: <1250786066-29777-2-git-send-email-santosh.shilimkar@ti.com>
References: <1250786066-29777-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48805 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbZHTQef (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 12:34:35 -0400
In-Reply-To: <1250786066-29777-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>

Second reason of OMAP4 boot failure on 2.6.31.rc6, the UART
platform data is not getting registered to kernel.
Registration was failing because of clock check failure in
omap_serial_init().
Below patch fix the same.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/serial.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index e1be77b..e8d55f4 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -620,8 +620,10 @@ void __init omap_serial_init(void)
 			uart->fck = NULL;
 		}
 
-		if (!uart->ick || !uart->fck)
-			continue;
+		if (!cpu_is_omap44xx()) {
+			if (!uart->ick || !uart->fck)
+				continue;
+		}
 
 		uart->num = i;
 		p->private_data = uart;
-- 
1.5.4.7

