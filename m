From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 02/14] usb: otg-fsm: Prevent build warning "VDBG" redefined
Date: Mon, 2 May 2016 15:18:45 +0300
Message-ID: <1462191537-10314-3-git-send-email-rogerq@ti.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462191537-10314-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.chen@freescale.com
Cc: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

If usb/otg-fsm.h and usb/composite.h are included together
then it results in the build warning [1].

Prevent that by defining VDBG locally.

Also get rid of MPC_LOC which doesn't seem to be used
by anyone.

[1] - warning fixed by this patch:

In file included from drivers/usb/dwc3/core.h:33,
   from drivers/usb/dwc3/ep0.c:33:
   include/linux/usb/otg-fsm.h:30:1: warning: "VDBG" redefined
   In file included from drivers/usb/dwc3/ep0.c:31:
   include/linux/usb/composite.h:615:1: warning: this is the location
   of the previous definition

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/common/usb-otg-fsm.c |  7 +++++++
 drivers/usb/phy/phy-fsl-usb.c    |  7 +++++++
 include/linux/usb/otg-fsm.h      | 15 ---------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
index 9059b7d..015cf41 100644
--- a/drivers/usb/common/usb-otg-fsm.c
+++ b/drivers/usb/common/usb-otg-fsm.c
@@ -30,6 +30,13 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/otg-fsm.h>
 
+#ifdef VERBOSE
+#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
+				 __func__, ## args)
+#else
+#define VDBG(stuff...)	do {} while (0)
+#endif
+
 /* Change USB protocol when there is a protocol change */
 static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
 {
diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index 94eb292..dd8a1ad 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -44,6 +44,13 @@
 
 #include "phy-fsl-usb.h"
 
+#ifdef VERBOSE
+#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
+				 __func__, ## args)
+#else
+#define VDBG(stuff...)	do {} while (0)
+#endif
+
 #define DRIVER_VERSION "Rev. 1.55"
 #define DRIVER_AUTHOR "Jerry Huang/Li Yang"
 #define DRIVER_DESC "Freescale USB OTG Transceiver Driver"
diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
index 7a03505..a0a8f87 100644
--- a/include/linux/usb/otg-fsm.h
+++ b/include/linux/usb/otg-fsm.h
@@ -21,21 +21,6 @@
 #include <linux/mutex.h>
 #include <linux/errno.h>
 
-#undef VERBOSE
-
-#ifdef VERBOSE
-#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
-				 __func__, ## args)
-#else
-#define VDBG(stuff...)	do {} while (0)
-#endif
-
-#ifdef VERBOSE
-#define MPC_LOC printk("Current Location [%s]:[%d]\n", __FILE__, __LINE__)
-#else
-#define MPC_LOC do {} while (0)
-#endif
-
 #define PROTO_UNDEF	(0)
 #define PROTO_HOST	(1)
 #define PROTO_GADGET	(2)
-- 
2.7.4
