From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] HSI: omap-ssi: include pinctrl header files
Date: Tue,  3 May 2016 17:16:21 +0200
Message-ID: <1462288586-584690-3-git-send-email-arnd@arndb.de>
References: <1462288586-584690-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462288586-584690-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrzej Hajda <a.hajda@samsung.com>, Sanjeev Sharma <sanjeev_sharma@mentor.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The driver now uses some pinctrl functions, but fails
to build if PINCTRL is disabled because the respective
header files are only included indirectly:

drivers/hsi/controllers/omap_ssi_core.c: In function 'ssi_clk_event':
drivers/hsi/controllers/omap_ssi_core.c:317:4: error: implicit declaration of function 'pinctrl_pm_select_idle_state' [-Werror=implicit-function-declaration]
drivers/hsi/controllers/omap_ssi_core.c:339:4: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
drivers/hsi/controllers/omap_ssi_port.c: In function 'ssi_flush':
drivers/hsi/controllers/omap_ssi_port.c:520:2: error: implicit declaration of function 'pinctrl_pm_select_idle_state' [-Werror=implicit-function-declaration]

This includes the headers from the files that call the functions,
which works even if pinctrl is turned off.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4bcf7414528a ("HSI: omap-ssi: add clk change support")
---
 drivers/hsi/controllers/omap_ssi_core.c | 1 +
 drivers/hsi/controllers/omap_ssi_port.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 15b2a600d77b..a3e0febfb64a 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/debugfs.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_platform.h>
 #include <linux/hsi/hsi.h>
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 98b22e88085c..ca7139eaaa1d 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 
 #include <linux/gpio/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/debugfs.h>
 
 #include "omap_ssi_regs.h"
-- 
2.7.0
