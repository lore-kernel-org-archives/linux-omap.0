From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] ARM:omap2: using strlcpy instead of strncpy
Date: Wed, 30 Jan 2013 19:46:49 +0800
Message-ID: <51090829.1010109@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:57821 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213Ab3A3Lqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 06:46:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


  the fields must be null-terminated:
  the caller may use it as null-terminted string, next.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-omap2/twl-common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index e49b40b..6a7aec6 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
 #include <linux/gpio.h>
+#include <linux/string.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
@@ -56,7 +57,7 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 			   struct twl4030_platform_data *pmic_data)
 {
 	omap_mux_init_signal("sys_nirq", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
-	strncpy(pmic_i2c_board_info.type, pmic_type,
+	strlcpy(pmic_i2c_board_info.type, pmic_type,
 		sizeof(pmic_i2c_board_info.type));
 	pmic_i2c_board_info.irq = pmic_irq;
 	pmic_i2c_board_info.platform_data = pmic_data;
-- 
1.7.10.4
