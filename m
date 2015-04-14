From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH v2 03/13] usb: otg-fsm: Prevent build warning "VDBG" redefined
Date: Tue, 14 Apr 2015 13:41:50 +0300
Message-ID: <1429008120-5395-4-git-send-email-rogerq@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

If usb/otg-fsm.h and usb/composite.h are included together
then it results in the build warning [1].

Prevent that by moving the VDBG defination into the
usb-otg-fsm.c file where it is used.

Also get rid of MPC_LOC which doesn't seem to be used
by anyone.

[1] - warning fixed by this patch:

   In file included from drivers/usb/dwc3/core.h:33,
                    from drivers/usb/dwc3/ep0.c:33:
   include/linux/usb/otg-fsm.h:30:1: warning: "VDBG" redefined
   In file included from drivers/usb/dwc3/ep0.c:31:
   include/linux/usb/composite.h:615:1: warning: this is the location of the previous definition

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/common/usb-otg-fsm.c |  9 +++++++++
 include/linux/usb/otg-fsm.h      | 15 ---------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
index 0caa37b..35f311a 100644
--- a/drivers/usb/common/usb-otg-fsm.c
+++ b/drivers/usb/common/usb-otg-fsm.c
@@ -30,6 +30,15 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/otg-fsm.h>
 
+#undef VDBG
+
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
diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
index 85a9150..73136aa 100644
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
2.1.0
