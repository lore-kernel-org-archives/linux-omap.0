From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [PATCH v4 3/4] OMAP2+: use control module mfd driver in omap_type
Date: Wed, 25 Jul 2012 15:05:19 +0400
Message-ID: <500FD2EF.4010304@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060901030603030409040307"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:58838 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754155Ab2GYLFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 07:05:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

This is a multi-part message in MIME format.
--------------060901030603030409040307
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

OMAP system control module can be probed early, then
omap_type is safe to use its APIs.

TODO: add support for other omap versions

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
---
 arch/arm/mach-omap2/id.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 40373db..8018cad 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mfd/omap_control.h>
 
 #include <asm/cputype.h>
 
@@ -43,15 +44,15 @@ int omap_type(void)
 	u32 val = 0;
 
 	if (cpu_is_omap24xx()) {
-		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+		val = omap_control_status_read();
 	} else if (soc_is_am33xx()) {
-		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
+		val = omap_control_status_read();
 	} else if (cpu_is_omap34xx()) {
-		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
+		val = omap_control_status_read();
 	} else if (cpu_is_omap44xx()) {
-		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
+		val = omap_control_status_read();
 	} else if (soc_is_omap54xx()) {
-		val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
+		val = omap_control_status_read();
 		val &= OMAP5_DEVICETYPE_MASK;
 		val >>= 6;
 		goto out;
-- 
1.7.7.6


--------------060901030603030409040307
Content-Type: text/plain; charset=UTF-8;
 name="Attached Message Part"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Attached Message Part"


--------------060901030603030409040307--
