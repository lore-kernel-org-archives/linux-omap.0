From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/22] ARM: omap1: move mach/usb.h to include/linux/soc
Date: Thu,  8 Aug 2019 23:22:14 +0200
Message-ID: <20190808212234.2213262-6-arnd@arndb.de>
References: <20190808212234.2213262-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190808212234.2213262-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The register definitions in this header are used in at least four
different places, with little hope of completely cleaning that up.

Split up the file into a portion that becomes a linux-wide header
under include/linux/soc/ti/, and the parts that are actually only
needed by board files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-ams-delta.c         |  2 +-
 arch/arm/mach-omap1/board-generic.c           |  2 +-
 arch/arm/mach-omap1/board-h2.c                |  2 +-
 arch/arm/mach-omap1/board-h3.c                |  2 +-
 arch/arm/mach-omap1/board-htcherald.c         |  2 +-
 arch/arm/mach-omap1/board-innovator.c         |  2 +-
 arch/arm/mach-omap1/board-nokia770.c          |  2 +-
 arch/arm/mach-omap1/board-osk.c               |  2 +-
 arch/arm/mach-omap1/board-palmte.c            |  2 +-
 arch/arm/mach-omap1/board-palmtt.c            |  2 +-
 arch/arm/mach-omap1/board-palmz71.c           |  2 +-
 arch/arm/mach-omap1/board-sx1.c               |  2 +-
 arch/arm/mach-omap1/clock_data.c              |  2 +-
 arch/arm/mach-omap1/usb.c                     |  2 +-
 arch/arm/mach-omap1/usb.h                     | 25 +++++++++++++++++
 drivers/usb/gadget/udc/omap_udc.c             |  3 +-
 drivers/usb/host/ohci-omap.c                  |  4 +--
 drivers/usb/phy/phy-isp1301-omap.c            |  2 +-
 .../usb.h => include/linux/soc/ti/omap1-usb.h | 28 ++++++-------------
 19 files changed, 52 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/mach-omap1/usb.h
 rename arch/arm/mach-omap1/include/mach/usb.h => include/linux/soc/ti/omap1-usb.h (86%)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index e47a6fbcfd6e..2d63db557792 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -39,7 +39,7 @@
 
 #include <mach/hardware.h>
 #include "camera.h"
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "ams-delta-fiq.h"
 #include "board-ams-delta.h"
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index c62554990115..8ef0a9b17e92 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -21,7 +21,7 @@
 
 #include <mach/mux.h>
 
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index cb7ce627ffe8..92a31727a069 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -41,7 +41,7 @@
 #include "flash.h"
 
 #include <mach/hardware.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 #include "board-h2.h"
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4249984f9c30..86260498c344 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -45,7 +45,7 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 #include "board-h3.h"
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 258304edf23e..f7220b60eb61 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -31,7 +31,7 @@
 #include "mmc.h"
 
 #include <mach/irqs.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 653af63320a8..f169e172421d 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -34,7 +34,7 @@
 #include <linux/platform_data/keypad-omap.h>
 
 #include <mach/hardware.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "iomap.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 11511ae2e0a2..e43c852103f5 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -31,7 +31,7 @@
 #include <mach/mux.h>
 
 #include <mach/hardware.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 3be7b3b580d3..99ebe4503787 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -51,7 +51,7 @@
 #include <mach/tc.h>
 
 #include <mach/hardware.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index ce6f0fcd9d12..4ac981c5cf74 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -38,7 +38,7 @@
 #include <linux/platform_data/keypad-omap.h>
 
 #include <mach/hardware.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "mmc.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 8a08311c4e05..e48ae5fbe1b1 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -38,7 +38,7 @@
 #include <linux/platform_data/keypad-omap.h>
 
 #include <mach/hardware.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 034e5bc6a029..37db0ab31528 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -40,7 +40,7 @@
 #include <linux/platform_data/keypad-omap.h>
 
 #include <mach/hardware.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index bb9ec345e204..0965b1b689ec 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -38,7 +38,7 @@
 #include "board-sx1.h"
 
 #include <mach/hardware.h>
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 3ebcd96efbff..ef46c5f67cf9 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -22,7 +22,7 @@
 #include "soc.h"
 
 #include <mach/hardware.h>
-#include <mach/usb.h>   /* for OTG_BASE */
+#include "usb.h"   /* for OTG_BASE */
 
 #include "iomap.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 740c876ae46b..a9deda073822 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -16,7 +16,7 @@
 
 #include <mach/mux.h>
 
