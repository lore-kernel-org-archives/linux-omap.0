From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/4] cbus: move <plat/cbus.h> to <linux/platform_data/cbus.h>
Date: Thu, 16 Jun 2011 14:27:15 +0300
Message-ID: <1308223638-9634-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44451 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754478Ab1FPL1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 07:27:24 -0400
Received: by mail-fx0-f50.google.com with SMTP id 16so1349679fxm.23
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 04:27:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

it's a much more sensible location for that
sort of thing.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c   |    2 +-
 arch/arm/mach-omap2/board-n8x0.c       |    2 +-
 arch/arm/plat-omap/include/plat/cbus.h |   40 --------------------------------
 drivers/cbus/cbus.c                    |    3 +-
 drivers/cbus/retu.c                    |    2 +-
 include/linux/platform_data/cbus.h     |   40 ++++++++++++++++++++++++++++++++
 6 files changed, 44 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/cbus.h
 create mode 100644 include/linux/platform_data/cbus.h

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 676d99f..7990c48 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/cbus.h>
 #include <linux/irq.h>
 #include <linux/input.h>
 #include <linux/clk.h>
@@ -37,7 +38,6 @@
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
 #include <plat/clock.h>
-#include <plat/cbus.h>
 
 #define ADS7846_PENDOWN_GPIO	15
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index b61ac1d..b3e80c9 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/stddef.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/cbus.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/usb/musb.h>
@@ -35,7 +36,6 @@
 #include <plat/onenand.h>
 #include <plat/mmc.h>
 #include <plat/serial.h>
-#include <plat/cbus.h>
 
 #include "mux.h"
 
diff --git a/arch/arm/plat-omap/include/plat/cbus.h b/arch/arm/plat-omap/include/plat/cbus.h
deleted file mode 100644
index 563b1c2..0000000
--- a/arch/arm/plat-omap/include/plat/cbus.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * cbus.h - CBUS platform_data definition
- *
- * Copyright (C) 2004 - 2009 Nokia Corporation
- *
- * Written by Felipe Balbi <felipe.balbi@nokia.com>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file "COPYING" in the main directory of this
- * archive for more details.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __PLAT_CBUS_H
-#define __PLAT_CBUS_H
-
-#define CBUS_RETU_DEVICE_ID	0x01
-#define CBUS_TAHVO_DEVICE_ID	0x02
-
-struct cbus_host_platform_data {
-	int	dat_gpio;
-	int	clk_gpio;
-	int	sel_gpio;
-};
-
-struct cbus_retu_platform_data {
-	int	irq_base;
-	int	irq_end;
-	int	devid;
-};
-
-#endif /* __PLAT_CBUS_H */
diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index fb524cb..486254d 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -33,8 +33,7 @@
 #include <linux/spinlock.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
-
-#include <plat/cbus.h>
+#include <linux/platform_data/cbus.h>
 
 #include "cbus.h"
 
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 3f0578b..be07938 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -37,6 +37,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/cbus.h>
 #include <linux/gpio.h>
 
 #include <asm/uaccess.h>
@@ -44,7 +45,6 @@
 
 #include <plat/mux.h>
 #include <plat/board.h>
-#include <plat/cbus.h>
 
 #include "cbus.h"
 #include "retu.h"
diff --git a/include/linux/platform_data/cbus.h b/include/linux/platform_data/cbus.h
new file mode 100644
index 0000000..a1c5a26
--- /dev/null
+++ b/include/linux/platform_data/cbus.h
@@ -0,0 +1,40 @@
+/*
+ * cbus.h - CBUS platform_data definition
+ *
+ * Copyright (C) 2004 - 2009 Nokia Corporation
+ *
+ * Written by Felipe Balbi <felipe.balbi@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __INCLUDE_LINUX_CBUS_H
+#define __INCLUDE_LINUX_CBUS_H
+
+#define CBUS_RETU_DEVICE_ID	0x01
+#define CBUS_TAHVO_DEVICE_ID	0x02
+
+struct cbus_host_platform_data {
+	int	dat_gpio;
+	int	clk_gpio;
+	int	sel_gpio;
+};
+
+struct cbus_retu_platform_data {
+	int	irq_base;
+	int	irq_end;
+	int	devid;
+};
+
+#endif /* __INCLUDE_LINUX_CBUS_H */
-- 
1.7.6.rc1

