From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Mon, 22 Nov 2010 14:22:40 +0530
Message-ID: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fixes compilation error as control.h APIs are not available to
drivers/usb/musb/am35x.c file. Earlier it was getting included
from <plat/control.h> but now moved to new location by another
pacth.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
Patch created against latest Linus's tree (v2.6.37-rc3)

 arch/arm/plat-omap/include/plat/usb.h |    2 ++
 drivers/usb/musb/am35x.c              |    1 -
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 59c7fe7..f1b8b40 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -6,6 +6,8 @@
 #include <linux/usb/musb.h>
 #include <plat/board.h>
 
+#include "../../../mach-omap2/control.h"
+
 #define OMAP3_HS_USB_PORTS	3
 enum ehci_hcd_omap_mode {
 	EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index b0aabf3..30f524a 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -30,7 +30,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/control.h>
 #include <plat/usb.h>
 
 #include "musb_core.h"
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
