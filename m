From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 3/4] rtc: omap: Update Kconfig for OMAP RTC
Date: Thu, 25 Sep 2014 15:02:08 +0530
Message-ID: <1411637529-18289-4-git-send-email-lokeshvutla@ti.com>
References: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rtc-linux@googlegroups.com, a.zummo@towertech.it
Cc: devicetree@vger.kernel.org, tony@atomide.com, j-keerthy@ti.com, nsekhar@ti.com, balbi@ti.com, t-kristo@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

RTC is present in AM43xx and DRA7xx also. Updating the
same in Kconfig.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
Changes since v1:
	- New patch
 drivers/rtc/Kconfig    | 6 +++---
 drivers/rtc/rtc-omap.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a168e96..b092e2f 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -971,11 +971,11 @@ config RTC_DRV_IMXDI
 	   will be called "rtc-imxdi".
 
 config RTC_DRV_OMAP
-	tristate "TI OMAP1"
-	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX
+	tristate "TI OMAP Real Time Clock"
+	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX || SOC_DRA7XX || SOC_AM43XX
 	help
 	  Say "yes" here to support the on chip real time clock
-	  present on TI OMAP1, AM33xx and DA8xx/OMAP-L13x.
+	  present on TI OMAP1, AM33xx, DA8xx/OMAP-L13x, AM43xx and DRA7xx.
 
 	  This driver can also be built as a module, if so, module
 	  will be called rtc-omap.
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 93c5424..f28f1fd 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -1,5 +1,5 @@
 /*
- * TI OMAP1 Real Time Clock interface for Linux
+ * TI OMAP Real Time Clock interface for Linux
  *
  * Copyright (C) 2003 MontaVista Software, Inc.
  * Author: George G. Davis <gdavis@mvista.com> or <source@mvista.com>
@@ -25,7 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/io.h>
 
-/* The OMAP1 RTC is a year/month/day/hours/minutes/seconds BCD clock
+/* The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
  * with century-range alarm matching, driven by the 32kHz clock.
  *
  * The main user-visible ways it differs from PC RTCs are by omitting
-- 
1.9.1
