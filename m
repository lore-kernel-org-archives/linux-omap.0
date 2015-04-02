From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 2/3] rtc: omap: Update Kconfig for OMAP RTC
Date: Thu, 2 Apr 2015 16:39:10 +0530
Message-ID: <1427972951-18959-3-git-send-email-lokeshvutla@ti.com>
References: <1427972951-18959-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36166 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbbDBLKc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Apr 2015 07:10:32 -0400
In-Reply-To: <1427972951-18959-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, rtc-linux@googlegroups.com
Cc: t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lokeshvutla@ti.com, alexandre.belloni@free-electrons.com

RTC is present in AM43xx and DRA7xx also. Updating the Kconfig
to depend on ARCH_OMAP or ARCH_DAVINCI

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b5b5c3d..40faf56 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1121,11 +1121,11 @@ config RTC_DRV_IMXDI
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

