From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V3 2/3] rtc: omap: Update Kconfig for OMAP RTC
Date: Fri, 24 Oct 2014 10:23:44 +0530
Message-ID: <1414126425-13198-3-git-send-email-lokeshvutla@ti.com>
References: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55832 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092AbaJXEz5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2014 00:55:57 -0400
In-Reply-To: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, a.zummo@towertech.it, johan@kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, akpm@linux-foundation.org, linux@roeck-us.net, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, lokeshvutla@ti.com

From: Tero Kristo <t-kristo@ti.com>

RTC is present in AM43xx and DRA7xx also. Updating the Kconfig
to depend on ARCH_OMAP or ARCH_DAVINCI

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/rtc/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 94ae179..8dfcb1b 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1001,11 +1001,11 @@ config RTC_DRV_IMXDI
 	   will be called "rtc-imxdi".
 
 config RTC_DRV_OMAP
-	tristate "TI OMAP1"
-	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX
+	tristate "TI OMAP Real Time Clock"
+	depends on ARCH_OMAP || ARCH_DAVINCI
 	help
 	  Say "yes" here to support the on chip real time clock
-	  present on TI OMAP1, AM33xx and DA8xx/OMAP-L13x.
+	  present on TI OMAP1, AM33xx, DA8xx/OMAP-L13x, AM43xx and DRA7xx.
 
 	  This driver can also be built as a module, if so, module
 	  will be called rtc-omap.
-- 
1.9.1