-#include <mach/usb.h>
+#include "usb.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/usb.h b/arch/arm/mach-omap1/usb.h
new file mode 100644
index 000000000000..08c9344c46e3
--- /dev/null
+++ b/arch/arm/mach-omap1/usb.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * fixme correct answer depends on hmc_mode,
+ * as does (on omap1) any nonzero value for config->otg port number
+ */
+#include <linux/platform_data/usb-omap1.h>
+#include <linux/soc/ti/omap1-usb.h>
+
+#if IS_ENABLED(CONFIG_USB_OMAP)
+#define	is_usb0_device(config)	1
+#else
+#define	is_usb0_device(config)	0
+#endif
+
+#if IS_ENABLED(CONFIG_USB_SUPPORT)
+void omap1_usb_init(struct omap_usb_config *pdata);
+#else
+static inline void omap1_usb_init(struct omap_usb_config *pdata)
+{
+}
+#endif
+
+#define OMAP1_OHCI_BASE			0xfffba000
+#define OMAP2_OHCI_BASE			0x4805e000
+#define OMAP_OHCI_BASE			OMAP1_OHCI_BASE
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index f36f0730afab..721c9c3fe5a7 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -40,8 +40,9 @@
 #include <asm/mach-types.h>
 
 #include <linux/omap-dma.h>
+#include <linux/platform_data/usb-omap1.h>
 
-#include <mach/usb.h>
+#include <linux/soc/ti/omap1-usb.h>
 
 #include "omap_udc.h"
 
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index e92ef3231f2c..841563fba20d 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -25,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/usb/otg.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/usb-omap1.h>
+#include <linux/soc/ti/omap1-usb.h>
 #include <linux/signal.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -37,8 +39,6 @@
 #include <mach/mux.h>
 
 #include <mach/hardware.h>
-#include <mach/usb.h>
-
 
 #define DRIVER_DESC "OHCI OMAP driver"
 
diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 7041ba030052..18cf87dcc21f 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -25,7 +25,7 @@
 
 #include <mach/mux.h>
 
-#include <mach/usb.h>
+#include <linux/soc/ti/omap1-usb.h>
 
 #undef VERBOSE
 
diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/include/linux/soc/ti/omap1-usb.h
similarity index 86%
rename from arch/arm/mach-omap1/include/mach/usb.h
rename to include/linux/soc/ti/omap1-usb.h
index 5429d86c7190..67488698601a 100644
--- a/arch/arm/mach-omap1/include/mach/usb.h
+++ b/include/linux/soc/ti/omap1-usb.h
@@ -1,34 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_TI_OMAP1_USB
+#define __SOC_TI_OMAP1_USB
 /*
- * FIXME correct answer depends on hmc_mode,
- * as does (on omap1) any nonzero value for config->otg port number
+ * Constants in this file are used all over the place, in platform
+ * code, as well as the udc, phy and ohci drivers.
+ * This is not a great design, but unlikely to get fixed after
+ * such a long time. Don't do this elsewhere.
  */
-#if IS_ENABLED(CONFIG_USB_OMAP)
-#define	is_usb0_device(config)	1
-#else
-#define	is_usb0_device(config)	0
-#endif
-
-#include <linux/platform_data/usb-omap1.h>
-
-#if IS_ENABLED(CONFIG_USB_SUPPORT)
-void omap1_usb_init(struct omap_usb_config *pdata);
-#else
-static inline void omap1_usb_init(struct omap_usb_config *pdata)
-{
-}
-#endif
 
 #define OMAP1_OTG_BASE			0xfffb0400
 #define OMAP1_UDC_BASE			0xfffb4000
-#define OMAP1_OHCI_BASE			0xfffba000
 
-#define OMAP2_OHCI_BASE			0x4805e000
 #define OMAP2_UDC_BASE			0x4805e200
 #define OMAP2_OTG_BASE			0x4805e300
 #define OTG_BASE			OMAP1_OTG_BASE
 #define UDC_BASE			OMAP1_UDC_BASE
-#define OMAP_OHCI_BASE			OMAP1_OHCI_BASE
 
 /*
  * OTG and transceiver registers, for OMAPs starting with ARM926
@@ -126,3 +112,5 @@ static inline void omap1_usb_init(struct omap_usb_config *pdata)
 #	define	CONF_USB0_ISOLATE_R	(1 << 3)
 #	define	CONF_USB_PWRDN_DM_R	(1 << 2)
 #	define	CONF_USB_PWRDN_DP_R	(1 << 1)
+
+#endif
-- 
2.20.0
