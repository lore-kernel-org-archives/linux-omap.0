From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/4] usb: ulpi: fix compilation warning
Date: Thu,  8 Jul 2010 14:03:01 +0530
Message-ID: <1278577982-30046-4-git-send-email-ajay.gupta@ti.com>
References: <1278577982-30046-1-git-send-email-ajay.gupta@ti.com>
 <1278577982-30046-2-git-send-email-ajay.gupta@ti.com>
 <1278577982-30046-3-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278577982-30046-3-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fixes below compilation warning from ulpi.h

include/linux/usb/ulpi.h:145:
        warning: 'struct otg_io_access_ops' declared inside parameter list
include/linux/usb/ulpi.h:145:
         warning: its scope is only this definition or declaration,
         which is probably not what you want

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 include/linux/usb/ulpi.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/ulpi.h b/include/linux/usb/ulpi.h
index 2369d07..900d97b 100644
--- a/include/linux/usb/ulpi.h
+++ b/include/linux/usb/ulpi.h
@@ -11,6 +11,7 @@
 #ifndef __LINUX_USB_ULPI_H
 #define __LINUX_USB_ULPI_H
 
+#include <linux/usb/otg.h>
 /*-------------------------------------------------------------------------*/
 
 /*
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
