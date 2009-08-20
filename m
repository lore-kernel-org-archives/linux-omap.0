From: Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 3/3] Regulator: Adding TPS65023 and TPS6507x in Kconfig and Makefile
Date: Fri, 21 Aug 2009 00:39:44 +0530
Message-ID: <1250795384-29924-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding TPS65023 and TPS6507x regulator driver support in
drivers/regulator/Makefile and drivers/regulator/Kconfig

Signed-off-by: Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>
---
 drivers/regulator/Kconfig  |   16 ++++++++++++++++
 drivers/regulator/Makefile |    3 +++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index f431779..8568f3e 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -117,4 +117,20 @@ config REGULATOR_LP3971
 	 Say Y here to support the voltage regulators and convertors
 	 on National Semiconductors LP3971 PMIC
 
+config REGULATOR_TPS65023
+	tristate "TI TPS65023 Power regulators"
+	depends on I2C
+	help
+	  This driver supports TPS65023 voltage regulator chips. TPS65023 provides
+	  three step-down converters and two general-purpose LDO voltage regulators.
+	  It supports TI's software based Class-2 SmartReflex implementation.
+
+config REGULATOR_TPS6507X
+	tristate "TI TPS6507X Power regulators"
+	depends on I2C
+	help
+	  This driver supports TPS6507X voltage regulator chips. TPS6507X provides
+	  three step-down converters and two general-purpose LDO voltage regulators.
+	  It supports TI's software based Class-2 SmartReflex implementation.
+
 endif
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 4d762c4..5263913 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -17,4 +17,7 @@ obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_PCF50633) += pcf50633-regulator.o
 
+obj-$(CONFIG_REGULATOR_TPS65023) += tps65023-regulator.o
+obj-$(CONFIG_REGULATOR_TPS6507X) += tps6507x-regulator.o
+
 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
-- 
1.6.2.4
