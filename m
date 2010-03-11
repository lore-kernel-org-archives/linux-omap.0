From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/3] usb: Fix USB_SUSPEND dependency for OTG
Date: Thu, 11 Mar 2010 10:03:29 -0800
Message-ID: <20100311180329.20537.95308.stgit@baageli.muru.com>
References: <20100311180023.20537.27516.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311180023.20537.27516.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

To use this, PM_RUNTIME must be set as discussed at:

http://thread.gmane.org/gmane.linux.usb.general/27432/focus=4460

Otherwise we'll get errors like:

drivers/usb/core/hcd.c:1892: error: 'pm_wq' undeclared (first use in this function)
drivers/usb/core/hcd.c:1892: error: (Each undeclared identifier is reported only once
drivers/usb/core/hcd.c:1892: error: for each function it appears in.)

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/core/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 97a819c..7e59444 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -109,7 +109,7 @@ config USB_SUSPEND
 config USB_OTG
 	bool
 	depends on USB && EXPERIMENTAL
-	select USB_SUSPEND
+	depends on USB_SUSPEND
 	default n
 
 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
