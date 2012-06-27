From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [PATCH v3 3/7] OMAP2+: use control module mfd driver in omap_type
Date: Wed, 27 Jun 2012 22:04:58 +0400
Message-ID: <4FEB4B4A.1040204@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:52677 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756107Ab2F0SE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 14:04:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

OMAP system control module can be probed early, then
omap_type is safe to use its APIs.

TODO: add support for other omap versions

Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
---
 arch/arm/mach-omap2/id.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 00486a8..1b0cec8 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mfd/omap_control.h>
 
 #include <asm/cputype.h>
 
@@ -43,13 +44,13 @@ int omap_type(void)
 	u32 val = 0;
 
 	if (cpu_is_omap24xx()) {
-		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+		val = omap_control_status_read(OMAP24XX_CONTROL_STATUS);
 	} else if (cpu_is_am33xx()) {
-		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
+		val = omap_control_status_read(AM33XX_CONTROL_STATUS);
 	} else if (cpu_is_omap34xx()) {
-		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
+		val = omap_control_status_read(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
-		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
+		val = omap_control_status_read(OMAP4_CTRL_MODULE_CORE_STATUS);
 	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
-- 
1.7.7.6


